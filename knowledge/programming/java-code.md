# Java Code Action
> Write Java code blocks with native Android API access directly in Tasker (6.6+).

## Key Facts
- Java Code action (Tasker 6.6+) lets you write Java directly within Tasker tasks -- no external IDE needed
- Full access to Android APIs, including accessibility services and UI operations
- RxJava2 included for reactive/asynchronous programming patterns
- Replaces App Factory (discontinued in 6.6) for custom code scenarios
- Built-in AI assistant can write and modify Java code from natural language descriptions
- Object scope rules: lowercase names = local, has uppercase = global, ALL CAPS = final

## Details

### Basic Usage
Add a Java Code action (Code category) and write Java in the code editor:
```java
// Simple example: set a Tasker variable
setLocal("my_result", "Hello from Java!");

// Access Android context
Context context = getContext();
String packageName = context.getPackageName();
setLocal("package", packageName);
```

The code executes within Tasker's process. You have access to the full Android SDK.

### Accessing Android APIs
```java
// Get system services
import android.media.AudioManager;

AudioManager am = (AudioManager) getContext().getSystemService(Context.AUDIO_SERVICE);
int volume = am.getStreamVolume(AudioManager.STREAM_MUSIC);
setLocal("current_volume", String.valueOf(volume));
```

```java
// Read device info
import android.os.Build;

setLocal("device", Build.MODEL);
setLocal("android_version", String.valueOf(Build.VERSION.SDK_INT));
```

### Variable Interaction
**Reading Tasker variables:**
```java
String myVar = getLocal("my_var");       // read %my_var
String globalVar = getGlobal("MyGlobal"); // read %MyGlobal
```

**Writing Tasker variables:**
```java
setLocal("result", "some value");    // sets %result
setGlobal("MyGlobal", "new value");  // sets %MyGlobal
```

### RxJava2 Support
RxJava2 is bundled for reactive patterns:
```java
import io.reactivex.Observable;
import io.reactivex.schedulers.Schedulers;

Observable.fromArray("one", "two", "three")
    .map(s -> s.toUpperCase())
    .subscribe(result -> {
        logAndToast(result);
    });
```

Useful for chaining async operations, debouncing inputs, and managing complex data flows.

### Accessibility Services
Access Tasker's accessibility service for UI automation:
```java
import android.accessibilityservice.AccessibilityService;

AccessibilityService as = tasker.getAccessibilityService();
if (as != null) {
    // Perform accessibility actions
    as.performGlobalAction(AccessibilityService.GLOBAL_ACTION_HOME);
}
```

This provides programmatic access to:
- Reading screen content (node tree)
- Clicking, scrolling, typing into UI elements
- Global actions (Home, Back, Recents, Notifications)

### UI Operations
Run code on the UI thread for operations that require it:
```java
tasker.doWithActivity(activity -> {
    // Code here runs on the UI thread with an Activity context
    Toast.makeText(activity, "Hello from Java!", Toast.LENGTH_SHORT).show();
});
```

### Helper Functions
Built-in helper functions available in Java Code blocks:

| Function | Description |
|----------|-------------|
| `getContext()` | Returns the Android Context |
| `getLocal(name)` | Read a local Tasker variable |
| `setLocal(name, value)` | Set a local Tasker variable |
| `getGlobal(name)` | Read a global Tasker variable |
| `setGlobal(name, value)` | Set a global Tasker variable |
| `callTask(taskName)` | Execute another Tasker task |
| `sendCommand(command)` | Send a Tasker command |
| `logAndToast(message)` | Log to Tasker log and show a toast |
| `tasker.getAccessibilityService()` | Get accessibility service instance |
| `tasker.doWithActivity(callback)` | Run code with Activity context on UI thread |

### Object Scope Rules
Variables/objects created in Java Code follow naming conventions for scope:

| Naming | Scope | Example |
|--------|-------|---------|
| All lowercase | Local to this Java Code block | `myCounter`, `tempList` |
| Has uppercase letter | Global (persists across blocks/tasks) | `MyCounter`, `dataStore` |
| ALL CAPS | Final (constant, cannot be reassigned) | `MAX_RETRIES`, `API_URL` |

Global objects persist in memory until Tasker is killed. Use them for caching or sharing data between Java Code blocks.

### Built-in AI Assistant
Tasker 6.6+ includes an AI assistant within the Java Code editor:
- Describe what you want in natural language
- AI generates Java code using the Tasker helper functions
- Can modify existing code based on instructions
- Uses the same AI providers as Widget v2 AI Generator (Gemini/OpenRouter)
- Understands Tasker-specific APIs and patterns

### Imports
Common imports are available by default. For others, add them at the top of your code:
```java
import android.net.wifi.WifiManager;
import android.bluetooth.BluetoothAdapter;
import java.util.*;
import java.io.*;
```

### Error Handling
```java
try {
    // risky operation
    String data = readSomeFile();
    setLocal("data", data);
    setLocal("success", "true");
} catch (Exception e) {
    setLocal("success", "false");
    setLocal("error", e.getMessage());
    logAndToast("Error: " + e.getMessage());
}
```

## Gotchas
- **Requires Tasker 6.6+** -- not available in older versions
- **Replaces App Factory** -- App Factory was discontinued in 6.6; use Java Code for custom code needs
- **Global objects persist in memory** -- be careful with large objects using uppercase names; they won't be garbage collected until Tasker restarts
- **UI operations must use `doWithActivity()`** -- accessing UI from the wrong thread causes crashes
- **Accessibility service may not be available** -- `getAccessibilityService()` returns null if the service isn't enabled; always null-check
- **Not all Android APIs are available** -- some require permissions that Tasker may not have; system-level APIs may need root or Shizuku
- **Code runs synchronously by default** -- long-running operations block the task; use RxJava or background threads for heavy work
- **Variable names in `setLocal()`/`getLocal()` don't include the `%` prefix** -- use `"my_var"` not `"%my_var"`

## Related
- [[java-reflection.md]] -- older Java reflection approach (pre-6.6)
- [[javascript.md]] -- JavaScript alternative for simpler scripting
- [[tasks-and-actions.md]] -- how Java Code actions fit in task execution
- [[action-codes.md]] -- action code for Java Code action
