# External Action

These are actions that are designed to work with a meta repo but
require external tools to be installed.
These external commands are not loaded into _meta-git_ like the core commands
but rather called from _meta-git_ itself.

## Developing an external action

An external action is required to take command line arguments to help use.
A minimum it should support are:

- '-h' The help argument
