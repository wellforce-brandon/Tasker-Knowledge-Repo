# Plugin Architecture
> How Tasker plugins work: bundles, intents, the plugin API, and creating compatible plugins.

## Key Facts
- Plugin system uses three components: EditActivity, FireReceiver (actions), QueryReceiver (conditions/events)
- Communication via Intent containing a Bundle of configuration data
- EXTRA_BUNDLE contains all plugin config as key-value pairs
- Modern plugins extend TaskerPluginRunnerAction class
- Actions use intent filter: `com.twofortyfouram.locale.intent.action.FIRE_SETTING`
- Events use intent filter: `net.dinglisch.android.tasker.ACTION_EDIT_EVENT`
- The plugin protocol originated from the Locale app and was adopted by Tasker

## Details

### Plugin Communication Model
The plugin system follows a three-phase lifecycle:

1. **Configuration phase**: User opens the plugin action/condition in Tasker. Tasker launches the plugin's EditActivity. User configures settings. EditActivity packages settings into a Bundle and returns it to Tasker via Intent result.

2. **Storage phase**: Tasker saves the Bundle as part of the task/profile configuration. The Bundle is opaque to Tasker -- only the plugin knows its internal structure.

3. **Execution phase**: When the task runs (or condition is checked), Tasker sends an Intent containing the saved Bundle to the plugin's FireReceiver (actions) or QueryReceiver (conditions/events). The plugin reads the Bundle, performs the action, and optionally returns results.

### Bundles and Extras
- `com.twofortyfouram.locale.intent.extra.BUNDLE` -- the main configuration Bundle
- `com.twofortyfouram.locale.intent.extra.BLURB` -- a short human-readable summary string shown in Tasker UI
- Bundle keys are plugin-specific and not standardized across plugins
- Tasker can pass its own variables into the Bundle if the plugin supports variable replacement
- Maximum Bundle size is limited by Android's IPC transaction limit (~1MB)

### Plugin Query/Fire Intents

#### Action Plugins (FireReceiver)
- Manifest intent filter: `com.twofortyfouram.locale.intent.action.FIRE_SETTING`
- Receives the saved Bundle and performs the action
- Can return result codes to indicate success/failure
- Modern plugins use `TaskerPluginRunnerAction` base class

#### Condition Plugins (QueryReceiver)
- Manifest intent filter: `com.twofortyfouram.locale.intent.action.QUERY_CONDITION`
- Returns RESULT_CONDITION_SATISFIED or RESULT_CONDITION_UNSATISFIED
- Tasker polls conditions periodically or on relevant system events

#### Event Plugins
- Use intent filter: `net.dinglisch.android.tasker.ACTION_EDIT_EVENT`
- Different from condition plugins in that they are push-based, not poll-based
- The plugin notifies Tasker when the event occurs via `TaskerPlugin.Event.addPassThroughMessageID()`

### Creating Tasker-Compatible Plugins
- Use the `tasker-plugin-sdk` library (available on Maven/JCenter)
- Extend `TaskerPluginRunnerAction` for actions or `TaskerPluginRunnerCondition` for conditions
- Implement EditActivity with proper result handling
- Declare correct intent filters in AndroidManifest.xml
- Use BundleScrubber to validate incoming Bundles
- Support Tasker variable replacement by calling `TaskerPlugin.Setting.requestTimeoutMS()` if needed
- Test with Tasker's built-in plugin debugging (long-press action > Test)

### Manifest Declaration Example
```xml
<!-- Action plugin -->
<receiver android:name=".FireReceiver">
    <intent-filter>
        <action android:name="com.twofortyfouram.locale.intent.action.FIRE_SETTING" />
    </intent-filter>
</receiver>

<!-- Edit activity -->
<activity android:name=".EditActivity">
    <intent-filter>
        <action android:name="com.twofortyfouram.locale.intent.action.EDIT_SETTING" />
    </intent-filter>
</activity>
```

## Gotchas
- BundleScrubber pattern is needed to sanitize incoming intent data -- without it, malformed Bundles can crash the plugin
- Event plugins use a different intent action than condition plugins -- do not mix them up
- Bundle size is limited by Android IPC; large data should be stored in files and referenced by path
- Tasker variable replacement only works for String values in the Bundle, not other types
- Some older plugins do not support Tasker's structured output (variables set via `TaskerPlugin.Setting.setVariableReplaceKeys()`)
- Plugin timeout defaults to 10 seconds; long-running plugins should request extended timeout

## Related
- [[intent-basics.md]] -- intents are the communication mechanism underlying all plugins
- [[autotools.md]] -- example of a major multi-feature plugin
- [[autoinput.md]] -- UI automation plugin
- [[autonotification.md]] -- notification management plugin
- [[join.md]] -- cross-device communication plugin
