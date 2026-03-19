# Scenes
> Scene creation, display modes, and element interaction in Tasker.

## Key Facts
- Scenes are Tasker's built-in UI system for creating custom dialogs, overlays, and full-screen interfaces
- Scenes are NOT deprecated as of Tasker 6.6 but are considered legacy -- development focus has shifted elsewhere
- A scene contains elements (buttons, text, images, WebViews, etc.) laid out on a canvas
- **Widget v2** (Tasker 6.4+) is the modern replacement for widget-type scenes
- **AutoTools Web Screens** and **WebView scenes** are recommended over native scene elements for modern UIs

## Details
### Creating Scenes
1. Go to the **Scenes** tab
2. Tap **+** to create a new scene
3. Set dimensions and background
4. Add elements by long-pressing the canvas
5. Configure element properties and event handlers

### Display Modes
- **Dialog**: floating window, dismissible
- **Overlay**: always-on-top, shown over other apps (requires Draw Over Other Apps permission)
- **Activity**: full-screen, appears in recent apps
- **Overlay, Blocking**: overlay that intercepts all touches

### Scene Actions
| Action | What It Does |
|--------|-------------|
| Create Scene | Loads scene into memory |
| Show Scene | Displays scene on screen |
| Hide Scene | Removes from display but keeps in memory |
| Destroy Scene | Removes from memory entirely |

### Modern Alternatives

#### Widget v2 (Tasker 6.4+)
The modern replacement for scene-based home screen widgets. Key capabilities:
- **Visual editor**: drag-and-drop layout design with real-time preview
- **Raw JSON mode**: full control for advanced users and version control
- **AI Generator** (6.5+): generate widget layouts from natural language using Gemini or OpenRouter
- **Material You colors** (Android 14+): `?colorPrimary`, `?colorSurface`, etc. for dynamic theming
- Scrollable lists, circular progress bars, blurred backgrounds, custom fonts
- Variable data binding with automatic updates

See [[widget-v2.md]] for full documentation.

#### WebView Scene
Create a scene with a single WebView element and build your UI in HTML/CSS/JS. Access Tasker via `tk.` prefix functions. See [[webview-and-js-bridge.md]].

#### AutoTools Web Screens
Template-based web UI with community presets, Material Design components, and JSON data binding.

## Gotchas
- Scenes use non-standard rendering -- they don't look like native Android widgets
- Stacking scenes on top of each other is faster than toggling element visibility within a scene
- Scene elements cannot achieve native Material Design appearance without WebView
- Widget v2 (6.4+) is now preferred over scenes for home screen widgets
- Scenes require "Draw Over Other Apps" permission for overlay mode

## Related
- [[scene-elements.md]] -- detailed element types and properties
- [[webview-and-js-bridge.md]] -- alternative UI approach using WebView
- [[widget-v2.md]] -- Widget v2 system (modern widget replacement)
