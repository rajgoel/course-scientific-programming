# Prerequisites and requirements

===

## Lecture

The lecture focuses on **Julia**, **Python**, and **C++** as programming languages suitable for scientific programming.

> [!IMPORTANT]
> Despite not requiring prior coding knowledge, students with little prior knowledge are strongly advised to do a crash course such as [Julia for Absolute Beginners](https://www.youtube.com/playlist?list=PLhQ2JMBcfAsiu2BjeDuj0OXxD1Or_FjID) as soon as possible. 


---

## Lab

In the lab you will be given the opportunity to acquire or intensify your programming knowledge on a programming project of your choice.

> [!IMPORTANT]
> The ambition of the project should match your prior knowledge.

---

## E-Assignments

On https://e-assignments.net you will find a collection of self-study exercises, helping you to learn how to implement solutions for common tasks in business analytics and data science.

> [!IMPORTANT]
> You must use your KLU email address to register.

===

## Grading

Grading will be based to 100% on a group project evaluated by 

- **Project ambition**  
  Complexity and scope of the selected topic
- **Implementation quality**  
  Correctness, structure, and completeness of the code
- **Documentation**  
  Clarity, completeness, and usability of the project documentation
- **Test coverage**  
  Evidence of adequate testing to ensure code quality
- **Time management**  
  Have all deadlines been met?
- **Individual contribution**  
  Commits, code reviews, pull requests, and e-assignments

---

### Individual contributions

> [!IMPORTANT]
> - Group members who do not work on the issues or conduct the code reviews assigned to them may receive lower grades than those who do. 
> - **Contribution concerns** must be raised with the instructor **before the respective deadlines**.

---

### Project presentation

In the last session of the course, each group will present their project to the class. The presentation should:

- Explain the problem being solved
- Demonstrate the implemented solution
- Highlight technical challenges and key design decisions

> [!IMPORTANT]
> The presentation is part of the final project grade and **attendance is mandatory** for the entire session. 

---

## Deadlines

- All deadlines are enforced automatically, and late work will not be assessed
- Group members share responsibility for meeting the deadlines of group work
- Deadline extensions can only be granted in case of exceptional circumstances and must be applied for immediately

> [!IMPORTANT]
> Make sure to have your work ready **well before the deadline** to hedge against unforeseen problems!

---

## Bonus

A bonus of up to **1.0 point on the final course grade** can be obtained by meaningful contributions to the course materials. 

---

### Contributing via Issues and Pull Requests (PR)

A typical workflow to contribute on [GitHub](https://github.com/rajgoel/course-scientific-programming) is:

- Create an **Issue**
- Comment on existing issues
- **Fork** the repository 
- Create a new **Branch** in your fork for your fix or feature
- Submit a **Pull Request**

> [!NOTE]
> For minor fixes (e.g., typos), a **Pull Request** may be submitted directly without creating an issue.

---

### Contributing via Discussions

The course also benefits from discussions:

- Start a [GitHub Discussion](https://github.com/rajgoel/course-scientific-programming/discussions)
- Participate in existing discussions
- Link discussions to issues or pull requests where relevant.

---

### Eligibility for bonus

Every PR merged is eligible for a bonus.

> [!TIP]
> Depending on the quality and impact, the following may also be eligible:  
> - **Pull Requests** that are rejected  
>   *Example:* A PR that fixes an issue but is not merged because another approach to fix the issue is taken.
> - **Issues**  
>   *Example:* Reporting an issue that ultimately leads to improvements.
> - **Discussions**  
>   *Example:* Starting or participating in a discussion helping clarify course content.

===

## Software and tools

---

### Command line/terminal

The command line is a text-based interface that allows users to interact directly with the operating system by typing commands. 

- **Windows:** Open *PowerShell*
- **MacOS/Linux:** Open *Terminal*

> [!NOTE]
> The command line can be used to install software and to run development tools such as Julia, Git, and many others. 

---

### Julia

Julia is the main programming language used in this course. Install it following the instructions at: https://julialang.org/install/

---

#### The Julia REPL

From the command line, you can start the [Julia REPL](https://docs.julialang.org/en/v1/stdlib/REPL/) in the current folder by
```bash
julia --project=.  
```

The REPL allows you to add packages, run Julia code, and read documentation. 

```julia
using Pkg
Pkg.add(url="https://github.com/KLU-BADS/ProjectTemplate.jl")
using ProjectTemplate
hello()
?hello
```

> [!IMPORTANT]
> Make sure to add `--project=.` (or similar) when invoking Julia to avoid bloating your default environment with unnecessary packages.


---

#### Revise.jl 

After importing a package with `using` or `import` all relevant files will be loaded to the REPL and local changes to these files will have no effect until the REPL is closed and reopened. 

> [!TIP]
> To automatically **synchronize imported packages with modified files**, add [Revise.jl](https://timholy.github.io/Revise.jl/stable/) to your Julia startup file:
>
> ```julia
> using Pkg
> Pkg.add("StartupCustomizer")
> import StartupCustomizer
> StartupCustomizer.add(StartupCustomizer.Revise())
> ```
>
> Then restart Julia. From now on every session loads Revise.jl until you run:
>
> ```julia
> using Pkg
> Pkg.add("StartupCustomizer")
> import StartupCustomizer
> StartupCustomizer.remove(StartupCustomizer.Revise())
> ```


---

### Python

To experiment with Python, you can use the online interpreter available at: https://www.online-python.com/

---

### C++

To experiment with C++, you can use the online compiler available at: https://www.onlinegdb.com/

> [!NOTE]
> Make sure to select *Language: C++23*

---

### Git

Git is a version control system used used by platforms like GitHub, GitLab, and Bitbucket to track changes in code and collaborate with others.

> [!TIP]
> Follow the instructions on https://git-scm.com/downloads to install git on your computer.
>
> After installation you may need to run
> ```bash
> git config --global user.name "Your Name"
> git config --global user.email "you@example.com"
> ```

---

### Git commands

You can use git via the command line. Common commands include:

```bash
git clone <repository-url>          # copy a repository to your local machine
git checkout -b <branch-name>       # create and switch to a new branch
git pull                            # pull latest changes from server to you local machine
git status                          # show which files you have changed
git diff                            # show changes 
git add <file>                      # stage changes to be committed
git commit -m "your commit message" # save staged changes with a descriptive message
git push -u origin <branch-name>    # upload committed changes to the remote repository and set upstream branch
```

> [!TIP]
> You can find a comprehensive guide for Git [here](https://www.w3schools.com/git) and [here](https://git-scm.com/book/en/v2).

---

### GitHub

GitHub is a collaboration platform based on git. In addition to git, it allows you to

- Create **Issues** and set *Assignees*, *Labels*, and *Milestones* to issues
- Create **Pull Requests** and request *Reviewers* 
- Manage issues and pull requests** in the browser
- Run workflows to automatically run tests and build documentation
- ...

> [!TIP]
> You can find a comprehensive guide for Git and GitHub [here](https://docs.github.com/en/get-started/start-your-journey) and [here](https://www.geeksforgeeks.org/blogs/ultimate-guide-git-github/).

===

## Project

---

The project is the core component of this course and determines your final grade.

---

### Group work

Projects are carried out in groups of 3–5 students. 

Each group will collaboratively plan, implement, document, test, and present a scientific programming project.

---

### Topic

The topic of the project is self-selected and should solve a problem relevant to business analytics and data science. 

> [!IMPORTANT]
> The topic must be approved by the instructor.


---

### Programming language

The primary language for the project must be **Julia**.

---

### GitHub

All projects are hosted on GitHub. Group members are expected to use branches, issues, commits, and pull requests to manage and track changes collaboratively.

