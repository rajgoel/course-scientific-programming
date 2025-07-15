# Clean code and documentation

> [!WARNING]
> Not yet complete

===

## Clean code

Code is clean if it can be understood easily - by everyone on the team. Clean code can be read and enhanced by everyone including its original author. 

> [!TIP]
> When revisiting your own code after a while, you still want to understand what you have been doing. 

===

### Variable naming

Good variable names improve readability and reduce the chance of misunderstanding the code.

> [!TIP]
> Use descriptive names that reflect the role or meaning of the variable.

---

**Do:**
- Choose descriptive and unambiguous names, prefer clarity over brevity (e.g., use `totalPrice` or `total_price` instead of `tp`)
- Use `camelCase` or `snake_case` for composed names
- Stick to a consistent naming convention (e.g., always use `camelCase`)
- Use nouns for data (speed, temperature, fileName)
- Boolean variables should use verb + adjective/noun for conditions (e.g, `isFeasible`, `has_content`, `cotainsElement`)

**Avoid:**
- Single letters except for trivial iterators (i, j in short loops)
- Abbreviations (`cnt` vs. `count`, `cfg` vs. `config`)
- Vague or generic names (data, tmp, foo, bar)

===

### Magic numbers

Magic numbers are unexplained constants in code. They hurt readability and make maintenance error-prone. Replace them with named constants that convey meaning.

**Bad:**
```julia
if length(data) > 42
  println("Too many elements")
end
```

**Better:**
```julia
const MAX_ELEMENTS = 42

if length(data) > MAX_ELEMENTS
  println("Too many elements")
end
```

> [!TIP]
> Named constants improve readability and make changes easier and safer. If `MAX_ELEMENTS` ever needs to change, you only update it in one place.

===

## Code organisation

Clean code is modular, readable, and easy to test and maintain.

---

### Use functions with a clear scope

- Each function should do one thing only.
- Function names should describe what they do (`computeTotal`, `loadData`, `filterValidEntries`) and should start with a verb.
- Functions should encapsulate logic. Avoid copy-pasting the same code block.

---

### Keep functions short

- A function should not exceed one screenful (~20–40 lines).
- Long functions make it harder to understand, test, and reuse code.
- Avoid multiple nested `if`/`else` or `for`/`while` blocks and use separate functions to avoid deep nesting
- Separate concerns (input, data processing, and output should be in different functions) 

---

**Bad:**
```julia [1|2-5|7-11|13-18|20-21]
function analyzeDataFromFile(filename)
  numbers = []
  for line in eachline(filename)
    push!(numbers, parse(Float64, strip(line)))
  end

  total = 0
  for n in numbers
    total += n
  end
  average = total / length(numbers)

  filtered = []
  for n in numbers
    if n > average
      push!(filtered, n)
    end
  end

  println("Average: ", average)
  println("Above average: ", filtered)
end
```

---

**Better:*
```julia
function readNumbers(filename)
  return [parse(Float64, strip(line)) for line in eachline(filename)]
end
```

```julia
function computeAverage(numbers)
  return sum(numbers) / length(numbers)
end
```

```julia
function filterAboveAverage(numbers, threshold)
  return [n for n in numbers if n > threshold]
end
```

```julia
function printSummary(average, filtered)
  println("Average: ", average)
  println("Above average: ", filtered)
end
```

```julia
function analyzeDataFromFile(filename)
  numbers = readNumbers(filename)
  average = computeAverage(numbers)
  filtered = filterAboveAverage(numbers, average)
  printSummary(average, filtered)
end
```
