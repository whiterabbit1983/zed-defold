# Build and Install Instructions

## Quick Start

### Prerequisites
```powershell
# Install Rust if not already installed
winget install Rustlang.Rustup

# Add WebAssembly target
rustup target add wasm32-wasip1
```

### Build
```powershell
cargo build --release --target wasm32-wasip1
```

### Install
```powershell
.\install.ps1
```

### Restart Zed
Close and reopen Zed editor.

## Development

### Install as Dev Extension
1. In Zed: `Ctrl+Shift+P`
2. Run: `zed: install dev extension`
3. Select: `C:\Users\asmat\work\zed_defold_ext`
4. Make changes and reload: `Ctrl+Shift+P` → `zed: reload extensions`

### Clean Build
```powershell
cargo clean
cargo build --release --target wasm32-wasip1
```

## What You Get

- ✅ Complete Defold API autocomplete
- ✅ Hover documentation with function signatures
- ✅ Parameter hints and type information
- ✅ Syntax highlighting for `.script`, `.gui_script`, `.render_script`, `.lua`
- ✅ Code snippets for common Defold patterns
- ✅ Uses [Defold's official Language Server](https://github.com/defold/lua-language-server)

## Files Structure

```
zed_defold_ext/
├── src/lib.rs                      # Extension code
├── grammars/lua.wasm               # Bundled Lua grammar
├── languages/defold/               # Language configuration
│   ├── config.toml
│   ├── highlights.scm
│   ├── brackets.scm
│   ├── indents.scm
│   ├── outline.scm
│   └── embedding.scm
├── extension.toml                  # Extension metadata
├── Cargo.toml                      # Rust dependencies
├── install.ps1                     # Installation script
├── README.md                       # Documentation
├── CHANGELOG.md                    # Version history
├── PROJECT_STRUCTURE.md            # Technical docs
└── LICENSE                         # Apache 2.0
```

## Troubleshooting

See README.md for detailed troubleshooting steps.

