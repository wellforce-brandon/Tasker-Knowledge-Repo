# AutoTools
> AutoTools plugin: Web Screens, JSON parsing, dialogs, secure settings, and more. Part of the AutoApps ecosystem.

## Key Facts
- Current version: v2.0+, actively maintained by joaomgcd
- Part of AutoApps subscription ($1.35/mo for 20+ plugins) or available standalone
- Swiss-army-knife plugin covering custom settings, web screens, data parsing, JSON handling, dialogs, and more
- Web Screens provide template-based UI with community presets using full HTML/CSS/JS
- Secure Settings functionality allows changing system settings that normally require ADB or root

## Details

### Web Screens
- Create custom UIs using HTML, CSS, and JavaScript
- Template system with community-shared presets available in-app
- Full JavaScript bridge to Tasker -- send/receive variables, trigger tasks
- Support for importing external libraries (jQuery, Material Design, etc.)
- Rendered in a WebView overlay or full-screen activity
- Can display data from Tasker variables dynamically
- Community presets cover common use cases: dashboards, media controllers, settings panels

### JSON Read/Write
- Parse JSON strings into Tasker variables
- Read specific keys using dot notation (e.g., `data.items.0.name`)
- Write/modify JSON data programmatically
- Useful for API response handling alongside HTTP Request action
- Supports arrays -- parsed into comma-separated Tasker arrays

### Dialogs
- Custom dialog creation beyond Tasker's built-in dialogs
- Support for input fields, lists, color pickers, date/time pickers
- Material Design styled dialogs
- Bottom sheets and floating dialogs
- Can chain multiple dialogs in sequence
- Results returned as Tasker variables

### Secure Settings
- Modify system/secure/global Android settings
- Many settings require ADB grant: `adb shell pm grant com.joaomgcd.autotools android.permission.WRITE_SECURE_SETTINGS`
- Common uses: change DPI, toggle rotation, modify animation scales, change default input method
- Some settings vary by Android version and manufacturer

### Additional Features
- **Text Processing**: Regex, find/replace, formatting
- **Clipboard Manager**: Enhanced clipboard with history
- **SSH**: Remote command execution via SSH
- **Screen Overlays**: Floating widgets and overlays outside of Web Screens
- **Data Storage**: Key-value persistent storage accessible across tasks

## Gotchas
- Web Screens can consume significant memory if complex -- keep templates lean
- Secure Settings ADB permission must be re-granted after app reinstall
- Some Web Screen community presets may be outdated or incompatible with newer Android versions
- JSON parsing of deeply nested structures can be slow with very large payloads
- Web Screen JavaScript bridge has a slight delay -- avoid rapid-fire communication loops

## Related
- [[plugin-architecture.md]] -- how AutoTools integrates with Tasker
- [[webview-and-js-bridge.md]] -- Web Screens vs native WebView approach
