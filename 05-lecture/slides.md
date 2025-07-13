# I/O and error handling

==

## Exchange formats

Common text-based formats for input/output (I/O) of programs and for exchanging data between systems are:

- CSV
- JSON
- XML

===

### CSV

**Comma‑separated values (CSV)** refers to a text format used to represent table data, i.e., rows of records, where each record has fields separated by commas (or other delimiters).

<div class="twocolumn">
<div>

| Name    | Age | City      |
|---------|-----|-----------|
| Alice   | 30  | Berlin    |
| Bob     | 25  | Paris     |
| Charlie | 35  | New York  |

</div>
<div>

```csv
Name, Age, City
"Alice", 30, "Berlin"
"Bob", 25, "Paris"
"Charlie", 35, "New York"
```
</div>
</div>

> [!TIP]
> The CSV format is the easiest way to work with data from spreadsheet software. Whether strings are quoted and the delimiters to be used may need to be adjusted. 


---

### DataFrames

- A **DataFrame** is a two-dimensional, **tabular data structure** with labeled rows and columns.
- Originated in [**R**](https://en.wikipedia.org/wiki/R_(programming_language))
- DataFrames are particularly useful when working with spreadsheets and/or CSV files.

---


### Julia

```julia
using Pkg
Pkg.add("DataFrames")
Pkg.add("CSV")
```

```julia [1-4|6-7|9-10|12-13|15-16|18-19|22-26]
using DataFrames, CSV

# Read CSV into DataFrame
input = CSV.read("input.csv", DataFrame)

# Remove whitespaces in labels
rename!(input, names(input) .=> strip.(names(input)) )

# Obtain statistics
describe(input)

# Inspect first 5 rows
first(input, 5)

# Filter and select
output = input[input.Age .> 18, [:Name, :Age]]

# Add a derived column
output.Initial = first.(output.Name)

# Write back to CSV
CSV.write("output.csv", output;
  quotechar='"',
  quotestrings=true
)
```

> [!WARNING]
> The output may contain different delimiters and quotation style as the input.

---

### JSON

---

### XML

===

## Web services

- http(s), get, post
- Rest API

===

## Charts


