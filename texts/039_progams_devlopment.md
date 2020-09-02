## Introduction to development

And now we are ready to do some kind of development project. We will try to implement the following traditional task for novice developers -- a calculator. And finally, we will get a network client-server application with a graphical user interface localized into Russian. We can find the code for this project on github:

[https://github.com/itmo-infocom/calc_examples](https://github.com/itmo-infocom/calc_examples)

Github supports hosting for software development and version control with Git. 

Version control (also known as revision control, source control, or source code management) is a class of systems responsible for managing changes to computer programs, documents, large web sites, or other collections of information. Version control is a component of software configuration management.

[VCS Release History Timeline](https://initialcommit.com/blog/Technical-Guide-VCS-Internals)

The first generation VCS were intended to track changes for individual files and checked-out files could only be edited locally by one user at a time. They were built on the assumption that all users would log into the same shared Unix host with their own accounts. The second generation VCS introduced networking which led to centralized repositories that contained the 'official' versions of their projects. This was good progress, since it allowed multiple users to checkout and work with the code at the same time, but they would all be committing back to the same central repository. Furthermore, network access was required to make commits. The third generation comprises the distributed VCS. In a distributed VCS, all copies of the repository are created equal -- generally there is no central copy of the repository. This opens the path for commits, branches, and merges to be created locally without network access and pushed to other repositories as needed.

 There are many VCS systems developed and used on UNIX-like systems: SCCS, RCS, CVS, SVN, Mercurial, Bazzar, etc., and Git is now the most popular. Git is a distributed version-control system for tracking changes in source code during software development. It was created by Linus Torvalds in 2005 for development of the Linux kernel, with other kernel developers contributing to its initial development.

## Devlopment tools
 The basic tool for working with Git repositories is the `git` utility:
```
man git
```
First we have to `clone` our repository:
```
$ git clone https://github.com/itmo-infocom/calc_examples
$ ls calc_examples/
calc  calc.services  calc_ui  calc_ui.pot  calc_ui-ru.po  calc.xinetd  gdialog  Makefile  README.md
```
Ok - we now have our own local copy. Let's go inside:
```
$ cd calc_examples/
```
Now let's take a look at the tags that indicate different stages of development -- tags:
```
$ git tag
Example_1
Example_2
Example_3
Example_4
Example_5
Example_6
Example_7
Example_8
Example_9
```
Let's move on to the initial stage now:
```
$ git checkout Example_1
Note: checking out 'Example_1'.
...
$ ls
Makefile  README.md
```
As we can see, most of the files have disappeared and now we only have a README and a Makefile. Let's take a look at the README:
```
$ cat README.md 
calc_examples
...
```
and at the Makefile:
```
$ cat Makefile 
clone:
...
```
A Makefile is a file containing a set of directives used by a `make` build automation tool to generate a target/goal. Make is the oldest and most widely used dependency-tracking tool for building software projects. It is used to build large projects such as the Linux kernel with tens of millions of source code lines. Usually, using make is pretty simple: you just run make with no arguments:
```
man make
```
In this case, the utility tries to find a makefile that starts with a lowercase letter and then with a capital letter. Usually the second Makefile with an uppercase letter is used, the lowercase version is often used for some local changes while testing and customizing the Makefile of an upstream project.

The makefile format is pretty simple -- It's just a lot of rules for building projects:
```
$ cat Makefile 
```
In the first position we see the `target`, after the semicolon, dependencies can be placed, which are just other targets. Lines following the description of targets and dependencies must start with a TAB character, and there are commands that must be executed to complete this target. If the dependencies are files, make checks the modification times of those files and recursively rebuilds those dependency targets.

The current Makefile just includes a few targets for working with the Git repository. The first will start by default. If we want to run another target, we must pass it as a parameter when running the `make` utility.


