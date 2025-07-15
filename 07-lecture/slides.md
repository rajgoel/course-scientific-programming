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

### Do
- Choose descriptive and unambiguous names, prefer clarity over brevity (e.g., use `totalPrice` or `total_price` instead of `tp`)
- Use `camelCase` or `snake_case` for composed names
- Stick to a consistent naming convention (e.g., always use `camelCase`)
- Use nouns for data (e.g., `speed`, `temperature`)
- Boolean variables should be named using verbs followed by adjectives or nouns that reflect a condition (e.g., `isFeasible`, `hasContent`, `containsElement`).

---

#### Avoid

- Single letters except for trivial iterators (i, j in short loops)
- Abbreviations (e.g., `cnt` vs. `count`, `cfg` vs. `config`)
- Vague or generic names (e.g., `data`, `tmp`, `foo`, `bar`)

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
- Avoid deep nesting of control structures (`if-else`, `for`, `while`) by extracting logic into separate functions.
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

> [!WARNING]
> This function is overly complex making it difficult to test and modify specific parts independently.

---

**Better:**
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

> [!TIP]
> Breaking functionality into smaller functions improves readability and makes it easier to test and modify specific parts independently.

===

## Code comments

Code comments help others (and your future self) understand how to use your code. 

> [!TIP]
> Use comments to document **what** a function or class does and **how to use** it. Avoid explaining **how it works** in detail if the code is self-explanatory - focus on intent and usage.

===

## Documentation

Documentation can automatically be generated from specially formated code comments. 

---

### Docstrings

Docstrings are structured string literals that document variables, functions, types, and modules.

- Placed immediately before the definition of a variable, function, type, or module.
- Usually start with a short summary sentence.
- Optionally include: a description of arguments and return values, edge cases or assumptions, usage examples.

---

### Docstrings for variables (Julia)

In Julia, use triple double quotes `"""..."""` for docstrings.


```julia
"""
Maximum number of elements allowed in the dataset.
"""
const MAX_ELEMENTS = 42
```

You can access this documentation interactively in the Julia REPL by typing:
```julia
?MAX_ELEMENTS
```

---

### Docstrings for functions (Julia)


```julia
"""
computeAverage(numbers) -> Float64

Compute the average of a list of numbers.

# Arguments
- `numbers`: A vector of numbers.

# Returns
- The arithmetic mean of the input numbers.
"""
function computeAverage(numbers)
  return sum(numbers) / length(numbers)
end
```

You can access this documentation interactively in the Julia REPL by typing:
```julia
?computeAverage
```

---

### Auto-generated documentation

For Julia, you can use [Documenter.jl](https://documenter.juliadocs.org/) to build a website from your docstrings and additional markdown files.

```julia
import Pkg
Pkg.add("Documenter")
```

> [!TIP]
> For Python you can use [pydoc](https://docs.python.org/3/library/pydoc.html), for C++ you can use [doxygen](https://www.doxygen.nl/). 

---

#### Step 1: Create a docs folder structure

Your project root should have a `docs` folder, e.g., with this structure:

```bash
MyProgram.jl          # program for which the documentation is built
docs/
  ├── make.jl         # script to build the docs
  └── src   
       └── index.md   # main markdown file for documentation
```

---

#### Step 2: Write module `MyProgram.jl`

In `MyProgram.jl` write your program using docstrings:
```julia
"""
module MyProgram

"""
computeAverage(numbers::Vector{Float64}) -> Float64

Compute the average of a list of numbers.

# Arguments
- `numbers`: A vector of floating-point numbers.

# Returns
- The arithmetic mean of the input numbers.
"""
function computeAverage(numbers::Vector{Float64})
  return sum(numbers) / length(numbers)
end

end # module MyProgram
```<!-- .element style="height:500px;" -->

---

#### Step 3: Write make.jl

In `docs/make.jl` write:
```julia
using Documenter

push!(LOAD_PATH, normpath(@__DIR__, "..")) # Required to find MyProgram.jl 

using MyProgram

makedocs(
    sitename = "MyProgram Documentation",
    format = Documenter.HTML(
      edit_link = nothing, 
      repolink = "", 
      inventory_version = "0.1"
    ),
    modules = [MyProgram],
    pages = [
        "Home" => "index.md",
    ],
    remotes = nothing, # Disable source code links if no git repo
)
```<!-- .element style="height:600px;" -->

---

## Step 3: Write index.md

In `docs/src/index.md`, write your landing page in markdown:
```md
# Welcome to my documentation

This the documentation of `MyProgram`, generated with Documenter.jl.

## Overview

This Julia program provides a simple Julia module with a utility function. Specifically, it includes a function to compute the average of a list of numbers.

---

## API Reference
````@autodocs
Modules = [MyProgram]
````
```<!-- .element style="height:500px;" -->

---

## Step 4: Build docs

From your project root folder:
```bash
julia --project=docs docs/make.jl
```
This will generate your documentation site in `docs/build/`.
