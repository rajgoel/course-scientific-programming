# Containers and user-defined types

===

## Containers

Containers are **data structures** capable of holding a collection of elements.

> [!IMPORTANT]
> There are many alternative types of containers and the choice of container highly depends on the use case.

===

### Array

[Arrays](https://en.wikipedia.org/wiki/Array_(data_structure)) are containers that hold elements of equal size in a contiguous block of memory. They provide direct access to each element using an index operation.

![Figure](03-lecture/array.svg)

> [!NOTE]
> Given an index, the memory location of each element can be determined without effort.

---

#### Removal of element

![Figure](03-lecture/array_removal.svg)


> [!NOTE]
> To guarantee contiguous block of memory, a removal of an element may require to **move the memory location of many elements**.

---

#### Insertion of element

![Figure](03-lecture/array_insertion.svg)

> [!NOTE]
> To guarantee contiguous block of memory, an insertion of an element may require to **move the memory location of all elements**.

---

**Julia:**
```julia [1-2|4-5|7-8|10-11|13-14|16-17|19-23]
# Creation
myarray = [1, 2, 3, 4]

# Access
x = myarray[1]           # Julia uses 1-based indexing

# Append (copies all data if allocated memory is exceeded)
push!(myarray, 5)        # myarray becomes [1, 2, 3, 4, 5]

# Pop last element (no copying)
pop!(myarray)            # myarray becomes [1, 2, 3, 4]

# Insert at position 2 (copies all data if allocated memory is exceeded)
insert!(myarray, 2, 99)  # myarray becomes [1, 99, 2, 3, 4]

# Remove element at position 3
deleteat!(myarray, 3)    # myarray becomes [1, 99, 3, 4]

# Iterate
sum = 0;
for element in myarray
  sum += element
end
```
<!-- .element style="height:600px;" -->

---

**Python:**
```python [1-2|4-5|7-8|10-11|13-14|16-17|19-22]
# Creation
myarray = [1, 2, 3, 4]   # Python list stores references in contiguous memory

# Access
x = myarray[0]           # Python uses 0-based indexing

# Append (copies all data if allocated memory is exceeded)
myarray.append(5)        # myarray becomes [1, 2, 3, 4, 5]

# Pop last element (no copying)
myarray.pop()            # myarray becomes [1, 2, 3, 4]

# Insert at index 1 (copies all data if allocated memory is exceeded)
myarray.insert(1, 99)    # myarray becomes [1, 99, 2, 3, 4]

# Remove element at index 2
del myarray[2]           # myarray becomes [1, 99, 3, 4]

# Iterate
sum = 0
for element in myarray:
  sum += element
```

> [!WARNING]
> Python lists behave like arrays from a usage perspective, but the official documentation focuses on their interface and not on the underlying implementation details. When performance matters, [Numpy](https://numpy.org/) can be used.

---

**C++:**
```cpp [1|4-5|7-8|10-11|13-14|16-17|19-20|22-23|25-29]
#include <vector>

int main() {
  // Creation
  std::vector<int> myarray = {1, 2, 3, 4};

  // Access
  auto x = myarray[0];   // C++ uses 0-based indexing

  // Reserve capacity
  myarray.reserve(5);    // may trigger copying

  // Append (may trigger copying if capacity exceeded)
  myarray.push_back(5);  // myarray becomes {1, 2, 3, 4, 5}

  // Pop last element
  myarray.pop_back();    // myarray becomes {1, 2, 3, 4}

  // Insert at position 1 (may trigger copying if capacity exceeded)
  myarray.insert(myarray.begin() + 1, 99);  // myarray becomes {1, 99, 2, 3, 4}

  // Remove element at position 2
  myarray.erase(myarray.begin() + 2);       // myarray becomes {1, 99, 3, 4}

  // Iterate
  int sum = 0;
  for (auto& element : myarray) {
    sum += element;
  }

  return 0;
}
```
<!-- .element style="height:600px;" -->

===

### String

A string is an array of characters.

![Figure](03-lecture/string.svg)

---

**Julia:**
```julia
mystring = "Hello, world!"
```

**Python:**
```python
mystring = "Hello, world!"
```

**C++:**
```cpp
#include <string>

int main() {
  std::string mystring = "Hello, world!";
  return 0;
}
```

---

### Tuple

A tuple is an ordered collection of elements, which can be of different types.

![Figure](03-lecture/tuple.svg)

---

**Julia:**
```julia
mytuple = (1, "hello", 3.14)
(index, word, value) = mytuple
```

**Python:**
```python
mytuple = (1, "hello", 3.14)
index, word, value = mytuple
```

**C++:**
```cpp
#include <tuple>
#include <string>

int main() {
  std::tuple<int, std::string, double> mytuple(1, "hello", 3.14);
  auto& [ index, word, value ] = mytuple;
  return 0;
}
```

> [!NOTE]
> In Julia and Python, tuples are immutable, meaning their elements cannot be changed after creation. To modify contents, you must create a new tuple.

===

### Doubly linked lists

Doubly linked lists are containers that hold sequences of elements in non-contiguous blocks of memory. [Doubly linked lists](https://en.wikipedia.org/wiki/Doubly_linked_list) provide direct access to the start and end of the sequence, as well as to the predecessor and successor of any element.

![Figure](03-lecture/list.svg)

> [!NOTE]
> To find a particular element, a large share of the elements may have to be traversed.

---

#### Removal of element

![Figure](03-lecture/list_removal.svg)

> [!NOTE]
> No memory relocation is necessary.

---

#### Insertion of element

![Figure](03-lecture/list_insertion.svg)

> [!NOTE]
> No memory relocation is necessary.

---

> [!WARNING]
> Julia and Python do not have a built-in doubly linked list.

---

**C++:**
```cpp [1|4|6-9|11-14|16-23|25-33]
#include <list>

int main() {
  std::list<int> mylist = {1, 2, 3, 4};

  // Forward traversal
  for (auto it = mylist.begin(); it != mylist.end(); ++it) {
    auto& value = *it;
  }

  // Backward traversal
  for (auto it = mylist.rbegin(); it != mylist.rend(); ++it) {
    auto& value = *it;
  }

  // Insert 99 before list element with value 3
  for (auto it = mylist.begin(); it != mylist.end(); ++it) {
    auto& value = *it;
    if (value == 3) {
      mylist.insert(it, 99);  // insert 99 before 3
      break;                  // interrupt loop
    }
  }

  // Remove any list element with value 2
  for (auto it = mylist.begin(); it != mylist.end(); ) {
    auto& value = *it;
    if (value == 2) {
      it = mylist.erase(it);  // erase returns iterator to next element
    }
    else {
      it++;
    }
  }

  return 0;
}
```

===

### Stack

[Stacks](https://en.wikipedia.org/wiki/Stack_(abstract_data_type)) are containers that follow a **last-in-first-out (LIFO)** principle. Elements are added (pushed) and removed (popped) only from the top of the stack.

![Figure](03-lecture/stack.svg)

===

### Queue

[Queues](https://en.wikipedia.org/wiki/Queue_(abstract_data_type)) are containers that follow a **first-in-first-out (FIFO)** principle. Elements are added at the back and removed from the front.

![Figure](03-lecture/queue.svg)

===

### Double-ended queue (deque)

[Double-ended queues](https://en.wikipedia.org/wiki/Double-ended_queue) are containers allowing to add and remove elements at the front and the back.

![Figure](03-lecture/deque.svg)

===

### Map, dictionary, or associative array

[Maps, dictionaries, or associative arrays](https://en.wikipedia.org/wiki/Map_(data_structure)) are containers that store key-value pairs, allowing retrieval, insertion, and deletion based on unique keys.

![Figure](03-lecture/map.svg)

> [!NOTE]
> Insertion, removal, and access may require traversing through multiple elements and possibly reorganising parts of the data.

===

### Set

[Sets](https://en.wikipedia.org/wiki/Set_(data_structure)) are containers that hold a collection of unique elements. Sets are primarily used to tests a value for membership and to remove duplicates.

> [!NOTE]
> Insertion, removal, and access may require traversing through multiple elements and possibly reorganising parts of the data.

===

## User-defined types
