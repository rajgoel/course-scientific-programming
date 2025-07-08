# Introduction

===


## How does a computer work?

At the hardware level, a computer executes **very simple instructions** such as loading data from memory, performing arithmetic, or comparing values. 

---

### Instruction cycle

The [instruction cycle](https://en.wikipedia.org/wiki/Instruction_cycle) of a [central processing unit (CPU)](https://en.wikipedia.org/wiki/Central_processing_unit) is:
1. **Fetch** an instruction from memory
2. **Decode** the instruction to determine what to do
3. **Execute** the instruction (e.g., add two numbers, jump to another instruction)

All modern programs, regardless of complexity, are built on these basic operations.

---

### Simple instructions

Computers operate with a small set of basic operations.

Examples:
- **Memory access**: `load`, `store`
- **Control flow**: `jump`, `branch if equal`
- **Logic**: `and`, `or`, `not`
- **Arithmetic**: `add`, `sub`, `mul`, `div`

Each of these corresponds to a **machine code instruction** the CPU can directly execute.

---

### Low-level programming languages

[Low-level programming languages](https://en.wikipedia.org/wiki/Low-level_programming_language), such as [assembly languages](https://en.wikipedia.org/wiki/Assembly_language), have a very strong correspondence between the instructions in the language and the architecture's machine code instructions.


> [!NOTE]
> Assembly languages usually have one statement per machine instruction. Each assembly language is specific to a particular computer architecture.

---

### Example: "Hello, world!" on x86 Linux

```x86asm
section	.text
   global _start
	
_start:	        
   mov	edx,len     ; length of string, third argument to write()
   mov	ecx,msg     ; address of string, second argument to write()
   mov	ebx,1       ; file descriptor (standard output), first argument to write()
   mov	eax,4       ; system call number for write()
   int	0x80        ; system call trap
	
   mov	ebx,0       ; exit code, first argument to exit()
   mov	eax,1       ; system call number for exit()
   int	0x80        ; system call trap

section	.data
msg db 'Hello, world!', 0xa  
len equ $ - msg
```
<!-- .element style="height:100vh;" -->

---

### High-level programming languages

[High-level programming languages](https://en.wikipedia.org/wiki/High-level_programming_language) have a strong abstraction from the details of the computer, focusing on being human-readable and -writable.

> [!IMPORTANT]
> In order to be executed by a computer, the code must be translated into machine code. A simple instruction written in a high-level programming language, may result in a large number of machine code instructions.

---

### From high-level code to machine code

There are different strategies to convert code written in a high-level programming language to machine code:

- **Interpretation**: Code is translated line-by-line during program execution.
- **Compilation**: Code is fully translated into machine code before execution.
- **Hybrid interpretation/compilation**: The program is compiled to **bytecode** before execution, and the bytecode is then either interpreted or compiled just-in-time.


---

### Byte code

[Bytecode](https://en.wikipedia.org/wiki/Bytecode) is a **platform-independent**, low-level instruction format designed for efficient execution by a virtual machine.

> [!NOTE]
> Bytecode is used as an intermediate representation of code written in a high-level programming language. To be executed it requires interpretation, [just-in-time compilation](https://en.wikipedia.org/wiki/Just-in-time_compilation), or [ahead-of-time compilation](https://en.wikipedia.org/wiki/Ahead-of-time_compilation).

===

## Programming languages

Like spoken languages, programming languages define:

- [**Syntax**](https://en.wikipedia.org/wiki/Syntax): the structure, grammar rules, and order of statements and expressions.
- [**Semantics**](https://en.wikipedia.org/wiki/Semantics):  the meaning or behavior associated with syntactic elements.

Moreover, most programming languages are designed for specific use cases and have a default assumption on how they are translated to machine code. 

---

### Common programming languages

- **Interpreted languages**, e.g., Python, JavaScript
- **Compiled languages**, e.g., C, C++
- **Hybrid languages**, e.g., Julia, Java

> [!NOTE]
> There are many other programming languages!

---

### Why are there so many languages?

There is no single best language because programming needs vary widely. Different languages were created to address 

- specific application domains, 
- hardware environments,
- varying priorities like performance, safety, or ease of use.

---

### How to select a language?

Factors influencing the choice of a language:

- **Use cases:** Is the language well-suited for your problem domain?
- **Ease of learning:** How quickly can you or your team become productive?
- **Performance:** Does the language deliver the required speed and efficiency?
- **Ecosystem:** Are there robust libraries, tools, and community support available?

---

### Languages suitable for business analytics and data science


| Language         | Python   | C++      | Julia    |
|------------------|----------|----------|----------|
| Ease of learning | ★★★☆☆ | ★☆☆☆☆ | ★★★★☆ |
| Performance      | ★☆☆☆☆ | ★★★★★ | ★★★☆☆ |
| Ecosystem        | ★★★★★ | ★★★★☆ | ★★★☆☆ |

> [!NOTE]
> Ratings are subjective and use-case dependent.

---

## Main languagem

The main language used in this course is the **Julia** language because it provides a reasonable tradeoff between ease of learning, performance, and ecosystem.

> [!NOTE]
> Where appropriate examples in **C++** and **Python** are given to show how they compare to **Julia**.

---

### Examples: Hello World!

**Julia:**
```julia
print("Hello World!")
```

**Python3:**
```python
print("Hello World!")
```

**C++23:**
```cpp
#include <print>

int main() {
    std::println("Hello World!");
    return 0;
}
```


===

## How to learn a language?

The best way to learn a language is to use the language in a project that you care for. 

> [!IMPORTANT]
> You don't learn a language by attending a lecture like this.

---

### Can large language models help?

**Large language models (LLMs)** are great tools to help you learn programming, but you must use them to learn.

> [!CAUTION]
> Using LLMs as a replacement to learning may help you to meet formal criteria for passing a class, but [may have negative impact on your long-term success](https://www.brainonllm.com/). 

---

### How can LLMs help?

- LLMs can help with any question relating syntax and semantics.
- LLMs can help with error messages and bug fixing.
- LLMs can help developing ideas on how to structure code.
- LLMs can help with writing basic code for widespread problems.
- LLMs can help with writing code for non-critical tasks for which validation is easy.

> [!CAUTION]
> LLMs can not be trusted, in particular when correctness, reliability, security, performance, or maintainability are important. LLMs may introduce subtle bugs that are very hard to find and fix.

---

### Focus of this course

This course aims at explaining programming concepts that are helpful for identifying an appropriate structure for your code. Most of these concepts are language agnostic.

> [!NOTE]
> The course assumes that you do use LLMs, in particular, for questions regarding syntax, semantics, error messages, bug fixing.

===

# Scientific programming

---

## Software quality requirements

General software quality requirements include:

- **Usability:** Intuitive and effective user interfaces and workflows.
- **Performance:** Adequate speed and resource usage for its purpose.
- **Reliability:** The software should work correctly and handle errors gracefully.
- **Security:** Protection against unauthorized access and malicious inputs.
- **Maintainability:** Code should be easy to modify, extend, and debug.

---

## Requirements for scientific programming

Scientific programming has the same software quality requirements with a focus on

- **Performance:** Efficient handling of large datasets and complex computations
- **Correctness:** Ensuring results are accurate and reliable
- **Reproducibility:** Ability to reproduce results exactly under the same conditions
- **Documentation:** Code must be easy to understand, verify, modify, and reuse.

---

### Performance

- Data sets can be huge and finding the right information may require complex calculations.
- For many decision problems there is a huge number of solutions requiring efficient strategies to search the solution space.

---

### Correctness

The correctness of scientific results can often not be validated by simple visual inspection. Instead, systematic testing should be conducted to validate methodology and results.

---

### Reproducibility

Scientific code should produce the same result when re-run under the same conditions.

---

### Documentation

Scientific code must be documented in such a way that other researchers can

- validate the correctness of the implementation,
- replicate results, and
- reuse and modify approaches.
 
> [!IMPORTANT]
> Documentation is also extremely important for yourself, so that you can do above yourself!


