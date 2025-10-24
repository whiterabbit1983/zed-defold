# Zed Defold Extension

A Defold game engine extension for the Zed editor that provides Lua language support for Defold script files.

## Features

- **🎁 Self-Contained**: All files bundled - no external dependencies or borrowed files from other extensions
- **🎨 Syntax Highlighting**: Full Lua syntax highlighting for all Defold script types
- **🤖 Lua Language Server**: Auto-configured for Defold with bundled API annotations
  - **Bundled Defold API documentation** - works immediately after install
  - Complete function signatures with parameter types
  - Hover documentation for all Defold functions
  - No downloads, no setup, no configuration!
- **📚 Advanced Features**:
  - Go-to-definition
  - Find references
  - Type hints and parameter info
  - Real-time diagnostics
  - Code completion
- **📁 File Type Recognition**: Automatic recognition of `.script`, `.gui_script`, `.render_script`, and `.lua` files
- **🧩 Smart Editing**: Bracket matching, auto-closing, indentation, and code outline
- **🌐 Cross-Platform**: Works on Windows, macOS, and Linux
- **⚡ Easy Install**: One-command installation with `install.ps1`

## Supported File Types

This extension recognizes the following Defold file types:
- `.script` - Game object scripts (lifecycle functions, collision handling)
- `.gui_script` - GUI scripts (UI logic and interactions)
- `.render_script` - Custom render scripts (rendering pipeline)
- `.lua` - Lua modules (reusable code libraries)

## 🚀 Autocomplete Features

The extension includes **bundled Defold API annotations** that work automatically:

✅ **Works out of the box:**
- Function signatures with parameter types
- Hover documentation for Defold functions
- Parameter hints while typing
- No errors on lifecycle functions (`init`, `update`, etc.)
- No "undefined global" warnings for Defold modules
- Full autocomplete for core APIs:
  - `go.*` - Game object functions (get_position, set_position, animate, etc.)
  - `msg.*` - Message passing (msg.post, msg.url, etc.)
  - `vmath.*` - Vector math (vector3, quat, lerp, normalize, etc.)
  - `gui.*` - GUI functions (get_node, animate, set_text, etc.)
  - `sprite.*` - Sprite functions (play_flipbook, set_constant, etc.)
  - `physics.*` - Physics functions (raycast, get_gravity, etc.)
  - `sys.*` - System functions (get_sys_info, load_resource, etc.)
  - `hash()` - Hash function

### Example Autocomplete

```lua
function init(self)
    -- Type "go." and see all game object functions with docs:
    local pos = go.get_position()  -- ✅ Shows signature and parameters
    
    -- Type "msg." for messaging:
    msg.post("#", "my_message")  -- ✅ Shows parameter info
    
    -- Type "vmath." for math:
    local v = vmath.vector3(1, 2, 3)  -- ✅ Type hints included
    
    -- Hover over any function for documentation!
end
```

### No Setup Required
- ✅ No Defold binary path needed
- ✅ No external downloads
- ✅ No configuration files
- ✅ Just install and start coding!

## Build Tasks

While Zed extensions don't support custom commands (yet), you can use **Zed's task system** to run Defold build commands:

1. Copy `tasks-template.json` from this repo to `.zed/tasks.json` in your Defold project
2. Set up environment variables (see `DEFOLD_SETUP.md`)
3. Run tasks via `Ctrl+Shift+P` → "task: spawn"

Available tasks:
- **Resolve Dependencies** - Download project dependencies
- **Clean Build** - Clean the build folder  
- **Build** - Build the project
- **Bundle** - Bundle for HTML5, Windows, macOS, Linux, Android, iOS

See [`DEFOLD_SETUP.md`](DEFOLD_SETUP.md) for detailed setup instructions.

## Code Snippets

**Note:** Zed extensions do NOT support bundled snippets. Install them separately using the provided script.

### Quick Install Snippets

```powershell
.\install-snippets.ps1
```

The extension provides 26 code snippets for common Defold patterns:

### Lifecycle Functions
- `init` - Initialize script
- `final` - Finalization logic
- `update` - Frame update
- `fixed_update` - Fixed timestep update
- `on_message` - Message handling
- `on_input` - Input handling
- `on_reload` - Hot-reload handling

### GUI Functions
- `gui_init` - GUI initialization
- `gui_on_message` - GUI message handling
- `gui_on_input` - GUI input handling

### Common Patterns
- `factory_create` - Create object from factory
- `go_animate` - Animate game object
- `msg_post` - Post message
- `go_property` - Define script property
- `timer_delay` - Create timer
- `http_request` - HTTP request
- `acquire_input` - Acquire input focus
- `collision_response` - Handle collision
- `contact_point_response` - Handle contact point
- `module` - Lua module template

### GUI Functions
- `gui_init` - GUI initialization
- `gui_on_message` - GUI message handling
- `gui_on_input` - GUI input handling
- `gui_animate` - Animate GUI node

### Property Annotations
- `property` - Define script property
- `class` - Annotate script class
- `field` - Add field annotation
- `selftype` - Annotate self parameter
- `script_template` - Complete script with properties

### Usage Example

Type `init` and press Tab (or Enter) to insert:
```lua
function init(self)
    -- Initialization logic
end
```

## Building the Extension

### Prerequisites

