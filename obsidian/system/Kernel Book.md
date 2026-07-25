## Chapter 2 - Setting up Lab
### Initial Configuration
#### Host name and Time
```bash
# /etc/rc.conf
hostname="lab"

ntpd_enable="YES"
ntpd_sync_on_start="YES"
```
#### Network
```bash
ifconfig # find your nic in VM with an IP address

# set it use DHCP
sysrc ifconfig_em0="DHCP"
```
#### initial setup: SSH, doas, git, fish, nvim and all other 
Check the [[FreeBSD]] initial setup
[[Git Master References]]
#### Updating the System
```bash
doas freebsd-update fetch install
doas pkg update && doas pkg upgrade
```
### Development tool
#### Clang/LLVM, git, gmake, gdb
```bash
cc --version
ls -lht (which cc)
doas pkg install git gmake gdb
```
LLVM
- `cc`: Clang is c compiler, 
	- Clang = front end (parser/analyzer), 
	- LLVM = back end (optimizer + code generator → machine code).
- make: a build tool reads a script file called `Makefile` that describe how to build a project(which files to compile/in what order/how to link them): BSD base system
- lldb: debugger
GNC
- gcc: GNU compiler
- gmake: GNU make, most Linux third party program
- gdb: the GNU debugger

| Job              | FreeBSD default | GNU alternative | The GNU "g" prefix                        |
| ---------------- | --------------- | --------------- | ----------------------------------------- |
| Compile C        | `clang` / `cc`  | `gcc`           | avoids clashing with `cc`                 |
| Build automation | `make` (BSD)    | `gmake`         | ==Beware: They are not fully compatible== |
| Debugging        | `lldb`          | `gdb`           | keeps both installable                    |
#### Documentation: `man` page
```bash
# key
# 1. User commands.
# 2. System calls and error numbers.
# 3. Functions in the C libraries.
# 4. Device drivers.
# 5. File formats.
# 6. Games and other diversions.
# 7. Miscellaneous information.
# 8. System maintenance and operation commands.
# 9. System kernel interfaces.
man 8 daemon
man -k daemon # find out all related keyword
```
#### FreeBSD Source Tree (Kernel source code)
It will be in `/usr/src`
```bash
doas git clone --branch releng/14.3 --depth 1 https://git.FreeBSD.org/src.git /usr/src
ls -lht /usr/src/sys # Kernel lives, like `dev`, `kern`, `net` and `vm`
```
Double check
```bash
freebsd-version -k
```
#### Backups and Snapshots
Note: ==Important! Important! Important!== Safely ==close all your VMs== before taking snapshot!!!!
```bash
[I] fion@freebsd ~> zfs list
NAME                            USED  AVAIL  REFER  MOUNTPOINT
zroot/vm                       10.8G   440G  4.63G  /home/fion/vm
zroot/vm/my-bsd                4.20G   440G  4.20G  /home/fion/vm/my-bsd
zroot/vm/my-linux              1.95G   440G  1.95G  /home/fion/vm/my-linux

# only snapshot what you want, if you want snapshot the `zroot/vm`, you use `-r` to recursively take all VMs under vm
# zfs snapshot -r zroot@clean-install
doas zfs snapshot zroot/vm/my-bsd@clean-install

[I] fion@freebsd ~> zfs list -t snapshot
NAME                                           USED  AVAIL  REFER  MOUNTPOINT
zroot/vm/my-bsd@clean-install                 3.05M      -  4.20G  -

# Roll back instantly
doas zfs rollback zroot/vm/my-bsd@clean-install
```
## Chapter 3 — A Gentle Introduction to UNIX

### Reader Guidance: How to Use This Chapter

### Introduction: Why UNIX Matters
- Why Should You Learn UNIX Before Writing Drivers?
- What You Will Learn in This Chapter
- The Bridge to Device Drivers
- Wrapping Up

### What Is UNIX?
- A Brief History of UNIX
- The UNIX Philosophy
- UNIX-like Systems Today
- Key Concepts and Terms
- How UNIX Differs from Windows
- Everyday UNIX in Your Life
- Hands-On Lab: Your First UNIX Commands
- Wrapping Up

