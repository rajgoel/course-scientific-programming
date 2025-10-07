# Software engineering

---


[Software engineering](https://en.wikipedia.org/wiki/Software_engineering) is the systematic application of engineering principles to the design, development, testing, documentation, deployment, and maintenance of software systems.

---

## Goals


Key goals are to

- manage complexity, 
- reduce errors, and 
- improve quality.

---


## Software development lifecycle


- Requirements
- Architecture and design
- Implementation (coding)
- Testing
- Deployment
- Maintenance

===

## Requirements engineering

Before writing any code, it's essential to clearly define:

- what your program is supposed to do,
- what data it needs,
- what output it should generate, and
- how you'll know it's working correctly.

This process is called **requirements engineering**.

---

## What is the goal?

- What is the research question?
- Which problem is to be solved?
- Which questions are to be answered?
- What are the assumptions?
- What are constraints and limitations?

---

## What is the required input?

- What type of data is required?
- Where does the data come from?
- What are the expectations for quality, correctness, and completeness?
- What is the expected format and structure?
- What kind of pre-processing of input data is required? 

---

## What is the required output?

- What are the expected results?
- Which data is generated?
- What format and structure is appropriate?

---

## How do you know it works?

- How will the program be tested?
- What are the correctness criteria?
- How can the results be validated or verified?

===

## Architecture and design

- Software **architecture** defines the high-level structure of a software system, i.e. how components are organized and interact.
- Software **design** is the detailed plan for how those components are implemented.

===

## UML component diagrams

A [UML component diagram](https://en.wikipedia.org/wiki/Component_diagram) shows the components of a larger system and the interfaces used to connect these components.

<!--
@startuml
  [Data provider] as DP
  [Controller] as C
  [Observer] as O
  [Model] as M
  interface "input" as IInput
  interface "control" as IControl
  interface "subscribe" as ISubscribe
  interface "update" as IUpdate
  DP .right.> IInput
  IInput -right- M
  M -down- ISubscribe
  O .up.> ISubscribe
  O -up- IUpdate
  M .down.> IUpdate
  C .left.> IControl
  M -right- IControl
}
@enduml
-->

![UML](09-lecture/Component_diagram.svg)<!-- .element style="height:400px;" -->

---

### Architectural principles

- **Separation of concerns:** Each component (e.g., data input, model logic, control logic, or output) is responsible for a single well-defined task.
- **Modularity:** It should be possible to replace or modify components without affecting the whole

===

## State machines

A [state machine](https://en.wikipedia.org/wiki/Finite-state_machine) represents systems by 

- **states** representing the characteristics of the system at a point in time,
- **state transitions** defining how the system can move from one state to another, and 
- **conditions** or **triggers** that cause these transitions.

> [!NOTE]
> State machines are quite common in scientific computing, in particular, when simulating complex systems.

---

### UML state machine diagrams

A [UML state machine diagram](https://en.wikipedia.org/wiki/UML_state_machine) depicts states, transitions, and conditions/triggers.

<!--
@startuml
[*] -> Initialized
Initialized -> Running : start
Running -d-> Paused : pause
Running -> Completed : finish
Completed -d-> [*]
Paused -> Aborted : abort
Running -> Aborted : abort
Paused -u-> Running : resume
Aborted -r-> [*]
@enduml
-->

![UML](09-lecture/State_machine_diagram.svg)<!-- .element style="height:400px;" -->

===


## UML class diagrams

[UML class diagrams](https://en.wikipedia.org/wiki/Class_diagram) represent the data and objects model of a program.

<div class="twocolumn" style="align-items:center;">
<div>
<!--
@startuml
object Simulator {
  +parameters: Parameters
  +current_state: State
  +logger: Logger
}
object Parameters {
  +duration: Int32
  +arrival_rate: Float64
  +service_rate: Float64
  +number_of_servers: Int32
}
object State {
  +time: Float64
  +queue_length: Int32
  +busy_servers: Int32
}
object Logger {
  +log: Vector{State}
}
Simulator -- Parameters
Simulator -- State
Simulator -- Logger
Logger - State
@enduml
-->

![UML](09-lecture/Class_diagram.svg)

</div>
<div>
They include:

- Classes/structs
- Attributes (fields)
- Methods (functions operating on the class)
- Inheritance and composition

</div>
</div>

> [!NOTE]
> Methods and inheritance are less important in Julia as it is not an object oriented language.

===

## UML activity diagrams

<div class="twocolumn" style="align-items:center;">
<div>
<!--
@startuml
start
:Initialize system state;
repeat
  :Wait for event;
  if () then (arrival)
    :Add entity to queue;
  else (departure)
    :Remove entity from queue;
  endif
  :Update system state;
repeat while () is (continue) not (terminate)
stop
@enduml
-->

![UML](09-lecture/Activity_diagram.svg)<!-- .element style="height:500px;" -->


</div>
<div>

[UML activity diagrams](https://en.wikipedia.org/wiki/Activity_diagram) describe workflows, i.e. sequences of operations and decisions.

</div>
</div>

> [!TIP]
> UML activity diagrams are especially useful for describing the control flow of algorithms.

===

## Implementation

A typical software development workflow looks like this: 

1. **Issues:** Define a task, feature, or bug.
2. **Forking:** Create your own copy of a repository to contribute to projects you do not own.
3. **Branching:** Develop new feature or fixes in isolated branches without affecting the main branch.
4. **Commits:** Save meaningful progress with context.
5. **Pull Requests:** Propose changes to be merged into the main branch.
6. **Code Review:** Peers review your code for correctness, readability, performance, and style.
7. **Merge and deploy:** Integrate tested code into the main branch and release new version.


===

## Continuous integration and continuous deployment (CI/CD)

[CI/CD](https://en.wikipedia.org/wiki/CI/CD) automates the building, testing, and deployment of software:

- **Continuous Integration (CI):** Automatically build and test your code every time you push changes.
- **Continuous Deployment (CD):** Automatically deploy new versions after passing tests.

> [!TIP]
> CI/CD is especially helpful in scientific programming to ensure that results are reproducible, models stay valid, and documentation is up to date.

---

## GitHub Actions

GitHub can be configured to automatically runs workflows defined through [YAML](https://en.wikipedia.org/wiki/YAML) files in a folder named `.github/workflows/`.

> [!TIP]
> See https://github.com/rajgoel/MyDemoPackage.jl/ for a sample package.

---

### CI for automatic testing

```yaml
name: Run tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        julia-version: ['1.11']
        julia-arch: [x64]
        os: [ubuntu-latest] # [ubuntu-latest, windows-latest, macOS-latest]
    steps:
      - uses: actions/checkout@v2
      - uses: julia-actions/setup-julia@latest
        with:
          version: ${{ matrix.julia-version }}
      - uses: julia-actions/julia-buildpkg@latest
      - uses: julia-actions/julia-runtest@latest
```

> [!TIP]
> Fork the project https://github.com/rajgoel/MyDemoPackage.jl/ and make changes to adapt to your needs.

---

### CD for automatic deployment of documentation

```yaml
name: Create documentation
on:
  push:
    branches:
      - main
    tags: '*'
  pull_request:
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: julia-actions/setup-julia@latest
        with:
          version: '1.11'
      - name: Install dependencies
        run: julia --project=docs/ -e 'using Pkg; Pkg.develop(PackageSpec(path=pwd())); Pkg.instantiate()'
      - name: Build and deploy
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} # For authentication with GitHub Actions token
          DOCUMENTER_KEY: ${{ secrets.DOCUMENTER_KEY }} # For authentication with SSH deploy key
        run: julia --project=docs/ docs/make.jl
```

> [!TIP]
> Fork the project https://github.com/rajgoel/MyDemoPackage.jl/ and make changes to adapt to your needs. For automatic deployment you may need to follow instructions given in the `README.md` of the project.

===

## Refactoring

Refactoring means restructuring existing code without changing its external behavior. 

> [!NOTE]
> The goal is to improve:
> - **Readability** (e.g., clearer names, better organization)
> - **Maintainability** (e.g., modular design, avoiding duplication)
> - **Performance** (e.g., replacing inefficient patterns)

> [!TIP]
> For every newly implemented functionality try to simplify and improve code quality before continuing. Always run tests after refactoring to ensure nothing breaks.
