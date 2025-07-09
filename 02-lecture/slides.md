# Programming basics

===

## Basic data types

---

Computers store data as sequences of binary digits (bits), grouped into blocks of fixed size (e.g., 8, 16, 32, or 64 bits).

===

## Booleans

**Booleans** can be represnted using a single bit.

- `1` correspond to **true**
- `0` corresponds to **false**

===

## Unsigned integers

An $n$-bit representation of a non-negative whole number, i.e., an **unsigned integer**, $x$ is a sequence of bits $b_i$ for $ i \in \lbrace 1, \ldots, n \rbrace$ such that 

$$ x =  b_{n-1} \cdot 2^{n-1} + b_{n-2} \cdot 2^{n-2} + \ldots + b_0 \cdot 2^0 $$

The range of numbers that can be represented by the $n$-bit representation is $[0,2^n - 1]$.

> [!NOTE]
> An 8-bit representation of the unsigned integer 42 is:
> ![Image](02-lecture/uint8.svg)


---

### What can go wrong when calculating with unsigned integers?

---

### Overflow 

**Overflow** occurs when a result exceeds the maximum value that can be represented:

![Image](02-lecture/overflow.svg)

---

### Y2K Problem

The **Y2K (year 2000)** problem was a very prominent example of overflow (in the decimal representation). 

> [!NOTE]
> Due to scarcity of memory in old computer programs, years were represented by 2-digits, i.e., the year 1999 was represented as `99`. The next year was represented as `00`.

---

### Y2038 Problem

The **Y2038 (year 2038)** problem, is a less known example of overflow that still may cause problems.

> [!NOTE]
> Unix-based systems represent time as the number of seconds since `00:00:00 UTC on 1 January 1970`. Traditionally, a signed 32-bit integer with a range $[-2^{31},2^{31}-1]$ was used.
> The largest time that can be represented with a 32-bit representation before overflow is `03:14:07 UTC on 19 January 2038`. One second later it will be `20:45:52 UTC on 13 December 1901`.

---


### Underflow 

**Underflow** occurs when a result falls below the minimum value that can be represented:

![Image](02-lecture/underflow.svg)

---

### Infinite countdown

An underflow problem can occur when repeatedly decrementing a number as long as it is non-negative. With unsigned integers the countdown will be infinite.

===

## Integers

An $n$-bit representation of a whole number, i.e., a **(signed) integer** $x$ is a sequence of bits $b_i \in \lbrace 0,1\rbrace$ for $ i \in \lbrace 1, \ldots, n \rbrace$ such that 

$$ x =  \class{highlight}{- b_{n-1} \cdot 2^{n-1}} + b_{n-2} \cdot 2^{n-2} + b_{n-3} \cdot 2^{n-3} + \ldots + b_0 \cdot 2^0 $$

The range of numbers that can be represented by the $n$-bit representation is $[-2^{n-1}, 2^{n-1} - 1]$.

> [!NOTE]
> An 8-bit representation of the integer -42 is:
> ![Image](02-lecture/int8.svg)

---

### Overflow and underflow

Overflow and underflow can happen whenever a number becomes too large or too small.

> [!WARNING]
> Overflow and underflow can happen when any part of a calculation  produces values outside the representable range, e.g., when calculating $y = ( x^3 )^{\tfrac{1}{3}}$, the value of $x^3$ may cause over- or underflow. 

===

## Fix point numbers

**Fixed point numbers** represent real numbers by allocating $k$ **bits for the fractional part**. The stored integer value  $x^\textrm{int}$ corresponds to the real number 
$$x^\textrm{real} = \tfrac{x^\textrm{int}}{2^k}$$


> [!NOTE]
> An 8-bit representation with 3 fractional bits of the number $5.25 = \tfrac{42}{2^3}$ is:
> ![Image](02-lecture/fixpoint.svg)


---

### What can go wrong when calculating with fix point numbers?

---

### Addition and subtraction

Addition and subtraction work equally well as with integers.

---

### Multiplication 

