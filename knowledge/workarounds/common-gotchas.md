# Common Gotchas
> Non-obvious Tasker behaviors, surprising limitations, and their solutions.

## Key Facts
- Tasker XML uses undocumented internal action codes -- guessing them causes import failures
- Git Bash on Windows rewrites Unix paths, breaking `adb push` commands
- The Twilight plugin for sunrise/sunset is deprecated and no longer available
- There is no built-in sunrise/sunset option in the Time context

## Details
### XML Action Code Guessing
Tasker uses numeric codes internally to identify actions (e.g., 123 = Run Shell). These codes are **not documented** and cannot be inferred from action names. Using a wrong code causes a hard import failure.

**Error**: `"missing action of type 970"` (or whatever the bad code is)
**Fix**: Only use codes obtained from actual Tasker exports. See [[action-codes.md]].

### Git Bash Path Mangling (Windows)
Git Bash (MSYS2) intercepts paths starting with `/` and rewrites them to Windows paths:
- `/sdcard/Tasker/` becomes `C:/Program Files/Git/sdcard/Tasker/`

**Fix**:
```bash
MSYS_NO_PATHCONV=1 adb push file.xml /sdcard/Tasker/
```
Or export it for the session: `export MSYS_NO_PATHCONV=1`

### OneDrive Path Issues
File operations (especially from Node.js/scripting tools) on OneDrive-synced directories can fail with `EEXIST` errors when creating directories or writing files. OneDrive's sync creates race conditions with file system operations.

**Fix**: Work in non-synced directories, or push files directly to `/sdcard/Tasker/` via ADB.

### Twilight Plugin (Deprecated)
Many older guides reference the Twilight plugin for sunrise/sunset-based profiles. This plugin is **no longer available**:
- Play Store listing is gone
- APK download links are broken
- No longer maintained

**Fix**: Use Tasker's built-in `Get Sunrise/Sunset` action instead. See [[sunrise-sunset-automation.md]].

### Time Profile Sunrise/Sunset
Old tutorials and even some Tasker documentation suggest there are sun icons in the Time context for sunrise/sunset. **These do not exist** in current Tasker versions (tested in 6.3.x).

**Fix**: Use variable-based Time profiles with `%SUNRISE`/`%SUNSET` variables populated by the `Get Sunrise/Sunset` action.

### Silent Failures
Several Tasker operations fail without any visible error:
- `settings put secure` without `WRITE_SECURE_SETTINGS` -- command runs but has no effect
- Invalid variable names (lowercase local vars used where globals are needed) -- silently empty

## Gotchas
- Always test shell commands manually via `adb shell` before relying on them in a Tasker task
- When an XML import fails, the error message may be vague -- check action codes first
- Variable names in Time context must use `HH.MM` format (dot separator), not `HH:MM`

## Related
- [[debugging.md]] -- how to investigate unexpected behavior
- [[android-version-compat.md]] -- version-specific gotchas
- [[permission-issues.md]] -- permission-related gotchas
- [[action-codes.md]] -- verified action codes to avoid import failures
- [[sunrise-sunset-automation.md]] -- working alternative to Twilight plugin
