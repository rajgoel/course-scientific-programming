# Programming basics

===

## Basic data types

---

Computers store data as sequences of binary digits (bits), grouped into blocks of fixed size (e.g., 8, 16, 32, or 64 bits).

---

### Unsigned integers

An $n$-bit representation of a non-negative whole number (an unsigned integer) $x$ consists of a sequence of bits $b_i \in \lbrace 0,1\rbrace$ for $ i \in \lbrace n-1, n-2, \ldots , 0 \rbrace$ such that 

$$ x =  b_{n-1} 2^{n-1} + b_{n-2} 2^{n-2} + \ldots + b_0 2^0 $$

The range of numbers that can be represented by the $n$-bit representation is $[0,2^n - 1]$.

<blockquote class="admonition note"> 
An 8-bit representation of the <b>unsigned integer</b> 42 is:
<div data-load="02-lecture/uint8.svg"></div>
</blockquote> 

---

### Integers

An $n$-bit representation of a whole number (an integer) $x$ consists of a sequence of bits $b_i \in \lbrace 0,1\rbrace$ for $ i \in \lbrace n-1, n-2, \ldots , 0 \rbrace$ such that 

$$ x =  \class{highlight}{- b_{n-1} 2^{n-1}} + b_{n-2} 2^{n-2} + b_{n-3} 2^{n-3} + \ldots + b_0 2^0 $$

The range of numbers that can be represented by the $n$-bit representation is $[-2^{n-1}, 2^{n-1} - 1]$.

<blockquote class="admonition note"> 
An 8-bit representation of the <b>integer</b> -42 is:
<div data-load="02-lecture/int8.svg"></div>
</blockquote> 

===

## Control flow


