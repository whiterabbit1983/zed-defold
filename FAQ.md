# Frequently Asked Questions

## General Questions

### Q: Why don't I need to specify a Defold binary path?
**A:** The Defold binary path is only needed for:
- Building and bundling projects
- Opening Defold Editor from the editor
- Version detection for bob.jar

For **autocomplete and documentation**, we only need the API annotations, which we download automatically from GitHub. You can code in Zed and build in Defold Editor!

### Q: Does this work with my Defold version?
**A:** Yes! The annotations from [astrochili/defold-annotations](https://github.com/astrochili/defold-annotations) are kept up-to-date with Defold releases and are generally backward-compatible. The extension downloads the latest annotations which work with all recent Defold versions.

### Q: How is this different from the VSCode extension?
**A:** 
- **Same autocomplete** - Both use astrochili/defold-annotations
- **Simpler setup** - Zed extension is fully automatic
- **No build tools** - Zed focuses on coding, use Defold Editor for building
- **Faster** - Zed is optimized for speed

See [COMPARISON_WITH_VSCODE.md](COMPARISON_WITH_VSCODE.md) for full comparison.

### Q: Can I build my project from Zed?
**A:** Not yet. The current version focuses on providing excellent autocomplete and documentation. You can build and test in Defold Editor as usual. Future versions might add build support.

## Setup Questions

### Q: Do I need to install anything else?
**A:** No! The extension:
- Downloads Lua Language Server automatically
- Downloads Defold API annotations automatically
- Configures everything automatically
- Just install and start coding!

### Q: Where are the annotations downloaded?
**A:** To the extension's working directory:
- **Windows:** `C:\Users\<you>\AppData\Local\Zed\extensions\work\defold\defold-annotations\`
- **macOS:** `~/Library/Application Support/Zed/extensions/work/defold/defold-annotations/`
- **Linux:** `~/.local/share/zed/extensions/work/defold/defold-annotations/`

### Q: How do I update the annotations?
**A:** 
1. Delete the `defold-annotations/` folder in the extension directory
2. Reload the extension in Zed (`Ctrl+Shift+P` → "zed: reload extensions")
3. Annotations will re-download automatically

Or just reinstall the extension.

## Usage Questions

### Q: Autocomplete isn't showing up. What should I do?
**A:** Check these:
1. **File extension** - Must be `.script`, `.gui_script`, or `.render_script`
2. **Language Server status** - Look for "Lua Language Server" in bottom-right
3. **First-time download** - Wait 10-20 seconds on first use
4. **Manual trigger** - Press `Ctrl+Space` after typing `go.`
5. **Check logs** - `Ctrl+Shift+P` → "zed: open log"

### Q: How do I see function documentation?
**A:** 
- **Hover** - Move mouse over any Defold function
- **Autocomplete** - Documentation shows in completion menu
- **Type hints** - Enabled automatically while typing

### Q: Why do I see "undefined global" warnings?
**A:** You shouldn't! The extension pre-configures all Defold globals. If you see this:
1. Make sure the extension is activated (check status bar)
2. Reload extensions
3. Check that Language Server downloaded annotations

## Feature Questions

### Q: Does this support code snippets?
**A:** Yes! 20+ snippets for common Defold patterns:
- `init`, `update`, `on_message`, `on_input`
- `factory_create`, `go_animate`, `msg_post`
- And more!

Type the snippet name and press Tab.

### Q: Can I debug my Defold game in Zed?
**A:** Not currently. Debugging support might be added in future versions. For now, use:
- Defold Editor's built-in debugger
- VSCode with local-lua-debugger
- Print debugging (`pprint()`)

### Q: Does this work with Defold extensions?
**A:** Yes! Common extensions like Spine, Facebook, IAP are included in the Defold annotations. For custom native extensions, the global recognition works, but you might need to add annotations manually for full documentation.

### Q: Can I use this with DefOS, Monarch, or other libraries?
**A:** The extension recognizes core Defold APIs. For third-party libraries:
- You'll get Lua autocomplete (standard Lua features)
- Add library-specific annotations for full docs (optional)
- Or just use the libraries - they'll still work!

## Technical Questions

### Q: What Language Server does this use?
**A:** [LuaLS/lua-language-server](https://github.com/LuaLS/lua-language-server) - the same one used by VSCode Defold extension. It's automatically downloaded and configured.

### Q: Where are the annotations from?
**A:** [astrochili/defold-annotations](https://github.com/astrochili/defold-annotations) - the same high-quality annotations used by VSCode Defold extension.

### Q: Is this open source?
**A:** Yes! Apache 2.0 license. Repository: [Your repo URL]

### Q: Can I contribute?
**A:** Absolutely! Contributions welcome:
- Report issues
- Suggest features
- Submit pull requests
- Improve documentation

## Workflow Questions

### Q: What's the recommended workflow?
**A:** 
1. **Code in Zed** - Fast, great autocomplete
2. **Build in Defold Editor** - Use official tools
3. **Test in Defold Editor** - Or standalone build
4. **Version control** - Git as usual

This is how many developers already work - best of both worlds!

### Q: Can I use Zed as my only tool?
**A:** For coding, yes! For building/testing, you'll need Defold Editor. The extension provides excellent coding experience but doesn't replace Defold Editor's build tools.

### Q: Should I switch from VSCode?
**A:** Try both and see what you prefer:
- **Zed** - Faster, cleaner, great for focused coding
- **VSCode** - More features, integrated building, debugging

Many developers use both for different tasks!

## Troubleshooting

### Q: Extension shows as installed but doesn't work
**A:** 
1. Check file has correct extension (`.script`, `.gui_script`)
2. Look at status bar - should show "Defold"
3. Restart Zed completely
4. Check logs for errors

### Q: Language Server keeps restarting
**A:** 
1. Check available disk space
2. Try deleting and re-downloading annotations
3. Check Zed logs for specific error
4. Report issue with log details

### Q: Autocomplete is slow
**A:** 
- First use: Annotations downloading (one-time, 10-20s)
- After that: Should be instant
- If still slow: Check system resources, restart Zed

### Q: Getting errors about missing modules
**A:** 
This usually means annotations didn't download. Try:
1. Check internet connection
2. Manually delete extension directory
3. Reinstall extension
4. Check firewall isn't blocking download

## Getting Help

### Q: Where can I get help?
**A:** 
- Check this FAQ
- Read [README.md](README.md)
- Check [HOW_IT_WORKS.md](HOW_IT_WORKS.md)
- Open an issue on GitHub
- Ask in Defold forums (mention using Zed)

### Q: How do I report a bug?
**A:** Open a GitHub issue with:
1. Zed version
2. Extension version
3. Steps to reproduce
4. Zed log output
5. Screenshots if relevant

### Q: Can I request a feature?
**A:** Yes! Open a GitHub issue with:
- Feature description
- Use case
- Why it would be helpful
- Examples from other editors (if applicable)

---

## Didn't find your answer?

Open an issue on GitHub or check the documentation:
- [README.md](README.md) - Overview and setup
- [HOW_IT_WORKS.md](HOW_IT_WORKS.md) - Technical details
- [COMPARISON_WITH_VSCODE.md](COMPARISON_WITH_VSCODE.md) - VSCode comparison

