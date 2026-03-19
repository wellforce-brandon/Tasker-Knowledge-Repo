# Backup and Recovery
> Exporting, sharing, and recovering Tasker configurations -- manual, automated, and cloud methods.

## Key Facts
- Tasker can export individual tasks, profiles, projects, and scenes as XML files
- **TaskerNet** provides cloud sharing -- export as a link for community sharing or personal backup
- **Clipboard import** (Tasker 6.6+) lets you paste exported XML directly from clipboard
- Full Tasker backup: export the entire `/sdcard/Tasker/` directory including `userbackup.xml`
- Tasker auto-backup creates `userbackup.xml` periodically in the Tasker directory

## Details

### Manual XML Export
Export individual components from the Tasker UI:

**Task export:**
1. Tasks tab > long-press a task
2. Export > XML to Storage (saves `.tsk.xml`)
3. Or Export > Description to Clipboard (human-readable, not re-importable)

**Profile export:**
1. Profiles tab > long-press a profile
2. Export > XML to Storage (saves `.prf.xml`, includes linked tasks)

**Project export:**
1. Bottom bar > long-press project tab
2. Export > XML to Storage (saves `.prj.xml`, includes all profiles, tasks, scenes in project)

**Scene export:**
1. Scenes tab > long-press a scene
2. Export > XML to Storage (saves `.scn.xml`)

Default export location: `/sdcard/Tasker/` or a user-chosen directory.

### XML Import
1. Tap the Import button (varies by tab) or browse to the XML file
2. Tasker reads the XML and creates the component
3. Name conflicts are resolved by appending a number

Or use file manager to open `.tsk.xml` / `.prf.xml` / `.prj.xml` files -- Tasker registers as a handler for these extensions.

### Clipboard Import (Tasker 6.6+)
Paste Tasker XML directly from clipboard:
1. Copy XML text to clipboard (from a message, web page, etc.)
2. Open Tasker
3. Tasker detects valid XML on clipboard and offers to import

This is useful for sharing configurations via text channels (forums, chat apps, email).

### TaskerNet Cloud Sharing
Share Tasker configurations as web links:

**Export to TaskerNet:**
1. Long-press a task/profile/project
2. Share > TaskerNet
3. Add a description
4. Publish -- generates a shareable URL

**Import from TaskerNet:**
1. Open the TaskerNet link in a browser
2. Tap "Import" -- opens Tasker and imports the configuration
3. Or browse TaskerNet within Tasker: menu > TaskerNet

**Features:**
- Public sharing with community ratings and comments
- Version history -- update shared items without changing the link
- Search and browse community-shared automations
- Private links available (not listed publicly)

### Full Backup Strategy

#### What to Back Up
| Item | Location | Contains |
|------|----------|----------|
| `userbackup.xml` | `/sdcard/Tasker/` | All profiles, tasks, scenes, projects |
| Project exports | `/sdcard/Tasker/` | Individual project XML files |
| Tasker preferences | App data | Settings, plugin configs |
| Plugin data | Per-plugin | AutoNotification configs, etc. |

#### Automated Backup Task
Create a task that runs periodically to back up Tasker data:

```
Profile: Time [Every 24 hours]
Task: Backup Tasker
  1. Variable Set %date To %DATE
  2. Variable Convert %date Date>Custom (yyyyMMdd)
  3. Copy Dir
       From: /sdcard/Tasker
       To: /sdcard/Backups/Tasker_%date
  4. Zip
       Files: /sdcard/Backups/Tasker_%date
       Zip File: /sdcard/Backups/Tasker_%date.zip
  5. Delete Dir
       Dir: /sdcard/Backups/Tasker_%date
       Recurse: on
  6. List Files
       Dir: /sdcard/Backups
       Match: Tasker_*.zip
       Sort: Date
       To: %backups
  7. If [ %backups(#) > 7 ]
       Delete File: %backups(1)    -- delete oldest if more than 7
     End If
```

#### Cloud Sync
Combine automated backup with cloud sync:
- Back up to a folder synced by Google Drive / Syncthing / Dropbox
- Use HTTP Request to upload to cloud storage APIs
- Use Join plugin to send backup to another device

### Recovery from Corruption
If Tasker data becomes corrupted:

1. **Try auto-backup first**: Tasker creates `userbackup.xml` automatically
   - Location: `/sdcard/Tasker/userbackup.xml`
   - Import via Tasker menu > Data > Restore

2. **Use manual backups**: Import `.prj.xml` or `.tsk.xml` files

3. **Full reset and restore**:
   - Clear Tasker app data (Settings > Apps > Tasker > Clear Data)
   - Reinstall if needed
   - Import the most recent full backup (`userbackup.xml` or project exports)

4. **Recover from TaskerNet**: If you published your configurations, re-import from your TaskerNet profile

### Version Control with Git
For advanced users, track Tasker configurations in git:

```
Profile: File Modified [/sdcard/Tasker/*.xml]
Task: Git Commit Tasker
  1. Run Shell
       Command: cd /sdcard/Tasker && git add -A && git commit -m "Auto-commit %DATE %TIME"
       Timeout: 10
```

**Setup:**
```bash
cd /sdcard/Tasker
git init
echo "*.bak" > .gitignore
git add -A
git commit -m "Initial Tasker backup"
```

**Benefits:**
- Full history of every change
- Diff between versions to see what changed
- Branch for experimental configurations
- Push to GitHub/GitLab for off-device backup

**Requirement:** Git must be installed (via Termux or similar).

## Gotchas
- **userbackup.xml may not include everything** -- plugin configurations and scene bitmaps are stored separately
- **Export includes linked components** -- exporting a profile includes its linked tasks (good for sharing, but creates duplicates on import if tasks already exist)
- **TaskerNet links are public by default** -- use private links for sensitive automations
- **Clipboard import only works with valid Tasker XML** -- partial or corrupted XML is silently rejected
- **Large projects produce large XML files** -- a complex project can be several MB
- **Git on Android** requires Termux or a git binary -- not available natively
- **Auto-backup timing** is not configurable -- Tasker writes `userbackup.xml` at its own schedule
- **Clear Data erases everything** -- always verify backup integrity before clearing app data

## Related
- [[import-export.md]] -- XML file structure and import/export details
- [[task-xml-structure.md]] -- understanding the XML format
- [[file-operations.md]] -- file copy/zip actions used in backup tasks
- [[error-handling.md]] -- handling backup failures
