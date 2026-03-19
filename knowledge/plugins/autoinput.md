# AutoInput
> AutoInput plugin: UI interaction, gestures, accessibility service, and screen queries. Single-action UI automation.

## Key Facts
- Current version: v2.x with Actions v2 rewrite, actively maintained by joaomgcd
- Single-action UI automation -- simulates touches, gestures, button presses, swipes, and app navigation
- Actions v2 is significantly faster than legacy v1 actions
- Requires Accessibility Service enabled to function
- Can query on-screen UI elements (text, IDs, descriptions) without screenshots

## Details

### UI Query
- Read text, content descriptions, and view IDs from any visible screen element
- Filter by app, package, class, text content, or view ID
- Returns structured data: text, ID, class name, bounds, clickable state
- Use queries to build conditional logic (e.g., "if button X is visible, click it")
- Can check if specific text exists on screen without OCR

### Click/Gesture Actions
- **Click**: Tap on coordinates, text match, or UI element ID
- **Long Click**: Long press with configurable duration
- **Swipe**: Define start/end points and duration
- **Gesture**: Record and replay complex multi-point gestures
- **Scroll**: Scroll within specific UI elements
- **Text Input**: Type text into focused fields
- **Key Events**: Send hardware key events (Back, Home, Recent Apps, etc.)
- Actions v2 uses direct accessibility node manipulation -- faster and more reliable than coordinate-based input

### Accessibility Service Setup
- Must be enabled in Settings > Accessibility > AutoInput
- Android may disable accessibility services after updates -- re-enable if automation stops working
- Some manufacturers aggressively kill accessibility services in battery optimization
- On Android 13+, restricted setting: may need to enable via Settings > Apps > AutoInput > Allow restricted settings

### Screen Text Detection
- Lightweight alternative to OCR -- reads accessibility tree, not pixels
- Works with standard Android UI elements
- Does not work with custom-drawn content (games, canvas-based UIs, some WebViews)
- Faster and more reliable than screenshot + OCR for standard apps

### Actions v2 vs Legacy
- v2 actions consolidated into a single "AutoInput Actions" entry in Tasker
- v2 is faster due to direct node interaction instead of coordinate injection
- v2 supports better element targeting with combined selectors
- Legacy actions still available for backward compatibility but should be migrated

## Gotchas
- Accessibility Service must be re-enabled after OS updates or app reinstalls on some devices
- Samsung and Xiaomi may kill the accessibility service aggressively -- apply battery kill workarounds
- Coordinate-based clicks break across different screen resolutions/DPIs -- prefer text or ID matching
- Some apps use custom rendering that accessibility services cannot read (games, Flutter apps, some WebViews)
- Actions v2 is a separate action entry from legacy -- do not confuse them in existing tasks
- Android 13+ treats accessibility as a restricted setting requiring explicit user opt-in

## Related
- [[plugin-architecture.md]] -- how AutoInput integrates with Tasker
- [[permission-issues.md]] -- accessibility service permissions and restricted settings
