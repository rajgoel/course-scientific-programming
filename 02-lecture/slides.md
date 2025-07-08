# Programming basics

===

## Basic data types

---

Computers store data as sequences of binary digits (bits), grouped into blocks of fixed size (e.g., 8, 16, 32, or 64 bits).

---

### Unsigned integers

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

### Underflow 

**Underflow** occurs when a result falls below the minimum value that can be represented:

<div data-load="02-lecture/underflow.svg"></div>

---

### Integers

An $n$-bit representation of a whole number, i.e., a **(signed) integer** $x$ is a sequence of bits $b_i \in \lbrace 0,1\rbrace$ for $ i \in \lbrace 1, \ldots, n \rbrace$ such that 

$$ x =  \class{highlight}{- b_{n-1} \cdot 2^{n-1}} + b_{n-2} \cdot 2^{n-2} + b_{n-3} \cdot 2^{n-3} + \ldots + b_0 \cdot 2^0 $$

The range of numbers that can be represented by the $n$-bit representation is $[-2^{n-1}, 2^{n-1} - 1]$.

<blockquote class="admonition note"> 
An 8-bit representation of the <b>integer</b> -42 is:
<div data-load="02-lecture/int8.svg"></div>
</blockquote> 

---

### Floating point numbers



===

## Control flow


