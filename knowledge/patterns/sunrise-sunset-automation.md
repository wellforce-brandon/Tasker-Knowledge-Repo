# Sunrise/Sunset Automation
> Complete pattern for triggering tasks at sunrise and sunset using Tasker's built-in actions.

## Key Facts
- Tasker has a built-in **Get Sunrise/Sunset** action (no plugins needed)
- Sunrise/sunset times are stored in global variables and fed into a **variable-based Time profile**
- A daily refresh task updates the sun times each day
- The Twilight plugin is deprecated -- this pattern replaces it entirely

## Details
### Overview
The pattern has three components:
1. **Update Sun Times** task -- computes today's sunrise/sunset and stores them
2. **Daily Refresh** profile -- triggers the update task each day
3. **Main Day/Night** profile -- uses the computed times to trigger day and night tasks

### Task: Update Sun Times
This task computes sunrise/sunset and converts the times to `HH.MM` format for the Time profile.

**Actions in order (verified working):**

1. **Get Sunrise/Sunset** (Location category)
   - Leave all fields empty (Latitude, Longitude, Seconds Since Epoch) -- it auto-detects location
   - Outputs `%ss_sunrise` and `%ss_sunset` as epoch seconds
   - Works offline, no internet required (Tasker 6.6+)

2. **Parse/Format DateTime** (Date/Time category) -- for sunrise
   - Input Type: Seconds Since Epoch
   - Input: `%ss_sunrise`
   - Output Format: `H.mm`
   - Output goes to `%formatted`

3. **Variable Set** -- capture sunrise
   - Name: `%SUNRISE` (uppercase = global, persists)
   - To: `%formatted`

4. **Parse/Format DateTime** -- for sunset
   - Input Type: Seconds Since Epoch
   - Input: `%ss_sunset`
   - Output Format: `H.mm`

5. **Variable Set** -- capture sunset
   - Name: `%SUNSET`
   - To: `%formatted`

### Profile: Daily Refresh
- **Context type**: Time
- **FROM**: 12:01 AM
- **TO**: 12:01 AM (or leave as single trigger)
- **Enter task**: Update Sun Times

This ensures sun times are recalculated daily. Times shift gradually through the year, so daily updates keep the automation accurate.

### Profile: Day/Night Trigger
- **Context type**: Time
- **FROM**: tap the crossed-arrows icon, enter `%SUNRISE`
- **TO**: tap the crossed-arrows icon, enter `%SUNSET`
- **Enter task**: Day_Mode (runs at sunrise)
- **Exit task**: Night_Mode (runs at sunset)

### First-Time Setup
The Time profile won't work until `%SUNRISE` and `%SUNSET` have values. On first setup:
1. Manually run the **Update Sun Times** task once (tap the play button)
2. Verify the variables are set: long-press the Variables tab to inspect
3. Then activate the profiles

### Example Day_Mode / Night_Mode Tasks
**Day Mode:**
1. Set Wallpaper (Type: All, Image: day wallpaper)
2. Custom Setting (Type: Secure, Name: `ui_night_mode`, Value: `1`)

**Night Mode:**
1. Set Wallpaper (Type: All, Image: night wallpaper)
2. Custom Setting (Type: Secure, Name: `ui_night_mode`, Value: `2`)

Both tasks require `WRITE_SECURE_SETTINGS` for the dark mode toggle. See [[permission-issues.md]].

**Note:** Use **Custom Setting** (action code 235) instead of Run Shell for `settings put` commands. Run Shell can fail with error 255 even when the permission is granted; Custom Setting uses Tasker's internal permission and works reliably.

## Gotchas
- **Variables must exist before profile activation**: the Time profile with `%SUNRISE`/`%SUNSET` will not trigger if the variables are empty -- run the update task manually first
- **Time format must be HH.MM with a dot**: Tasker's variable-based Time context expects `7.30`, not `7:30` or `07:30:00`
- **Get Location v2 needs location permission**: ensure Tasker has location access, or the sunrise/sunset calculation will have no coordinates
- **Daily drift**: sunrise/sunset shift by ~1-2 minutes per day; the daily refresh profile keeps this accurate
- **Twilight plugin is dead**: don't install it; use this built-in pattern instead

## Related
- [[profiles-and-contexts.md]] -- how Time contexts and variable mode work
- [[permission-issues.md]] -- WRITE_SECURE_SETTINGS for dark mode commands
- [[shell-commands.md]] -- Run Shell action for settings commands
- [[tasks-and-actions.md]] -- task structure and action categories
