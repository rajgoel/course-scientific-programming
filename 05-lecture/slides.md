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

<div class="twocolumn" style="align-items: center;">
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

```julia  [1|3-12|14-15|17-18|20-21|23-24|26-27]
using EzXML

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

```python  [1|3-12|14-15|17-18|20-21|23-24]
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

# Parse XML from string and get root
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

## File system

Many programs read from or write files stored on the local disk. Usually, this is done line by line.

---

### Julia

```julia [1-8|10-14]
# Check whether input file exists
input_filename = "input.txt"
if isfile(input_filename)
  # Read a text file line by line
  for line in eachline(input_filename)
    println(line)
  end
end

# Write to output file
output_filename = "output.txt";
open("output.txt", "w") do myfile
  write(myfile, "Hello, file system!")
end
```

---

### Python

```python [1|3-9|11-14]
import os

# Check whether input file exists
input_filename = "input.txt"
if os.path.isfile(input_filename):
  # Read a text file line by line
  with open(input_filename, "r") as myfile:
    for line in myfile:
      print(line, end='')

# Write to output file
output_filename = "output.txt";
with open(output_filename, "w") as myfile:
  myfile.write("Hello, file system!")
```

---

### C++

```cpp [1-4|7-16|18-22]
#include <iostream>
#include <fstream>
#include <string>
#include <filesystem>

int main() {
  // Check whether input file exists
  std::string input_filename = "input.txt";
  if (std::filesystem::exists(input_filename)) {
    std::ifstream my_input_stream(input_filename);
    std::string line;
    while (std::getline(my_input_stream, line)) {
      // Print line to console
      std::cout << line << std::endl;
    }
  }

  // Write to output file
  std::string output_filename = "output.txt";
  std::ofstream my_output_stream(output_filename);
  my_output_stream << "Hello, file system!";
  my_output_stream.close();

  return 0;
}
```

===

## Web services

[Web services](https://en.wikipedia.org/wiki/Web_service) are used for transferring machine-readable file formats such as CSV, JSON, and XML between machines using a web technology such as [HTTP](https://en.wikipedia.org/wiki/HTTP).
 
They allow programs to communicate over the internet and are commonly used to access remote data or functionality via [APIs](https://en.wikipedia.org/wiki/API).

---

### Julia

```julia
using HTTP
using JSON3

latitude = 53.55
longitude = 9.99
url = "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&hourly=temperature_2m"

response = HTTP.get(url)
data = JSON3.read(String(response.body))

# Access temperature data

for i in 1:24
  println("The temperature at ", data.hourly.time[i]," is ", data.hourly.temperature_2m[i], data.hourly_units.temperature_2m)
end
```

---

### Python

```python
import requests

latitude = 53.55
longitude = 9.99
url = f"https://api.open-meteo.com/v1/forecast?latitude={latitude}&longitude={longitude}&hourly=temperature_2m"

response = requests.get(url)
data = response.json()

# Access temperature data
for i in range(24):
    print(f"The temperature at {data['hourly']['time'][i]} is {data['hourly']['temperature_2m'][i]} {data['hourly_units']['temperature_2m']}")
```

---

### C+++

> [!TIP]
> For C++, the [libcurl](https://curl.se/libcurl/) library can be used to make http-requests.

===

## Visualisation

In Julia, plots can be easily created using `Plots.jl`
```julia
import Pkg;
Pkg.add("Plots")
```

> [!TIP]
> For Python and C++ you can use [matplotlib](https://matplotlib.org).

===

### Line plot

<div class="twocolumn" style="align-items: center;">
<div>

![Plot](05-lecture/lineplot.svg)
</div>
<div>

```julia
using Plots

x = 0:0.1:10
y = sin.(x)

plot(x, y, label = "sin(x)", title = "Line Plot")

savefig("lineplot.svg")
```
</div>
</div>

---

### Scatter plot

<div class="twocolumn" style="align-items: center;">
<div>

![Plot](05-lecture/scatterplot.svg)
</div>
<div>

```julia
using Plots

x = rand(100)
y = rand(100)

scatter(x, y, title = "Scatter Plot")

savefig("scatterplot.svg")
```
</div>
</div>

---

### Bar plot

<div class="twocolumn" style="align-items: center;">
<div>

![Plot](05-lecture/barplot.svg)
</div>
<div>

```julia
using Plots

categories = ["A", "B", "C"]
values = [5, 3, 7]

bar(categories, values, title = "Bar Plot")

savefig("barplot.svg")
```
</div>
</div>

---

### Histogram

<div class="twocolumn" style="align-items: center;">
<div>

![Plot](05-lecture/histogram.svg)
</div>
<div>

```julia
using Plots

data = randn(1000)
histogram(data, bins = 30, title = "Histogram")

savefig("histogram.svg")
```
</div>
</div>

---

### Heatmap

<div class="twocolumn" style="align-items: center;">
<div>

![Plot](05-lecture/heatmap.svg)
</div>
<div>

```julia
using Plots

z = [sin(x/10) * cos(y/10) for x in 0:50, y in 0:50]
heatmap(z, title = "Heatmap")

savefig("heatmap.svg")
```
</div>
</div>

---

### 3D surface

<div class="twocolumn" style="align-items: center;">
<div>

![Plot](05-lecture/surface.svg)
</div>
<div>

```julia
using Plots

x = y = range(-5, 5, length = 100)
z = [sin(sqrt(xi^2 + yi^2)) for xi in x, yi in y]

surface(x, y, z, title = "3D Surface Plot")

savefig("surface.svg")
```
</div>
</div>
 
