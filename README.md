```
███╗   ███╗███████╗████████╗ █████╗                ██████╗ ██╗████████╗
████╗ ████║██╔════╝╚══██╔══╝██╔══██╗              ██╔════╝ ██║╚══██╔══╝
██╔████╔██║█████╗     ██║   ███████║    █████╗    ██║  ███╗██║   ██║   
██║╚██╔╝██║██╔══╝     ██║   ██╔══██║    ╚════╝    ██║   ██║██║   ██║   
██║ ╚═╝ ██║███████╗   ██║   ██║  ██║              ╚██████╔╝██║   ██║   
╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝               ╚═════╝ ╚═╝   ╚═╝   
```

# Meta Git
## What is meta-git?
The _meta-git_ project is an application that makes working with a meta repos (via the use of [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules)) simple.
The true power of _meta-git_ is that it abstractions advanced git usage and configuration to make it easy for any developer to get on board.

### What is a meta-repo?

_"A meta repo is a repo that allows tracking of various repos at a particular configuration"_

This becomes beneficial when you require repos to be at a particular version in order for your project to work correctly (ie. you require a third party project to remain at a particular version).

## Getting started
Once you have cloned this repo locally, you will need to install to be able
to use it globally in your shell.

Run the following to install:
```sh
> ./meta-git install
```

_Note: If you rely on auto-complete for commands, you'll need to restart your terminal._

# The power of meta-git!!!

The commands used in _meta-git_ are analogous to _git_'s commands (with a couple extra) so there is little learning curve if you are a familiar with git. To get the most recent usage of _meta-git_ , please check its help message by going:
```sh
> meta-git -h
```
## Examples using meta-git
### Setting different repos to use the same branch
This feature is awesome when you need to make hotfixes / features across different projects and ensure all the different projects still work together.
[![asciicast](https://asciinema.org/a/bVGjRiy046kl9jUj0mf54LdLL.png)](https://asciinema.org/a/bVGjRiy046kl9jUj0mf54LdLL)

### Creating a branch to use a particular branches on repos
The benefit of this is that we can developers easily share and change environments to match their co-workers.
[![asciicast](https://asciinema.org/a/fCUSU04pDUBWeAc7iOlOxcjZC.png)](https://asciinema.org/a/fCUSU04pDUBWeAc7iOlOxcjZC)

## Things to watch out for...

_"Missing changes in the meta repo"_

If you are working on repos that are submodules and haven't set the meta repo to now use the new branch,
your changes are only visible locally. Anyone trying to use your meta repo branch would
get the default branch of the submodules not the branch you intended.
Easy fix is to use _meta-git set_ action to ensure changes are made and are preserved.

_"Repos are in a detached state"_

As the meta repo helps us to track changes in submodules, it does not use
the branch name to track but rather the commit hash of the repo.
It is still tracking said branch but it will show it is a detached state.
