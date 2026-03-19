# Debugging
> Debugging techniques in Tasker: Flash, logs, variable inspection, and tracing.

## Key Facts
- **Flash** action is the quickest way to display variable values during task execution
- **Run Log** (Menu > More > Run Log) shows a history of all profile triggers and task executions
- Variables tab (VARS) in Tasker's main screen shows all currently set global variables
- Tasks can be tested individually with the **Play** button in the Task Edit screen
- Individual actions can be disabled without deleting them by long-pressing and toggling

## Details

### Flash Action for Quick Debugging
- Use **Alert > Flash** to display variable values at any point in a task
- Example: `Flash "http_code: %http_response_code, data: %http_data"`
- Flash shows briefly on screen and does not block task execution
- For longer display, use **Alert > Popup** or **Alert > Text Dialog** instead
- Flash can display multiple variables in one message for quick comparison
- Tip: prefix debug flashes with a marker like `[DBG]` so they are easy to identify and remove later

### Tasker Run Log
- Access via **Menu > More > Run Log** from the main Tasker screen
- Shows chronological history of:
  - Profile activations and deactivations
  - Task starts and completions
  - Event triggers and why they fired (or did not fire)
- Each entry includes a timestamp and relevant details
- Essential for diagnosing "why didn't my profile trigger?" questions
- The Run Log can be cleared and has a configurable maximum size

### Variable Inspection
- The **VARS** tab on Tasker's main screen lists all global variables and their current values
- Local variables exist only during task execution and are not shown in the VARS tab
- To inspect local variables, use Flash or write them to a file during task execution
- **Variable Search** action can check if a variable matches a pattern
- Use **Set Clipboard** action to copy complex variable contents for examination outside Tasker

### Systematic Debugging Approach

#### When a Task Does Not Work
1. Open the task and tap the **Play** button to run it manually
2. Add Flash actions before and after suspect actions to verify execution flow
3. Flash key variable values to verify they contain expected data
4. Check that variable names are spelled correctly (case-sensitive for locals)
5. Review the Run Log for any error messages

#### When a Profile Does Not Trigger
1. Check the **Run Log** for any mention of the profile
2. Verify all required permissions are granted (location, notification access, etc.)
3. Check that battery optimization is disabled for Tasker (Settings > Apps > Tasker > Battery > Unrestricted)
4. Ensure Tasker's accessibility service or notification listener is enabled if required
5. Test the profile's conditions manually -- are they actually being met?
6. Check if the profile is enabled (not crossed out in the Profiles tab)
7. On some devices, check manufacturer-specific battery/background restrictions

#### When Actions Produce Unexpected Results
1. Enable **Continue Task After Error** and check `%err`/`%errmsg` (copy to local vars first)
2. Verify variable types -- a number stored as a string may not compare correctly
3. Check for invisible whitespace in variable values (use Variable Search with regex)
4. Test with hardcoded values to isolate whether the issue is in the data or the logic

### Per-Action Disable
- Long-press any action in the Task Edit screen to access the context menu
- Toggle the action on/off without deleting it
- Disabled actions are shown with strikethrough text
- Useful for temporarily skipping actions during debugging
- Better than deleting and re-adding actions

### Popup Warnings and Errors
- Enable via **Menu > Preferences > UI > Popup Warnings/Errors**
- Shows system-level warnings about Tasker operations
- Displays errors that would otherwise be silent (e.g., failed actions without Continue Task After Error)
- Recommended to keep enabled during development, can disable for production use

### Write to File for Persistent Logging
- Use **File > Write File** to append debug information to a log file
- Include timestamps: `%DATE %TIME - %http_response_code - %http_data`
- Useful for debugging tasks that run unattended (e.g., overnight automations)
- Remember to clean up or disable file logging when debugging is complete

## Gotchas
- Flash messages disappear quickly -- for complex data, use Popup or write to file instead
- Local variables are not visible in the VARS tab -- you can only inspect them during execution
- The Run Log has a maximum size and older entries are discarded -- check it promptly
- Some profiles require specific conditions to trigger that may be hard to reproduce during testing (e.g., specific Bluetooth device, incoming call)
- The Play button runs the task without any profile context, so event-specific variables like `%evtprm1` will be empty
- On heavily customized Android skins (Samsung, Xiaomi, Huawei), additional battery optimization settings may silently kill Tasker in the background
- Variable names are case-sensitive for local variables but case-insensitive for global variables

## Related
- [[error-handling.md]] -- handling errors after finding them
- [[variables.md]] -- inspecting variable state
- [[common-gotchas.md]] -- known issues that look like bugs
