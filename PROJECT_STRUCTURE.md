# Defold Extension for Zed - Project Structure

This document describes the self-contained structure of the Defold extension.

## 📦 Project Files

```
zed_defold_ext/
├── src/
│   └── lib.rs                      # Main extension code (Rust)
├── languages/
│   └── defold/
│       ├── config.toml             # Language configuration
│       ├── highlights.scm          # Syntax highlighting rules
│       ├── brackets.scm            # Bracket matching rules
│       ├── indents.scm             # Indentation rules
│       ├── outline.scm             # Code outline rules
│       └── embedding.scm           # Embedded language support
├── grammars/
│   └── lua.wasm                    # Tree-sitter Lua grammar (bundled)
├── extension.toml                  # Extension metadata
├── Cargo.toml                      # Rust dependencies
├── install.ps1                     # Installation script
├── README.md                       # Documentation
├── CHANGELOG.md                    # Version history
├── LICENSE                         # Apache 2.0 license
├── .gitignore                      # Git ignore rules
└── .luarc.json                     # Example Lua LS config

After building:
├── target/
│   └── wasm32-wasip1/
│       └── release/
│           └── zed_defold.wasm     # Compiled extension
```

## 🔧 Build Output Structure

After running `cargo build --release --target wasm32-wasip1`, the compiled extension is ready at:
- `target/wasm32-wasip1/release/zed_defold.wasm`

## 📥 Installed Structure

When installed via `install.ps1`, the extension is copied to:
```
%LOCALAPPDATA%\Zed\extensions\installed\defold\
├── extension.wasm                  # Compiled extension
├── extension.toml                  # Extension metadata
├── grammars/
│   └── lua.wasm                    # Tree-sitter Lua grammar
└── languages/
    └── defold/
        ├── config.toml             # Language configuration
        ├── highlights.scm          # Syntax highlighting
        ├── brackets.scm            # Bracket matching
        ├── indents.scm             # Indentation
        ├── outline.scm             # Code outline
        └── embedding.scm           # Embedded languages
```

## ✅ Self-Contained Design

All necessary files are included in the repository:

1. **Lua Grammar** (`grammars/lua.wasm`): Bundled tree-sitter grammar for syntax parsing
2. **Language Files** (`languages/defold/*.scm`): All syntax rules and configurations
3. **Extension Code** (`src/lib.rs`): Rust code for Zed integration
4. **Installation Script** (`install.ps1`): Automated deployment

**No external dependencies** from other Zed extensions are required!

## 🔄 Update Process

To update the extension:
1. Make changes to source files
2. Rebuild: `cargo build --release --target wasm32-wasip1`
3. Reinstall: `.\install.ps1`
4. Restart Zed

## 📝 File Descriptions

### Core Files
- **`src/lib.rs`**: Implements Zed extension API, handles Language Server installation
- **`extension.toml`**: Extension metadata (id, name, version, grammar sources)
- **`Cargo.toml`**: Rust project configuration and dependencies

### Language Support
- **`config.toml`**: File associations, comment syntax, brackets, autoclose behavior
- **`highlights.scm`**: Tree-sitter queries for syntax highlighting
- **`brackets.scm`**: Tree-sitter queries for bracket pair detection
- **`indents.scm`**: Tree-sitter queries for auto-indentation
- **`outline.scm`**: Tree-sitter queries for code outline/navigation
- **`embedding.scm`**: Tree-sitter queries for embedded language detection

### Bundled Binary
- **`grammars/lua.wasm`**: Precompiled tree-sitter Lua grammar (49KB)
  - Source: Lua extension from Zed's official extensions
  - Enables syntax parsing without requiring separate grammar installation

## 🎯 Supported File Types

The extension activates for these file extensions:
- `.script` - Game object scripts
- `.gui_script` - GUI scripts
- `.render_script` - Render scripts
- `.lua` - Lua modules

## 📚 Additional Resources

- [Zed Extension API](https://zed.dev/docs/extensions)
- [Tree-sitter Query Syntax](https://tree-sitter.github.io/tree-sitter/using-parsers#query-syntax)
- [Defold Manual](https://defold.com/manuals/)
- [Lua Language Server](https://github.com/LuaLS/lua-language-server)

