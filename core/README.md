# Core Actions

A core action is built of the following:

- Must only use git and require not other dependencies.
- Written entirely inside POSIX shell (for optimal use)
- Follow the UNIX philosophy (Do one thing well)

##  Developing a core action

Each core module must contain a function of the following semantics:

*"core_check_[action]"*

This will ensure that we check to make sure we are in a meta repo in the local
file directory before executing the function.
The only exception to the rule is when '-h' is passed in.

*"core_[action]"*

This is an action that does not require to be inside a meta repo directory.
Ie. Clone
