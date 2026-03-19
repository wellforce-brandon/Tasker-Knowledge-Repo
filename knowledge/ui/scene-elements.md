# Scene Elements
> Scene element types, properties, and event handlers in Tasker.

## Key Facts
- Elements are the building blocks of Tasker scenes (buttons, text, images, etc.)
- Each element has properties (position, size, color) and event handlers (tap, long tap, value changed)
- Elements can be updated dynamically at runtime via task actions
- For modern UIs, prefer a single WebView element over multiple native elements

## Details
### Element Types
| Element | Purpose |
|---------|---------|
| Text | Display text with formatting |
| TextEdit | User text input field |
| Button | Tappable button |
| Image | Display an image |
| Slider | Numeric input slider |
| Spinner | Dropdown selection |
| Toggle | On/off switch |
| CheckBox | Boolean checkbox |
| WebView | Embedded web browser (HTML/CSS/JS) |
| Map | Google Maps view |
| Video | Video player |
| Oval / Rectangle | Shape elements |

### Common Properties
- **Position**: X/Y coordinates on the scene canvas
- **Size**: Width/Height in pixels
- **Visibility**: Shown/Hidden (toggleable at runtime)
- **Background Colour**: element fill color
- **Text Colour**: text foreground color
- **Text Size**: font size

### Event Handlers (Tap, Long Tap, Value Changed)
Each element can trigger task actions on:
- **Tap**: single tap
- **Long Tap**: press and hold
- **Value Changed**: when element value changes (TextEdit, Slider, Toggle, etc.)
- **Stroke**: touch/drag gestures (direction, start/end coordinates)

Event handlers run inline task actions or call named tasks.

### Dynamic Element Updates
Use these actions to modify elements at runtime:

| Action | What It Changes |
|--------|----------------|
| Element Value | The element's current value |
| Element Text | Displayed text content |
| Element Text Colour | Text foreground color |
| Element Text Size | Font size |
| Element Back Colour | Background color |
| Element Image | Displayed image |
| Element Position | X/Y coordinates |
| Element Size | Width/Height |
| Element Visibility | Show/Hide |
| Element Border | Border style |
| Element Depth | Z-order layering |
| Element Focus | Input focus |

### Testing Elements
- **Test Element** action reads current element properties (text, value, visibility, position, etc.)
- Useful for conditional logic based on UI state

## Gotchas
- Stacking scenes is faster than toggling element visibility within a single scene
- Native elements look dated compared to modern Android UI -- use WebView for polished interfaces
- Element coordinates are pixel-based and don't adapt to different screen sizes automatically
- Element event handlers run at high priority -- keep them lightweight to avoid blocking
- Map element requires Google Play Services

## Related
- [[scenes.md]] -- scene creation and display modes
- [[webview-and-js-bridge.md]] -- alternative to native scene elements
