# Code organisation

===

## Functions

---

### What is a function?

- A function is a reusable block of code that performs a specific task.
- Functions help organize code, reduce duplication, and improve readability.

> [!TIP]
> You can think of functions as implementations of mathematical functions $f: X \rightarrow Y$, input/output procedures, utilities, and similar.

---

### Why use functions?

- **Decomposition:** Break a large problem into smaller, manageable parts.
- **Reuse:** Call the same logic from different parts of the program.
- **Testing:** Easier to test small components than large monolithic programs.
- **Documentation:** Named functions help describe what the code does.

---

### Arguments, function body, and return value

A function typically consists of:

- Inputs to the function called **arguments**
- A block of code that performs computation called the **function body**
- The final result produced by the function called the **return value**.

> [!NOTE]
> Not every function requires inputs and not every function produces a final result.

---

### Examples: Julia

A **generic** function accepting all argument types:

```julia
function square(x)
  return x * x
end
```

> [!WARNING]
> If the type of `x` does not support `*`, above will result in a runtime error.

---

A function only accepting integers as argument:

```julia
function square(x::Int)::UInt
  return x * x
end
```

> [!NOTE]
> The return type `::UInt` gives the user a guarantee that the result is an unsigned integer.

---

### Examples: Python

A **generic** function accepting all argument types:

**Python:*
```python
def square(x):
    return x * x
```

> [!WARNING]
> If the type of `x` does not support `*`, above will result in a runtime error.

---

A function only accepting integers as argument:

```python
def square(x: int) -> int:
  return x * x
```

> [!NOTE]
> The return type `int` gives the user a guarantee that the result is an integer (Python does not have an unsigned integer type).

---

### Examples: C++

Regular C++ functions require that argument type and return value are specified explicitly. 

```cpp
unsigned int square(int x) {
  return x * x;
}

unsigned int square(unsigned int x) {
  return x * x;
}
```


---

