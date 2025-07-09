# Containers and user-defined types

===

## Containers

Containers are data structure capable of holding a collection of elements.

> [!IMPORTANT]
> There are many alternative types of containers and the choice of container highly depends on the use case.

===

### Array

[Arrays](https://en.wikipedia.org/wiki/Array_(data_structure)) are containers that hold elements of equal size in contiguous block of memory. They provide direct access to each element using an index operation.

![Figure](03-lecture/array.svg)

---

#### Removal of element

![Figure](03-lecture/array_removal.svg)


> [!NOTE]
> To guarantee contiguous block of memory, a removal of an element may require to move the memory location of many elements.

---

#### Insertion of element

![Figure](03-lecture/array_insertion.svg)

> [!NOTE]
> To guarantee contiguous block of memory, an insertion of an element may require to move the memory location of all elements.

===

### List

Lists are containers that hold sequences of elements in non-contiguous blocks of memory. [Doubly linked lists](https://en.wikipedia.org/wiki/Doubly_linked_list) provide direct access to the start and end of the sequence, as well as to the predecessor and successor of any element.

![Figure](03-lecture/list.svg)

---

#### Removal of element

![Figure](03-lecture/list_removal.svg)

---

#### Insertion of element

![Figure](03-lecture/list_insertion.svg)

===

### Set

[Sets](https://en.wikipedia.org/wiki/Set_(data_structure)) are containers that hold a collection of unique elements. Sets are primarily used to tests a value for membership in a set and to remove duplicates.

---

Visualisation svg

===

### Stack

[Stacks](https://en.wikipedia.org/wiki/Stack_(abstract_data_type)) are containers that follow a **last-in-first-out (LIFO)** principle. Elements are added (pushed) and removed (popped) only from the top of the stack.

---

Visualisation svg

===

## Queue

[Queues](https://en.wikipedia.org/wiki/Queue_(abstract_data_type)) are containers that follow a **first-in-first-out (FIFO)** principle. Elements are added at the back and removed from the front.

===

## Priority queue

[Priority queues](https://en.wikipedia.org/wiki/Priority_queue) are containers where each element has a priority, and elements are removed based on highest priority rather than insertion order.

---

Visualisation svg

===

## Map, dictionary, or associative array

[Maps, dictionaries, or associative arrays](https://en.wikipedia.org/wiki/Map_(data_structure)) are containers that store key-value pairs, allowing fast retrieval, insertion, and deletion based on unique keys.

---

Visualisation svg

===
