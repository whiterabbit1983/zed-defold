# Defold Setup Guide for Zed

This guide helps you set up Defold development in Zed.

## Prerequisites

1. **Install Defold**: Download from https://defold.com/download/
2. **Install bob.jar**: Defold's command-line build tool
   - Download from: https://github.com/defold/defold/releases
   - Or use the one from your Defold installation

## Quick Setup

### 1. Configure Environment Variables

Add these to your shell profile (`~/.bashrc`, `~/.zshrc`, or Windows Environment Variables):

```bash
# Path to bob.jar
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

### 2. Set Up Tasks in Your Defold Project

Create `.zed/tasks.json` in your Defold project root:

```bash
mkdir -p .zed
cp tasks-template.json .zed/tasks.json
```

### 3. Run Tasks

1. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on macOS)
2. Type "task: spawn"
3. Select a Defold task:
   - **Defold: Resolve Dependencies** - Download project dependencies
   - **Defold: Clean Build** - Clean the build folder
   - **Defold: Build** - Build the project
   - **Defold: Bundle for [Platform]** - Bundle for specific platform

## Alternative: Shell Scripts

If you prefer shell scripts, create these in your project:

### `build.sh` (macOS/Linux)
```bash
#!/bin/bash
java -jar "$BOB_JAR" \
  --email "$DEFOLD_EMAIL" \
  --auth "$DEFOLD_AUTH" \
  build
```

### `bundle.sh` (macOS/Linux)
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

## Available Platforms

- `js-web` - HTML5
- `x86_64-win32` - Windows 64-bit
- `x86_64-macos` / `arm64-macos` - macOS Intel/Apple Silicon
- `x86_64-linux` - Linux 64-bit
- `arm64-android` / `armv7-android` - Android
- `arm64-ios` / `x86_64-ios` - iOS

## Getting Your Auth Token

1. Open Defold Editor
2. Go to **File** → **Preferences**
3. Copy your authentication token from the **General** tab

## Troubleshooting

### "Could not find or load main class"
- Check that `BOB_JAR` environment variable points to a valid bob.jar file
- Download bob.jar from https://github.com/defold/defold/releases

### "Authentication required"
- Set `DEFOLD_EMAIL` and `DEFOLD_AUTH` environment variables
- Or remove `--email` and `--auth` from task arguments for local builds

### "Keystore not found"
- Check that keystore paths in environment variables are correct
- Or remove keystore arguments from Android bundle tasks

## Future Extensions API

Zed is actively developing their extension API. In the future, we may be able to add:
- Custom commands in the Command Palette
- Interactive setup wizards
- Build output parsing
- One-click bundling

Follow Zed's development: https://github.com/zed-industries/zed

