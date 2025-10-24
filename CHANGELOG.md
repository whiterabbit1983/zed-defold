# Changelog

All notable changes to the Defold extension for Zed will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-10-24

### Added
- Initial release of Defold extension for Zed
- **Completely self-contained** - no external dependencies or borrowed files
- **Defold Language Server Integration**:
  - Uses [Defold's official Lua Language Server fork](https://github.com/defold/lua-language-server)
  - Complete Defold API documentation built-in (no manual setup required!)
  - Full function signatures with parameter types
  - Hover documentation for all Defold functions
  - Automatic installation and configuration
- **Advanced Autocomplete Features**:
  - Function name completion for all Defold modules (go, msg, gui, vmath, etc.)
  - Parameter hints while typing
  - Type checking and inference
  - Go-to-definition and find references
  - No "undefined global" warnings
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
- Based on patterns from [vscode-defold](https://github.com/astrochili/vscode-defold)
- Uses Lua grammar from [tree-sitter-grammars/tree-sitter-lua](https://github.com/tree-sitter-grammars/tree-sitter-lua)
- **Language server from [defold/lua-language-server](https://github.com/defold/lua-language-server)** - Defold's official fork with built-in API support

## Future Improvements

Potential features for future versions:
- Defold project detection and configuration
- Integration with Defold build tools (bob.jar)
- Quick access to Defold documentation
- Defold-specific diagnostics and linting rules
- Asset preview integration
- Debugging support (when Zed supports it)

