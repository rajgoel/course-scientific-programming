# Complexity and performance

> [!WARNING]
> Not yet complete

===

## Complexity

Computational complexity refers to the resources (time, memory) required by an algorithm as input size grows.

---

### Big O-notation

Big O-notation is used to describe how an algorithm’s execution time or memory usage **scales relative to input size**, .

> [!TIP]
> The goal is to characterise growth rate, not to provide an exact count of instructions.

---

### Constant, linear, polynomial, exponential growth

Let $n$ be a measure of the input size of $n$ and let $c$ indicate the run time (or memory usage) for $n=1$. Then,
 
- $O(1)$ indicates that the run time (or memory usage) stays constant, approximately $c \cdot 1$, regardless of $n$,
- $O(n)$ indicates that the run time (or memory usage) grows linearly with $n$, approximately $c \cdot n$,
- $O(n^k)$ for a given $k$, indicates that the run time (or memory usage) grows polynomially with $n$, approximately $c \cdot n^k$,
- $O(k^n)$ for a given $k$, indicates that the run time (or memory usage) grows exponentially with $n$, approximately $c \cdot k^n$.

---

### Example: $O(1)$

```julia
function getSize(myinput::Vector{<:Number})
  return length(myinput)
end
```

> [!NOTE]
> The `length` function in Julia (returning the number of elements in a container) is constant in time, because the size is stored internally. Thus, the runtime does not depend on the number of elements.

---

### Example: $O(n)$

```julia
function getTotal(myinput::Vector{<:Number})
  return sum(myinput)
end
```

> [!NOTE]
> The `sum` function in Julia (returning the sum of elements in a container) is linear in time, because it has to iterate over all elements. 

---

### Example: $O(n)$

```julia
function normalize(myinput::Vector{<:Number})
  return myinput ./ sum(myinput)
end
```

> [!NOTE]
> Both the `sum` function and the element-wise division using the `./` operator are linear in time because they iterate over each of the $n$ elements in the vector. Since `sum(myinput)` is evaluated exactly once before the element-wise division occurs, the total runtime is linear in $n$.

---

### Example: $O(n^2)$

```julia [1-22|1-5|7-22|9-10|11-20|12-13|14-19|15-16|17-18|21|1-22]
# Compute Euclidean distance between two points (x1, y1) and (x2, y2)
function distance(x1::Number, y1::Number, x2::Number, y2::Number)
  # O(1): arithmetic and sqrt are constant time
  return sqrt( (x1 - x2)^2 + (y1 - y2)^2 )
end

# Compute full distance matrix for a vector of points (pairs)
function distanceMatrix(points::Vector{<:Tuple{<:Number, <:Number}})
  n = length(points)      # O(1): length stored internally
  matrix = zeros(n, n)    # O(n^2): allocate n x n matrix
  for i in 1:n            # Outer loop: n iterations
    xi = points[i][1]     # O(1): indexing an array, O(1): accessing tuple element
    yi = points[i][2]     # O(1): indexing an array, O(1): accessing tuple element
    for j in 1:n          # Inner loop: n iterations
      xj = points[j][1]   # O(1): indexing an array, O(1): accessing tuple element
      yj = points[j][2]   # O(1): indexing an array, O(1): accessing tuple element
      # O(1): distance calculation, O(1): indexing into 2D array
      matrix[i, j] = distance(xi,yi,xj,yj)
    end
  end
  return matrix           # O(1): returning the matrix without copying
end
```
<!-- .element style="height:600px;" -->

> [!NOTE]
> Computing a distance matrix is quadratic in time, because the nested loops have a complexity of $O(n) \cdot O(n) \cdot O(1) = O(n^2)$, and no other operation adds a higher complexity.

---

### Example: $O(2^n)$

````julia [1-24|4|16-19|22-40|23-28|30-39|22-40]
"""
recursivelySolveKnapsackProblem(items::Vector{<:Tuple{<:Number, <:Number}}, capacity::Number, index::Int=1) -> Number

Solve the [0/1 knapsack problem](https://en.wikipedia.org/wiki/Knapsack_problem) using brute-force recursion.

# Arguments
- `items::Vector{<:Tuple{<:Number, <:Number}}`: Vector of `(value, weight)` pairs for each item.
- `capacity::Number`: The maximum weight capacity of the knapsack.
- `index::Int=1`: Current item index (used internally for recursion).

# Returns
- The maximum total value achievable without exceeding the knapsack capacity.

# Example
```julia
items = [(60, 10), (100, 20), (120, 30)]
capacity = 50
solutionValue = recursivelySolveKnapsackProblem(items, capacity)
println(solutionValue)  # Output: 220
```
"""
function recursivelySolveKnapsackProblem(items::Vector{<:Tuple{<:Number, <:Number}}, capacity::Number, index::Int=1)
  n = length(items)
  if index > n || capacity <= 0
    return 0
  end
  
  value, weight = items[index]
  
  if weight > capacity
    # Skip current item if it doesn't fit
    return recursivelySolveKnapsackProblem(items, capacity, index + 1)
  else
    # Option 1: skip current item
    withoutItem = recursivelySolveKnapsackProblem(items, capacity, index + 1)
    # Option 2: include current item
    withItem = value + recursivelySolveKnapsackProblem(items, capacity - weight, index + 1)
    return max(withoutItem, withItem)
  end
