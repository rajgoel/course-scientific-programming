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
An 8-bit representation of the <b>unsigned integer</b> 42 is:
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

An underflow problem can occur when decrementing a number as long as it is non-negative. With unsigned integers the countdown will be infinite.

===

## Integers

An $n$-bit representation of a whole number, i.e., a **(signed) integer** $x$ is a sequence of bits $b_i \in \lbrace 0,1\rbrace$ for $ i \in \lbrace 1, \ldots, n \rbrace$ such that 

$$ x =  \class{highlight}{- b_{n-1} \cdot 2^{n-1}} + b_{n-2} \cdot 2^{n-2} + b_{n-3} \cdot 2^{n-3} + \ldots + b_0 \cdot 2^0 $$

The range of numbers that can be represented by the $n$-bit representation is $[-2^{n-1}, 2^{n-1} - 1]$.

<blockquote class="admonition note"> 
An 8-bit representation of the <b>integer</b> -42 is:
<div data-load="02-lecture/int8.svg"></div>
</blockquote> 

---

### Overflow and underflow

Overflow and underflow and underflow can happen whenever a number becomes too large or too small.

> [!WARNING]
> Overflow and underflow can happen when any part of a calculation become too large or too small, e.g., $y = \sqrt{ x^2 }$. 

===

### Fix point numbers

===

### Floating point numbers



===

## Control flow


