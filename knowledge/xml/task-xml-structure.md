# Task XML Structure
> Anatomy of Tasker XML exports -- tasks, profiles, projects, and context types.

## Key Facts
- Root element is `<TaskerData>` with attributes `sr=""`, `dession="no"`, and `tv="6.3.13"` (Tasker version)
- Each task is wrapped in `<Task sr="task0">` with metadata children
- Actions are `<Action sr="actN" ve="7">` elements containing `<code>` and argument elements
- Action arguments use `<Str>`, `<Int>`, and `<Img>` elements with `sr="argN"` attributes

## Details
### Top-Level Structure
```xml
<TaskerData sr="" dession="no" tv="6.3.13">
    <Task sr="task0">
        <cdate>1709612345678</cdate>    <!-- creation timestamp (epoch ms) -->
        <edate>1709612345678</edate>    <!-- last edit timestamp (epoch ms) -->
        <id>123</id>                     <!-- unique task ID -->
        <nme>Day_Mode</nme>              <!-- task name -->
        <Action sr="act0" ve="7">
            <!-- first action -->
        </Action>
        <Action sr="act1" ve="7">
            <!-- second action -->
        </Action>
    </Task>
</TaskerData>
```

### Action Elements
Each action has:
- `sr="actN"` -- sequential numbering starting at 0
- `ve="7"` -- action version (typically 7)
- `<code>` -- the numeric action code (see [[action-codes.md]])
- `<Str sr="argN" ve="3">` -- string arguments
- `<Int sr="argN" val="V"/>` -- integer arguments
- `<Img sr="argN" ve="2">` -- image arguments (for wallpaper, etc.)

### Action Argument Naming
Arguments are numbered sequentially: `arg0`, `arg1`, `arg2`, etc. The meaning of each argument depends on the action code.

**Run Shell (code 123) arguments:**

| Argument | Type  | Meaning                      |
|----------|-------|------------------------------|
| arg0     | Str   | Command string               |
| arg1     | Int   | Use Root (0=no, 1=yes)       |
| arg2     | Int   | Timeout (seconds, 0=none)    |
| arg3     | Str   | Store Output In (variable)   |
| arg4     | Str   | Store Errors In (variable)   |
| arg5     | Str   | (unused)                     |

### Complete Working Example: Day Mode.tsk.xml
```xml
<TaskerData sr="" dession="no" tv="6.3.13">
	<Task sr="task0">
		<cdate>1741200000000</cdate>
		<edate>1741200000000</edate>
		<id>1001</id>
		<nme>Day Mode</nme>
		<Action sr="act0" ve="7">
			<code>123</code>
			<Str sr="arg0" ve="3">settings put secure ui_night_mode 1</Str>
			<Int sr="arg1" val="0"/>
			<Int sr="arg2" val="0"/>
			<Str sr="arg3" ve="3"/>
			<Str sr="arg4" ve="3"/>
			<Str sr="arg5" ve="3"/>
		</Action>
	</Task>
</TaskerData>
```
This task runs a single Run Shell action to enable light mode. The Set Wallpaper action must be added via the Tasker UI after import (its XML code is unknown).

A matching **Night Mode** task is identical except:
- `<id>1002</id>`, `<nme>Night Mode</nme>`
- Command: `settings put secure ui_night_mode 2` (dark mode)

### Variable References in XML
Variables in command strings appear as-is: `%VARIABLE` in the `<Str>` value. Tasker resolves them at runtime.

### Profile XML Structure
```xml
<Profile sr="prof10" ve="2">
    <id>10</id>              <!-- REQUIRED: unique profile ID -->
    <mid0>112</mid0>         <!-- entry task ID -->
    <mid1>151</mid1>         <!-- exit task ID (optional) -->
    <nme>Profile Name</nme>  <!-- optional: name (absent for anonymous) -->

    <!-- Context nodes (at least one required, up to 4, AND logic) -->
    <Time sr="con0">...</Time>
    <State sr="con0" ve="2">...</State>
    <Event sr="con0" ve="2">...</Event>
    <App sr="con0">...</App>
</Profile>
```

### Context Type XML

**Time context:**
```xml
<Time sr="con0">
    <fh>7</fh><fm>30</fm>    <!-- from hour/minute (24h) -->
    <th>22</th><tm>0</tm>    <!-- to hour/minute -->
</Time>
```
Variable mode uses `%VARIABLE` in `HH.MM` format (dot-separated).

**State context** (code from Profile States table):
```xml
<State sr="con0" ve="2">
    <code>165</code>
    <Str sr="arg0" ve="3">%Variable</Str>
    <Int sr="arg1" val="1"/>
</State>
```

**Event context** (code from Profile Events table):
```xml
<Event sr="con0" ve="2">
    <code>599</code>
    <Str sr="arg0" ve="3">action.name</Str>
</Event>
```

**App context:**
```xml
<App sr="con0">
    <pkg>com.example.app</pkg>
    <cls>com.example.app.MainActivity</cls>
</App>
```

### Project XML Structure
```xml
<Project sr="proj0" ve="2">
    <name>My Project</name>       <!-- REQUIRED -->
    <pids>10,15</pids>            <!-- comma-separated profile IDs -->
    <scenes>Scene1,Scene2</scenes>
    <tids>112,150</tids>          <!-- comma-separated task IDs -->
</Project>
```

### Export File Types

| Type | Suffix | How to Identify |
|------|--------|----------------|
| Task | `.tsk.xml` | Only `<Task>` nodes, no `<Profile>` |
| Profile | `.prf.xml` | One `<Profile>` + associated `<Task>` nodes |
| Scene | `.scn.xml` | One `<Scene>` + optional anonymous tasks |
| Project | `.prj.xml` | One `<Project>` + all contained items |
| Backup | `.xml` | Multiple projects/profiles/tasks |

### Plugin Actions
All plugins use code **1000** with a `<Bundle>` element for configuration:
```xml
<Action sr="act0" ve="7">
    <code>1000</code>
    <Bundle sr="arg0">
        <Vals sr="val">...</Vals>
    </Bundle>
</Action>
```

## Gotchas
- The `dession` attribute is literally `"dession"` (not "session") -- this is Tasker's actual spelling
- `tv` attribute must match a valid Tasker version or import may fail
- Action numbering (`act0`, `act1`, ...) must be sequential with no gaps
- Empty `<Str>` arguments should still be included as `<Str sr="argN" ve="3"/>` -- omitting them can cause issues
- Timestamps (`<cdate>`, `<edate>`) are in milliseconds since epoch, not seconds
- Task collision handling (`<rty>`): 0=Abort New, 1=Abort Existing, 2=Run Both
- Anonymous tasks (triggered by profiles) have no `<nme>` element
- The "Base" project cannot be exported -- move items to a named project first
- `<dmetric>` element (display metrics) only appears when Scenes are included
- Import fails if a task/profile with the same name already exists

## Related
- [[action-codes.md]] -- numeric codes used in XML
- [[import-export.md]] -- how XML files are imported/exported
- [[shell-commands.md]] -- Run Shell action details