- [Rust](https://rustup.rs/) (latest stable version)
- Zed editor installed

### Build Steps

1. Clone or navigate to this repository:
```bash
cd zed_defold_ext
```

2. Add the WebAssembly target:
```bash
rustup target add wasm32-wasip1
```

3. Build the extension:
```bash
cargo build --release --target wasm32-wasip1
```

This will create a `.wasm` file in `target/wasm32-wasip1/release/zed_defold.wasm`

### Installing the Extension

#### Quick Install (Windows)

Run the provided installation script:
```powershell
.\install.ps1
```

This is completely self-contained - no external dependencies needed!

#### Manual Installation

**Windows:**
```powershell
# Create the extension directory
New-Item -ItemType Directory -Force -Path "$env:LOCALAPPDATA\Zed\extensions\installed\defold"

# Copy the extension files
Copy-Item -Path "target\wasm32-wasip1\release\zed_defold.wasm" -Destination "$env:LOCALAPPDATA\Zed\extensions\installed\defold\extension.wasm" -Force
Copy-Item -Path "extension.toml" -Destination "$env:LOCALAPPDATA\Zed\extensions\installed\defold\extension.toml" -Force

# Copy grammars (bundled in the project)
New-Item -ItemType Directory -Force -Path "$env:LOCALAPPDATA\Zed\extensions\installed\defold\grammars"
Copy-Item -Path "grammars\lua.wasm" -Destination "$env:LOCALAPPDATA\Zed\extensions\installed\defold\grammars\lua.wasm" -Force

# Copy all language files (all bundled in the project)
Copy-Item -Path "languages" -Destination "$env:LOCALAPPDATA\Zed\extensions\installed\defold\" -Recurse -Force
```

**macOS/Linux:**
```bash
# Create the extension directory
mkdir -p ~/Library/Application\ Support/Zed/extensions/installed/defold  # macOS
# or
mkdir -p ~/.local/share/zed/extensions/installed/defold  # Linux

# Copy the extension files (adjust path for Linux if needed)
cp target/wasm32-wasip1/release/zed_defold.wasm ~/Library/Application\ Support/Zed/extensions/installed/defold/extension.wasm
cp extension.toml ~/Library/Application\ Support/Zed/extensions/installed/defold/

# Copy grammars (bundled in the project)
mkdir -p ~/Library/Application\ Support/Zed/extensions/installed/defold/grammars
cp grammars/lua.wasm ~/Library/Application\ Support/Zed/extensions/installed/defold/grammars/

# Copy all language files (all bundled in the project)
cp -r languages ~/Library/Application\ Support/Zed/extensions/installed/defold/
```

3. Restart Zed editor

4. The extension should now be active. Open any `.script` or `.gui_script` file to test it.

## 📦 What's Included

The extension is completely self-contained with:

- ✅ Extension WASM binary (`extension.wasm`)
- ✅ Extension configuration (`extension.toml`)
- ✅ Bundled Lua grammar (`grammars/lua.wasm`)
- ✅ Complete language support files:
  - `highlights.scm` - Syntax highlighting rules
  - `brackets.scm` - Bracket matching rules
  - `indents.scm` - Indentation rules
  - `outline.scm` - Code outline rules
  - `embedding.scm` - Embedded language rules
  - `config.toml` - Language configuration
- ✅ Lua Language Server integration (auto-downloads on first use)

**No external dependencies needed!** Everything is bundled in the project.

## Development

### Method 1: Install Dev Extension (Recommended for Development)

1. In Zed, open the Command Palette (`Ctrl+Shift+P`)
2. Run: `zed: install dev extension`
3. Select this extension directory
4. Zed will automatically build and install the extension
5. Make changes and use `zed: reload extensions` to reload

### Method 2: Manual Build and Install

1. Build the extension:
```bash
cargo build --release --target wasm32-wasip1
```

2. Install using the script:
```bash
.\install.ps1
```

3. Restart Zed

4. Make changes and rebuild as needed

## Comparison with VSCode Extension

This extension focuses on **coding experience** (autocomplete, documentation):
- ✅ Same autocomplete quality as VSCode Defold extension
- ✅ No Defold binary path needed
- ✅ Zero configuration
- ❌ No build/bundle features (use Defold Editor for that)

See **[COMPARISON_WITH_VSCODE.md](COMPARISON_WITH_VSCODE.md)** for detailed comparison.

## Troubleshooting

### Extension not loading

- Make sure the WASM file is named `extension.wasm` (not `zed_defold.wasm`)
- Check that all files are in the correct directory structure
- Restart Zed after installation

### Language server not working

- The extension will automatically download the Lua Language Server on first use
- Check the Zed log for any error messages: `zed: open log`
- Make sure you're opening a file with `.script`, `.gui_script`, `.render_script`, or `.lua` extension

### Snippets not appearing

- **Install snippets first**: Run `.\install-snippets.ps1`
- Snippets must be in `%APPDATA%\Zed\snippets\defold.json` (Windows)
- The file must be named `defold.json` to match the language name
- Restart Zed after installation
- Type the full prefix (e.g., `init`) and press `Tab`
- See `SNIPPETS_INSTALL.md` for detailed instructions

### Defold API not recognized

**All Defold APIs work out of the box!** The extension uses Defold's official Language Server fork which includes all API documentation.

If autocomplete isn't working:
1. Make sure you're opening a `.script`, `.gui_script`, or `.render_script` file
2. Wait 10-20 seconds on first use (Language Server downloads automatically)
3. Look for "Lua Language Server" in the status bar
4. Try `Ctrl+Space` to manually trigger autocomplete

See **[DEBUG_AUTOCOMPLETE.md](DEBUG_AUTOCOMPLETE.md)** for detailed troubleshooting.

## License

Apache-2.0

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

