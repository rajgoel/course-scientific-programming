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
input_frame = CSV.read( "input.csv", DataFrame )

# Remove whitespaces in labels
rename!(input_frame, names(input_frame) .=> strip.(names(input_frame)) )

# Print statistics
println( describe(input_frame) )

# Print first 2 rows
println( first(input_frame, 2) )

# Filter and select
output_frame = input_frame[input_frame.Age .> 18, [:Name, :Age]]

# Add a derived column
output_frame.Initial = first.( output_frame.Name )

# Write back to CSV
CSV.write( "output.csv", output_frame;
  delim = ",",
  quotechar = '"',
  quotestrings = true
)
```

> [!NOTE]
> The '.' operator .

---

### Python

```bash
pip install pandas
```

```python
import pandas as pd
import csv

# Read CSV into DataFrame
input_frame = pd.read_csv( "input.csv" )

# Remove whitespace in column labels
input_frame.columns = input_frame.columns.str.strip()

# Print statistics
print( input_frame.describe() )

# Inspect first 2 rows
print( input_frame.head(2) )

# Filter and select
output_frame = input_frame[input_frame["Age"] > 18][["Name", "Age"]]

# Add a derived column
output_frame["Initial"] = output_frame["Name"].str[0]

# Write back to CSV with all fields quoted
output_frame.to_csv(
    "output.csv",
    index = False,
    sep = ',',
    quotechar = '"',
    quoting = csv.QUOTE_ALL
)
```

---

### C++

C++ does not have a built-in `DataFrame` class.

> [!TIP]
> You may want to use https://github.com/hosseinmoein/DataFrame

===

### JSON

---

### XML

===

## Web services

- http(s), get, post
- Rest API

===

## Charts


