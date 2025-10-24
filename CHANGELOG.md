# Changelog

All notable changes to the Defold extension for Zed will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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

