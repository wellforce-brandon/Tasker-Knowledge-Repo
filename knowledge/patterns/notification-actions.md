# Notification Actions
> Creating, managing, and intercepting notifications in Tasker -- built-in actions and plugin comparison.

## Key Facts
- Tasker has a built-in **Notify** action (code 523) for creating notifications -- no plugin needed for basic use
- **AutoNotification** plugin provides richer features: custom layouts, intercept, grouping, media style
- **Live Update notifications** (Tasker 6.6+) update notification content in real-time without recreating
- Android 8+ requires notification channels; Android 13+ requires POST_NOTIFICATIONS permission
- Notify Cancel (code 524) dismisses notifications by ID or title match
- Notification intercept via profile event can trigger tasks when any app posts a notification

## Details

### Built-in Notify Action
Found under Alert category. Creates standard Android notifications.

**Parameters:**
| Parameter | Description |
|-----------|-------------|
| Title | Notification title text |
| Text | Notification body text |
| Icon | Small icon (resource name or path) |
| Number | Badge number |
| Priority | Min / Low / Default / High / Max (pre-Android 8) |
| Category | Alarm, Call, Email, Message, etc. |
| On Click | Task to run when notification is tapped |
| On Dismiss | Task to run when notification is dismissed |
| Actions | Up to 3 button actions, each triggering a task |
| ID | Numeric ID for updating/canceling specific notifications |
| Sound | Custom sound file |
| LED Color | Notification LED color (devices with LED) |

**Example XML:**
```xml
<Action sr="act0" ve="7">
    <code>523</code>
    <Str sr="arg0" ve="3">My Title</Str>
    <Str sr="arg1" ve="3">My notification text</Str>
    <Img sr="arg2" ve="2">hd_ab_search</Img>
    <Int sr="arg6" val="0"/>
</Action>
```

### Notify vs AutoNotification Comparison

| Feature | Built-in Notify | AutoNotification |
|---------|----------------|------------------|
| Basic notification | Yes | Yes |
| Custom layouts | No | Yes |
| Notification intercept | Via profile event | Yes (more options) |
| Action buttons | 3 max | 3 max |
| Reply action | No | Yes (v4.3.14+) |
| Media style | No | Yes |
| Grouping | No | Yes |
| Custom fonts/colors | Limited | Yes |
| Big picture/inbox style | Limited | Yes |
| Progress bar | No | Yes |
| Chronometer | No | Yes |

**Recommendation:** Use built-in Notify for simple notifications. Use AutoNotification when you need rich formatting, intercept, grouping, or media controls.

### Notification Channels (Android 8+)
Android 8+ requires notifications to be assigned to a channel:
- Tasker creates a default channel automatically
- Create custom channels in Tasker Preferences > Notification Channels
- Channels control: importance, sound, vibration, LED, lock screen visibility
- **Channels are immutable after creation** -- delete and recreate to change settings
- Users can independently modify channel settings in Android Settings

### Creating Simple Notifications
```
Notify
  Title: Download Complete
  Text: %filename has been downloaded
  Icon: hd_ab_search
  ID: 100
  On Click: Open Downloads
```

### Creating Notifications with Action Buttons
```
Notify
  Title: Music Player
  Text: Now Playing: %MTRACK
  Action 1 Label: Pause
  Action 1 Task: Media Pause
  Action 2 Label: Next
  Action 2 Task: Media Next
  Action 3 Label: Close
  Action 3 Task: Dismiss Player
  ID: 200
```

### Live Update Notifications (Tasker 6.6+)
Update existing notification content without dismissing and recreating:
- Set the same **ID** as the original notification
- Use the **Notify** action again with updated text/title
- The notification updates in-place -- no flash or re-sort in the shade
- Useful for: download progress, timer countdowns, live sensor data, media now-playing

```
[Label: UPDATE_LOOP]
  Variable Set %progress To [calculated value]
  Notify
    Title: Downloading...
    Text: %progress%% complete
    ID: 300
  Wait 1 Second
  If [ %progress < 100 ]
    Goto Label: UPDATE_LOOP
  End If
  Notify
    Title: Download Complete
    Text: File saved
    ID: 300
```

In Tasker 6.6+, the update is optimized so that only changed fields are pushed, reducing overhead.

### Notify Cancel
Dismiss notifications created by Tasker:
```
Notify Cancel
  ID: 300           -- cancel by numeric ID
```
```
Notify Cancel
  Title: Download*  -- cancel by title pattern match
```

### Intercepting Third-Party Notifications
Use a **Notification** profile event:
- **Owner Application**: filter by package name (e.g., `com.whatsapp`)
- **Title**: filter by title text or pattern
- **Text**: filter by body text or pattern
- **Priority**: filter by notification priority

Available variables in the triggered task:
| Variable | Content |
|----------|---------|
| `%evtprm1` | Notification title |
| `%evtprm2` | Notification text |
| `%evtprm3` | Notification subtext |
| `%evtprm4` | Source app package |

For more advanced interception (reading actions, big text, images), use AutoNotification Intercept.

### Notification Grouping and Stacking
**AutoNotification grouping:**
- Set a Group ID on related notifications
- First notification with a Group ID creates the group
- Subsequent notifications join the group
- A summary notification is auto-created
- Expanding the group reveals individual notifications

**Built-in Tasker:** No native grouping support. Workaround: use a single notification with accumulated text (append new lines to the text field on each update).

### Importance Levels
| Level | Behavior |
|-------|----------|
| Min | No sound, no peek, shows in shade only |
| Low | No sound, no peek |
| Default | Sound, no peek |
| High | Sound, peek (heads-up) |
| Max | Sound, peek, always visible (used for alarms) |

On Android 8+, importance is set on the channel, not the individual notification.

## Gotchas
- **Android 13+ requires POST_NOTIFICATIONS permission** -- notifications silently fail without it
- **Notification channels are immutable** -- cannot change importance/sound after creation; must delete and recreate
- **Notify with same ID replaces** -- this is the mechanism for Live Update; don't reuse IDs accidentally
- **Notification intercept requires Notification Listener permission** -- may be revoked after OS updates
- **AutoNotification Reply action was broken until v4.3.14** -- ensure plugin is updated
- **Live Update works by reissuing Notify with the same ID** -- on pre-6.6, this causes a visible flash
- **Too many active notifications** cause Android to start collapsing them -- keep active count reasonable

## Related
- [[autonotification.md]] -- AutoNotification plugin for advanced notification features
- [[event-handling.md]] -- event-driven patterns including notification triggers
- [[flow-control.md]] -- loop patterns for notification update loops
- [[android-version-compat.md]] -- Android version notification requirements
