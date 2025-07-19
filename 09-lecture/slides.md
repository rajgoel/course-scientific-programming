# Software engineering

> [!WARNING]
> Not yet complete

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
- **state transitions** defining how the system can moves from one state to another, and 
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
The include:

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

![UML](09-lecture/Activity_diagram.svg)<!-- .element style="height:600px;" -->


</div>
<div>

[UML activity diagrams](https://en.wikipedia.org/wiki/Activity_diagram) describe workflows, i.e. sequences of operations and decisions.

</div>
</div>

> [!TIP]
> UML activity diagrams are especially useful for describing the control flow of algorithms.

===

### API

---

## CI/CD

---

### Automated testing

---

### Publishing documentation

---

### Refactoring

## Software Development Workflows

### 1. Issues
Track tasks, bugs, and discussions.

### 2. Branching
Work in isolation without breaking the main project.

### 3. Commits
Save meaningful progress with context.

### 4. Forking
Contribute to projects you don’t control.

### 5. Pull Requests
Review code before merging — enable collaboration and quality control.

### 6. Code Review
Feedback loop for correctness, clarity, and style.

### 7. Merge and Maintain
Keep the main branch stable, tested, and production-ready.