Assume we have two numbers

 $x^\textrm{real}_1 = \tfrac{x^\textrm{int}_1}{2^3}$ and $x^\textrm{real}_2 = \tfrac{x^\textrm{int}_2}{2^3}$, 

then

$$
x^\textrm{real}_1 \cdot x^\textrm{real}_2 = \dfrac{x^\textrm{int}_1}{2^3} \cdot \dfrac{x^\textrm{int}_2}{2^3} = \dfrac{ \class{highlight}{\tfrac{x^\textrm{int}_1 \cdot x^\textrm{int}_2}{2^3}}}{2^3}
$$

> [!WARNING]
> When determining a fix point number result  with 3 fractional bits, one of the following problems may occur:
> - $( x^\textrm{int}_1 \cdot x^\textrm{int}_2 )$ may overflow, 
> - $x^\textrm{int}_1 / 2^3$ may lose precision and even may become 0
> - $x^\textrm{int}_2 / 2^3$ may lose precision and even may become 0

---

It is unclear how to calculate the product of arbitrary fix point numbers and even multiplying by 1 is not trivial.

> [!NOTE]
> Fix point numbers are rarely used.


===

## Floating point numbers

<!-- Way of representing real numbers that is better for calculations -->


**Floating point numbers** represent real numbers in the form

$$ x= \pm m \cdot b^e $$

where

- $m$ is called the **mantissa**
- $b$ is the **base** ($b=2$ for computers or $b=10$ for humans) 
- $e$ is the **exponent** 

> [!NOTE]
> A 32-bit representation with base 2 of a floating point number:
> ![Image](02-lecture/float.svg)
> <small>Source: <a href="https://en.wikipedia.org/wiki/Single-precision_floating-point_format">Wikipedia</a></small>

---

### What can go wrong when calculating with floating point numbers?

---

### Basic arithmetic operations

Basic arithmetic operations like addition, subtraction, multiplication, and division work well with floating point numbers.

> [!WARNING]
> Precision loss is inevitable due to rounding errors when representing real numbers as floating point numbers.

---

### Example

A 64-bit floating point representation causes
```julia
0.1 + 0.2 == 0.3
```
and
```julia
0.1 + 0.2 <= 0.3 
```
to fail because rounding leads to this result:
```julia
0.1 + 0.2 == 0.30000000000000004
```

---

### Floating point comparisons

Comparisons of floating point numbers should **always** be made using a small threshold $\varepsilon$ to account for rounding errors.

> [!TIP]
> - Use $| a + b - c | \leq \varepsilon$ instead of $a + b = c$
> - Use $(a + b < c) \vee ( |a + b - c | \leq \varepsilon )$ instead of $a + b \leq c$
> - ...

===

## Characters

Characters represent individual symbols such as letters, digits, or punctuation marks. They can be stored as an **unsigned integer** code according to a given **encoding standard**.

> [!NOTE]
> Strings are not basic data types, they are sequences of characters.

---

## Character encoding 

The most common encoding standards for characters are **ASCII** and **Unicode**.

- **ASCII** uses 7 or 8 bits to represent characters, covering basic English letters, digits, and common symbols.
- **Unicode** extends this to support characters from almost all writing systems worldwide, using variable-length encodings like UTF-8, UTF-16, or UTF-32.

> [!NOTE]
> **Example:** In ASCII, the letter `A` is represented by the unsigned integer `65`.

===

## Variables

---

Variables are used to store data values in memory. A variable has:

- a name
- a type (e.g., boolean, integer, float)
- a value

---

## Typed vs. untyped languages

- **Statically typed:** the type of every variable is known before runtime (e.g., C++)
  - Type errors are caught at compile time
  - Can be more efficient and safer

- **Dynamically typed:** variable types are determined at runtime based on how data flows through the program (e.g., Python)
  - Type errors may occur at runtime
  - Some type errors may be silently ignored and cause unexpected behaviour

> [!NOTE]
> Julia is a dynamically typed language, but it allows optional **type annotations** and uses **type inference** to optimise performance.


---

## Variable declaration in Julia

In Julia variables can be declared without specifying the type:
```julia
flag = true     # inferred type: Bool
x = 42          # inferred type: Int64
π = 3.14        # inferred type: Float64
c = 'A'         # inferred type: Char
```

