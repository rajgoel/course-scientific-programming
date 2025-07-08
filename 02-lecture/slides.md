# Programming basics

===

## Basic data types

---

Computers store data as sequences of binary digits (bits), grouped into blocks of fixed size (e.g., 8, 16, 32, or 64 bits).

===

## Unsigned integers

An $n$-bit representation of a non-negative whole number, i.e., an **unsigned integer**, $x$ is a sequence of bits $b_i$ for $ i \in \lbrace 1, \ldots, n \rbrace$ such that 

$$ x =  b_{n-1} \cdot 2^{n-1} + b_{n-2} \cdot 2^{n-2} + \ldots + b_0 \cdot 2^0 $$

The range of numbers that can be represented by the $n$-bit representation is $[0,2^n - 1]$.

<blockquote class="admonition note"> 
An 8-bit representation of the unsigned integer 42 is:
<div data-load="02-lecture/uint8.svg"></div>
</blockquote> 

---

### What can go wrong when calculating with unsigned integers?

---

### Overflow 

**Overflow** occurs when a result exceeds the maximum value that can be represented:

<div data-load="02-lecture/overflow.svg"></div>

---

### Y2K Problem

The **Y2K (year 2000)** problem was a very prominent example of overflow (in the decimal representation). 

Due to scarcity of memory in old computer programs, years were represented by 2-digits, i.e., the year 1999 was represented as `99`. The next year as `00`.

---

### Y2038 Problem

The ** Y2038 (year 2038)** problem, is a less known example of overflow.

Many Unix-based systems represent time as the number of seconds since `00:00:00 UTC on 1 January 1970`, using a signed 32-bit integer with a range $[-2^{31},2^{31}-1]$.

The last time that can be represented with a 32-bit representation before overflow is `03:14:07 UTC on 19 January 2038`. One second later it will be `20:45:52 UTC on 13 December 1901`.

---


### Underflow 

**Underflow** occurs when a result falls below the minimum value that can be represented:

<div data-load="02-lecture/underflow.svg"></div>

---

### Infinite countdown

An underflow problem can occur when repeatedly decrementing a number as long as it is non-negative. With unsigned integers the countdown will be infinite.

===

## Integers

An $n$-bit representation of a whole number, i.e., a **(signed) integer** $x$ is a sequence of bits $b_i \in \lbrace 0,1\rbrace$ for $ i \in \lbrace 1, \ldots, n \rbrace$ such that 

$$ x =  \class{highlight}{- b_{n-1} \cdot 2^{n-1}} + b_{n-2} \cdot 2^{n-2} + b_{n-3} \cdot 2^{n-3} + \ldots + b_0 \cdot 2^0 $$

The range of numbers that can be represented by the $n$-bit representation is $[-2^{n-1}, 2^{n-1} - 1]$.

<blockquote class="admonition note"> 
An 8-bit representation of the integer -42 is:
<div data-load="02-lecture/int8.svg"></div>
</blockquote> 

---

### Overflow and underflow

Overflow and underflow can happen whenever a number becomes too large or too small.

> [!WARNING]
> Overflow and underflow can happen when any part of a calculation  produces values outside the representable range, e.g., when calculating $y = ( x^3 )^{\tfrac{1}{3}}$, the value of $x^3$ may cause over- or underflow. 

===

## Fix point numbers

**Fixed point numbers** represent real numbers by allocating $k$ **bits for the fractional part**. The stored integer value  $x^\textrm{int}$ corresponds to the real number 
$$x^\textrm{real} = \tfrac{x^\textrm{int}}{2^k}$$


<blockquote class="admonition note"> 
An 8-bit representation with 3 fractional bits of the number $5.25 = \tfrac{42}{2^3}$ is:
<div data-load="02-lecture/fixpoint.svg"></div>
</blockquote> 


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

$$ x= \pm \cdot m \cdot b^e $$

where

- $m$ is called the **mantissa**
- $b$ is the **base**, i.e., $b=2$ for computers or $b=10$ for humans 
- $e$ is the **exponent** 

<blockquote class="admonition note"> 
A 32-bit representation with base 2 of a floating point number:

<div data-load="02-lecture/float.svg"></div>

<small>Source: <a href="https://en.wikipedia.org/wiki/Single-precision_floating-point_format">Wikipedia</a></small>
</blockquote> 

---

### What can go wrong when calculating with fix point numbers?

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
or
```julia
0.1 + 0.2 <= 0.3 
```
to fail because rounding leads to this result:
```julia
0.1 + 0.2 == 0.30000000000000004
```

---

### Floating point comparisons

Comparisons of floating point numbers should always be made using a small threshold $\varepsilon$ to account for rounding errors.

> [!TIP]
> - Use $| 0.1 + 0.2 - 0.3 | \leq \varepsilon$ instead of $0.1 + 0.2 = 0.3$
> - Use $(0.1 + 0.2 < 0.3) \vee ( 0.1 + 0.2 - 0.3 | \leq \varepsilon )$ instead of $0.1 + 0.2 \leq 0.3$


===

## Control flow


