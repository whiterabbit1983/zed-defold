# Defold Tasks Installer for Zed Editor
# Run this script from your Defold project root to install build tasks

Write-Host "Installing Defold Tasks for Zed..." -ForegroundColor Cyan

# Check if we're in a Defold project
if (-not (Test-Path "game.project")) {
    Write-Host "Error: game.project not found!" -ForegroundColor Red
    Write-Host "Please run this script from your Defold project root directory." -ForegroundColor Red
    exit 1
}

# Create .zed directory
$zedDir = ".zed"
New-Item -ItemType Directory -Force -Path $zedDir | Out-Null

# Find the source tasks template
$sourcePath = Join-Path $PSScriptRoot "..\defold-tasks.json"
$destPath = Join-Path $zedDir "tasks.json"

if (Test-Path $sourcePath) {
    Copy-Item $sourcePath $destPath -Force
    Write-Host "Success! Tasks installed to: $destPath" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Set up environment variables for your system:" -ForegroundColor White
    Write-Host "   - BOB_JAR: Path to bob.jar" -ForegroundColor Gray
    Write-Host "   - DEFOLD_EMAIL: Your Defold email" -ForegroundColor Gray
    Write-Host "   - DEFOLD_AUTH: Your Defold auth token" -ForegroundColor Gray
    Write-Host ""
    Write-Host "2. Run tasks via: Ctrl+Shift+P -> 'task: spawn'" -ForegroundColor White
    Write-Host ""
    Write-Host "Available tasks:" -ForegroundColor Yellow
    Write-Host "  - Defold: Resolve Dependencies" -ForegroundColor White
    Write-Host "  - Defold: Clean Build" -ForegroundColor White
    Write-Host "  - Defold: Build" -ForegroundColor White
    Write-Host "  - Defold: Bundle for HTML5/Windows/macOS/Linux/Android/iOS" -ForegroundColor White
    Write-Host ""
    Write-Host "For more info, see README.md" -ForegroundColor Cyan
} else {
    Write-Host "Error: defold-tasks.json not found!" -ForegroundColor Red
    Write-Host "Make sure the script is in the extension directory." -ForegroundColor Red
    Write-Host ""
    Write-Host "You can also manually copy defold-tasks.json to .zed/tasks.json in your project." -ForegroundColor Yellow
    exit 1
}

