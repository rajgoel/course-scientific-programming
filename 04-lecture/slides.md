# Containers

---

Containers are **data structures** capable of holding a collection of elements.

> [!IMPORTANT]
> There are many alternative types of containers and the choice of container highly depends on the use case.

===

## Array

[Arrays](https://en.wikipedia.org/wiki/Array_(data_structure)) are containers that hold elements of equal size in a contiguous block of memory. They provide direct access to each element using an index operation.

![Figure](04-lecture/array.svg)

> [!NOTE]
> Given an index, the memory location of each element can be determined without effort.

---

### Removal of element

![Figure](04-lecture/array_removal.svg)


> [!NOTE]
> To guarantee contiguous block of memory, a removal of an element may require to **move the memory location of many elements**.

---

### Insertion of element

![Figure](04-lecture/array_insertion.svg)

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

## String

A string is an array of characters.

![Figure](04-lecture/string.svg)

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

## Tuple

A tuple is an ordered collection of elements, which can be of different types.

![Figure](04-lecture/tuple.svg)

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

## Doubly linked lists

Doubly linked lists are containers that hold sequences of elements in non-contiguous blocks of memory. [Doubly linked lists](https://en.wikipedia.org/wiki/Doubly_linked_list) provide direct access to the start and end of the sequence, as well as to the predecessor and successor of any element.

![Figure](04-lecture/list.svg)

> [!NOTE]
> To find a particular element, a large share of the elements may have to be traversed.

---

### Removal of element

![Figure](04-lecture/list_removal.svg)

> [!NOTE]
> No memory relocation is necessary.

---

### Insertion of element

![Figure](04-lecture/list_insertion.svg)

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
<!-- .element style="height:600px;" -->

===

## Stack

[Stacks](https://en.wikipedia.org/wiki/Stack_(abstract_data_type)) are containers that follow a **last-in-first-out (LIFO)** principle. Elements are added (pushed) and removed (popped) only from the top of the stack.

![Figure](04-lecture/stack.svg)

---

**Julia:**
```julia [1-3| 5-8|10-11|13-14|16-17]
using DataStructures

mystack = Stack{Int}()  # create an empty stack of integers

# Push
push!(mystack, 1)
push!(mystack, 2)
push!(mystack, 3)

# Top
top = first(mystack)    # look at the top element without removing it

# Pop
popped = pop!(mystack)  # remove and return the top element

# Check if empty
isempty(mystack)
```

---

> [!WARNING]
> Python does not have a built-in stack.

---

**C++:**
```cpp [1,4|6-10|12-13|15-16]
#include <stack>

int main() {
  std::stack<int> mystack;

  // Push
  mystack.push(1);
  mystack.push(2);
  mystack.push(3);

  // Top
  int top = mystack.top();

  // Pop
  mystack.pop();

  return 0;
}
```


===

## Queue

[Queues](https://en.wikipedia.org/wiki/Queue_(abstract_data_type)) are containers that follow a **first-in-first-out (FIFO)** principle. Elements are added at the back and removed from the front.

![Figure](04-lecture/queue.svg)


---

**Julia:**
```julia [1,3|5-8|10-11|13-14|16-17]
using DataStructures

myqueue = Queue{Int}()  # create an empty queue

# Enqueue
enqueue!(myqueue, 1)
enqueue!(myqueue, 2)
enqueue!(myqueue, 3)

# Peek first element of queue (does not remove element)
x = first(myqueue)

# Dequeue (returns element)
x = dequeue!(myqueue)

# Check if empty
isempty(myqueue)
```

---

> [!WARNING]
> Python does not have a built-in queue.

---

**C++:**
```cpp [1,4|6-9|11-12|14-15|17-18]
#include <queue>

int main() {
  std::queue<int> myqueue;

  // Enqueue
  myqueue.push(1);
  myqueue.push(2);
  myqueue.push(3);

  // Peek front
  int front = myqueue.front();

  // Dequeue (does not return element)
  myqueue.pop();

  // Check if empty
  bool is_empty = myqueue.empty();

  return 0;
}
```

===

## Double-ended queue (deque)

[Double-ended queues](https://en.wikipedia.org/wiki/Double-ended_queue) are containers allowing to add and remove elements at the front and the back.

![Figure](04-lecture/deque.svg)

---

**Julia:**
```julia [1-3|5-8|9|11-13|15-17|19-20]
using DataStructures

mydeque = Deque{Int}()  # create empty deque

# Push to back and front
push!(mydeque, 1)        # push to back
push!(mydeque, 2)        # push to back
push!(mydeque, 3)        # push to back
pushfirst!(mydeque, 4)   # push to front

# Peek at front and back
front = first(mydeque)
back = last(mydeque)

# Pop from front and back
a = popfirst!(mydeque)
b = pop!(mydeque)

# Check if empty
is_empty = isempty(mydeque)
```

---

**Python:**
```python [1-3|6-8|9|11-13|15-17|19-20]
from collections import deque

mydeque = deque()

# Push to back and front
mydeque.append(1)      # push to back
mydeque.append(2)      # push to back
mydeque.append(3)      # push to back
mydeque.appendleft(4)  # push to front

# Peek at front and back
front = mydeque[0]
back = mydeque[-1]

# Pop from front and back
a = mydeque.popleft()
b = mydeque.pop()

# Check if empty
is_empty = len(mydeque) == 0
```

---

**C++:**
```cpp [1,4|7-9|10|12-14|16-18|20-21]
#include <deque>

int main() {
  std::deque<int> mydeque;

  // Push to back and front
  mydeque.push_back(1);  // push to back
  mydeque.push_back(2);  // push to back
  mydeque.push_back(3);  // push to back
  mydeque.push_front(4); // push to front

  // Peek at front and back
  int front = mydeque.front();
  int back  = mydeque.back();

  // Pop from front and back
  mydeque.pop_front();
  mydeque_back();

  // Check if empty
  bool is_empty = mydeque.empty();

  return 0;
}
```

===

## Map, dictionary, or associative array

[Maps, dictionaries, or associative arrays](https://en.wikipedia.org/wiki/Map_(data_structure)) are containers that store key-value pairs, allowing retrieval, insertion, and deletion based on unique keys.

![Figure](04-lecture/map.svg)

> [!NOTE]
> Insertion, removal, and access may require traversing through multiple elements and possibly reorganising parts of the data.

---

**Julia:**
```julia [1-2|4-5|7-8|10-11|13-14|16-19]
# Creation
mymap = Dict("apple" => 3, "banana" => 5, "cherry" => 2)

# Check whether key exists
exists = haskey(mymap, "apple")

# Access
x = mymap["apple"]

# Insert / Update
mymap["cherry"] = 3

# Remove
delete!(mymap, "banana")

# Iterate
for (k, v) in mymap
  println("key = $k, value = $v")
end
```

---

**Python:**
```python [1-2|4-5|7-8|10-11|13-14|16-18]
# Creation
mymap = {"apple": 3, "banana": 5, "cherry": 2}

# Check whether key exists
exists = "apple" in mymap

# Access
x = mymap["apple"]

# Insert / Update
mymap["cherry"] = 3

# Remove
del mymap["banana"]

# Iterate
for k, v in mymap.items():
  print(f"key = {k}, value = {v}")
```

---

**C++:**
```cpp [1-3|6-11|13-14|16-17|19-20|22-23|25-28]
#include <unordered_map>
#include <print>
#include <string>

int main() {
  // Creation
  std::unordered_map<std::string, int> mymap{
    {"apple", 3},
    {"banana", 5},
    {"cherry", 2}
  };
  
  // Check whether key exists
  auto exists = mymap.contains("apple");
  
  // Access
  auto& x = mymap["apple"];

  // Insert / Update
  mymap["cherry"] = 3;

  // Remove
  mymap.erase("banana");

  // Iterate
  for (const auto& [key, value] : mymap) {
    std::println("{}: {}", key, value);
  }

  return 0;
}
```

===

## Set

[Sets](https://en.wikipedia.org/wiki/Set_(data_structure)) are containers that hold a collection of unique elements. Sets are primarily used to test a value for membership and to remove duplicates.

> [!NOTE]
> Insertion, removal, and access may require traversing through multiple elements and possibly reorganising parts of the data.

---

**Julia:**
```julia [1-4|6-8|10-11|13-14|16-19]
using DataStructures

# Creation
myset = Set([1, 2, 3])

# Insert
push!(myset, 3)
push!(myset, 4)

# Remove
delete!(myset, 2)

# Check membership
exists = 3 in myset

# Iterate
for element in myset
  println(element)
end
```

---

**Python:**
```python  [1-2|4-6|8-9|11-12|14-16]
# Creation
myset = {1, 2, 3}

# Insert
myset.add(3)
myset.add(4)

# Remove
myset.remove(2)

# Check membership
exists = 3 in myset

# Iterate
for element in myset:
  print(element)
```

---

**C++:**
```cpp [1-2|5-6|8-10|12-13|15-16|18-21]
#include <unordered_set>
#include <print>

int main() {
  // Creation
  std::unordered_set<int> myset = {1, 2, 3};

  // Insert
  myset.insert(3);
  myset.insert(4);

  // Remove
  myset.erase(2);

  // Check membership
  auto exists = myset.contains(3);

  // Iterate
  for (auto& element : myset) {
    std::println("{}", element);
  }

  return 0;
}
```

===

## When to use which container

| Container              | When to use                                           | When to avoid                               |
|------------------------|-------------------------------------------------------|---------------------------------------------|
| **Array**              | Frequent access of elements by index                  | Frequent insertion or removal in the middle |
| **Tuple**              | Fixed-size, heterogeneous data                        | Variable sized, homogeneous data            |
| **Doubly linked list** | Frequent insertion or removal in the middle           | Frequent access of individual elements      |
| **Stack**              | Last-in, first-out behavior                           | Access of elements other than the top       |
| **Queue**              | First-in, first-out behavior                          | Access of elements other than front or back |
| **Deque**              | Frequent addition or removal of elements at both ends | Access of elements in the middle            |
| **Map / Dictionary**   | Access element by key                                 | Access of elements by index                 |
| **Set**                | Eliminate duplicates, check membership                | Frequent access of individual elements      |
<!-- .element style="font-size:32px;" -->

---

> [!TIP]
> If there is no clear reason to favour a particular container type, the **array** type is a reasonable choice.


