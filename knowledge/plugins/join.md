# Join
> Join plugin: cross-device messaging, commands, file sharing, and push notifications. Bridges Tasker across multiple devices and platforms.

## Key Facts
- Actively updated by joaomgcd
- Cross-device communication: push notifications, sync clipboard, share files, trigger Tasker tasks remotely
- Local network file transfer for fast LAN sharing
- Browser extensions for Chrome, Firefox, and Edge
- Native SMS sending from phone via remote command
- Remote app launching and media control
- Join Actions Tasker action for streamlined multi-device automation

## Details

### Sending Messages Between Devices
- Push text, URLs, files, and clipboard content to any registered device
- Target specific devices, device groups, or all devices
- Messages delivered via Google Cloud Messaging (GCM/FCM)
- Local network mode for faster delivery when devices are on same WiFi
- Messages can carry Tasker variables as key-value pairs

### Push Commands
- Predefined commands: ring phone, set wallpaper, open URL, send SMS, take screenshot
- Custom Tasker commands: trigger any named task on the remote device
- Commands can include parameters passed as variables to the receiving task
- Command history viewable in Join app and web interface
- Supports chaining: device A triggers device B which triggers device C

### File Sharing
- Push files between devices via cloud (Google Drive backend)
- Local network transfer for large files on same WiFi -- significantly faster
- Share images, documents, APKs, and any file type
- Files can be auto-saved to configurable directories on receiving device
- Maximum file size depends on Google Drive quota for cloud transfer

### Integration with Tasker Events
- **Join Event**: Profile trigger when a Join push is received
- Access received data via `%jointext`, `%joinclip`, `%joinurl`, `%joinfile`, etc.
- **Join Actions**: Single Tasker action to send pushes (replaces older multi-step setup)
- Can trigger tasks on remote devices and wait for response
- EventGhost and IFTTT integration for non-Android endpoints

### Browser Extensions
- Available for Chrome, Firefox, and Edge
- Push URLs, text, and clipboard from browser to phone
- Receive notifications from phone on desktop
- Send SMS from browser using phone's SIM
- Tab sharing between browser and device
- Extension communicates via Join's cloud API

### Remote SMS
- Send SMS from any device using the phone's native SMS capability
- Compose from browser extension, another phone, or API call
- Requires SMS permission granted on the sending phone
- MMS support for images and group messages
- Can be triggered by Tasker tasks on remote devices

### Media Control
- Control media playback on remote devices (play, pause, skip, volume)
- Works with any media app that uses Android's MediaSession API
- Can push media URLs to play on remote device

### REST API
- Join has a public REST API for integration with external services
- API key based authentication
- Endpoints for push, devices list, and SMS
- Useful for server-side automation, webhooks, and custom integrations
- API documentation available at joaoapps.com/join/api

## Gotchas
- Google Cloud Messaging requires Google Play Services -- does not work on degoogled devices
- Cloud pushes have a small delay (1-5 seconds typically); local network is near-instant
- File sharing via cloud counts against Google Drive storage quota
- Join requires a Google account for device registration and cloud routing
- Browser extensions must be logged into the same Google account as the phone
- SMS sending requires the phone to be online and have cellular service
- Free version limits number of devices; paid unlocks unlimited

## Related
- [[plugin-architecture.md]] -- how Join integrates with Tasker
- [[api-integration.md]] -- Join also has a REST API for external automation
