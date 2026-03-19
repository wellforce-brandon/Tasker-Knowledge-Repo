# Shell Commands in Tasker
> Run Shell action, root vs non-root commands, and common shell patterns.

## Key Facts
- The **Run Shell** action executes shell commands on the Android device
- XML action code for Run Shell is **123**
- Root commands require either rooted device or Shizuku for certain permissions
- `WRITE_SECURE_SETTINGS` permission enables `settings put secure` commands without root

## Details
### Run Shell Action
- **Category**: Code
- **Command field**: any valid shell command
- **Use Root toggle**: when enabled, runs via `su`; when disabled, runs as the Tasker app user
- **Timeout**: defaults to no timeout; set a value to prevent hung commands
- **Store Output In / Store Errors In**: capture stdout/stderr into Tasker variables

### Run Shell XML Structure (Code 123)
```xml
<Action sr="act0" ve="7">
    <code>123</code>
    <Str sr="arg0" ve="3">settings put secure ui_night_mode 2</Str>
    <Int sr="arg1" val="0"/>  <!-- Use Root: 0=no, 1=yes -->
    <Int sr="arg2" val="0"/>  <!-- Timeout (seconds, 0=none) -->
    <Str sr="arg3" ve="3"/>   <!-- Store Output In (variable name) -->
    <Str sr="arg4" ve="3"/>   <!-- Store Errors In (variable name) -->
    <Str sr="arg5" ve="3"/>   <!-- (unused) -->
</Action>
```

### Dark Mode / Light Mode Commands
```bash
# Enable dark mode
settings put secure ui_night_mode 2

# Enable light mode
settings put secure ui_night_mode 1
```
These require `WRITE_SECURE_SETTINGS` permission. See [[permission-issues.md]].

**Recommended alternative**: Use the **Custom Setting** action (Settings > Custom Setting) instead of Run Shell for `settings put` commands. Set Type=Secure, Name=`ui_night_mode`, Value=1 or 2. This uses Tasker's own permission grant and avoids shell error 255. The Custom Setting action code is **235**.

### Common ADB Commands for Tasker File Management
```bash
# Push files to device
adb push Day_Mode.tsk.xml /sdcard/Tasker/
adb push wallpaper.jpg /sdcard/Tasker/wallpapers/

# Create directories on device
adb shell "mkdir -p /sdcard/Tasker/wallpapers"

# Grant permissions
adb shell pm grant net.dinglisch.android.taskerm android.permission.WRITE_SECURE_SETTINGS
```

### Root vs Non-Root
- **Non-root** (Use Root = off): runs as Tasker's app user; limited to permissions granted to Tasker
- **Root** (Use Root = on): runs as root via `su`; requires rooted device
- **Shizuku alternative**: grants elevated permissions without root -- enables `settings put secure` commands with Use Root off

## Gotchas
- `settings put secure` commands **silently fail** if `WRITE_SECURE_SETTINGS` is not granted -- no error is shown and the task continues
- Git Bash on Windows mangles `/sdcard/` paths in ADB commands -- use `MSYS_NO_PATHCONV=1` prefix
- Shell commands run synchronously -- a long-running command blocks the task until it completes or times out

## Related
- [[java-reflection.md]] -- alternative for Android API access
- [[permission-issues.md]] -- shell commands may need special permissions
- [[action-codes.md]] -- Run Shell is code 123
- [[import-export.md]] -- ADB push commands for file deployment