The type can also be explicitly specified:
```julia
flag::Bool = true
x::Int64 = 42
π::Float64 = 3.14
c::Char = 'A'
```

> [!NOTE]
> Julia allows Unicode characters in variable names, so you can use letters from many languages and mathematical symbols as variable names.

---

## Variable declaration in Python

In Python variables are declared without specifying the type:
```python
flag = True     # inferred type: bool
x = 42          # inferred type: int
pi = 3.14       # inferred type: float
c = 'A'         # inferred type: str (1-character string)
```

> [!NOTE]
> Python does not have a dedicated character data type.


---

## Variable declaration in C++

In C++ variables are declared by explicitly specifying the type:
```cpp
bool flag = true;
int x = 42;
double pi = 3.14;
char c = 'A';
```

The type can also be deduced through initialisation:
```cpp
auto flag = true; // inferred type: bool 
auto x = 42;      // inferred type: int
auto pi = 3.14;   // inferred type: double
auto c = 'A';     // inferred type: char
```

> [!NOTE]
> Type deduction must be possible at compile time.


===

## Control flow basics

---

Control flow determines the order in which instructions in a program are executed. 

---

### Linear execution

<div class="twocolumn">
<div>
<!--
@startuml
start
:initialise x := 5;
:initialise y := 3;
:set z := x * y;
stop
@enduml
convert -density 200 linear.svg linear.png
-->

![UML](02-lecture/linear.svg)
<!-- .element style="height:600px;" -->

</div>
<div>

**Julia:**
```julia
x = 5
y = 3
z = x * y
```

**Python:**
```python
x = 5
y = 3
z = x * y
```

**C++:**
```cpp
auto x = 5;
auto y = 3;
auto z = x * y;
```

</div>
</div>


---

### Branching

<div class="twocolumn">
<div>
<!--
@startuml
start
:declare y;
:read x;
if () then (x<0)
  :set y := -x;
else (x >= 0)
  :set y := x;
endif
:write y;
stop
@enduml
convert -density 200 branching.svg branching.png
-->

![UML](02-lecture/branching.svg)
<!-- .element style="height:600px;" -->

</div>
<div>

**Julia:**
```julia
print("Enter x: ")
x = parse(Int, readline()) # read input and convert to Int
if x < 0
  y = -x
else
  y = x
end
println("y = ", y)
```

**Python:**
```python
x = int(input("Enter x: ")) # read input and convert to int
if x < 0:
  y = -x
else:
  y = x
print("y =", y)
```
</div>
</div>


> [!NOTE]
> Numeric comparisons require a numeric type.

---

**C++:**
```cpp
#include <iostream>

int main() {
  int x; // x must be declared before the input can be assigned to it
  std::cout << "Enter x: ";
  std::cin >> x;
  int y; // y must be declared before a value can be assigned to it
  if (x < 0) {
    y = -x;
  }
  else {
    y = x;
  }

  std::cout << "y = " << y << std::endl;
  return 0;
}
```
<!-- .element style="height:500px;" -->

> [!NOTE]
> In C++, variable declaration before assigning a value may be required.


---

### Loops

<div class="twocolumn">
<div>
<!--
@startuml
start
:initialise i := 0;
repeat
  :set i := i + 1;
repeat while () is ( i < 5 ) not (i >= 5)
stop
@enduml
convert -density 200 loop.svg loop.png
-->

![UML](02-lecture/loop.svg)
<!-- .element style="height:600px;" -->

</div>
<div>

**Julia:**
```julia
i = 0
while i < 5
  i += 1
end
```

**Python:**
```python
i = 0
while i < 5:
  i += 1
```

**C++:**
```cpp
int i = 0;
while (i < 5) {
  i += 1;
}
```
</div>
</div>

---

### Parallel execution

On modern computers with many CPUs, parallel execution can significantly speed up computer programs. However, parallel computing requires special care, particularly with regard to memory management and synchronization.

> [!NOTE]
> Parallel computing is beyond the scope of this course.

