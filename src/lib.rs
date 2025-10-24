use zed_extension_api::{self as zed, LanguageServerId, Result};

struct DefoldExtension {
    cached_binary_path: Option<String>,
    annotations_downloaded: bool,
}

const ANNOTATIONS_REPO: &str = "https://github.com/astrochili/defold-annotations/archive/refs/heads/main.zip";

impl DefoldExtension {
    fn ensure_annotations(&mut self) -> Result<String> {
        let annotations_dir = "defold-annotations";
        
        // Only download once per extension lifecycle
        if !self.annotations_downloaded {
            // Download and extract annotations (Zed will skip if already exists)
            if let Err(e) = zed::download_file(
                ANNOTATIONS_REPO,
                annotations_dir,
                zed::DownloadedFileType::Zip,
            ) {
                // If download fails, still try to use existing annotations
                eprintln!("Failed to download annotations: {}", e);
            }
            self.annotations_downloaded = true;
        }
        
        Ok(annotations_dir.to_string())
    }
    
    fn language_server_binary_path(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<String> {
        if let Some(path) = worktree.which("lua-language-server") {
            return Ok(path);
        }

        if let Some(path) = &self.cached_binary_path {
            if std::fs::metadata(path).map_or(false, |stat| stat.is_file()) {
                return Ok(path.clone());
            }
        }

        zed::set_language_server_installation_status(
            language_server_id,
            &zed::LanguageServerInstallationStatus::CheckingForUpdate,
        );
        let release = zed::latest_github_release(
            "LuaLS/lua-language-server",
            zed::GithubReleaseOptions {
                require_assets: true,
                pre_release: false,
            },
        )?;

        let (platform, arch) = zed::current_platform();
        let asset_name = format!(
            "lua-language-server-{version}-{os}-{arch}.{extension}",
            version = release.version,
            os = match platform {
                zed::Os::Mac => "darwin",
                zed::Os::Linux => "linux",
                zed::Os::Windows => "win32",
            },
            arch = match arch {
                zed::Architecture::Aarch64 => "arm64",
                zed::Architecture::X8664 => "x64",
                zed::Architecture::X86 => return Err("unsupported architecture".into()),
            },
            extension = match platform {
                zed::Os::Mac | zed::Os::Linux => "tar.gz",
                zed::Os::Windows => "zip",
            }
        );

        let asset = release
            .assets
            .iter()
            .find(|asset| asset.name == asset_name)
            .ok_or_else(|| format!("no asset found matching {:?}", asset_name))?;

        let version_dir = format!("lua-language-server-{}", release.version);
        let binary_path = format!(
            "{version_dir}/bin/lua-language-server{extension}",
            extension = match platform {
                zed::Os::Windows => ".exe",
                _ => "",
            }
        );

        if !std::fs::metadata(&binary_path).map_or(false, |stat| stat.is_file()) {
            zed::set_language_server_installation_status(
                language_server_id,
                &zed::LanguageServerInstallationStatus::Downloading,
            );

            zed::download_file(
                &asset.download_url,
                &version_dir,
                match platform {
                    zed::Os::Mac | zed::Os::Linux => zed::DownloadedFileType::GzipTar,
                    zed::Os::Windows => zed::DownloadedFileType::Zip,
                },
            )
            .map_err(|e| format!("failed to download file: {e}"))?;

            let entries =
                std::fs::read_dir(".").map_err(|e| format!("failed to list working directory {e}"))?;
            for entry in entries {
                let entry = entry.map_err(|e| format!("failed to load directory entry {e}"))?;
                if entry.file_name().to_str() != Some(&version_dir) {
                    std::fs::remove_dir_all(&entry.path()).ok();
                }
            }

            zed::make_file_executable(&binary_path)?;
        }

        self.cached_binary_path = Some(binary_path.clone());
        Ok(binary_path)
    }
}

impl zed::Extension for DefoldExtension {
    fn new() -> Self {
        Self {
            cached_binary_path: None,
            annotations_downloaded: false,
        }
    }

    fn language_server_command(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        Ok(zed::Command {
            command: self.language_server_binary_path(language_server_id, worktree)?,
            args: vec![],
            env: Default::default(),
        })
    }

    fn language_server_initialization_options(
        &mut self,
        _language_server_id: &LanguageServerId,
        _worktree: &zed::Worktree,
    ) -> Result<Option<zed::serde_json::Value>> {
        // Ensure annotations are downloaded
        let annotations_path = self.ensure_annotations()?;
        
        let initialization_options = zed::serde_json::json!({
            "Lua": {
                "runtime": {
                    "version": "Lua 5.1",
                    "special": {
                        "include": "require"
                    }
                },
                "diagnostics": {
                    "globals": [
                        // Defold core modules
                        "go", "msg", "gui", "sys", "sound", "sprite", "physics",
                        "particlefx", "tilemap", "label", "model", "spine", "camera",
                        "collectionfactory", "factory", "collectionproxy",
                        
                        // Math and utilities
                        "vmath", "hash", "pprint", "json", "image", "zlib",
                        
                        // System and lifecycle
                        "crash", "profiler", "resource", "timer", "http",
                        
                        // Rendering
                        "render", "matrix4", "vector3", "vector4", "quat",
                        
                        // Extensions and platform
                        "webview", "push", "iap", "iac", "buffer", "socket",
                        "html5", "facebook", "crashlytics"
                    ],
                    "disable": ["lowercase-global", "trailing-space"]
                },
                "workspace": {
                    "checkThirdParty": false,
                    "library": [annotations_path],
                    "ignoreDir": [".defold", "build"]
                },
                "completion": {
                    "keywordSnippet": "Both",
                    "callSnippet": "Both",
                    "enable": true
                },
                "hint": {
                    "enable": true,
                    "setType": true,
                    "paramName": "All"
                },
                "hover": {
                    "enable": true,
                    "viewString": true,
                    "viewNumber": true
                }
            }
        });

        Ok(Some(initialization_options))
    }

    fn language_server_workspace_configuration(
        &mut self,
        _language_server_id: &LanguageServerId,
        _worktree: &zed::Worktree,
    ) -> Result<Option<zed::serde_json::Value>> {
        // Use the same annotations path
        let annotations_path = "defold-annotations";
        
        let workspace_config = zed::serde_json::json!({
            "Lua": {
                "runtime": {
                    "version": "Lua 5.1"
                },
                "diagnostics": {
                    "globals": [
                        "go", "msg", "gui", "sys", "sound", "sprite", "physics",
                        "particlefx", "tilemap", "label", "model", "spine", "camera",
                        "collectionfactory", "factory", "collectionproxy",
                        "vmath", "hash", "pprint", "json", "image", "zlib",
                        "crash", "profiler", "resource", "timer", "http",
                        "render", "matrix4", "vector3", "vector4", "quat",
                        "webview", "push", "iap", "iac", "buffer", "socket",
                        "html5", "facebook", "crashlytics"
                    ]
                },
                "workspace": {
                    "checkThirdParty": false,
                    "library": [annotations_path],
                    "ignoreDir": [".defold", "build"]
                },
                "completion": {
                    "enable": true
                },
                "hint": {
                    "enable": true
                }
            }
        });

        Ok(Some(workspace_config))
    }
}

zed::register_extension!(DefoldExtension);

