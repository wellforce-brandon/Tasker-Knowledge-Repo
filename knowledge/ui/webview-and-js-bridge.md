# WebView and JS Bridge
> WebView-based UIs and JavaScript-Tasker communication for rich interfaces.

## Key Facts
- WebView is a scene element that renders HTML/CSS/JS inside Tasker
- Three modes: URI (web URLs), File (local HTML), Direct (inline HTML)
- When "Allow Phone Access" is enabled, JS can call all Tasker functions via `tk.` prefix
- WebView is the recommended approach for modern, responsive Tasker UIs

## Details
### Setting Up a WebView Scene
1. Create a new scene (Scenes tab > +)
2. Add a **WebView** element sized to fill the scene
3. Set the content mode:
   - **URI mode**: loads a web URL
   - **File mode**: loads a local HTML file (must use absolute path, e.g., `/sdcard/Tasker/ui/index.html`)
   - **Direct mode**: embed HTML/JS inline in the action

### JavaScript-to-Tasker Communication
With "Allow Phone Access" enabled, all Tasker JS functions are available with the `tk.` prefix:

```javascript
// Flash a message
tk.flash("Hello from WebView!");

// Run a Tasker task
tk.performTask("MyTask", 5, "param1", "param2");

// Read a global variable
var sunrise = tk.global("SUNRISE");

// Set a local variable
tk.setLocal("result", "some value");

// Read local variables as JSON
var locals = JSON.parse(tk.locals());
```

### Tasker-to-JavaScript Communication
Use the **Element Web Control** action to execute JS in a running WebView:
- Action: Element Web Control
- Scene: your scene name
- Element: your WebView element name
- Command: JavaScript code to execute

### HTML/CSS in Tasker
- Use File mode for complex UIs (easier to maintain than Direct mode)
- Reference CSS/JS files with absolute paths
- Full HTML5/CSS3 support (uses Android's V8/WebView engine)
- Responsive design works -- use viewport meta tag

### AutoTools Web Screens (Alternative)
AutoTools provides a higher-level UI framework:
- Template-based design with community presets
- JSON data binding
- Material Design-ready components
- Generally easier than raw HTML for common patterns

## Gotchas
- File paths must be **absolute** (e.g., `/sdcard/...`) -- relative paths fail
- Only enable "Allow Phone Access" for **trusted content** -- JS gains access to device files
- Enable **popup support** to prevent crashes from form elements (dropdowns, etc.)
- Use the **Page Loaded** event to trigger initialization logic
- Only one WebView JS engine runs at a time -- same limitation as JavaScriptlet
- WebView functions use `tk.` prefix, not the bare function names used in JavaScriptlet

## Related
- [[scenes.md]] -- WebView is a scene element
- [[javascript.md]] -- JS execution context differences
- [[scene-elements.md]] -- other UI element types
