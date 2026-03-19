# Variables
> Local vs global variables, built-in variables, structured data access, arrays, and variable manipulation in Tasker.

## Key Facts
- Variable names must have at least 3 alphanumeric characters after the `%` sign
- Underscores are allowed internally in variable names (e.g., `%my_var`)
- Variable names are case-sensitive: `%Name` and `%name` are different variables
- Local variables (`%all_lower`) are scoped to the task or scene and lost when the task ends
- Global variables (`%Has_Upper`) persist across tasks and survive reboots, lasting until Tasker is uninstalled
- Built-in variables (`%ALL_CAPS` convention) are system-managed by Tasker (e.g., `%TIME`, `%DATE`, `%BATT`)
- Each concurrent execution of the same task gets its own independent copies of local variables

## Details

### Local Variables
Local variables use all-lowercase names after the `%` prefix:

```
%myvar
%counter
%loop_index
%temp_result
```

Local variables exist only for the duration of a single task run. If a task runs multiple times concurrently (e.g., triggered by rapid events), each run has its own isolated set of local variables. This makes them safe for parallel execution without race conditions.

Local variables are significantly faster than global variables, especially for array operations. Always prefer local variables for processing work and only copy results to globals when persistence is needed.

### Global Variables
Global variables have at least one uppercase letter after `%`:

```
%MyResult
%Has_Upper
%SavedData1
```

Globals persist indefinitely -- they survive task completion, profile deactivation, and device reboots. They are only cleared when Tasker is uninstalled or when explicitly deleted via `Variable Clear`.

**Performance note:** Global variables (especially global arrays) are significantly slower than local variables because they are written to persistent storage. When processing large datasets, copy global arrays into local variables, perform your operations, then copy the result back.

### Built-in Variables
Tasker provides many built-in variables that are automatically populated by the system. By convention these use `%ALL_CAPS`:

| Variable | Description |
|----------|-------------|
| `%TIME` | Current time (HH:MM) |
| `%DATE` | Current date |
| `%BATT` | Battery level (0-100) |
| `%WIFI` | WiFi enabled status |
| `%LOC` | Last GPS fix (lat,lon) |
| `%WIN` | Current foreground app window title |
| `%PACTIVE` | Comma-separated list of active profiles |
| `%caller()` | Array of calling task names (for `Perform Task` chains) |

Some built-in variables are set only in specific contexts. For example, `%evtprm1`, `%evtprm2`, etc. are set by event contexts and contain event-specific parameters.

### Structured Variables (v5.12+)
Tasker can parse and access structured data (JSON, HTML/XML, CSV) directly through dot notation and bracket syntax.

#### JSON Access
Given a variable `%json` containing JSON data:

```
// Smart search (finds first matching key at any depth)
%json.name

// Full path access (explicit hierarchy)
%json.person.address.city

// All matches (returns array of all values matching the key)
%json.name()

// Root-level array access
%json[=:=root=:=]()

// Array element by index (1-based)
%json.items(2)
```

Smart search scans the entire JSON tree for the first key match, which is convenient but can be ambiguous in deeply nested structures. Use full-path access when precision matters.

#### HTML/XML Access

```
// Element text content
%html.div
%html.title

// Attribute extraction
%html[img=:=src]

// All matching elements
%html.p()
```

#### CSV Access

```
// Column by header name
%csv.name
%csv.age

// Requires the CSV to have a header row
```

### Arrays (Pseudo-Arrays)
Tasker arrays are sets of variables sharing a base name with numeric suffixes. They are 1-based (unlike JavaScript's 0-based indexing).

```
%arr1 = "apple"
%arr2 = "banana"
%arr3 = "cherry"
```

#### Array Accessor Syntax

| Syntax | Returns |
|--------|---------|
| `%arr(#)` | Count of elements |
| `%arr(>)` | First element value |
| `%arr(<)` | Last element value |
| `%arr(2)` | Element at index 2 |
| `%arr(2:4)` | Elements 2 through 4 (comma-separated) |
| `%arr(*)` | Random element |
| `%arr(#?value)` | Index of first element matching "value" |
| `%arr($?pattern)` | Elements matching a pattern (regex or glob) |

Arrays are created by actions like `Variable Split`, `Array Set`, or by manually setting indexed variables. They can be manipulated with `Array Push`, `Array Pop`, `Array Merge`, and other array actions.

### Variable References (Indirect Access)
Double `%%` enables dynamic variable naming -- the inner variable is resolved first, then used as the name of the outer variable:

```
// If %varname contains "mydata"
// Then %%varname resolves to the value of %mydata

Variable Set: %varname  To: counter
Variable Set: %counter  To: 42
// %%varname now evaluates to 42
```

This is useful for building variable names programmatically, such as iterating over a set of named variables or implementing dictionary-like lookups.

### Variable Manipulation Actions
Key actions for working with variables:

- **Variable Set** -- assign a value (supports math via `Enable Math`)
- **Variable Clear** -- delete a variable or pattern of variables
- **Variable Split** -- split a string into an array by a delimiter
- **Variable Join** -- join an array into a single string
- **Variable Search Replace** -- regex find/replace within a variable
- **Variable Convert** -- change format (e.g., to/from base64, URL encoding, JSON encoding)
- **Variable Section** -- extract a substring by position or regex
- **Variable Randomize** -- set to a random value within a range
- **Array Set** -- create an array from a delimited string
- **Array Push** -- add element(s) to an array
- **Array Pop** -- remove and retrieve element(s) from an array
- **Arrays Merge** -- combine arrays (supports `%%` double variable referencing)

### v6.5+ Changes
- **JSON Encode** option added to the Variable Convert action, making it easy to safely encode strings for JSON output
- **Variable Prefix** option available on all output-generating actions, letting you direct action output into a custom variable instead of the default
- **Arrays Merge** gained support for double variable referencing (`%%`), enabling more dynamic array operations

## Gotchas
- Global variables (especially arrays) are significantly slower than local variables -- use local for any intensive processing, then copy results to globals if persistence is needed
- Performance warning: thousands of array operations (push/pop/set) can take several seconds; batch operations or `Variable Join`/`Variable Split` are faster alternatives
- In JavaScript (`JavaScriptlet` action), chained declarations like `var a=1, b=2;` only propagate the **first** variable (`a`) back to Tasker; declare each variable on a separate statement to ensure all are returned
- Variable names are case-sensitive: `%Foo`, `%foo`, and `%FOO` are three different variables with different scoping rules
- 1-based array indexing catches JavaScript developers off guard -- `%arr(1)` is the first element, not `%arr(0)`
- Using `Variable Clear` with a pattern like `%arr*` will clear ALL variables starting with `arr`, not just the array -- name variables carefully to avoid collisions
- Structured variable access (dot notation) requires Tasker v5.12 or later; older versions will treat the dot as literal text
- `%arr(#)` returns 0 (not empty/error) if the array does not exist, which can mask bugs in array initialization

## Related
- [[tasks-and-actions.md]] -- variables are set and used within task actions
- [[javascript.md]] -- accessing and returning Tasker variables from JavaScript
- [[shell-commands.md]] -- variable substitution in shell commands and scripts