### The Shell: Your Window Into FreeBSD
- What Is a Shell?
- How to Know Which Shell You're Using
- The Structure of a Command
- Essential Commands for Beginners
  - Navigating Directories
  - Managing Files and Directories
  - Viewing File Contents
  - Editing Files
    - Hands-On Lab: Your First Edits
    - Common Beginner Pitfall: Stuck in vi
- Tips and Shortcuts
  - Tab completion (tcsh)
  - Command history (tcsh)
  - Wildcards (globbing)
  - Editing on the command line (tcsh)
- Hands-On Lab: Navigating and Managing Files
- Wrapping Up

### The FreeBSD Filesystem Layout
- Devices as Files: /dev
- Absolute vs. Relative Paths
  - Example: Navigating with Absolute vs Relative Paths
- Hands-On Lab: Exploring the Filesystem
- Wrapping Up

### Users, Groups, and Permissions
- Users and Groups
- File Ownership
- Permissions
- Changing Permissions
- Changing Ownership
- Practical Scenario: Project Directory
- Hands-On Lab: Permissions in Action
- Wrapping Up

### Processes and System Monitoring
- What Is a Process?
- Foreground vs. Background Processes
- Viewing Processes
  - Watching Processes and System Load with top
    - Quick check with uptime
- Stopping Processes
  - Process Hierarchy: Parents and Children
- Monitoring System Resources
- Hands-On Lab: Working with Processes
- Wrapping Up

### Installing and Managing Software
- Binary Packages with pkg
  - Common Commands
- The FreeBSD Ports Collection
  - Why Use Ports?
  - Getting and Exploring the Ports Tree
  - Installing the Ports Collection with Git
  - Browsing the Ports
  - Building from Ports
  - Mixing Ports and Packages
- Where Installed Software Goes
- Practical Example: Installing vim and htop
  - Using pkg
  - Using Ports
- Hands-On Lab: Managing Software
- Wrapping Up

### Keeping FreeBSD Up to Date
- Why Updates Matter
- The freebsd-update Tool
- The Update Workflow
- Example Session
- Kernel Updates with freebsd-update
- Upgrading to a New Release with freebsd-update
- Hands-On Lab: Running Your First Update
- Wrapping Up

### Scheduling and Automation
- Why Automate Tasks?
- cron: The Automation Workhorse
- Understanding the crontab Format
  - Examples of cron jobs
- Editing and Managing Crontabs
- Where Do Logs Go?
- at: One-Time Scheduling
- periodic: FreeBSD's Maintenance Helper
  - Where the Scripts Live
  - What periodic Does by Default
  - Running periodic Manually
  - Customizing periodic with periodic.conf
  - Discovering All Available Checks
  - Why This Matters for Developers
- Hands-On Lab: Automating Tasks
- Common Pitfalls for Beginners
- Why This Matters for Driver Developers
- Wrapping Up

### Introduction to Shell Scripting
1. Your first script: shebang, make it executable, run it
2. Variables and quoting
3. Exit status and short circuit operators
4. Tests and conditions: if, [ ], files and numbers
5. Loops: for and while
6. Case statements for tidy branching
7. Functions to organize your script
8. A practical example: a tiny backup script
9. Working with temporary files safely
10. Debugging your scripts
11. Putting it together: organize downloads by type
- Hands-on Lab: three mini tasks
- Common beginner pitfalls and how to avoid them
- Wrapping up

### Shell Portability: Handling Edge Cases and bash vs sh
- The Problem: Filenames with Special Characters
- A Naive Approach That Breaks
- The bash Solution: Using Null Delimiters
- The POSIX-Compliant Alternative
- Understanding the Trade-Off
- When to Choose bash
- A Third Option: find -exec
- Practical Advice
- Wrapping Up

### Seeking Help and Documentation in FreeBSD
- The Power of man Pages
  - Man Page Sections
  - Man Section 9: The Kernel Developer's Manual
  - Hands-On Preview
  - Searching the man Pages
- The FreeBSD Handbook
  - Other Documentation
- Community and Support
  - How to Ask for Help
  - Example of a Poor Help Request
  - Example of a Good Help Request
- Hands-On Lab: Exploring Documentation
- Wrapping Up

### Peeking into the Kernel and System State
- dmesg: Reading the Kernel's Diary
- sysctl: The Kernel's Control Panel
  - Exploring Everything
  - Changing Values
