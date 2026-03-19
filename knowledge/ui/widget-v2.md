# Widget v2
> Modern home screen widget system (Tasker 6.4+) with visual editor, AI generation, and Material Design support.

## Key Facts
- Widget v2 replaces scene-based widgets starting in Tasker 6.4
- Visual drag-and-drop editor with real-time preview OR raw JSON mode for advanced users
- AI Generator (Tasker 6.5+) creates widget layouts from natural language descriptions using Gemini or OpenRouter
- Supports scrollable lists, circular progress bars, media player controls, blurred backgrounds, custom fonts
- Variable data binding allows dynamic content updates without recreating the widget
- Material Design token colors available on Android 14+ for system-matching themes

## Details

### Visual Editor
The visual editor provides a drag-and-drop interface for widget design:
- **Elements**: Text, Image, Shape, Spacer, Progress Bar, Button
- **Containers**: Row, Column, Box (for layering/overlapping elements)
- **Properties panel**: tap any element to configure size, color, padding, margins, click actions
- **Preview**: real-time preview updates as you edit
- Widgets are stored as JSON internally but the visual editor hides this complexity

### Raw JSON Mode
Switch to JSON mode for full control:
```json
{
  "type": "column",
  "padding": 16,
  "children": [
    {
      "type": "text",
      "text": "%DATE",
      "fontSize": 24,
      "color": "#FFFFFF"
    },
    {
      "type": "text",
      "text": "%BATT%%",
      "fontSize": 16,
      "color": "#B0B0B0"
    }
  ]
}
```
JSON mode is useful for templating, copying between widgets, and version control.

### AI Generator (6.5+)
Generate widget layouts from text descriptions:
1. Open Widget v2 editor
2. Tap the AI Generator button
3. Describe the widget (e.g., "media player with album art, play/pause, and track name")
4. Select AI provider: **Gemini** (free, requires API key) or **OpenRouter** (paid, multiple models)
5. Review and edit the generated layout
6. Iterate with follow-up prompts to refine

The AI generator understands Tasker variables and can bind them to elements automatically.

### Scrollable Lists
Create scrollable content within widgets:
- Use a `list` element type with an array variable as data source
- Each list item follows a template layout
- Bind array elements to text/image properties
- Supports click actions per item
- Performance: keep lists under ~50 items for smooth scrolling

```json
{
  "type": "list",
  "data": "%my_array",
  "itemTemplate": {
    "type": "row",
    "children": [
      {"type": "text", "text": "%item.title"},
      {"type": "text", "text": "%item.subtitle"}
    ]
  }
}
```

### Media Player Presets
Built-in media player widget templates:
- Album art display with blurred background
- Play/Pause, Previous, Next, Shuffle, Repeat buttons
- Track name, artist, album text fields
- Progress bar (linear or circular)
- Binds to `%MTRACK`, `%MARTIST`, `%MALBUM` and other media variables

### Circular Progress Bars
```json
{
  "type": "circularProgress",
  "value": "%BATT",
  "max": 100,
  "strokeWidth": 8,
  "color": "#4CAF50",
  "backgroundColor": "#333333",
  "child": {
    "type": "text",
    "text": "%BATT%%"
  }
}
```

### Blurred Backgrounds
Apply blur effects to widget backgrounds:
- Gaussian blur on images
- Configurable blur radius
- Useful for media player widgets (blurred album art as background)

### Custom Fonts
- Reference font files stored on device
- Google Fonts integration (specify font family name)
- Per-element font configuration
- Font weight and style support

### Variable Data Binding
Widgets update dynamically when bound variables change:
- Use `%variable_name` syntax in any text or value property
- Arrays supported for lists: `%my_array()`
- Tasker built-in variables work: `%TIME`, `%DATE`, `%BATT`, etc.
- Updates happen automatically when variables change -- no manual refresh needed
- Use `Widget v2 Update` action to force an immediate refresh

### Element Tags and Variable Visibility
- Assign tags to elements for programmatic control
- Show/hide elements based on variable values:
```json
{
  "type": "text",
  "text": "Charging",
  "tag": "charging_indicator",
  "visible": "%CHARGING ~ true"
}
```
- Tag-based targeting lets tasks modify specific elements without rebuilding the whole widget

### Material Design Token Colors (Android 14+)
Access the device's Material You dynamic color palette:
- `?colorPrimary`, `?colorSecondary`, `?colorTertiary`
- `?colorSurface`, `?colorOnSurface`, `?colorSurfaceVariant`
- `?colorPrimaryContainer`, `?colorOnPrimaryContainer`
- Colors automatically adapt to wallpaper changes and dark/light mode
- Fallback colors can be specified for older Android versions

## Gotchas
- Widget v2 requires Tasker 6.4+ -- older versions only support scene-based widgets
- AI Generator requires an API key (Gemini or OpenRouter) -- not included with Tasker
- Widget updates have a system-imposed minimum interval (~30 minutes for Android widgets) unless using `Widget v2 Update` action
- Complex widgets with many elements may render slowly on low-end devices
- Scrollable lists in widgets have limited interaction -- no swipe gestures, only tap and scroll
- Material Design tokens only work on Android 14+ -- use explicit hex colors for broader compatibility
- JSON syntax errors in raw mode produce cryptic error messages -- validate JSON before applying
- Widget v2 and legacy scene widgets are separate systems -- they don't share configuration

## Related
- [[scenes.md]] -- legacy scene system (Widget v2 replaces scene-based widgets)
- [[scene-elements.md]] -- element types in legacy scenes
- [[variables.md]] -- variable binding used in widgets
