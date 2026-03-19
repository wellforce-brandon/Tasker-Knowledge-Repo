# File Operations
> Reading, writing, copying, listing, and managing files in Tasker with scoped storage considerations.

## Key Facts
- Core file actions: Read File, Write File, Read Line, Read Paragraph, Copy File/Dir, Delete File/Dir, List Files
- Android 10+ introduced scoped storage -- file access outside app-specific dirs requires `content://` URIs or SAF
- Tasker's `WRITE_EXTERNAL_STORAGE` / `READ_EXTERNAL_STORAGE` still works on Android 10-12 with `requestLegacyExternalStorage`
- Android 13+ completely enforces scoped storage -- use Tasker's built-in file picker or `content://` URIs
- Zip/Unzip and Read/Write Binary actions available for archive and binary file operations

## Details

### Read File
Reads entire file content into a variable.
```
Read File
  File: /sdcard/Documents/myfile.txt
  To Variable: %file_content
```
- Reads the full file into a single variable
- For large files, consider Read Line to process line by line
- Supports text encodings (UTF-8 default)

### Write File
Writes variable content to a file.
```
Write File
  File: /sdcard/Documents/output.txt
  Text: %data_to_write
  Append: off  (or on to add to existing file)
```
- Creates the file if it doesn't exist
- **Append mode** adds to the end of existing content
- Creates parent directories automatically

### Read Line
Reads a specific line from a file.
```
Read Line
  File: /sdcard/data.csv
  Line: %line_number
  To Variable: %line_content
```
- Lines are 1-indexed
- Useful in For loops to iterate through file lines
- Returns empty if line number exceeds file length

### Read Paragraph
Reads a paragraph (block of text between blank lines).
```
Read Paragraph
  File: /sdcard/notes.txt
  Paragraph: 1
  To Variable: %para
```

### Copy File / Copy Dir
```
Copy File
  From: /sdcard/Documents/source.txt
  To: /sdcard/Backup/source.txt
```
```
Copy Dir
  From: /sdcard/MyProject
  To: /sdcard/Backup/MyProject
```

### Move File
Uses Copy + Delete pattern or the dedicated Move action:
```
Move
  From: /sdcard/Downloads/file.zip
  To: /sdcard/Archives/file.zip
```

### Delete File / Delete Dir
```
Delete File
  File: /sdcard/temp/cache.tmp
```
```
Delete Dir
  Dir: /sdcard/temp
  Recurse: on
```
- **Recurse** deletes directory contents recursively
- No confirmation prompt -- be careful with variable paths

### Create Directory
```
Create Directory
  Dir: /sdcard/MyApp/logs
```
- Creates parent directories as needed

### List Files
Lists files in a directory into an array variable.
```
List Files
  Dir: /sdcard/Documents
  Match: *.txt
  Sort: Alpha
  To Variable: %files
```
- Result is an array: `%files()` with elements `%files(1)`, `%files(2)`, etc.
- **Match** supports glob patterns: `*.txt`, `photo_*`, `*.{jpg,png}`
- **Sort options**: Alpha, Date Modified, Size
- **Include Hidden**: toggle to include dotfiles
- **Recurse**: search subdirectories

### Browse Files
Opens a file picker dialog and returns the selected path:
```
Browse Files
  Dir: /sdcard/Documents
  Mime Type: */*
  To Variable: %selected_file
```

### Zip / Unzip
```
Zip
  Files: /sdcard/Documents/report.txt,/sdcard/Documents/data.csv
  Zip File: /sdcard/Archives/bundle.zip
  Password: optional_password
```
```
Unzip
  Zip File: /sdcard/Archives/bundle.zip
  To Dir: /sdcard/Extracted
  Password: optional_password
```

### GZip / GUnzip
For single-file gzip compression:
```
GZip
  File: /sdcard/logs/huge_log.txt
  Delete Original: on
```
```
GUnzip
  File: /sdcard/logs/huge_log.txt.gz
  Delete Original: on
```

### Read Binary / Write Binary
For non-text files (images, audio, etc.):
```
Read Binary
  File: /sdcard/Pictures/photo.jpg
  To Variable: %binary_data
```
Binary data is stored as base64-encoded strings in variables.

### Scoped Storage (Android 10+)

#### The Problem
Android 10+ restricts direct file access to:
- App-specific internal storage: `/data/data/net.dinglisch.android.taskerm/`
- App-specific external storage: `/sdcard/Android/data/net.dinglisch.android.taskerm/`
- Public directories only via MediaStore or SAF

#### Tasker's Handling
- **Android 10-12**: Tasker uses `requestLegacyExternalStorage` flag -- broad file access still works
- **Android 13+**: Legacy flag ignored. Tasker uses:
  - All Files Access permission (`MANAGE_EXTERNAL_STORAGE`) for most operations
  - Storage Access Framework (SAF) for restricted locations
  - `content://` URIs returned by file pickers

#### content:// URIs
When using file pickers or receiving files from other apps:
```
Variable Set %file_uri To content://com.android.providers.downloads.documents/document/1234
Read File
  File: %file_uri
  To Variable: %content
```
- Tasker can read/write `content://` URIs directly in most file actions
- Permissions on `content://` URIs are temporary -- they expire when Tasker restarts

#### Best Practices for Scoped Storage
1. Use `/sdcard/Tasker/` as your working directory (Tasker has guaranteed access)
2. Use file picker actions to get `content://` URIs for files outside Tasker's directories
3. Grant All Files Access permission when possible for broader compatibility
4. Avoid hardcoding paths to `/sdcard/Download/` or other public dirs -- use variables from file pickers

### Encoding
- Default encoding is UTF-8
- Specify encoding in Read File / Write File for other encodings
- Common alternatives: ISO-8859-1, UTF-16, ASCII
- BOM (Byte Order Mark) is preserved when present

## Gotchas
- **Delete Dir with Recurse is permanent** -- no recycle bin, no undo
- **content:// URI permissions are temporary** -- if Tasker restarts, you lose access; re-pick the file
- **List Files returns full paths** -- each array element is the complete path, not just the filename
- **Write File without Append overwrites** -- existing content is lost
- **Large files in variables** can cause memory issues -- Tasker variables have practical limits around 1-2 MB of text
- **Binary data is base64** -- a 1 MB file becomes ~1.37 MB as base64 in a variable
- **File operations on SD cards** (removable storage) require SAF on Android 5+ -- direct paths don't work
- **Line endings**: Read File preserves original line endings (CRLF vs LF); Write File uses the device default

## Related
- [[shell-commands.md]] -- Run Shell for advanced file operations (cp, mv, find, etc.)
- [[android-version-compat.md]] -- scoped storage changes by Android version
- [[error-handling.md]] -- handling file operation failures
- [[import-export.md]] -- Tasker's own XML file import/export
