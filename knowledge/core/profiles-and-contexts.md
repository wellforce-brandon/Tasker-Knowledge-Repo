# Profiles and Contexts
> How Tasker uses profiles and contexts to trigger tasks based on conditions.

## Key Facts
- A **profile** is a trigger condition paired with an **enter task** and an optional **exit task**
- The trigger condition is called a **context** -- one or more must be active for the profile to fire
- The enter task runs when the context becomes active; the exit task runs when it deactivates
- Multiple contexts in one profile form an AND condition (all must be true)

## Details
### Profiles
- Created from the Profiles tab via the `+` button
- After creating, you pick a context type, then assign enter/exit tasks
- A profile can have up to 4 contexts (all must be satisfied simultaneously)

### Context Types
- **Time**: triggers between a FROM and TO time
- **State**: active while a condition is true (e.g., WiFi Connected, Display On)
- **Event**: fires once when something happens (e.g., Notification Received, Shake)
- **Application**: active while a specific app is in the foreground
- **Day**: triggers on specific days of the week
- **Location**: triggers when entering/leaving a geographic area

### Time Context
- Uses a clock picker for FROM and TO times
- **Tap the label** (e.g., "FROM") to cycle between modes: fixed time, repeating, and variable
- **Variable mode**: tap the crossed-arrows icon next to the clock to enter a `%VARIABLE` name instead of a fixed time. This is how you feed dynamic sunrise/sunset times into a profile.
- Time context evaluates once per minute

### Sunrise/Sunset Triggering
There is **no built-in sun option** in the Time context despite some old docs and tutorials suggesting otherwise.

**Twilight plugin**: Previously used for sunrise/sunset profiles, but it is **deprecated** -- download links are broken and it's no longer available on the Play Store.

**Working alternative**: Use the built-in `Get Sunrise/Sunset` action to compute sun times, store them in global variables (`%SUNRISE`, `%SUNSET`), and feed those variables into a Time context using variable mode. See [[sunrise-sunset-automation.md]] for the full pattern.

## Gotchas
- **No built-in sunrise/sunset in Time context**: don't waste time looking for sun icons in the clock picker -- they don't exist in current Tasker versions
- **Twilight plugin is dead**: any guide referencing it is outdated; the plugin APK is no longer available
- **Time variable format**: when using variables in a Time context, the format must be `HH.MM` (with a dot, e.g., `7.30` for 7:30 AM), not `HH:MM`
- State contexts remain active continuously; Event contexts fire once and are done -- choosing the wrong type changes behavior entirely
- **Unfinished profiles are deleted**: if you back out of a profile before assigning a task, Tasker deletes the profile entirely. Always have your task ready before creating the profile.

## Related
- [[tasks-and-actions.md]] -- tasks are what profiles trigger
- [[event-handling.md]] -- event-driven patterns using profiles
- [[sunrise-sunset-automation.md]] -- full pattern for sun-based automation
