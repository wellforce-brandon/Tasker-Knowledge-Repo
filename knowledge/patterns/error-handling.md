# Error Handling
> Error detection, retry logic, and failure notification patterns in Tasker.

## Key Facts
- Primary mechanism: **Continue Task After Error** checkbox available on most actions
- When enabled, a failed action sets `%err` (error code) and `%errmsg` (description) instead of stopping the task
- By default (checkbox unchecked), a failed action stops the entire task immediately
- **CRITICAL**: `%err` and `%errmsg` are reset by `If`/`Else`/`End If` actions themselves -- copy them to local variables immediately
- JavaScript errors within JavaScriptlet do NOT set Tasker's `%err` -- use try/catch instead

## Details

### Detecting Errors (%err and %errmsg)
When **Continue Task After Error** is enabled on an action:
- If the action succeeds: `%err` is unset, `%errmsg` is unset
- If the action fails: `%err` is set to a numeric error code, `%errmsg` contains a human-readable description
- These variables are automatically cleared/reset before each action that has Continue Task After Error enabled

### The Critical %err Copy Pattern
Because `%err` and `%errmsg` are reset by flow-control actions (If, Else, End If, For, etc.), you MUST copy them to local variables immediately after the potentially failing action:

```
A1: HTTP Request [Continue Task After Error: ON]
A2: Variable Set %local_err to %err
A3: Variable Set %local_errmsg to %errmsg
A4: If %local_err Is Set
A5:   Flash "Error: %local_errmsg"
A6: End If
```

If you skip the copy step and check `%err` directly in the If:
```
A1: HTTP Request [Continue Task After Error: ON]
A2: If %err Is Set     <-- THIS WILL NEVER BE TRUE
```
The If action itself resets `%err` before evaluating the condition, so the check always fails.

### Retry Patterns

#### Simple Retry Loop
```
A1: Variable Set %retries to 0
A2: [Risky Action with Continue Task After Error: ON]
A3: Variable Set %local_err to %err
A4: If %local_err Is Set AND %retries < 3
A5:   Variable Add %retries Value 1
A6:   Wait 2 seconds
A7:   Goto A2
A8: End If
A9: If %local_err Is Set
A10:  Flash "Failed after 3 retries: %local_errmsg"
A11: End If
```

#### Exponential Backoff
- Calculate wait time: `%wait = 2 ^ %retries` seconds
- Use Variable Math or JavaScriptlet for the power calculation
- Cap the maximum wait to avoid excessively long delays

### JavaScript Error Handling
Errors inside a **JavaScriptlet** action do NOT set Tasker's `%err` and `%errmsg`. Instead, use JavaScript's native try/catch:

```javascript
try {
    var data = JSON.parse(http_data);
    setLocal("result", data.value);
    setLocal("js_err", "");
} catch (e) {
    setLocal("result", "");
    setLocal("js_err", e.message);
}
```
Then check `%js_err` in subsequent Tasker actions.

### Return Value Method
An alternative to Continue Task After Error:
- Do NOT enable Continue Task After Error
- Place a **Return** action (with a return value) immediately after the risky action
- If the risky action succeeds, execution continues to Return, and the task exits with the return value
- If the risky action fails, the task stops at the failure point and never reaches Return
- The calling task (via Perform Task) can check whether a return value was received

### Failure Notifications
Common patterns for alerting on errors:
- **Flash**: Quick on-screen message for non-critical errors
- **Notify**: Persistent notification for errors requiring attention
- **Send SMS / HTTP Request**: Alert remotely for critical failures in automation
- **Write File**: Log errors to a file for later review

### Graceful Degradation
- Use If/Else to provide fallback behavior when an action fails
- Example: if HTTP Request fails, use cached data from a file
- Example: if GPS is unavailable, fall back to network location
- Set sensible default values before risky actions so variables are never empty

## Gotchas
- The number one mistake: checking `%err` directly in an If without copying it first -- the If resets `%err` before evaluating
- `%err` is set per-action -- it does not accumulate across multiple actions
- Not all actions support Continue Task After Error -- check for the checkbox in the action configuration
- JavaScriptlet errors are silent to Tasker unless you explicitly use try/catch and setLocal
- A task that stops due to an uncaught error produces no notification by default -- enable Popup Warnings/Errors in preferences to see these
- `%err` codes are numeric but not standardized across all actions -- rely on `%errmsg` for human-readable information
- When using Perform Task, a child task failure does not automatically propagate to the parent task

## Related
- [[debugging.md]] -- debugging when errors occur
- [[api-integration.md]] -- error handling for API calls
- [[variables.md]] -- %err and %errmsg variables
