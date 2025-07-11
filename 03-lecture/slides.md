# Code organisation

===

## Functions

===

## User-defined types

User-defined types allow you to define your own data structures, grouping multiple values. They are typically used to model **structured data**.

> [!TIP]
> Use user-defined types when you want to represent a concept or entity that has multiple components.

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

===

## Object-oriented programming

[Object-oriented programming (OOP)](https://en.wikipedia.org/wiki/Object-oriented_programming) organizes code by combining data (fields) and behavior (methods) into objects.

> [!NOTE]
> In OOP languages like Python and C++, functions (called methods) can be attached to types and operate directly on the data of the type.

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


===

## Multiple dispatch

---

**Julia:**
```julia
struct Person
  name::String
  age::Int
end

greet(p::Person) = println("Hello, my name is ", p.name)

p = Person("Alice", 30)
greet(p)
```

> [!NOTE]
> Julia separates data and behavior: data is defined in structs, while behavior is implemented in functions that operate on those structs but are not part of them. This design, where a function’s behavior depends on the types of its arguments, is called **multiple dispatch**.

===

## Modules, packages, and libraries
