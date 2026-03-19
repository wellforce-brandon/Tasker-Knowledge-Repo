# Android Version Compatibility
> Android version-specific issues, manufacturer battery kill workarounds, and essential device settings for Tasker reliability.

## Key Facts
- Android 14+: Tasker Settings blocked from normal install (low target SDK). Fix: `adb install --bypass-low-target-sdk-block` or Shizuku
- Android 16: WiFi Tether broken without Shizuku. Install Shizuku from GitHub, not Play Store
- Android 16: Advanced Protection Mode may block sideloaded apps including Tasker
- Android 16: Airplane Mode toggle conflict with Shizuku (known bug)
- Minimum SDK raised to 27 (Android 8.1) in Tasker 6.6, target API 35
- WorkManager migration banner appears on Android 14+ (Tasker 6.7+) -- accept it
- After OS upgrade, background restrictions may reset -- re-check all settings

## Details

### Android 10+ Changes
- Background activity launch restrictions introduced
- Draw Over Other Apps permission required for launching activities from background
- Location access limited to "While in use" or "All the time" -- Tasker needs "All the time"
- Scoped storage introduced (affects file access in later versions)

### Android 12+ Changes
- Exact alarm permission required (SCHEDULE_EXACT_ALARM)
- Foreground service launch restrictions from background
- Approximate vs precise location split -- Tasker needs precise location for geofencing

### Android 13+ Changes
- Notification permission must be explicitly granted (POST_NOTIFICATIONS)
- Per-app language settings may affect Tasker locale detection
- Media file permissions granularized (images, video, audio separate)

### Android 14+ Changes
- Tasker Settings install blocked due to low target SDK
- Fix option 1: `adb install --bypass-low-target-sdk-block TaskerSettings.apk`
- Fix option 2: Install Shizuku and grant permission through it
- Foreground service types must be declared -- affects custom plugins
- WorkManager migration banner in Tasker 6.7+ should be accepted for reliable alarm scheduling

### Android 15 Changes
- Background activity restrictions further intensified
- Apps can no longer start activities from the background without explicit user interaction or a foreground service
- Foreground service types are more strictly enforced -- Tasker's monitoring service must declare correct types
- Edge-to-edge display enforced for all apps targeting API 35 -- may affect scene overlays
- Predictive back gesture can interfere with scene-based dialogs
- PendingIntent mutability checks are stricter -- affects some older plugin versions
- **Foreground service strategies**: Tasker uses `dataSync`, `mediaPlayback`, and `specialUse` foreground service types; ensure Tasker is not battery-optimized to maintain these

### Android 16 Changes
- WiFi Tether action broken without Shizuku granting permission
- Shizuku must be installed from GitHub releases, not Play Store (Play Store version is outdated)
- Advanced Protection Mode can block sideloaded apps entirely, including Tasker if not from Play Store
- Airplane Mode toggle has a known conflict when using Shizuku -- may not work reliably
- New Shizuku version required for compatibility -- older Shizuku builds may fail silently
- Background process limits further tightened -- foreground service is essential
- JobScheduler constraints more aggressive -- affects time-based profile accuracy
- See [[shizuku.md]] for Shizuku setup details and workarounds

### Foreground Service Strategies (Android 14+)
Tasker relies on foreground services to maintain background execution. Key strategies:
- **Always enable "Run in Foreground"**: Tasker Preferences > Monitor > Run in Foreground
- **Foreground service types** used by Tasker: `dataSync`, `mediaPlayback`, `specialUse`, `location`
- The notification shown by the foreground service can be customized (Tasker Preferences > Monitor)
- On Android 15+, apps targeting API 35 must declare exact foreground service types in manifest -- Tasker handles this automatically
- If Tasker's notification disappears, the foreground service was killed -- check battery optimization settings
- Some manufacturers (Samsung, Xiaomi) kill foreground services despite exemptions -- use dontkillmyapp.com for device-specific fixes

### Manufacturer Battery Kill Settings

Battery kill severity ratings from dontkillmyapp.com (0 = no issue, 5 = aggressive).

#### Samsung (5/5 severity)
- Remove Tasker from Sleeping Apps and Deep Sleeping Apps
- Add Tasker to Unmonitored Apps list
- Disable Adaptive Battery
- Lock Tasker in recent apps (swipe down on app card to lock)
- Settings > Apps > Tasker > Battery > Unrestricted

#### Xiaomi / MIUI / HyperOS (5/5 severity)
- Enable Auto Start for Tasker (Settings > Apps > Manage Apps > Tasker > Auto Start)
- Enable Display on Lock Screen
- Grant Additional Permissions (popup, background start)
- Disable MIUI auto backup for Tasker
- Lock Tasker in recent apps
- Set Battery Saver to "No restrictions"

#### Huawei / EMUI (5/5 severity)
- Lock Tasker in recent apps
- Disable PowerGenie: `adb shell pm disable-user com.huawei.powergenie`
- Settings > Apps > Tasker > Battery > Launch: set to Manual, enable all toggles
- Disable battery optimization for Tasker

#### OnePlus (5/5 severity)
- Disable battery optimization for Tasker
- Lock Tasker in recent apps
- Disable Adaptive Battery (Settings > Battery > Adaptive Battery)
- Settings > Apps > Tasker > Advanced > Optimize battery usage > disable

#### Google Pixel / AOSP (0/5 severity)
- Standard battery exemption is sufficient
- Settings > Apps > Tasker > Battery > Unrestricted

### Essential Settings for All Devices
- **Run in Foreground**: Tasker Preferences > Monitor > Run in Foreground: enabled
- **Reliable Alarms**: Tasker Preferences > Monitor > Use Reliable Alarms: Always
- **Battery Optimization**: Disabled for Tasker, all plugins, and Tasker Settings
- **Background Activity**: Enabled in device settings for Tasker
- **Draw Over Other Apps**: Enabled (required on Android 10+ for launching activities from background)
- **Notification Permission**: Granted (Android 13+)
- **Exact Alarm Permission**: Granted (Android 12+)

## Gotchas
- Shizuku Play Store version is outdated -- always install from GitHub releases
- After any OS upgrade, background restrictions may silently reset -- re-verify all permissions and battery settings
- WorkManager migration banner on Android 14+ (Tasker 6.7+) must be accepted for proper alarm behavior
- Samsung One UI may re-add Tasker to Sleeping Apps after updates -- check periodically
- Xiaomi MIUI may reset Auto Start permission after system updates
- Some manufacturers add new battery restrictions with each OS skin update without documentation
- Tasker Settings is a separate app that also needs battery optimization disabled

## Related
- [[permission-issues.md]] -- permission grants and ADB commands
- [[common-gotchas.md]] -- general gotchas including version-specific ones
- [[shizuku.md]] -- Shizuku setup for elevated permissions without root