- /dev: Where Devices Come to Life
- Hands-On Lab: Your First Peek Inside
- From Shell to Hardware: The Big Picture
- Common Beginner Pitfalls
- Wrapping Up

### Wrapping Up
- Practice Ground
- Filesystem and Navigation (8 exercises)
- Users, Groups, and Permissions (6 exercises)
- Processes and System Monitoring (7 exercises)
- Installing and Managing Software (pkg and Ports) (6 exercises)
- Automation and Scheduling (cron, at, periodic) (6 exercises)
- Shell Scripting (/bin/sh) (7 exercises)
- Peeking into the Kernel (dmesg, sysctl, /dev) (6 exercises)
- Wrapping Up
- Looking Ahead

---

## Chapter 4 — A First Look at the C Programming Language

### Reader Guidance: How to Use This Chapter
- How to Get the Most Out of This Chapter

### Introduction
- What is C?
- Why Should I Learn C for FreeBSD?
- What If I've Never Programmed Before?
- How Is This Chapter Organized?

### Setting Up Your Environment
- Installing a C Compiler on FreeBSD
- Behind the Scenes: The Compilation Pipeline
- Using Makefiles
- Installing the FreeBSD Source Code
- Summary

### Anatomy of a C Program
- The Basic Structure
- #include Directives: Adding Libraries
- The main() Function: Where Execution Begins
- Statements and Function Calls
- Return Values
- Bonus Learning Point About Return Values
- Putting It All Together
- A First Glimpse at Good Practices in C
  1. Always Use Braces
  2. Indentation Matters
  3. Prefer Meaningful Names
  4. No "Magic Numbers"
  - Why This Matters for You
- Summary

### Variables and Data Types
- What Is a Variable?
- Declaring Variables
- Common C Data Types
- Type Qualifiers
- Constant Values and #define
- Why Use #define for Constants?
- Real Example From FreeBSD
- Watch Out: There Is No Type Checking
- Best Practices for #define Constants in Kernel Development
- Best Practices for Variables
- Summary

### Operators and Expressions
- What Is an Expression?
- Arithmetic Operators
- Comparison Operators
- Logical Operators
- Assignment and Compound Assignment Operators
- Bitwise Operators
- Operator Precedence and Associativity
- Summary

### Control Flow
- Making Decisions: if, else if, else
- Multi-way Branching: switch
- Repetition: while, do-while, for
- Breaking and Continuing Loops
- Summary

### Functions
- Why Functions Matter
- Declaring and Defining Functions
- Parameters and Arguments
- Return Values
- Scope and Lifetime of Variables
- Summary

### Pointers and Memory
- What Is a Pointer?
- Declaring and Using Pointers
- Pointers and Addresses
- The NULL Pointer
- Pointers and Functions
- Pointer Arithmetic
- Why Pointers Matter in the Kernel
- Summary

### Arrays and Strings
- Working with Arrays
- Strings as Character Arrays
- Common String Functions
- Arrays, Pointers, and the Kernel
- Summary

### Structures and Unions
- Grouping Data with Structures
- Accessing Structure Members
- Pointers to Structures
- Unions
- Structures in FreeBSD
- Summary

### The C Preprocessor
- What the Preprocessor Does
- Macros with #define
- Conditional Compilation
- Include Guards
- Summary

### Memory Safety and Common Pitfalls
- Buffer Overflows
- Dangling Pointers and Use-After-Free
- Memory Leaks
- Uninitialized Variables
- Undefined Behavior
- Summary

### FreeBSD Kernel Normal Form (KNF) Coding Style
- What Is KNF?
- Key Style Rules
- Why Style Consistency Matters
- Summary

### Wrapping Up
- Practice Ground (final exercises)
- Looking Ahead

---

## Chapter 5 — Understanding C for FreeBSD Kernel Programming

> Detailed subtitles were not exposed in the retrieved source. Companion
> material covers how kernel C differs from userland C: the freestanding
> environment, forbidden libc calls, kernel memory allocation (malloc(9)),
> data types, locking primitives, and kernel-safe coding patterns.

---

## Chapter 6 — The Anatomy of a FreeBSD Driver

> Detailed subtitles were not exposed in the retrieved source. Companion
> material covers the structure of a loadable kernel module, device_t,
> driver_t and devclass, the newbus framework, module event handlers,
> and the lifecycle of a driver from load to unload.