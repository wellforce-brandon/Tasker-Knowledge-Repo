# Common Intents
> Frequently used Android intents with Tasker parameters and examples.

## Key Facts
- Most common intents use the `android.intent.action.*` namespace
- System broadcast intents are useful for reacting to device state changes
- App-specific intents allow integration with third-party apps
- On Android 8+, many implicit broadcasts are restricted -- check the Android documentation for exceptions
- Tasker-to-Tasker communication can use custom intent actions

## Details

### System Intents

#### Opening Content
- **`android.intent.action.VIEW`** -- Opens a URL, file, or content URI
  - Target: Activity
  - Data: the URI to open (e.g., `https://example.com`, `file:///sdcard/doc.pdf`, `geo:37.7749,-122.4194`)
  - The system chooses the appropriate app based on the URI scheme and MIME type

- **`android.intent.action.SEND`** -- Share content to another app
  - Target: Activity
  - Mime-Type: `text/plain` for text, `image/jpeg` for images, etc.
  - Extra: `android.intent.extra.TEXT:Your message here`
  - Extra: `android.intent.extra.SUBJECT:Email subject`

- **`android.intent.action.SENDTO`** -- Send to a specific address
  - Target: Activity
  - Data: `smsto:1234567890` for SMS, `mailto:user@example.com` for email

#### Bluetooth Events (Receive)
- **`android.bluetooth.device.action.ACL_CONNECTED`** -- A Bluetooth device connected
- **`android.bluetooth.device.action.ACL_DISCONNECTED`** -- A Bluetooth device disconnected
- These are broadcast intents that Tasker can receive via Intent Received

#### Power and Battery (Receive)
- **`android.intent.action.BATTERY_CHANGED`** -- Battery level or charging state changed
- **`android.intent.action.POWER_CONNECTED`** -- Device plugged in
- **`android.intent.action.POWER_DISCONNECTED`** -- Device unplugged

#### Connectivity (Receive)
- **`android.net.wifi.STATE_CHANGE`** -- Wi-Fi connection state changed
- **`android.net.conn.CONNECTIVITY_CHANGE`** -- Network connectivity changed (deprecated on Android 7+ for background apps)

### App-Specific Intents

#### Media Control
- **`com.android.music.musicservicecommand`** -- Control the default music player
  - Extra: `command:play`, `command:pause`, `command:next`, `command:previous`
  - Target: BroadcastReceiver
- For broader media control, use Tasker's built-in **Media Control** action instead, which handles multiple players

#### Camera Intents
- **`android.media.action.IMAGE_CAPTURE`** -- Open camera to take a photo
  - Target: Activity
  - Returns the captured image
- **`android.media.action.VIDEO_CAPTURE`** -- Open camera to record video
  - Target: Activity

#### Home Assistant Integration
- **`io.homeassistant.companion.android.COMMAND`** -- Send commands to Home Assistant
  - Target: BroadcastReceiver
  - Package: `io.homeassistant.companion.android` (or `.minimal` for minimal version)
  - Extra: `command:command_broadcast_intent`
  - Additional extras define the specific command and parameters

### Tasker-to-Tasker Intents
- Use a custom action string (e.g., `com.myname.myproject.MY_ACTION`) to communicate between Tasker profiles
- Send with Target: BroadcastReceiver
- Receive with Intent Received event matching the same action
- Pass data through extras
- Useful for decoupling tasks and creating modular designs

### Settings and System Actions
- **`android.settings.WIFI_SETTINGS`** -- Open Wi-Fi settings
  - Target: Activity
- **`android.settings.BLUETOOTH_SETTINGS`** -- Open Bluetooth settings
  - Target: Activity
- **`android.settings.APPLICATION_DETAILS_SETTINGS`** -- Open app info page
  - Target: Activity
  - Data: `package:com.example.app`

## Gotchas
- Many system broadcasts are restricted on Android 8+ -- apps must register receivers at runtime or be explicitly listed as exceptions
- Bluetooth intents require the `BLUETOOTH` permission, which Tasker should already have if Bluetooth access was granted
- Media control intents vary by music player app -- some apps use custom actions instead of the standard ones
- The `CONNECTIVITY_CHANGE` broadcast is largely deprecated for background receivers on Android 7+; use Tasker's built-in Net context instead
- When targeting specific apps with Package/Class, verify the exact package name -- it varies between app versions and variants
- Camera intents return results to the calling activity, which Tasker may not be able to capture directly -- consider using Tasker's built-in camera actions instead

## Related
- [[intent-basics.md]] -- how intents work in general
- [[event-handling.md]] -- using intents as event triggers
