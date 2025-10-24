# How the Defold Extension Works

This extension provides complete Defold API autocomplete with full documentation, just like the [VSCode Defold extension](https://github.com/astrochili/vscode-defold).

## Key Features

### 1. Automatic API Annotations Download
On first use, the extension automatically:
- Downloads [astrochili/defold-annotations](https://github.com/astrochili/defold-annotations)
- Extracts them to the extension's working directory
- Configures the Lua Language Server to use them

**No manual setup required!**

### 2. Complete Defold API Support
With the annotations, you get:
- ✅ Function signatures: `msg.post(receiver: string|url|userdata, message_id: string|userdata, message?: table)`
- ✅ Parameter documentation with `@param` tags
- ✅ Hover tooltips showing function descriptions
- ✅ Type information for all Defold types
- ✅ Return value documentation

### 3. All Defold Modules Recognized
40+ Defold modules are automatically recognized:
- Core: `go`, `msg`, `gui`, `sys`
- Math: `vmath`, `matrix4`, `vector3`, `quat`
- Physics: `physics`, `collisionobject`
- Graphics: `sprite`, `render`, `particlefx`
- And many more!

## How It Works

### Extension Initialization
```rust
1. User opens a .script file in Zed
2. Extension activates
3. ensure_annotations() checks if annotations exist
4. If not, downloads from GitHub automatically
5. Configures Language Server with annotations path
6. Language Server starts with full Defold API support
```

### File Structure
```
Extension working directory:
├── defold-annotations/     # Auto-downloaded
│   ├── defold/            # Defold API definitions
│   └── builtins/          # Lua builtins
├── lua-language-server-*/ # Auto-downloaded
└── extension.wasm         # Extension code
```

## Comparison with VSCode Extension

| Feature | VSCode Defold | This Extension |
|---------|---------------|----------------|
| API Annotations | Manual sync command | ✅ Automatic |
| Annotations Source | astrochili/defold-annotations | ✅ Same |
| Function Signatures | ✅ Yes | ✅ Yes |
| Hover Documentation | ✅ Yes | ✅ Yes |
| Parameter Hints | ✅ Yes | ✅ Yes |
| Setup Required | Sync command | ✅ None |

## Technical Details

### Annotations Download
- **Source:** https://github.com/astrochili/defold-annotations/archive/refs/heads/main.zip
- **Format:** EmmyLua/LuaLS annotations
- **Size:** ~1MB compressed
- **Frequency:** Once (cached after first download)

### Language Server Configuration
The extension configures Lua Language Server with:
```json
{
  "Lua": {
    "runtime": { "version": "Lua 5.1" },
    "workspace": {
      "library": ["path/to/defold-annotations"]
    },
    "completion": { "enable": true },
    "hint": { "enable": true }
  }
}
```

### Supported File Types
- `.script` - Game object scripts
- `.gui_script` - GUI scripts
- `.render_script` - Render scripts
- `.lua` - Lua modules

## Benefits

### For Developers
- ✅ No configuration needed
- ✅ Works immediately after install
- ✅ Same experience as VSCode
- ✅ Always up-to-date annotations

### For Projects
- ✅ No per-project setup
- ✅ No `.luarc.json` required
- ✅ Works in any Defold project
- ✅ Consistent across team members

## Maintenance

### Updating Annotations
To get the latest Defold API updates:
1. Delete `defold-annotations/` folder in extension directory
2. Reload extension in Zed
3. Annotations re-download automatically

Or simply reinstall the extension.

### Extension Directory Location
**Windows:** `C:\Users\<username>\AppData\Local\Zed\extensions\work\defold\`
**macOS:** `~/Library/Application Support/Zed/extensions/work/defold/`
**Linux:** `~/.local/share/zed/extensions/work/defold/`

## Credits

- Annotations: [astrochili/defold-annotations](https://github.com/astrochili/defold-annotations)
- Inspiration: [astrochili/vscode-defold](https://github.com/astrochili/vscode-defold)
- Language Server: [LuaLS/lua-language-server](https://github.com/LuaLS/lua-language-server)
- Defold Engine: [defold.com](https://defold.com)

