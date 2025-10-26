#!/bin/bash
# Defold Tasks Installer for Zed Editor
# Run this script from your Defold project root to install build tasks

echo -e "\033[0;36mInstalling Defold Tasks for Zed...\033[0m"

# Check if we're in a Defold project
if [ ! -f "game.project" ]; then
    echo -e "\033[0;31mError: game.project not found!\033[0m"
    echo -e "\033[0;31mPlease run this script from your Defold project root directory.\033[0m"
    exit 1
fi

# Create .zed directory
ZED_DIR=".zed"
mkdir -p "$ZED_DIR"

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_PATH="$SCRIPT_DIR/../defold-tasks.json"
DEST_PATH="$ZED_DIR/tasks.json"

if [ -f "$SOURCE_PATH" ]; then
    cp "$SOURCE_PATH" "$DEST_PATH"
    echo -e "\033[0;32mSuccess! Tasks installed to: $DEST_PATH\033[0m"
    echo ""
    echo -e "\033[0;33mNext steps:\033[0m"
    echo -e "\033[0;37m1. Set up environment variables for your system:\033[0m"
    echo -e "\033[0;90m   - BOB_JAR: Path to bob.jar\033[0m"
    echo -e "\033[0;90m   - DEFOLD_EMAIL: Your Defold email\033[0m"
    echo -e "\033[0;90m   - DEFOLD_AUTH: Your Defold auth token\033[0m"
    echo ""
    echo -e "\033[0;37m2. Run tasks via: Ctrl+Shift+P -> 'task: spawn'\033[0m"
    echo ""
    echo -e "\033[0;33mAvailable tasks:\033[0m"
    echo -e "\033[0;37m  - Defold: Resolve Dependencies\033[0m"
    echo -e "\033[0;37m  - Defold: Clean Build\033[0m"
    echo -e "\033[0;37m  - Defold: Build\033[0m"
    echo -e "\033[0;37m  - Defold: Bundle for HTML5/Windows/macOS/Linux/Android/iOS\033[0m"
    echo ""
    echo -e "\033[0;36mFor more info, see README.md\033[0m"
else
    echo -e "\033[0;31mError: defold-tasks.json not found!\033[0m"
    echo -e "\033[0;31mMake sure the script is in the extension directory.\033[0m"
    echo ""
    echo -e "\033[0;33mYou can also manually copy defold-tasks.json to .zed/tasks.json in your project.\033[0m"
    exit 1
fi

