use zed_extension_api::{self as zed, serde_json, LanguageServerId, Result};

struct DefoldExtension {
    cached_binary_path: Option<String>,
    api_path: Option<String>,
}

impl DefoldExtension {
    fn download_defold_api(&mut self, language_server_id: &LanguageServerId) -> Result<String> {
        if let Some(path) = &self.api_path {
            // Check if the API path still exists
            if std::fs::metadata(path).map_or(false, |stat| stat.is_dir()) {
                return Ok(path.clone());
            }
        }

        // Download the latest Defold annotations from astrochili/defold-annotations
        zed::set_language_server_installation_status(
            language_server_id,
            &zed::LanguageServerInstallationStatus::Downloading,
        );

        let release = zed::latest_github_release(
            "astrochili/defold-annotations",
            zed::GithubReleaseOptions {
                require_assets: false,
                pre_release: false,
            },
        )?;

        // Download the pre-packaged defold_api ZIP from releases
        // URL format: https://github.com/astrochili/defold-annotations/releases/download/{version}/defold_api_{version}.zip
        let download_url = format!(
            "https://github.com/astrochili/defold-annotations/releases/download/{}/defold_api_{}.zip",
            release.version,
            release.version
        );

        let version_dir = format!("defold-api-{}", release.version);
        // The ZIP contains a defold_api folder with all the Lua API files
        let api_path_relative = format!("{}/defold_api", version_dir);

        if !std::fs::metadata(&api_path_relative).map_or(false, |stat| stat.is_dir()) {
            zed::download_file(
                &download_url,
                &version_dir,
                zed::DownloadedFileType::Zip,
            )
            .map_err(|e| format!("failed to download Defold annotations: {e}"))?;

            // Clean up old annotation versions
            let entries = std::fs::read_dir(".")
                .map_err(|e| format!("failed to list working directory {e}"))?;
            for entry in entries {
                let entry = entry.map_err(|e| format!("failed to load directory entry {e}"))?;
                let entry_name = entry.file_name();
                if let Some(name) = entry_name.to_str() {
                    if name.starts_with("defold-api-") && name != version_dir {
                        std::fs::remove_dir_all(&entry.path()).ok();
                    }
                }
            }
        }

        // Convert to absolute path for the language server
        let mut absolute_path = std::env::current_dir()
            .map_err(|e| format!("failed to get current directory: {e}"))?
            .join(&api_path_relative)
            .to_string_lossy()
            .to_string();

        // Fix Windows path format: remove leading slash from "/C:/..." -> "C:/..."
        // This happens when converting paths in WASM environment
        if absolute_path.starts_with('/') && absolute_path.len() > 2 {
            if let Some(second_char) = absolute_path.chars().nth(1) {
                if let Some(third_char) = absolute_path.chars().nth(2) {
                    if second_char.is_ascii_alphabetic() && third_char == ':' {
                        absolute_path = absolute_path[1..].to_string();
                    }
                }
            }
        }

        self.api_path = Some(absolute_path.clone());
        Ok(absolute_path)
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
            api_path: None,
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
        language_server_id: &LanguageServerId,
        _worktree: &zed::Worktree,
    ) -> Result<Option<zed::serde_json::Value>> {
        // Download and use Defold API definitions from GitHub
        let api_path = self.download_defold_api(language_server_id)?;
        
        let workspace_config = serde_json::json!({
            "checkThirdParty": false,
            "library": [api_path],
            "ignoreDir": [".defold", "build"]
        });
        
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
                        // Script lifecycle functions
                        "init", "final", "update", "fixed_update", "on_input", "on_message", "on_reload",
                        
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
                    "disable": ["lowercase-global", "undefined-global", "trailing-space"]
                },
                "workspace": workspace_config,
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
        language_server_id: &LanguageServerId,
        _worktree: &zed::Worktree,
    ) -> Result<Option<zed::serde_json::Value>> {
        // Download and use Defold API definitions from GitHub
        let api_path = self.download_defold_api(language_server_id)?;
        
        let workspace_config = serde_json::json!({
            "Lua": {
                "runtime": {
                    "version": "Lua 5.1"
                },
                "diagnostics": {
                    "globals": [
                        // Script lifecycle functions
                        "init", "final", "update", "fixed_update", "on_input", "on_message", "on_reload",
                        
                        "go", "msg", "gui", "sys", "sound", "sprite", "physics",
                        "particlefx", "tilemap", "label", "model", "spine", "camera",
                        "collectionfactory", "factory", "collectionproxy",
                        "vmath", "hash", "pprint", "json", "image", "zlib",
                        "crash", "profiler", "resource", "timer", "http",
                        "render", "matrix4", "vector3", "vector4", "quat",
                        "webview", "push", "iap", "iac", "buffer", "socket",
                        "html5", "facebook", "crashlytics"
                    ],
                    "disable": ["lowercase-global", "undefined-global", "trailing-space"]
                },
                "workspace": {
                    "checkThirdParty": false,
                    "library": [api_path],
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