[Templates](https://en.wikipedia.org/wiki/Template_(C%2B%2B)) can be used to allow functions to operate with generic types.

```cpp
#include <concepts>

template <std::integral T>
unsigned int square(T x) {
  return x * x;
}

int main() {
  int a = -5;
  unsigned int b = 7;

  auto x = square(a);  // 25
  auto y = square(b);  // 49

  return 0;
}
```



---

### Variable access

- Variables defined inside a function are **local** to that function:
  - They exist only during the function's execution.
  - They cannot be accessed from outside the function.
- Variables defined outside a function can only be accessed inside a function if their **scope** includes the function.

> [!IMPORTANT]
> Whether and how variables defined outside a function can be accessed depends on the language and program structure. We will learn more on **scopes** later.

===

## Recursive functions

---

A **recursive function** is a function that calls itself. They are useful for problems that can be broken down into smaller, similar subproblems.

> [!IMPORTANT]
> Every recursive function must have a branch allowing to stop the recursion and prevent loops exceeding the maximal depth possible. 

---

### Example: factorial function

**Julia:**
```julia
function factorial(n)
  if n == 0
    return 1
  else
    return n * factorial(n - 1)  # recursive call
  end
end
```

**Python:**
```python
def factorial(n):
  if n == 0:
    return 1
  else:
    return n * factorial(n - 1)  # recursive call
```

**C++:**
```cpp
int factorial(int n) {
  if (n == 0) {
    return 1;
  }
  else {
    return n * factorial(n - 1); // recursive call
  }
}
```

===

## User-defined types

User-defined types allow you to define your own data structures, grouping multiple values. They are typically used to model **structured data**.

> [!TIP]
> Define user-defined types when you want to represent a concept or entity that has multiple components.

---

**Julia:**
```julia
struct Person
  name::String
  age::Int
end

p = Person("Alice", 30)
println("Name: ",p.name)
println("Age: ",p.age)
```

---

**Python:**
```python
class Person:
  # Explicit definition of constructor
  def __init__(self, name, age):
    self.name = name
    self.age = age

p = Person("Alice", 30)
print("Name:", p.name)
print("Age:",p.age)
```

---

**C++:**
```cpp
#include <string>
#include <print>

struct Person {
  std::string name;
  int age;
};

int main() {
  Person p{"Alice", 30};
  std::println("Name: {}",p.name);
  std::println("Age: {}",p.age);
  
  return 0;
}
```

> [!NOTE]
> In C++, `struct` and `class` are largely identical (except for a few details).

===

## Object-oriented programming

[Object-oriented programming (OOP)](https://en.wikipedia.org/wiki/Object-oriented_programming) organises code by combining data (fields) and behavior (methods) into objects.

> [!WARNING]
> Julia does not support traditional OOP.

---

**Python:**
```python
class Person:
  def __init__(self, name, age):
    self.name = name
    self.age = age

  def greet(self):
    print(f"Hello, my name is {self.name}.")

p = Person("Alice", 30)
p.greet()
```

---

**C++:**
```cpp
#include <string>
#include <print>

struct Person {
  std::string name;
  int age;

  void greet() const {
    std::println("Hello, my name is {}", name);
  }
};

int main() {
  Person p{"Alice", 30};
  p.greet();
}
```
<!-- .element style="height:500px;" -->

---

### Inheritance

**Inheritance** is a core concept in  object-oriented programming allowing a derived class to reuse, extend, or modify behavior and data of an existing class (base class).

- Derived classes inherit fields and methods from their base class.
- Derived classes can override methods to change or extend behavior.

> [!TIP]
> Use inheritance if a object **is** a specialisation of another object, e.g. a car is a vehicle.

---

**C++:**
```cpp [4-11|13-19|21-24]
#include <print>
#include <string>

struct Person {
  std::string name;
  int age;

  void greet() const {
    std::println("Hello, my name is {}", name);
  }
};

struct Employee : Person {
  std::string employee_id;

  void greet() const {
    std::println("Hello, my name is {} and my employee ID is {}", name, employee_id);
  }
};

int main() {
  Employee e{"Alice", 30, "E123"};
  e.greet();
}
```

---

**Python:**
```python [1-7|9-15|17-18]
class Person:
  def __init__(self, name, age):
    self.name = name
    self.age = age

  def greet(self):
    print(f"Hello, my name is {self.name}.")

class Employee(Person):
  def __init__(self, name, age, employee_id):
    super().__init__(name, age)
    self.employee_id = employee_id

  def greet(self):
    print(f"Hello, my name is {self.name} and my employee ID is {self.employee_id}.")

e = Employee("Alice", 30, "E123")
e.greet()
```

---

## Composition

Composition is a design principle where objects are built by combining other objects, instead of inheriting from a base class.

> [!NOTE]
> Instead of inheriting fields and methods, one object contains another as a member.

> [!TIP]
> Use composition if an object **has** a another object, e.g. a car has an engine.

---

**Python:**
```python [1-7|9-16|18-19]
class Person:
  def __init__(self, name, age):
    self.name = name
    self.age = age

  def greet(self):
    print(f"Hello, my name is {self.name}.")

class Employee:
  def __init__(self, person, employee_id):
    self.person = person  # Composition: Employee "has a" Person
    self.employee_id = employee_id

  def greet(self):
    self.person.greet()   # delegate to Person's greet
    print(f"My employee ID is {self.employee_id}.")

e = Employee(Person("Alice", 30) , "E123")
e.greet()
```

---

**C++:**
```cpp [4-11|13-21|24-25]
#include <print>
#include <string>

struct Person {
  std::string name;
  int age;

  void greet() const {
    std::println("Hello, my name is {}", name);
  }
};

struct Employee {
  Person person;           // Composition: Employee "has a" Person
  std::string employee_id;

  void greet() const {
    person.greet();  // delegate to Person's greet
    std::println("My employee ID is {}", employee_id);
  }
};

int main() {
  Employee e{{"Alice", 30}, "E123"};
  e.greet();
}
```

---

**Julia:**
```julia [1-4|6-9|11-18|20-21]
struct Person
  name::String
  age::Int
end

struct Employee
  person::Person   # Composition: Employee "has a" Person
  employee_id::String
end

function greet(p::Person)
  println("Hello, my name is ", p.name)
end

function greet(e::Employee)
  greet(e.person)  # delegate to Person's greet
  println("My employee ID is ", e.employee_id)
end

e = Employee(Person("Alice", 30), "E123")
greet(e)
```

===

## Modules, packages, and libraries

---

### Using existing code

Code is distributed and shared via **modules**, **packages**, and **libraries**.

Using existing code helps
- avoid reinventing the wheel,
- speed up development, and
- leverage tested and optimized functionality.

> [!NOTE]
> The way code is distributed and shared differs by programming language.

---

### Julia

In Julia, packages can be installed from within the REPL, e.g.:

```julia
using Pkg
Pkg.add("Plots")
```

After installation, an external packages can be used as follows:

```julia
import Plots
Plots.plot([1, 2, 3], [4, 6, 5])
```

or

```julia
using Plots
plot([1, 2, 3], [4, 6, 5])
```


---

### Python

In Python, packages can be installed from within the command line, e.g.:

```bash
pip install numpy
```

After installation, an external packages can be used as follows:

```python
import numpy as np

arr = np.array([1, 2, 3])
print(np.mean(arr))
```

---

### C++

In C++, using an external library typically requires:

- downloading and installing the library,  
- linking the library during compilation, and  
- including the appropriate headers.

After installation, a library can be used as follows:

```cpp
#include <iostream>
#include <nlohmann/json.hpp>

int main() {
  std::string jsonString = "{\"name\":\"Alice\",\"age\":30}";
  auto j = nlohmann::json::parse(jsonString);
  std::cout << j["name"] << " is " << j["age"] << " years old.\n";

  return 0; 
}
```


