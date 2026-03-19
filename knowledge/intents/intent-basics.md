# Intent Basics
> How Android intents work within Tasker -- sending, receiving, and structuring intents.

## Key Facts
- Intents are Android's inter-component messaging system for communication between apps and components
- Tasker can send intents via the **Misc > Send Intent** action
- Tasker can receive intents via the **Intent Received** event context
- Tasker can ONLY receive **broadcast** intents -- it cannot receive activity or service intents
- Intents are the underlying mechanism behind most plugin communication in Tasker

## Details

### Intent Structure (Action, Category, Data, Extras)
An intent consists of several fields that define what it does and where it goes:

- **Action**: A string describing what the receiver should do (e.g., `android.intent.action.VIEW`, `android.intent.action.SEND`)
- **Category**: Additional classification context for the intent (e.g., `android.intent.category.DEFAULT`)
- **Data**: A URI-formatted string representing the data to act on (e.g., `https://example.com`, `content://contacts/1`)
- **Mime-Type**: The MIME type of the data (e.g., `text/plain`, `image/jpeg`). Data and Mime-Type are mutually exclusive in Tasker's Send Intent action
- **Extras**: Key-value pairs carrying additional data, entered as colon-separated pairs (e.g., `subject:Hello World`)
- **Package**: Restricts delivery to a specific app package (e.g., `com.example.app`)
- **Class**: Restricts delivery to a specific component class within the package

### Extras Type Handling
Extras are auto-typed based on their value format:
- Plain number: `int` (e.g., `count:5`)
- Number with `L` suffix: `long` (e.g., `timestamp:1234567890L`)
- Decimal number: `float` (e.g., `ratio:3.14`)
- Decimal with `D` suffix: `double` (e.g., `precise:3.14159D`)
- `true` or `false`: `boolean` (e.g., `enabled:true`)
- Everything else: `String`
- Cast override with prefix: `(Uri)` forces a Uri type (e.g., `(Uri)path:content://media/1`)

### Sending Intents from Tasker
The **Send Intent** action (Misc > Send Intent) has these fields:
- Action, Cat (category), Data, Mime-Type, Extra, Extra, Package, Class
- **Target**: Choose between **Activity**, **BroadcastReceiver**, or **Service**
  - Activity: launches an app screen
  - BroadcastReceiver: sends to all registered receivers
  - Service: starts a background service

### Receiving Intents (Intent Received context)
The **Intent Received** event context creates an intent filter that matches incoming broadcasts:
- **Action**: The intent action to match
- **Category**: Optional category filter
- **Scheme**: URI scheme filter (e.g., `http`, `content`)
- **Mime Type**: MIME type filter
- **Priority**: For ordered broadcasts, higher priority receives first (range -999 to 999)

When an intent is received, Tasker provides data through variables:
- `%intent_data` -- the intent's data URI
- `%evtprm1` through `%evtprm5` -- event parameters

### Broadcast vs Activity vs Service
- **Broadcast intents** are delivered to all registered receivers simultaneously. Tasker can both send and receive these
- **Activity intents** launch a visible UI component. Tasker can send these but cannot receive them
- **Service intents** start background processing. Tasker can send these but cannot receive them
- When receiving, Tasker always acts as a BroadcastReceiver

### Extras as Task Variables
When an intent is received, its extras are converted to task variables:
- The extra key name is transformed: lowercased, with special characters replaced
- Example: an extra `MyApp_Count` becomes `%myapp_count`
- Array extras become indexed variables (e.g., `%fruits1`, `%fruits2`, `%fruits3`)
- Check the Run Log or use Flash to inspect which variables are created

## Gotchas
- Tasker can only receive **broadcast** intents -- if an app sends an activity or service intent, Tasker will not see it
- Data and Mime-Type fields are mutually exclusive in Send Intent -- setting both will cause issues
- Extra values are auto-typed, which can cause problems if a numeric string should remain a string -- there is no way to force string type for purely numeric values
- When receiving intents, the variable names derived from extras may not be obvious -- use the Run Log to discover them
- Some intents require specific permissions that Tasker may not hold
- On Android 8+, many implicit broadcast intents no longer work due to background execution limits
- Intent Received profiles may not trigger if the sending app targets only explicit intents (specifying a package/class that is not Tasker)

## Related
- [[common-intents.md]] -- ready-to-use intent examples
- [[plugin-architecture.md]] -- plugins communicate via intents
