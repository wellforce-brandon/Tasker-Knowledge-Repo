# Tasks and Actions
> Task structure, action execution order, and flow control in Tasker.

## Key Facts
- A **task** is an ordered list of **actions** that execute sequentially
- Actions are numbered starting from 0 in XML (`act0`, `act1`, ...) but shown as 1-based in the UI
- Each action belongs to a category (Display, Code, Location, Variables, etc.)
- Actions can be reordered by long-pressing and dragging in the task editor

## Details
### Task Structure
- Tasks have a name, a unique numeric ID, and a creation/edit timestamp
- A task can be run manually, triggered by a profile, or called from another task
- Tasks appear in the Tasks tab; tap `+` to create, tap a task to edit

### Action Categories and Notable Actions

| Category   | Action             | What It Does                                       |
|------------|--------------------|----------------------------------------------------|
| Display    | Set Wallpaper      | Sets launcher, lock screen, or both wallpapers     |
| Code       | Run Shell          | Executes a shell command (optionally as root)       |
| Location   | Get Location v2    | Gets current GPS/network location                  |
| Location   | Get Sunrise/Sunset | Computes sunrise/sunset times for a location        |
| Variables  | Variable Set       | Sets a variable to a value                          |
| Date/Time  | Parse/Format DateTime | Converts between date/time formats (epoch, etc.) |

### Set Wallpaper Action
Found under **Display** category:
- **Type** dropdown: Launcher / Lock Screen / Both
- **Image** picker: browse to an image file on the device
- **Options**: Scale, Crop, Center

### Run Shell Action
Found under **Code** category:
- **Command**: the shell command string
- **Use Root**: toggle for root execution
- **Timeout**: seconds before the command is killed
- **Store Output In**: optional variable to capture stdout
- **Store Errors In**: optional variable to capture stderr

### Action Execution Order
- Actions execute top-to-bottom in the order shown in the task editor
- Flow control actions (If, Else, End If, For, Goto) can alter the order
- The `Stop` action halts the task immediately

See [[flow-control.md]] for comprehensive flow control coverage (If/Else, For loops, Goto, Perform Task, per-action conditions, and common patterns).

### Task Collision Handling
When a profile triggers a task that's already running, Tasker uses the **collision handling** setting:

| Mode | Behavior |
|------|----------|
| **Abort New Task** | New trigger is ignored; existing instance keeps running |
| **Abort Existing Task** | Running instance is killed; new instance starts |
| **Run Both Together** | Both instances run simultaneously (default) |

Set collision handling: long-press task > Settings icon > Collision Handling.

**Run Both Together** can cause race conditions with shared global variables -- use Abort New or Abort Existing for tasks that modify shared state.

### Task Priority
- Priority ranges from 0 (lowest) to 50 (highest); default is 5 for user tasks, 6 for profile-triggered
- Higher priority tasks preempt lower priority tasks when competing for execution
- Set priority: long-press task > Settings icon > Priority
- Perform Task can override priority for subroutine calls
- Time-critical tasks (alarm responses, phone call handling) should use priority 9+

### Anonymous vs Named Tasks
- **Named tasks**: appear in the Tasks tab, reusable across profiles, can be called via Perform Task
- **Anonymous tasks**: created inline in a profile (tap the `+` next to a profile), not reusable
- Anonymous tasks cannot be called by name from other tasks
- Convert anonymous to named: long-press the task in the profile > Give It A Name

### Calendar Actions (Tasker 6.5+)
| Action | Code | Description |
|--------|------|-------------|
| Calendar Insert | 395 | Create calendar events |
| Calendar Update | 396 | Modify existing events |
| Calendar Delete | 397 | Remove events |
| Calendar Query | 398 | Search for events by date, title, etc. |

Calendar actions require calendar read/write permissions.

### Dark Mode Action (Code 361)
Toggle or set dark mode:
```
Dark Mode
  Mode: On / Off / Toggle
```
Works on Android 10+. On some manufacturer skins, additional toggles may be needed.

## Gotchas
- Actions that fail silently (like `settings put` without proper permissions) won't stop the task -- subsequent actions still run
- Reordering actions in the UI changes their `sr="actN"` numbering in the exported XML
- Some actions (like Set Wallpaper) have no known XML action code -- they must be added via the UI
- **Run Both Together** collision handling with shared globals causes race conditions -- use Abort New/Existing instead
- **Anonymous tasks can't be shared** -- if you need a task in multiple profiles, name it
- **Priority 0 tasks may never run** if higher-priority tasks are active -- use at least priority 1

## Related
- [[profiles-and-contexts.md]] -- profiles trigger tasks
- [[variables.md]] -- variables used within tasks
- [[action-codes.md]] -- XML numeric codes for actions
- [[shell-commands.md]] -- details on the Run Shell action
- [[flow-control.md]] -- comprehensive flow control: If, For, Goto, Perform Task, conditions
