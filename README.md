# Zed Defold Extension

A Defold game engine extension for the Zed editor that provides Lua language support for Defold script files.

## 🚀 Installation

### Using Zed's Built-in Extension Installer (Recommended)

The easiest way to install this extension is to use Zed's "Install Dev Extension" feature, which handles compilation automatically:

1. **Clone this repository**:
```bash
git clone https://github.com/whiterabbit1983/zed-defold.git
cd zed-defold
```

2. **Open Zed and install the dev extension**:
   - Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (macOS)
   - Type `zed: install dev extension`
   - Select the command and navigate to this extension's directory
   - Zed will automatically compile and install the extension

3. **Done!** The extension will appear in your installed extensions list.

> **Note**: Zed will automatically install the required `wasm32-wasip1` Rust target and compile the extension if needed. You can skip the manual steps below.

### Manual Build and Installation (Advanced)

If you prefer to build manually or Zed's auto-compilation doesn't work:

1. **Install the WebAssembly target** (if not already installed):
```bash
rustup target add wasm32-wasip1
```

2. **Build the extension**:
```bash
cargo build --release --target wasm32-wasip1
```

This creates `target/wasm32-wasip1/release/zed_defold.wasm`

3. **Install using Zed**:
   - Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (macOS)
   - Type `zed: install dev extension`
   - Navigate to this extension's directory
   - Zed will register the pre-built extension

### Prerequisites

- [Rust](https://rustup.rs/) (latest stable version) - for manual builds
- Zed editor installed

## Setup for Build Tasks

### Prerequisites

1. **Install Defold**: Download from https://defold.com/download/
2. **Install bob.jar**: Defold's command-line build tool
   - Download from: https://github.com/defold/defold/releases
   - Or use the one from your Defold installation

### Environment Variables

To use build tasks, add these to your shell profile (`~/.bashrc`, `~/.zshrc`, or Windows Environment Variables):

```bash
# Path to bob.jar (required for build tasks)
export BOB_JAR="/path/to/bob.jar"

# Defold credentials (optional, needed for cloud builds)
export DEFOLD_EMAIL="your.email@example.com"
export DEFOLD_AUTH="your_auth_token"

# Android signing (optional, for Android bundles)
export ANDROID_KEYSTORE="/path/to/keystore.keystore"
export ANDROID_KEYSTORE_PASS="your_password"
export ANDROID_KEYSTORE_ALIAS="your_alias"

# iOS signing (optional, for iOS bundles)
export IOS_IDENTITY="iPhone Developer: Your Name"
export IOS_PROVISIONING="/path/to/profile.mobileprovision"
```

### Getting Your Auth Token

1. Open Defold Editor
2. Go to **File** → **Preferences**
3. Copy your authentication token from the **General** tab

### Alternative: Shell Scripts

If you prefer shell scripts over Zed tasks, create these in your project:

**`build.sh` (macOS/Linux):**
```bash
#!/bin/bash
java -jar "$BOB_JAR" \
  --email "$DEFOLD_EMAIL" \
  --auth "$DEFOLD_AUTH" \
  build
```

**`bundle.sh` (macOS/Linux):**
```bash
#!/bin/bash
PLATFORM=${1:-js-web}
java -jar "$BOB_JAR" \
  --email "$DEFOLD_EMAIL" \
  --auth "$DEFOLD_AUTH" \
  --platform "$PLATFORM" \
  --bundle-output build/bundle \
  --variant debug \
  resolve build bundle
```

Make them executable:
```bash
chmod +x build.sh bundle.sh
```

Then run from Zed's terminal:
```bash
./build.sh
./bundle.sh x86_64-win32
```

### Available Platforms

- `js-web` - HTML5
- `x86_64-win32` - Windows 64-bit
- `x86_64-macos` / `arm64-macos` - macOS Intel/Apple Silicon
- `x86_64-linux` - Linux 64-bit
- `arm64-android` / `armv7-android` - Android
- `arm64-ios` / `x86_64-ios` - iOS


## Build Tasks

While Zed extensions don't support custom commands (yet), you can use **Zed's task system** to run Defold build commands:

### Quick Install

Use the installer script from the `scripts/` folder of this repository.

Run from your Defold project root:

**Windows:**
```powershell
# From your Defold project root
path\to\zed-defold\scripts\install-tasks.ps1
```

**Linux/macOS:**
```bash
# From your Defold project root
/path/to/zed-defold/scripts/install-tasks.sh
```

### Manual Setup (All platforms)

1. Copy `defold-tasks.json` from this repository to `.zed/tasks.json` in your Defold project
2. Set up environment variables (see [Environment Variables](#environment-variables) section above)
3. Run tasks via `Ctrl+Shift+P` → "task: spawn"

### Available tasks:
- **Resolve Dependencies** - Download project dependencies
- **Clean Build** - Clean the build folder  
- **Build** - Build the project
- **Bundle** - Bundle for HTML5, Windows, macOS, Linux, Android, iOS

### Build Tasks Troubleshooting

**"Could not find or load main class"**
- Check that `BOB_JAR` environment variable points to a valid bob.jar file
- Download bob.jar from https://github.com/defold/defold/releases

**"Authentication required"**
- Set `DEFOLD_EMAIL` and `DEFOLD_AUTH` environment variables
- Or remove `--email` and `--auth` from task arguments for local builds

**"Keystore not found"**
- Check that keystore paths in environment variables are correct
- Or remove keystore arguments from Android bundle tasks

## Code Snippets

**Note:** Zed extensions do NOT support bundled snippets. Install them separately using the provided script.

### Quick Install Snippets

Use the installer script from the `scripts/` folder of this repository:

**Windows:**
```powershell
path\to\zed-defold\scripts\install-snippets.ps1
```

**Linux/macOS:**
```bash
/path/to/zed-defold/scripts/install-snippets.sh
```

### Manual Installation

If you prefer to install snippets manually:

**Windows:**
```powershell
# Create snippets directory
New-Item -ItemType Directory -Force -Path "$env:APPDATA\Zed\snippets"

# Copy the snippets file
Copy-Item defold-snippets.json "$env:APPDATA\Zed\snippets\defold.json"
```

**macOS:**
```bash
# Create snippets directory
mkdir -p "$HOME/Library/Application Support/Zed/snippets"

# Copy the snippets file
cp defold-snippets.json "$HOME/Library/Application Support/Zed/snippets/defold.json"
```

**Linux:**
```bash
# Create snippets directory
mkdir -p ~/.config/zed/snippets

# Copy the snippets file
cp defold-snippets.json ~/.config/zed/snippets/defold.json
```

After installation, restart Zed or run `zed: reload extensions`.

### Available Snippets

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

**No external dependencies needed!** Everything is bundled in the project.

## Troubleshooting

## License

Apache-2.0

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

