# Shizuku
> Granting elevated permissions to Tasker without root using Shizuku and wireless debugging.

## Key Facts
- Shizuku grants ADB-level permissions to apps without rooting the device
- **Install from GitHub releases** (github.com/RikkaApps/Shizuku), NOT from Play Store (outdated version)
- Setup via wireless debugging (Android 11+) or ADB over USB
- Tasker 6.6+ has native Shizuku integration -- some actions automatically use Shizuku when needed
- Shizuku must be re-started after every device reboot (no persistence by default)
- Enables permissions like WRITE_SECURE_SETTINGS, DUMP, and package management without root

## Details

### What Shizuku Does
Shizuku runs a process with ADB-level (shell) privileges and allows authorized apps to execute commands through it. This bridges the gap between normal app permissions and root:

| Permission Level | Access |
|-----------------|--------|
| Normal app | Limited to granted runtime permissions |
| Shizuku (ADB/shell) | system settings, package management, accessibility grants |
| Root | Full system access |

### Installation
1. Download latest APK from **GitHub releases**: `github.com/RikkaApps/Shizuku/releases`
2. Install on device
3. **Do NOT use the Play Store version** -- it is significantly outdated and may not work with current Tasker

### Setup via Wireless Debugging (Android 11+)
1. Enable **Developer Options** (Settings > About Phone > tap Build Number 7 times)
2. Enable **Wireless Debugging** in Developer Options
3. Open Shizuku app
4. Tap **Start via Wireless Debugging**
5. Pull down notification shade -- tap the wireless debugging notification
6. Note the **pairing code** and **port**
7. Enter pairing code in Shizuku
8. Shizuku starts its background service

**On some devices** (Samsung, Xiaomi), wireless debugging resets on reboot. Re-pair after each restart.

### Setup via ADB over USB
```bash
adb shell sh /sdcard/Android/data/moe.shizuku.privileged.api/start.sh
```
Or use Shizuku's built-in command shown in the app.

### Permissions Grantable via Shizuku
Common permissions Tasker can leverage through Shizuku:

| Permission | What It Enables |
|-----------|----------------|
| `WRITE_SECURE_SETTINGS` | Modify system settings (brightness, rotation, etc.) |
| `DUMP` | Access system dumps and battery stats |
| `PACKAGE_USAGE_STATS` | App usage statistics |
| `CHANGE_COMPONENT_ENABLED_STATE` | Enable/disable app components |
| `INSTALL_PACKAGES` | Silent app installation |
| `DELETE_PACKAGES` | Silent app uninstallation |
| `MANAGE_USERS` | User/profile management |

Grant via Shizuku's built-in permission manager or via Tasker Run Shell with Shizuku:
```
Run Shell
  Command: pm grant net.dinglisch.android.taskerm android.permission.WRITE_SECURE_SETTINGS
  Use Shizuku: on
```

### Tasker 6.6 Native Integration
Tasker 6.6+ detects Shizuku automatically and uses it for actions that need elevated permissions:
- **Custom Setting** action uses Shizuku for secure/global settings when available
- **WiFi Tether** action (requires Shizuku on Android 16)
- **Some system toggle actions** fall back to Shizuku if normal permissions insufficient
- No manual configuration needed -- Tasker checks for Shizuku and uses it transparently

### Granting Tasker Permissions via Shizuku
To grant Tasker a specific permission:
```bash
# Via ADB (if Shizuku not yet running)
adb shell pm grant net.dinglisch.android.taskerm android.permission.WRITE_SECURE_SETTINGS

# Via Shizuku (after Shizuku is running)
# Use Tasker's Run Shell action with Shizuku enabled
```

Or use the Shizuku app > Authorized Applications > grant permissions to Tasker.

### Lifecycle and Persistence

**Shizuku does NOT persist across reboots by default.**

After reboot:
1. Open Shizuku app
2. Re-start via wireless debugging or ADB
3. All previously authorized apps remain authorized -- only the background service needs restarting

**Automation options for re-start:**
- Tasker can detect boot with a Device Boot profile event, but cannot start Shizuku automatically (chicken-and-egg problem)
- Some custom ROMs/Magisk modules can auto-start Shizuku
- On rooted devices: Shizuku can be started via root and persists better

### Re-starting Shizuku On-Device
If you have Shizuku running and it dies (not from reboot):
```
Run Shell
  Command: sh /sdcard/Android/data/moe.shizuku.privileged.api/start.sh
  Use Root: on  (only if rooted)
```

Without root, you must use the wireless debugging pairing flow again.

## Gotchas
- **Play Store version is outdated** -- always install from GitHub releases
- **Must re-start after every reboot** -- there is no automatic persistence without root
- **Wireless debugging may reset** -- Samsung and Xiaomi devices often disable wireless debugging on reboot
- **Android 16: Airplane Mode toggle conflict** -- toggling airplane mode via Shizuku causes a known bug; may not work reliably
- **Not all permissions can be granted** -- Shizuku provides ADB-level access, not root; some operations still require root
- **Shizuku authorization is per-app** -- each app that wants to use Shizuku must be individually authorized
- **Battery impact is minimal** -- Shizuku's background service uses negligible resources
- **WiFi Tether on Android 16** requires Shizuku -- the action is completely broken without it

## Related
- [[android-version-compat.md]] -- Android version-specific Shizuku requirements
- [[permission-issues.md]] -- permission grants and ADB commands
- [[shell-commands.md]] -- Run Shell action that can use Shizuku
