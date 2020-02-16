# shabang

This is a repository to manage various shell executables and such that I like to
have available.

### Executables/Scripts and Their Purpose

**`clin.zsh`, `clnote.zsh`, `clout.zsh`, `clp_state.zsh`**

A collection of `zsh` scripts that I use to log and monitor my time.  `clin` is
"clock in", `clout` is "clock out", and `clnote` is "log a note".  They are
mostly a personal project, but if you use them and have questions, let me know.
They could be improved.

**`launch_tmux_server.sh`**

This script is essentially an encoding of my preferences for and notions of a
"tmux server".  In particular, how I want to launch one.  My goal is to be able
to save state, shut down the server, restart the server and load the saved
state (even if that state is multiple shells connected to multiple things).

My server will be resilient to situations where it is not run with root
privileges, meaning it may be killed by administrators or automated
process-killing utilities that enforce resource usage policies.

My server will also respect a shared resources environment, making careful use
of CPU and memory.

My server will deal with the reality of shared resources that are not updated as regularly as they could be.  Thus, it will run in a way that is compatible with tmux 1.8.  This is subject to change.

**`theme_my_term.sh`**

A script that does magic, giving your terminal a makeover that is both
functional and aesthetically pleasing.  Seriously, check it out, read the
comments (because the magic is actually done by
github.com/Mayccoll/Gogh).

**`ssh_proxy_jump.sh`**

A manual, should-work-anywhere ssh tunnel including a proxy jump.  Do this more
automatically using `.ssh/config`, but sometimes you find yourself on a strange
machine and you just need to do the slick tunnel + proxy without config files.

**`rrnote.zsh`**

Work in progress.

**`net_list_iface.zsh`**

Work in progress.

