# Installing Defold Snippets for Zed

**Note:** Zed extensions do NOT support bundled snippets. Snippets must be installed separately by users.

## Quick Install

### Windows:
```powershell
# Create snippets directory if it doesn't exist
New-Item -ItemType Directory -Force -Path "$env:APPDATA\Zed\snippets"

# Copy the snippets file
Copy-Item "defold-snippets.json" "$env:APPDATA\Zed\snippets\defold.json"
```

### macOS:
```bash
# Create snippets directory if it doesn't exist
mkdir -p ~/.config/zed/snippets

# Copy the snippets file
cp defold-snippets.json ~/.config/zed/snippets/defold.json
```

### Linux:
```bash
# Create snippets directory if it doesn't exist
mkdir -p ~/.config/zed/snippets

# Copy the snippets file
cp defold-snippets.json ~/.config/zed/snippets/defold.json
```

## After Installation

1. **Restart Zed** or run `zed: reload extensions` from the Command Palette
2. **Open any `.script` file**
3. **Type a snippet prefix** (e.g., `init`) and press `Tab`

## Available Snippets

### Lifecycle Functions
- `script` - Full script template with all lifecycle functions
- `init` - Initialize script
- `update` - Frame update
- `fixed_update` - Fixed timestep update
- `on_message` - Message handling
- `on_input` - Input handling
- `final` - Finalization
- `on_reload` - Hot-reload handling

### Common Patterns
- `go_animate` - Animate game object
- `msg_post` - Post message
- `go_property` - Define script property
- `timer_delay` - Create timer
- `factory_create` - Create object from factory
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

## How to Use

1. Type the prefix (e.g., `init`)
2. Press `Tab`
3. The snippet expands with placeholders
4. Press `Tab` again to jump between placeholders
5. `$0` marks the final cursor position

## Troubleshooting

**Q: Snippets don't appear in autocomplete?**
- Make sure the file is named `defold.json` (not `defold-snippets.json` or `lua.json`)
- Restart Zed after installation
- Check that the file is in the correct directory
- The file must be named `defold.json` to match the language name in the extension

**Q: Where is the snippets directory?**
- Windows: `C:\Users\<YourName>\AppData\Roaming\Zed\snippets\`
- macOS: `~/.config/zed/snippets/`
- Linux: `~/.config/zed/snippets/`
- Or use Zed command: `snippets: open folder`

**Q: Why `defold.json` and not `lua.json`?**
- The snippets file name must match the language name from `config.toml`
- Our extension uses `name = "Defold"` → snippets in `defold.json`
- This prevents conflicts with the official Lua extension's `lua.json`

**Q: Can I customize the snippets?**
- Yes! Edit `defold.json` in the snippets directory
- Restart Zed after making changes

