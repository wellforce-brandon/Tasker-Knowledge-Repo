# JavaScript in Tasker
> JavaScript actions, the JS bridge, ES6 support, async patterns, and the new Java Code action.

## Key Facts
- Three execution methods: **JavaScriptlet** (inline code), **JavaScript** (external .js file), **WebView** scene element
- Local Tasker variables are accessible in JS without the `%` prefix (e.g., `%myvar` becomes `myvar`)
- Global variables: use `global('VarName')` to read, `setGlobal('VarName', value)` to write
- 130+ built-in functions exposed by Tasker across audio, display, file, network, and other categories
- Only one JavaScriptlet can execute at a time across all tasks (serialized execution)
- JS executes faster than equivalent Tasker action chains for string manipulation, math, and data processing

## Details

### Execution Methods

**JavaScriptlet Action** -- Inline JS code written directly in the action field. Best for short scripts and quick variable manipulation. Code runs in Tasker's own JS engine context.

**JavaScript Action** -- Loads and runs an external `.js` file. Better for larger scripts and reusable code. Supports loading multiple JS libraries (newline-separated paths).

**WebView Scene Element** -- JS runs inside a WebView. Functions use the `tk.` prefix to call Tasker built-ins (e.g., `tk.flash('hello')`). Has full DOM access but a different execution context than JavaScriptlet.

### Accessing Tasker Variables

Local variables auto-propagate between Tasker and JS in both directions:

```javascript
// Reading local vars -- %my_name becomes my_name in JS
flash(my_name);

// Writing local vars -- just assign, it propagates back to Tasker
var result = "done";
// %result is now "done" in subsequent Tasker actions
```

Global variables require explicit function calls:

```javascript
// Reading globals
var sdk = global('SDK');
var bat = global('BATT');

// Writing globals
setGlobal('MyGlobal', 'some value');
```

### Array Handling

Tasker arrays are 1-based (`%arr(1)`), but JS arrays are 0-based (`arr[0]`). When Tasker passes an array to JS, the mapping is:

```
%arr(1) -> arr[0]
%arr(2) -> arr[1]
```

The array variable itself (e.g., `arr`) becomes a standard JS array.

### Variable Declaration and Propagation

Variables declared with `var` propagate back to Tasker after the JavaScriptlet completes:

```javascript
// CORRECT -- separate var statements
var a = 1;
var b = 2;

// WRONG -- chained declaration, only 'a' propagates back
var a = 1, b = 2;
```

### ES6 Support

Tasker uses Android's V8 engine via WebView. On **Android 8.1+** (requires **Tasker 6.6** minimum), the following ES6 features are available:

- `let` / `const`
- Arrow functions (`=>`)
- Template literals (backtick strings)
- Destructuring assignment
- `Promise`
- `Map` / `Set`
- Classes
- `for...of` loops
- Spread operator (`...`)

**Not supported:** ES modules (`import` / `export`) are not available in the JavaScriptlet context.

### Built-in Functions

Tasker exposes 130+ functions to JS, organized by category. Examples:

| Category | Functions (examples) |
|----------|---------------------|
| Audio | `mediaVol()`, `soundMode()` |
| Display | `flash()`, `flashLong()`, `statusBar()` |
| File | `readFile()`, `writeFile()`, `listFiles()` |
| Network | `httpGet()`, `httpPost()`, `wifiToggle()` |
| Task | `performTask()`, `wait()`, `exit()` |
| Variables | `global()`, `setGlobal()`, `setLocal()` |

### Async Operations

By default, a JavaScriptlet exits as soon as synchronous code finishes. For asynchronous operations:

1. Uncheck **Auto Exit** in the JavaScriptlet action settings
2. Manually call `exit()` when all async work is done

```javascript
// Auto Exit must be unchecked for this to work
httpGet('https://example.com/api', function(response) {
    var result = response;
    exit();
});
```

If Auto Exit remains checked, the action completes before callbacks fire and results are lost.

### Developing and Debugging

- **Export JS library template:** Menu > More > Developer > Save JS Library Template -- generates a file documenting all available Tasker JS functions with signatures
- **Detect environment:** `var onAndroid = (global('sdk') > 0);` -- returns false when running off-device in a browser or Node.js
- **Error handling:** Use `try/catch` blocks. JS errors do NOT set Tasker's `%err` variable.
- **Multiple libraries:** In the JavaScript action, list multiple `.js` file paths separated by newlines; all are loaded before execution

### Java Code Action (v6.6+)

Tasker 6.6 introduced the **Java Code** action, a significant expansion beyond JavaScript:

- Write arbitrary Java code with native Android API access
- RxJava2 support for reactive programming
- Access Accessibility Services via `tasker.getAccessibilityService`
- Perform UI operations via `tasker.doWithActivity`
- Built-in AI assistant to help write Java code
- Replaces App Factory (now discontinued)

This action is distinct from JavaScriptlet -- it compiles and runs Java, not JavaScript, and has deeper system access.

## Gotchas
- **Chain var declarations break propagation:** `var a=1, b=2;` only propagates `a` back to Tasker. Always use separate `var` statements.
- **Auto Exit and async:** Forgetting to uncheck Auto Exit is the most common cause of async code silently failing.
- **Serialized execution:** Only one JavaScriptlet runs at a time across all tasks. A long-running script blocks every other task that needs JS.
- **Built-in function priority:** Tasker built-in functions called from JS execute at the parent task's priority + 2, which can block lower-priority concurrent tasks.
- **External library security:** Any loaded JS library has access to device files and Tasker functions. Verify the trustworthiness of third-party code before loading it.
- **WebView prefix:** In WebView scene elements, Tasker functions require the `tk.` prefix (e.g., `tk.flash()` not `flash()`). In JavaScriptlet, no prefix is needed.
- **try/catch does not set %err:** JavaScript exceptions caught or uncaught do not populate Tasker's `%err` variable. Handle errors within JS.
- **ES modules unavailable:** `import`/`export` syntax will fail in JavaScriptlet. Use library loading or concatenation instead.

## Related
- [[variables.md]] -- variable interaction between Tasker and JS
- [[java-reflection.md]] -- Java Function action (pre-6.6 approach)
- [[tasks-and-actions.md]] -- where JavaScript actions fit in task structure
