# AutoNotification
> AutoNotification plugin: notification intercept, creation, buttons, and grouping. Rich notification management for Tasker.

## Key Facts
- Current version: v4.3.14 (Dec 2025), actively maintained by joaomgcd
- Target API 36 in latest release
- Create rich notifications with custom fonts, colors, backgrounds, images, and action buttons
- Intercept and read third-party app notifications
- Block specific app notifications (Android 8+ notification channels)
- Media notification style for media playback control
- Latest update fixed Reply action functionality

## Details

### Intercepting Notifications
- Read notification title, text, subtext, big text, app name, package name
- Trigger Tasker profiles/tasks when specific notifications appear
- Filter by app, title text, body text, or regex patterns
- Access notification extras (actions, icons, timestamps)
- Requires Notification Listener permission (Settings > Apps > Special access > Notification access)
- Can intercept notifications silently without showing them to the user

### Creating Custom Notifications
- Full control over notification appearance: title, text, subtext, icon, large icon, background image
- Custom fonts and text colors using HTML formatting
- Progress bars (determinate and indeterminate)
- Expandable big text, big picture, and inbox styles
- Notification channels support (Android 8+) with per-channel importance and sound
- Chronometer and countdown timer display
- Group notifications with summary

### Action Buttons
- Add up to 3 action buttons per notification
- Each button can trigger a different Tasker task
- Reply action for inline text input (fixed in v4.3.14)
- Icon support on action buttons
- Buttons can carry variable data back to Tasker

### Notification Grouping
- Group related notifications under a single summary
- Expandable groups show individual notifications
- Custom group summary text
- Auto-dismiss group when all children dismissed

### Media Notification Style
- Create media-style notifications with playback controls
- Play, pause, skip, previous buttons
- Album art display
- Integrates with Android media session for lock screen and system media controls

### Live Update Notifications (Tasker 6.6+)
Tasker 6.6 introduced native Live Update notifications that update in-place:
- Reissue a notification with the same ID to update content without dismiss/recreate flash
- Optimized path: only changed fields are pushed to the system
- Works with both built-in Notify and AutoNotification
- Ideal for: progress bars, timers, live sensor data, now-playing displays
- See [[notification-actions.md]] for implementation patterns

### Reply Action Fix (v4.3.14+)
The Notification Reply action was broken in earlier versions:
- Fixed in AutoNotification v4.3.14 (Dec 2025)
- Inline reply now correctly sends the reply text to the source app
- Requires the source app to support `RemoteInput` (inline reply API)
- Use `%anreply` variable to capture the user's reply text in Tasker

### Notification Grouping Patterns
Advanced grouping strategies with AutoNotification:
- **Group by category**: set Group ID to a category string (e.g., "email", "chat")
- **Auto-summary**: first notification creates the group; subsequent ones stack under it
- **Custom summary text**: configure the group summary notification separately
- **Group dismiss**: dismissing the summary dismisses all children
- **Per-group sounds**: different notification channels per group for distinct sounds

### Notification Blocking
- Block notifications from specific apps (Android 8+)
- Target specific notification channels within an app
- Useful for silencing noisy apps conditionally based on Tasker context
- Can restore blocked notifications when conditions change

## Gotchas
- Notification Listener permission may be revoked after OS updates -- re-check if intercept stops working
- Android 13+ requires POST_NOTIFICATIONS permission for creating notifications
- Some apps use non-standard notification structures that may not parse correctly
- Notification channels (Android 8+) are immutable after creation -- to change importance/sound, delete and recreate
- Heavy use of notification interception can impact battery life
- Reply action requires the source app to support inline reply (RemoteInput)

## Related
- [[plugin-architecture.md]] -- how AutoNotification integrates with Tasker
- [[permission-issues.md]] -- notification listener permissions
- [[notification-actions.md]] -- built-in Notify action and Live Update patterns
