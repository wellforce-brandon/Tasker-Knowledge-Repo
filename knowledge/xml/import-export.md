# Import and Export
> Importing and exporting Tasker projects, tasks, profiles, and scenes.

## Key Facts
- Task files use the naming convention `TaskName.tsk.xml`
- Profile files use `ProfileName.prf.xml`
- The standard push location on the device is `/sdcard/Tasker/`
- Import is done via long-press on the Tasks or Profiles tab header

## Details
### Export Formats
- **Tasks**: `.tsk.xml` -- contains full task definition with all actions
- **Profiles**: `.prf.xml` -- contains profile triggers and linked task references
- **Projects**: `.prj.xml` -- contains a bundle of profiles, tasks, and scenes

### Importing Tasks and Profiles
1. Place the XML file on the device (e.g., via `adb push`)
2. In Tasker, navigate to the Tasks or Profiles tab
3. **Long-press the tab header** (the word "TASKS" or "PROFILES")
4. Select **Import** from the menu
5. Browse to the file location and select it

### Pushing Files via ADB
```bash
# Push a task XML to the device
adb push Day_Mode.tsk.xml /sdcard/Tasker/

# Push wallpaper images
adb push day_wallpaper.jpg /sdcard/Tasker/wallpapers/

# Create a directory on the device first
adb shell "mkdir -p /sdcard/Tasker/wallpapers"
```

### ADB Push from Git Bash on Windows
Git Bash intercepts paths starting with `/` and rewrites them. For example, `/sdcard/` becomes `C:/Program Files/Git/sdcard/`. Fix this by setting `MSYS_NO_PATHCONV=1`:

```bash
# Single command
MSYS_NO_PATHCONV=1 adb push file.xml /sdcard/Tasker/

# For an entire session
export MSYS_NO_PATHCONV=1
adb push file.xml /sdcard/Tasker/
```

### TaskerNet (Cloud Sharing, v5.5+)
Share tasks/profiles/projects as web links anyone with Tasker can import:
1. Long-press a project/profile/task > **Export** > **As Link**
2. Generates a URL like `https://taskernet.com/shares/?user=AS35...`
3. Opening the link on a device with Tasker v5.4b+ triggers an import dialog
4. Shows full task data and asks confirmation before importing
5. Can optionally run/enable immediately after import

### Clipboard Import (v6.6+)
Copy Tasker XML or Data URIs to clipboard, then press Ctrl+V on Tasker's main screen to import.

### Programmatic Import
There is no stable intent-based import mechanism. The `net.dinglisch.android.tasker.ACTION_TASK` intent can *run* existing tasks but cannot import new ones. The recommended workflow:
1. Push XML via ADB
2. Import manually in Tasker UI (or use TaskerNet links)
3. Verify and adjust action parameters as needed

## Gotchas
- **Git Bash path mangling**: `/sdcard/` gets rewritten to `C:/Program Files/Git/sdcard/` unless you set `MSYS_NO_PATHCONV=1` before the `adb push` command
- **Invalid action codes in XML** cause import to fail silently or with a cryptic error like `"missing action of type 970"`. Always use codes from verified exports.
- **OneDrive paths**: some file tools (Node.js `fs`, etc.) may throw `EEXIST` errors when operating on files in OneDrive-synced directories; prefer working in non-synced directories or `/sdcard/Tasker/` directly
- The import dialog may not show `.xml` files if they're in an unexpected location -- always push to `/sdcard/Tasker/`
- **Import fails if same name exists**: a task/profile with an identical name already in Tasker will block import
- **File suffix matters**: Tasker filters by `.tsk.xml`, `.prf.xml`, `.prj.xml`, `.scn.xml` -- wrong suffix and the file won't appear

## Related
- [[task-xml-structure.md]] -- structure of exported XML
- [[action-codes.md]] -- codes found in exported files
- [[common-gotchas.md]] -- Git Bash and OneDrive path gotchas
