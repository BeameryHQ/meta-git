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

## The power of meta-git!!!
_setting different repos to use the same branch_
[![asciicast](https://asciinema.org/a/bVGjRiy046kl9jUj0mf54LdLL.png)](https://asciinema.org/a/bVGjRiy046kl9jUj0mf54LdLL)
