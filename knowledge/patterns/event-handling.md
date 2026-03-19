# Event Handling
> Event-driven patterns in Tasker: profiles, intents, broadcasts, and event chaining.

## Key Facts
- **Profiles** are the primary event-handling mechanism in Tasker
- **Event contexts** fire once when the event occurs (e.g., Notification Received, SMS Received)
- **State contexts** remain active while a condition is true (e.g., Wi-Fi Connected, Orientation)
- Profiles can have an entry task (runs when activated) and an exit task (runs when deactivated)
- **Cooldown** setting on profiles prevents rapid re-firing of the same event

## Details

### Event Contexts vs State Contexts
Understanding the difference is fundamental to correct event handling:

**Event Contexts:**
- Fire once at the moment the event occurs
- Have no duration -- they trigger and are done
- Only support an entry task (no exit task)
- Examples: Notification Received, SMS Received, File Modified, Intent Received, Shake
- Cannot be combined with other event contexts in a single profile (one event per profile)

**State Contexts:**
- Active for a duration while the condition is true
- Support both entry task (when state becomes true) and exit task (when state becomes false)
- Examples: Wi-Fi Connected, Bluetooth Connected, Orientation, Power, Time range
- Multiple state contexts can be combined in a single profile (all must be true to activate)

### Intent-Based Events
- Use **Event > System > Intent Received** to react to broadcast intents from other apps
- Specify the intent action to match (e.g., `android.bluetooth.device.action.ACL_CONNECTED`)
- Optionally filter by category, scheme, or MIME type
- Intent extras become available as task variables
- See [[intent-basics.md]] for full details on variable naming from extras

### Notification Events
- **Built-in**: Event > UI > Notification provides basic notification detection
  - Filter by owner app and title text
- **AutoNotification plugin**: More powerful notification interception
  - Can read notification text, buttons, images
  - Can interact with notifications (dismiss, click buttons)
  - Supports notification grouping and filtering

### Calendar Changed Event (v6.5+)
- Event > Date/Time > Calendar Changed
- Fires when any calendar event is added, modified, or deleted
- Use Calendar actions to read the updated event details
- Useful for automations tied to scheduling changes

### Received Share Event (v6.5+)
- Event > Misc > Received Share
- Makes Tasker appear as a share target in Android's share menu
- When content is shared to Tasker, this event fires with the shared data
- Access shared content via `%shared_text`, `%shared_uri`, etc.
- Enables Tasker to process shared URLs, text, images, and files

### Extra Triggers (v6.6)
- Allow external mechanisms to trigger Tasker tasks
- Supported trigger sources:
  - **Home Screen shortcuts**: Trigger a task from a home screen icon
  - **Car Mode**: Auto-trigger when Android Auto connects
  - **Bixby Routines**: Samsung devices can trigger Tasker tasks from Bixby
  - **Quick Settings Tile**: Trigger from the notification shade
- Configured per-task in the task properties

### Chaining Events Across Tasks
Patterns for connecting multiple events and tasks:

#### Profile-to-Profile via Variable
1. Profile A fires Task A, which sets `%EventFlag` to a value
2. Profile B uses State > Variable Value context watching `%EventFlag`
3. When `%EventFlag` matches, Profile B activates

#### Profile-to-Profile via Intent
1. Task A uses Send Intent with a custom action
2. Profile B uses Intent Received matching that action
3. Data is passed through intent extras

#### Perform Task for Sequential Processing
1. Event profile fires the main task
2. Main task uses **Perform Task** to call sub-tasks
3. Sub-tasks can return values to the main task
4. Enables modular, reusable event handling

### Cooldown Setting
- Found in the profile properties (long-press profile > Properties)
- Specifies a minimum time between successive activations
- Prevents rapid re-firing when events occur in quick succession
- Example: a sensor event that fires many times per second can be throttled to once every 5 seconds
- Does not apply to the first trigger, only to subsequent ones within the cooldown window

### Event Priority and Ordering
- For ordered broadcasts, the Intent Received priority field controls receive order
- Higher priority values receive the broadcast first
- A receiver can abort an ordered broadcast to prevent lower-priority receivers from getting it
- Most broadcasts are NOT ordered -- priority has no effect on standard broadcasts

## Gotchas
- Event contexts can only have one event per profile -- you cannot combine two events in one profile
- State contexts can be combined (AND logic), but mixing event and state contexts in one profile has special behavior: the event only triggers while the state is active
- Exit tasks only run for state-based profiles, not event-based ones
- Cooldown applies per-profile, not per-event type -- if you need different cooldowns for the same event, create separate profiles
- Some events require specific permissions or services to be enabled (notification listener, accessibility service)
- On Android 8+, many system broadcast events are restricted for background receivers
- Battery optimization can prevent profiles from triggering reliably -- always exclude Tasker from battery optimization
- The Play button in Task Edit runs the task without event context, so event-specific variables will be empty during manual testing

## Related
- [[profiles-and-contexts.md]] -- how profiles define event triggers
- [[intent-basics.md]] -- intents as event sources
- [[common-intents.md]] -- specific intents for event handling
