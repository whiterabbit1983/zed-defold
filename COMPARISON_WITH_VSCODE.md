# Comparison with VSCode Defold Extension

This document compares this Zed extension with the [VSCode Defold extension](https://github.com/astrochili/vscode-defold).

## Feature Comparison

| Feature | VSCode Defold | Zed Defold | Notes |
|---------|---------------|------------|-------|
| **Autocomplete** | ✅ Yes | ✅ Yes | Both download astrochili/defold-annotations |
| **Function Signatures** | ✅ Yes | ✅ Yes | Full parameter types and docs |
| **Hover Documentation** | ✅ Yes | ✅ Yes | Same annotation source |
| **Syntax Highlighting** | ✅ Yes | ✅ Yes | Tree-sitter Lua grammar |
| **Auto-setup** | ✅ Yes (sync command) | ✅ Yes (automatic) | Zed is fully automatic |
| **Build/Bundle** | ✅ Yes | ❌ No | VSCode uses bob.jar |
| **Deploy to Mobile** | ✅ Yes | ❌ No | VSCode feature |
| **Open Defold Editor** | ✅ Yes | ❌ No | VSCode feature |
| **Debugging** | ✅ Yes | ❌ No | VSCode uses local-lua-debugger |
| **Snippets** | ✅ Yes | ✅ Yes | Common Defold patterns |

## Why No Defold Binary Path?

### VSCode Extension Uses It For:
1. **bob.jar operations** - Building and bundling
2. **Version detection** - Sync annotations for specific Defold version
3. **Opening editor** - Launch Defold from VSCode
4. **Resolving dependencies** - Project setup

### Zed Extension Approach:
For **autocomplete and documentation** (core developer experience):
- ✅ **No binary needed** - Annotations downloaded from GitHub
- ✅ **Always latest** - Main branch has newest Defold API
- ✅ **Zero configuration** - Works immediately
- ✅ **Version compatible** - Annotations work across recent versions

### What This Means:
- ✅ **Autocomplete works perfectly** without Defold binary
- ✅ **No setup required** - just install and code
- ❌ **Can't build from Zed** - use Defold Editor for that
- ❌ **Can't bundle** - use Defold Editor or bob.jar manually

## Recommended Workflow

### With Zed Extension:
1. **Code in Zed** - Full autocomplete and documentation
2. **Build in Defold Editor** - Use Defold for building/testing
3. **Version control** - Git workflow as usual

This is similar to how many developers already work:
- Code in their favorite editor
- Build/test in Defold Editor
- Best of both worlds!

### Alternative: Full VSCode Stack
If you need building/bundling from editor:
- Use VSCode with Defold Kit extension
- Has all integrated features
- Requires Defold binary path setup

## Why This Extension Exists

Many developers prefer Zed for:
- ⚡ **Speed** - Zed is extremely fast
- 🎯 **Focus** - Minimal, distraction-free
- 🚀 **Modern** - Built with Rust, GPU-accelerated
- 🧩 **Simplicity** - Clean UI, no clutter

This extension brings **Defold development** to Zed while maintaining the minimalist philosophy.

## Future Possibilities

Potential features that could be added:
- 🔜 Open Defold Editor command (if Defold path configured)
- 🔜 Run bob.jar for building
- 🔜 Version-specific annotations
- 🔜 Project templates

## Current Focus

**v0.1.0 focuses on the core developer experience:**
- ✅ Excellent autocomplete
- ✅ Full API documentation
- ✅ Zero setup
- ✅ Fast and lightweight

This covers 90% of what developers need while coding!

## Annotations Source

Both extensions use: [astrochili/defold-annotations](https://github.com/astrochili/defold-annotations)

**VSCode:** Downloads via extension command, can sync to specific version  
**Zed:** Downloads automatically on first use, always uses latest

Both approaches work well because:
- Defold API is mostly stable
- Annotations cover multiple versions
- Breaking changes are rare and documented

## Summary

### Choose Zed Extension If:
- ✅ You want fast, focused coding experience
- ✅ You build/test in Defold Editor anyway
- ✅ You prefer minimal setup
- ✅ You love Zed's speed and UI

### Choose VSCode Extension If:
- ✅ You want all-in-one IDE experience
- ✅ You need building/bundling from editor
- ✅ You want debugging support
- ✅ You need mobile deployment

### Use Both!
Many developers use:
- **Zed for coding** - Fast, focused, great autocomplete
- **Defold Editor for building** - Official tools, testing
- **VSCode for debugging** - When needed

Each tool excels at what it does best! 🎯

