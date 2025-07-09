# Containers and user-defined types

===

## Containers

Containers are data structures capable of holding a collection of elements.

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

===

### List

Lists are containers that hold sequences of elements in non-contiguous blocks of memory. [Doubly linked lists](https://en.wikipedia.org/wiki/Doubly_linked_list) provide direct access to the start and end of the sequence, as well as to the predecessor and successor of any element.

![Figure](03-lecture/list.svg)

> [!NOTE]
> To find a particular element, a large share of the list may have to be traversed.

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

===

### Set

[Sets](https://en.wikipedia.org/wiki/Set_(data_structure)) are containers that hold a collection of unique elements. Sets are primarily used to tests a value for membership and to remove duplicates.

> [!NOTE]
> Insertion, removal, and access may require the traversal of a large share of the elements in the set.

===

### Stack

[Stacks](https://en.wikipedia.org/wiki/Stack_(abstract_data_type)) are containers that follow a **last-in-first-out (LIFO)** principle. Elements are added (pushed) and removed (popped) only from the top of the stack.

![Figure](03-lecture/stack.svg)

===

### Queue

[Queues](https://en.wikipedia.org/wiki/Queue_(abstract_data_type)) are containers that follow a **first-in-first-out (FIFO)** principle. Elements are added at the back and removed from the front.

![Figure](03-lecture/queue.svg)

===

### Map, dictionary, or associative array

[Maps, dictionaries, or associative arrays](https://en.wikipedia.org/wiki/Map_(data_structure)) are containers that store key-value pairs, allowing fast retrieval, insertion, and deletion based on unique keys.

---

Visualisation svg

===
