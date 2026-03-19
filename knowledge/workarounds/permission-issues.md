# Permission Issues
> Permission grants, battery optimization, background execution, and Tasker reliability.

## Key Facts
- `WRITE_SECURE_SETTINGS` is required for `settings put secure` commands (e.g., dark mode toggle)
- This permission can be granted via **Shizuku** (no root needed) or **ADB**
- Without it, `settings put secure` commands **silently fail** -- no error, no effect
- Shizuku uses wireless debugging to grant permissions without a PC after initial setup

## Details
### WRITE_SECURE_SETTINGS
Required for modifying system secure settings, including:
- `ui_night_mode` (dark/light mode)
- Other `settings put secure` commands

#### Granting via ADB (one-time, requires PC)
```bash
adb shell pm grant net.dinglisch.android.taskerm android.permission.WRITE_SECURE_SETTINGS
```

#### Granting via Shizuku (no root, no PC after setup)
1. Install **Shizuku** from the Play Store
2. On the device, enable **Developer Options** > **Wireless Debugging**
3. In Shizuku, tap **Start via Wireless Debugging** and follow the pairing flow
4. Once Shizuku is running, open Tasker -- it will request permission from Shizuku
5. Grant the permission; Tasker can now use `WRITE_SECURE_SETTINGS`

**Shizuku advantage**: after initial setup, Shizuku can be restarted on-device without a PC. It persists across reboots if configured with the wireless debugging method.

### Other ADB-Grantable Permissions

| Permission | ADB Command Suffix | What It Enables |
|---|---|---|
| `DUMP` | `android.permission.DUMP` | Check running services |
| `READ_LOGS` | `android.permission.READ_LOGS` | Read system logs, clipboard monitoring, logcat events |
| `SET_VOLUME_KEY_LONG_PRESS_LISTENER` | `android.permission.SET_VOLUME_KEY_LONG_PRESS_LISTENER` | Intercept volume key long press |

All use: `adb shell pm grant net.dinglisch.android.taskerm <permission>`

Some permissions must be granted to **Tasker Settings** instead:
```bash
adb shell pm grant com.joaomgcd.taskersettings android.permission.WRITE_SECURE_SETTINGS
```

**Easy method**: Install the [Tasker Permissions](https://github.com/joaomgcd/Tasker-Permissions) app for a UI wrapper to grant all permissions.

### Battery Optimization Exemptions
- Tasker should be excluded from battery optimization to ensure profiles trigger reliably
- Settings > Apps > Tasker > Battery > Unrestricted

### Background Execution Limits
- Android 12+ aggressively kills background apps
- Grant Tasker the "Allow background activity" permission
- Some OEMs (Samsung, Xiaomi) have additional battery managers that must whitelist Tasker

## Gotchas
- **Silent failure**: `settings put secure ui_night_mode 2` does absolutely nothing without `WRITE_SECURE_SETTINGS` -- no error is shown in Tasker, the command appears to succeed
- **Shizuku needs restart after reboot**: Shizuku's service doesn't survive device reboots by default; you must re-start it (though this can be done on-device without a PC)
- **ADB grant is permanent**: once granted via `adb shell pm grant`, the permission persists across app updates and reboots
- **Package name**: Tasker's package is `net.dinglisch.android.taskerm` (note the `m` at the end)

## Related
- [[android-version-compat.md]] -- permissions change by Android version
- [[shell-commands.md]] -- ADB commands for permission grants
- [[common-gotchas.md]] -- permission-related gotchas
