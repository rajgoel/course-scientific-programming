# Input and output

===

## Exchange formats

Common text-based formats for input and output of programs and for exchanging data between systems are:

- CSV
- JSON
- XML

===

## CSV

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

```julia [1-4|6-7|9-10|12-13|15-16|18-19|21-26]
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
> The '.' operator is used for element-wise application on an array or collection. 

---

### Python

```bash
pip install pandas
```

```python [1-5|7-8|10-11|13-14|16-17|19-20|22-29]
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

## JSON

[**JavaScript Object Notation (JSON)**](https://www.json.org) is a data exchange format for structured data that is not necessarily tabular.

JSON is built on two structures:

- A collection of name/value pairs.
- An ordered list of values.

```json
{
  "name": "Alice",
  "age": 30,
  "skills": ["Julia", "Python", "C++"]
}
```

---

#### Julia

```julia
using Pkg
Pkg.add("JSON3")
```

```julia [1|3-5|7-9|11-13|15-16]
using JSON3

# Parse JSON string
mystring = """{"name":"Alice","age":30,"skills":["Julia","Python","C++"]}"""
myjson = JSON3.read(mystring, Dict{String,Any})

# Access fields
println(myjson.name, " is ", myjson.age, " years old.")
println("Skills: ", join(myjson.skills, ", "))

# Modify
myjson["city"] = "Berlin"
push!(myjson["skills"],"JSON")

# Serialize
mystring = JSON3.write(myjson)
```

---

### Python

```python [1|3-5|7-9|11-13|15-16]
import json

# Parse JSON string into a dict
mystring = '{"name":"Alice","age":30,"skills":["Julia","Python","C++"]}'
myjson = json.loads(mystring)

# Access fields
print(f"{myjson['name']} is {myjson['age']} years old.")
print("Skills:", ", ".join(myjson["skills"]))

# Modify
myjson["city"] = "Berlin"
myjson["skills"].append("JSON")

# Serialize
mystring = json.dumps(myjson)
```

---

### C++

C++ does not have a built-in `json` class.

> [!TIP]
> You may want to use https://github.com/nlohmann/json

===

## XML

[**Extensible Markup Language (XML)**](https://www.w3.org/XML/) is a hierarchical data exchange format based on nested tags. 

```xml
<person name="Alice">
  <skills>
    <skill>Julia</skill>
    <skill>Python</skill>
    <skill>C++</skill>
  </skills>
</person>
```

---

### XML Schema Definition (XSD)

XML files are commonly based on an [XML Schema Definition (XSD)](https://www.w3.org/XML/Schema) which defines the structure and data types of an XML document. 

```xsd
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xs:element name="person">
    <xs:complexType>
      <xs:attribute name="name" type="xs:string" use="required"/>
      <xs:sequence>
        <xs:element name="skills">
          <xs:complexType>
            <xs:sequence>
              <xs:element name="skill" type="xs:string" maxOccurs="unbounded"/>
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
</xs:schema>
```
<!-- .element style="height:500px;" -->

---

### Julia

```julia
using Pkg
Pkg.add("EzXML")
```

```julia [1|3-14|16-17|19-20|22-23|25-26]
using EzXML

# Parse XML string
mystring = """
<person name="Alice">
  <skills>
    <skill>Julia</skill>
    <skill>Python</skill>
    <skill>C++</skill>
  </skills>
</person>
"""

myxml = parsexml(mystring)

# Get the root node of the XML-tree
myperson = root(myxml)

# Get name of myperson
myname = myperson["name"]

# Find all skills of myperson
myskills = findall("//skill",myperson)

# Output
println(myname, " knows about ", join(nodecontent.(myskills), ", "))
```

> [!NOTE]
> The schema definition is neither needed nor used here.

---

### Python

```python  [1|3-14|16-17|19-20|22-23|25-26]
import xml.etree.ElementTree as XML

# XML input string
mystring = """
<person name="Alice">
  <skills>
    <skill>Julia</skill>
    <skill>Python</skill>
    <skill>C++</skill>
  </skills>
</person>
"""

# Parse XML from string
myperson = XML.fromstring(mystring)

# Get name of myperson
myname = myperson.attrib["name"]

# Find all skills of myperson
myskills = [skill.text for skill in myperson.find("skills").findall("skill")]

# Output
print(f"{myname} knows about {', '.join(myskills)}")
```

> [!NOTE]
> The schema definition is neither needed nor used here.

---

### C++

Several XML-parser libraries exist for C++, e.g. [Xerces-C++ ](https://xerces.apache.org/xerces-c/) or [
pugixml](https://pugixml.org/) that can be used similarly to the respective Julia and Python libraries.

> [!TIP]
> [schematic++](https://github.com/rajgoel/schematicpp) can generate a C++ class structure corresponding to a given XML Schema Definition (XSD).


===

## Web services

- http(s), get, post
- Rest API
- streams

===

## Visualisation


