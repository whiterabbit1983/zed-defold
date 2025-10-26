# Changelog

All notable changes to the Defold extension for Zed will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.4] - 2025-10-26

### Added
- **Automatic Defold API Download**: Extension now automatically downloads pre-packaged Defold API annotations from [astrochili/defold-annotations](https://github.com/astrochili/defold-annotations) releases
  - Downloads `defold_api_{version}.zip` instead of full source code
  - Annotations are extracted to extension's working directory
  - Automatic cleanup of old API versions
- **Installation Scripts**: Added cross-platform installation scripts in `scripts/` folder
  - `install-snippets.ps1` / `install-snippets.sh` - Install code snippets
  - `install-tasks.ps1` / `install-tasks.sh` - Install build tasks in Defold projects
- **Manual Snippets Installation**: Added detailed manual installation instructions for all platforms in README

### Changed
- **Documentation Consolidation**: Merged DEFOLD_SETUP.md into README.md for easier navigation
  - All setup instructions now in one place
  - Better organization with clear sections
- **Renamed Files**:
  - `tasks-template.json` → `defold-tasks.json` for clarity
  - All references updated across documentation and scripts
- **Script Organization**: Moved all installation scripts to dedicated `scripts/` folder
- Updated README structure for better readability

### Removed
- `DEFOLD_SETUP.md` - Content moved to README.md

## [0.1.3] - 2025-10-25

### Changed
- **Simplified Installation**: Removed `install.ps1` script in favor of using Zed's built-in "Install Dev Extension" feature
- Updated README with clearer installation instructions
- Moved installation section to the top of README for better visibility
- Installation now uses Zed's native extension system, which automatically handles compilation

### Removed
- `install.ps1` - Installation script (replaced by Zed's native installer)

## [0.1.2] - 2025-10-25

### Changed
- Installation script now copies API files to both `extensions/installed/defold` and `extensions/work/defold` directories for better compatibility

## [0.1.1] - 2025-10-25

### Fixed
- Added Lua grammar repository configuration to extension.toml
- Updated bundled Lua grammar binary (lua.wasm)

## [0.1.0] - 2025-10-24

### Added
- Initial release of Defold extension for Zed
- **Automatic Defold API Annotations**:
  - Auto-downloads [astrochili/defold-annotations](https://github.com/astrochili/defold-annotations) on first use
  - Same approach as [VSCode Defold extension](https://github.com/astrochili/vscode-defold)
  - No manual setup required - works immediately!
  - Annotations cached after first download
- **Complete Autocomplete Features**:
  - Full function signatures with parameter types
  - Hover documentation with descriptions
  - Parameter hints while typing (`@param` tags)
  - Type information for all Defold types
  - Function name completion for 40+ Defold modules
  - Go-to-definition and find references
  - No "undefined global" warnings
- **Lua Language Server Integration**:
  - Automatic configuration for Defold projects
  - Custom initialization with annotations path
  - Workspace configuration with Lua 5.1
  - Support for type hints and parameter info
- Support for `.script`, `.gui_script`, `.render_script`, and `.lua` file types
- Syntax highlighting using bundled tree-sitter Lua grammar
- Complete language support files:
  - `highlights.scm` - Full Lua syntax highlighting
  - `brackets.scm` - Bracket matching
  - `indents.scm` - Smart indentation
  - `outline.scm` - Code outline/navigation
  - `embedding.scm` - Embedded language support
- Smart bracket matching and auto-closing
- Line and block comment support
- Code navigation and outline view
- Cross-platform support (Windows, macOS, Linux)
- One-command installation script (`install.ps1`)
- Comprehensive documentation:
  - `DEFOLD_AUTOCOMPLETE_SETUP.md` - Complete autocomplete setup guide
  - `PROJECT_STRUCTURE.md` - Technical documentation
  - Enhanced README with feature highlights

### Key Technologies
- Inspired by [astrochili/vscode-defold](https://github.com/astrochili/vscode-defold)
- Annotations from [astrochili/defold-annotations](https://github.com/astrochili/defold-annotations)
- Uses Lua grammar from [tree-sitter-grammars/tree-sitter-lua](https://github.com/tree-sitter-grammars/tree-sitter-lua)
- Language server from [LuaLS/lua-language-server](https://github.com/LuaLS/lua-language-server)

## Future Improvements

Potential features for future versions:
- Defold project detection and configuration
- Integration with Defold build tools (bob.jar)
- Quick access to Defold documentation
- Defold-specific diagnostics and linting rules
- Asset preview integration
- Debugging support (when Zed supports it)

