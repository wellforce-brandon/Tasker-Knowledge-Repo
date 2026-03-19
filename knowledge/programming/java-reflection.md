# Java Reflection in Tasker
> Using Java Function action and the new Java Code action for Android API access.

## Key Facts
- **Java Function** action calls any Java/Android API method via reflection (all Tasker versions)
- **Java Code** action (Tasker 6.6+) lets you write arbitrary Java code with native API access
- Java Code replaces App Factory (now discontinued) and is the forward-compatible approach
- Object names: all-lowercase = local, has-uppercase = global, ALL-CAPS = final global

## Details
### Java Function Action (Legacy)
Calls a single Java method at a time:
1. Specify a class (for static methods) or an existing object
2. Select a method via the built-in class browser
3. Pass parameters and assign return values

```
Class: android.provider.Settings$Secure
Method: putString(ContentResolver, String, String)
```

### Java Code Action (v6.6+)
Write arbitrary Java code blocks with full Android API access:
- Native Android API access
- RxJava2 support for reactive programming
- Accessibility Services via `tasker.getAccessibilityService`
- UI operations via `tasker.doWithActivity`
- Helper functions: `callTask`, `sendCommand`, `logAndToast`
- **Built-in AI assistant** to help write and modify code

### Object Management
| Name Pattern | Scope | Persistence |
|-------------|-------|-------------|
| `myobject` | Local to task | Lost at task end |
| `MyObject` | Global | Until Tasker killed |
| `MYOBJECT` | Global + final | Until Tasker killed (immutable) |

### Common Patterns
- Cast return values: `(ClassName) obj` when methods return generic `Object`
- Access static fields: use `getField()` reflection (no direct static field access)
- Start activities: add `FLAG_ACTIVITY_NEW_TASK` (runs in non-UI thread)

## Gotchas
- **Always delete global Java objects when done** -- they consume memory until Tasker is killed
- Global objects are lost on Tasker kill or device restart -- don't rely on them for persistence
- Java Function runs in a non-UI thread -- cannot show dialogs directly
- Cannot call Java functions inside If conditions
- Methods requiring undeclared permissions will fail silently
- Intents may need `FLAG_ACTIVITY_NEW_TASK` flag
- No direct static field access -- use reflection with `getField()`

## Related
- [[javascript.md]] -- JS can also call Java methods; often simpler
- [[shell-commands.md]] -- alternative for system-level operations
- [[tasks-and-actions.md]] -- where Java actions fit in task flow
