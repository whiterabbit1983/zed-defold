#!/bin/bash
# Defold Snippets Installer for Zed Editor
# Run this script to install Defold code snippets

echo -e "\033[0;36mInstalling Defold Snippets for Zed...\033[0m"

# Determine Zed config directory based on OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    SNIPPETS_DIR="$HOME/Library/Application Support/Zed/snippets"
else
    # Linux
    SNIPPETS_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zed/snippets"
fi

# Create snippets directory
mkdir -p "$SNIPPETS_DIR"

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SOURCE_PATH="$SCRIPT_DIR/../defold-snippets.json"
DEST_PATH="$SNIPPETS_DIR/defold.json"

if [ -f "$SOURCE_PATH" ]; then
    cp "$SOURCE_PATH" "$DEST_PATH"
    echo -e "\033[0;32mSuccess! Snippets installed to: $DEST_PATH\033[0m"
    echo ""
    echo -e "\033[0;33mNext steps:\033[0m"
    echo -e "\033[0;37m1. Restart Zed or run 'zed: reload extensions'\033[0m"
    echo -e "\033[0;37m2. Open a .script file\033[0m"
    echo -e "\033[0;37m3. Type 'init' and press Tab\033[0m"
    echo ""
    echo -e "\033[0;33mAvailable snippets:\033[0m"
    echo -e "\033[0;37m  script, init, update, on_message, on_input, final, on_reload,\033[0m"
    echo -e "\033[0;37m  go_animate, msg_post, timer_delay, factory_create, http_request,\033[0m"
    echo -e "\033[0;37m  gui_init, gui_on_message, gui_on_input, gui_animate,\033[0m"
    echo -e "\033[0;37m  class, field, selftype, script_template, and more!\033[0m"
else
    echo -e "\033[0;31mError: defold-snippets.json not found!\033[0m"
    echo -e "\033[0;31mMake sure you are running this script from the extension directory.\033[0m"
    exit 1
fi

