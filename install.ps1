# Defold Extension for Zed - Installation Script
# Run this script after building the extension with: cargo build --release --target wasm32-wasip1

Write-Host "Installing Defold extension for Zed..." -ForegroundColor Green

# Define paths
$ExtensionDir = "$env:LOCALAPPDATA\Zed\extensions\installed\defold"

# Check if build exists
if (-not (Test-Path "target\wasm32-wasip1\release\zed_defold.wasm")) {
    Write-Host "Error: Extension not built. Run: cargo build --release --target wasm32-wasip1" -ForegroundColor Red
    exit 1
}

# Check if required files exist
$RequiredFiles = @(
    "extension.toml",
    "grammars\lua.wasm",
    "languages\defold\config.toml",
    "languages\defold\highlights.scm"
)

foreach ($file in $RequiredFiles) {
    if (-not (Test-Path $file)) {
        Write-Host "Error: Required file missing: $file" -ForegroundColor Red
        exit 1
    }
}

# Create extension directory
Write-Host "Creating extension directory..."
New-Item -ItemType Directory -Force -Path $ExtensionDir | Out-Null

# Copy extension files
Write-Host "Copying extension files..."
Copy-Item -Path "target\wasm32-wasip1\release\zed_defold.wasm" -Destination "$ExtensionDir\extension.wasm" -Force
Copy-Item -Path "extension.toml" -Destination "$ExtensionDir\extension.toml" -Force

# Copy grammars (self-contained, no external dependencies)
Write-Host "Copying Lua grammar..."
New-Item -ItemType Directory -Force -Path "$ExtensionDir\grammars" | Out-Null
Copy-Item -Path "grammars\lua.wasm" -Destination "$ExtensionDir\grammars\lua.wasm" -Force

# Copy language files (all self-contained)
Write-Host "Copying language configuration..."
Copy-Item -Path "languages" -Destination $ExtensionDir -Recurse -Force

Write-Host "`nInstallation complete!" -ForegroundColor Green
Write-Host "Extension installed to: $ExtensionDir" -ForegroundColor Cyan
Write-Host "`nAll files are self-contained - no external dependencies!" -ForegroundColor Green
Write-Host "`nPlease restart Zed editor to activate the extension." -ForegroundColor Yellow
Write-Host "After restarting, open any .script or .gui_script file to test!" -ForegroundColor Yellow
