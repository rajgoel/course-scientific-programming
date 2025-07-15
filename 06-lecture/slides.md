# Error handling and testing

> [!WARNING]
> Not yet complete

===

## Errors

Almost every program can be assumed to have errors.

> [!TIP]
> Programs should report or crash on errors rather than silently ignoring them. Silent failures make bugs harder to detect and fix.

---

### Logical issues

Logical issues occur when the algorithmic logic of the program does not match the requirements.

Examples:
- Incorrect expressions
- Wrong assumptions about input or data
- Invalid control flow (e.g., wrong branching or looping, early termination or unreachable code)
- Wrong algorithm for problem

---

### Invalid input

The input does not necessarily match the expected format, type, or range. This can be due to accident or intention.

Examples:
- Typos
- Flipped data (e.g., latitude and longitude)
- Incorrect format (e.g., lower case where upper case is expected, trailing whitespaces)
- Corrupted or incomplete input (e.g., due to unstable network connection)

---

### Representation errors

The internal variable representation does not fully match its intended semantic meaning.
 
Examples:
- Precision loss can lead to wrong results (e.g., floating point comparisons).
- Over- and underflow leads to incorrect variable values.

---

### Unavailable resources

Required resources may not be available when needed.

Examples:
- Missing files
- Network disconnection
- Out-of-memory
- Insufficient permissions

===

## Check before use

In general, you cannot trust input data to match the assumptions of your program. To avoid errors, you may want to check assumptions before using the data.

**Example: Julia:**
```julia
if b != 0 
  println( a / b )
else
  println("Division by zero")
end
```
 
> [!TIP]
> Checking data may be computationally expensive. For performance reasons, you may want to skip checks if your program logic guarantees validity of data.

===

## Assertions

Assertions are checks that certain conditions in the data are satisfied. They are used to catch bugs in development and ensure that the program logic is correct.

> [!TIP]
> Do **not** use assertions to validate wrong user input and other errors that can be expected at runtime.

---

### Julia

```julia
function divide(a, b)
  @assert b != 0 "Denominator must not be zero"
  return a / b
end
```

> [!TIP]
> Assertions can be disabled with: `@eval Main macro assert(args...); nothing; end`. This line must be executed **before** any `@assert` statement is parsed..

---

### Python

```python
def divide(a, b):
  assert b != 0, "Denominator must not be zero"
  return a / b
```

> [!TIP]
> Assertions can be disabled with: `python -O script.py`

---

### C++

```cpp
#include <cassert>

int divide(int a, int b) {
  assert(b != 0);
  return a / b;
}
```

> [!TIP]
> Assertions can be disabled by defining `NDEBUG` at compile time.


---

## Exceptions

---

## Try/catch