end
````
<!-- .element style="height:600px;" -->

> [!NOTE]
> Each step except for the recursive calls has a time complexity of $O(1)$. In each of the $n$ indices two calls to the recursive function are made, resulting in an overall complexity of $O(2^n)$.

---

### Example: $O(\log n)$

```julia
function binarySearch(sortedArray::Vector{<:Number}, target::Number)
  left = 1
  right = length(sortedArray)

  while left <= right
    middle = div(left + right, 2) # returns integer
    if sortedArray[middle] == target
      return mid
    elseif sortedArray[middle] < target
      left = middle + 1
    else
      right = middle - 1
    end
  end

  return -1  # not found
end
```
<!-- .element style="height:500px;" -->

> [!NOTE]
> Each iteration cuts the search space in half. For an input size of $n$, the maximum number of iterations $k$ before the size of the search space reduces to 1 or less, can be computed by finding the smallest $k$ such that  $\frac{n}{2^k} \leq 1$ or $n \leq 2^k$. Thus, $k = \log_2 n$. For Big-O notation, the base of the logarithm is irrelevant, so the complexity is $O(\log n)$.

===

### Complexity of container operations

<small>

| Container          | Access (by index/key) | Search (by value/key) | Insertion           | Deletion            |
| ------------------ | --------------------- | --------------------- | ------------------- | ------------------- |
| Array              | $O(1)$                  | $O(n)$                  | $O(n)$ (anywhere) | $O(n)$ (anywhere), $O(1)$ (only last) |
| Doubly Linked List | $O(n)$                  | $O(n)$                  | $O(1)$ (at head/tail) | O(1) (given node)   |
| Queue              | $O(1)$ (front element)  |                         | $O(1)$ (enqueue)      | $O(1)$ (dequeue)      |
| Stack              | $O(1)$ (top element)    |                         | $O(1)$ (push)         | $O(1)$ (pop)          |
| Map (hash-based)   | $O(1)$ (average)        | $O(1)$ (average)        | $O(1)$ (average)      | O(1) (average)      |
| Set (hash-based)   | $O(1)$ (average)        | $O(1)$ (average)        | $O(1)$ (average)      | $O(1)$ (average)      |

</small>

> [!NOTE]
> Although the average time complexity for access, insertion, and deletion in hash-based maps and sets is $O(1)$, access by index in arrays, and insertion or deletion in doubly linked lists, queues, and stacks are significantly faster due to a smaller constant number of instructions.

===

## Performance

The performance of a program highly depends on 
- the algorithmic complexity and
- the number of memory allocations and copies.

> [!TIP]
> Use appropriate data structures and containers to avoid unnecessary complexity and memory (re-)allocations.

---

### Dynamic vs. static types

Changing the type of a variable or using abstract types can trigger memory reallocation and impact performance.

> [!TIP]
> Julia-specific performance advice on type stability and container choices can be found [here](https://docs.julialang.org/en/v1/manual/performance-tips/#man-performance-abstract-container).

===

## Benchmarking

Benchmarking measures the execution time of code snippets to evaluate performance in practice.

```julia
import Pkg
Pkg.add("BenchmarkTools")
```

```julia
using BenchmarkTools

function sum_squares(n)
  s = 0
  for i in 1:n
    s += i^2
  end
  return s
end

@btime sum_squares(10000)
```

> [!TIP]
> `@btime` excludes compilation time.

===

## Profiling

<div class="twocolumn" style="align-items: center;">
<div>

![Profile](08-lecture/profile.svg)<!-- .element style="height:500px;" -->

</div>
<div>

[Profiling](https://en.wikipedia.org/wiki/Profiling_(computer_programming)) helps identifying which parts of a program consume the most time. 

It is useful for 
detecting performance bottlenecks and optimizing critical code paths.

</div>
</div>

> [!TIP]
> For Julia, you can use [Profile.jl](https://docs.julialang.org/en/v1/manual/profile/), for C++ (with GCC) you can use [gprof](https://hpc-wiki.info/hpc/Gprof_Tutorial).


