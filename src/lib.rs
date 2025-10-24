use zed_extension_api::{self as zed, LanguageServerId, Result};

struct DefoldExtension {
    cached_binary_path: Option<String>,
}

impl DefoldExtension {
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
            "defold/lua-language-server",
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
        // Defold's Language Server fork has built-in Defold API support
        // We just need to configure it for Lua 5.1 and enable features
        let initialization_options = zed::serde_json::json!({
            "Lua": {
                "runtime": {
                    "version": "Lua 5.1",
                    "special": {
                        "include": "require"
                    }
                },
                "diagnostics": {
                    "disable": ["lowercase-global", "trailing-space"]
                },
                "workspace": {
                    "checkThirdParty": false,
                    "library": [],
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
        // Defold's fork includes Defold APIs by default
        let workspace_config = zed::serde_json::json!({
            "Lua": {
                "runtime": {
                    "version": "Lua 5.1"
                },
                "workspace": {
                    "checkThirdParty": false,
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

