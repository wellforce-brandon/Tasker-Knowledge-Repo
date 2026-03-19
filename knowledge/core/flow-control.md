# Flow Control
> Conditional execution, loops, gotos, subroutines, and per-action conditions in Tasker.

## Key Facts
- Tasker provides If/Else/For/Goto flow control actions plus per-action inline conditions
- **Never use Goto with action numbers** -- always use labels (action numbers shift when you add/remove actions)
- For loops iterate over comma-separated items, variable arrays, or numeric ranges
- Perform Task acts as a subroutine call with parameter passing via `%par1`/`%par2`
- Per-action conditions (inline If) let you conditionally run any single action without nesting If blocks

## Details

### If / Else If / Else / End If

Basic conditional branching. Every If must have a matching End If.

```
Action 1: If [ %myvar ~ hello ]
Action 2:   Flash "It's hello"
Action 3: Else If [ %myvar ~ world ]
Action 4:   Flash "It's world"
Action 5: Else
Action 6:   Flash "Something else"
Action 7: End If
```

**Condition operators:**
| Operator | Meaning |
|----------|---------|
| `eq` | Equals (numeric) |
| `neq` | Not equals (numeric) |
| `~` | Matches (pattern/regex) |
| `!~` | Doesn't match |
| `~R` | Matches regex |
| `!~R` | Doesn't match regex |
| `<` / `>` | Less than / Greater than (numeric) |
| `Set` | Variable is set (non-empty) |
| `!Set` | Variable is not set |

**Boolean logic:** Multiple conditions can be combined with AND/OR within a single If action. Use the `+` button in the condition editor to add more conditions.

**Nesting:** If blocks can be nested. Keep nesting shallow (2-3 levels max) for readability -- use Perform Task to break out complex logic into subtasks.

### For / End For Loops

Iterates a loop variable over a set of values.

```
Action 1: For %item Items: apple,banana,cherry
Action 2:   Flash "%item"
Action 3: End For
```

**Item sources:**
- **Comma-separated list**: `apple,banana,cherry`
- **Variable containing a list**: `%my_list` (where `%my_list = apple,banana,cherry`)
- **Array variable**: `%my_array()` -- iterates over all elements
- **Numeric range**: `1:10` (1 through 10), `0:100:5` (0 to 100 step 5)

**Nested For loops** work as expected -- use different variable names for each level.

### Goto Action

Jumps to a labeled action, a specific action number, or top/end of task.

```
Action 1: [Label: START]
Action 2: Variable Add %counter Value 1
Action 3: If [ %counter < 10 ]
Action 4:   Goto Label: START
Action 5: End If
```

**Goto types:**
| Type | Use |
|------|-----|
| **Label** | Jump to a named label (ALWAYS prefer this) |
| **Top of Task** | Jump to action 1 |
| **End of Task** | Jump past last action (exits task) |
| **Action Number** | Jump to a specific number (NEVER use this -- numbers change when editing) |

**Setting a label:** In the task editor, tap an action > set the Label field (top of action config screen).

### Loop Control: Continue and Break

Tasker doesn't have explicit `continue` or `break` keywords. Instead:

- **Continue** (skip to next iteration): Use `Goto` > Type: `Top of Loop`
- **Break** (exit the loop): Use `Goto` > Type: `End of Loop`

These special Goto types appear in the Goto action's Type dropdown when inside a For loop.

```
For %file Items: %files()
  If [ %file ~ *.tmp ]
    Goto Type: Top of Loop     <-- skip .tmp files (continue)
  End If
  If [ %count > 100 ]
    Goto Type: End of Loop     <-- stop after 100 (break)
  End If
  [process %file...]
End For
```

### Per-Action Conditions (Inline If)

Any action can have an inline condition without using an If block. In the action editor, tap the **If** button at the bottom to add a condition.

```
Action: Flash "Battery low!" If [ %BATT < 20 ]
```

In XML, this appears as `<ConditionList>` inside the `<Action>` element.

**When to use inline If vs If block:**
- Use inline If for single actions that need a condition -- avoids If/End If clutter
- Use If blocks when multiple actions share the same condition
- Inline conditions support the same operators as If blocks

### Perform Task (Subroutine Calls)

Call another task as a subroutine, optionally passing parameters and receiving a return value.

**Calling:**
```
Perform Task
  Name: My Helper Task
  Par 1: %some_data
  Par 2: %more_data
  Priority: %priority + 1
  Return Value Variable: %result
```

**In the called task:**
- `%par1` and `%par2` contain the passed values
- `%caller()` array contains info about the calling task
- Use `Return` action with a value to send data back
- All local variables (`%lowercase`) are scoped to the called task

**Priority rules:**
- Called tasks inherit the caller's priority by default
- Higher priority tasks can preempt lower priority ones
- Set priority explicitly when calling time-critical subroutines

**Return action:**
```
Return Value: %my_result
```
The value is placed into the caller's Return Value Variable.

### Common Patterns

#### Retry Loop (with backoff)
```
Variable Set %attempts To 0
Variable Set %max_retries To 3
[Label: RETRY]
  HTTP Request [url, method, etc.]
  If [ %http_response_code ~ 2?? ]
    Goto Label: DONE
  End If
  Variable Add %attempts Value 1
  If [ %attempts >= %max_retries ]
    Flash "Failed after %max_retries attempts"
    Goto Label: DONE
  End If
  Wait 2 Seconds
  Goto Label: RETRY
[Label: DONE]
```

#### While-Loop Simulation
Tasker has no `while` keyword. Use For with Goto:
```
Variable Set %running To 1
For %tick Items: 1:9999
  If [ %running eq 0 ]
    Goto Type: End of Loop
  End If
  [do work...]
  If [ %some_condition ~ done ]
    Variable Set %running To 0
  End If
End For
```
Or use Goto with labels (simpler for infinite loops):
```
[Label: LOOP]
  [do work...]
  If [ %keep_going ~ true ]
    Goto Label: LOOP
  End If
```

#### State Machine
```
Variable Set %state To INIT
[Label: STATE_MACHINE]
If [ %state ~ INIT ]
  [initialization...]
  Variable Set %state To RUNNING
  Goto Label: STATE_MACHINE
Else If [ %state ~ RUNNING ]
  [main work...]
  Variable Set %state To CLEANUP
  Goto Label: STATE_MACHINE
Else If [ %state ~ CLEANUP ]
  [cleanup...]
  Variable Set %state To DONE
End If
```

## Gotchas
- **Never Goto action numbers** -- they change when you insert/delete actions. Always use labels
- **For loop variable is local** -- `%item` in a For loop is local to that task instance
- **Goto Top/End of Loop only works inside a For block** -- using it outside a For causes undefined behavior
- **Deeply nested If blocks** are hard to debug. Prefer Perform Task to break out complex logic, or use inline If for simple conditions
- **Perform Task is asynchronous by default** if you don't use a Return Value Variable. Set a Return Value Variable to make it synchronous (waits for child task to complete)
- **%par1/%par2 are the only parameter variables** -- for more data, pass a JSON string or set global variables before calling
- **Return without Perform Task** -- using Return in a task not called via Perform Task acts like Stop

## Related
- [[tasks-and-actions.md]] -- task structure and execution basics
- [[action-codes.md]] -- numeric codes for If (37), End If (38), For (39), End For (40), Goto (135), etc.
- [[variables.md]] -- variable scoping, local vs global
- [[error-handling.md]] -- retry patterns and error detection
