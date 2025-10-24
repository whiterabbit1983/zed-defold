# Defold Snippets Installer for Zed Editor
# Run this script to install Defold code snippets

Write-Host "Installing Defold Snippets for Zed..." -ForegroundColor Cyan

# Create snippets directory
$snippetsDir = "$env:APPDATA\Zed\snippets"
New-Item -ItemType Directory -Force -Path $snippetsDir | Out-Null

# Copy snippets file
$sourcePath = Join-Path $PSScriptRoot "defold-snippets.json"
$destPath = Join-Path $snippetsDir "defold.json"

if (Test-Path $sourcePath) {
    Copy-Item $sourcePath $destPath -Force
    Write-Host "Success! Snippets installed to: $destPath" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Restart Zed or run 'zed: reload extensions'" -ForegroundColor White
    Write-Host "2. Open a .script file" -ForegroundColor White
    Write-Host "3. Type 'init' and press Tab" -ForegroundColor White
    Write-Host ""
    Write-Host "Available snippets:" -ForegroundColor Yellow
    Write-Host "  script, init, update, on_message, on_input, final, on_reload," -ForegroundColor White
    Write-Host "  go_animate, msg_post, timer_delay, factory_create, http_request," -ForegroundColor White
    Write-Host "  gui_init, gui_on_message, gui_on_input, gui_animate," -ForegroundColor White
    Write-Host "  class, field, selftype, script_template, and more!" -ForegroundColor White
} else {
    Write-Host "Error: defold-snippets.json not found!" -ForegroundColor Red
    Write-Host "Make sure you are running this script from the extension directory." -ForegroundColor Red
}

