#!/bin/bash
#TODO: using `#!/bin/bash` is fine in most cases, but should consider more portable or userland versions, if needed

# This script encodes my preferences and requirements for a tmux session server.

# Requires:
#   tmux 1.8+,
#   bash (doesn't have to be your shell, just available), 


# What this does, tl;dr:
#   Launches a named tmux server session to manage all sorts of workloads.
#
#   tmux options:
#       -2  : Assume 256 color is supported (pretty safe bet these days)
#       -u  : Assume UTF-8 is supported (maybe less safe, but I usually have it)
#       -f my_tmux.conf
#           : Use the given config file instead of system or user default
#   tmux command:
#       new-session  : A misleading name, because this command is so powerful.  This can be for creating a new session and initializing the state that will be managed.  But it can also be used to restart and attach to a previously saved session!  We'll see this below.
#   new-session options:
#       -A  : MAGIC!  This makes new-session behave like attach-session if session-name already exists.  Thus, if you need to start from scratch, cool, but if not, let's just pick up back where we left off.  All for free, thanks to tmux!
#       -P  : Print information about the session
#       -c start-directory
#           : A newer feature I want to explore later, not tmux 1.8 compatible.  By default, the tmux "working directory" will be "~" or "/"
#       -s session-name
#           : Name the session `session-name`.  This is important.  It is what we'll save state to.
#   tmux shell:
#       The last arg to `tmux new-session` is the interactive shell it will run.  Bash is usually best bet on shared resources. I prefer a login shell, thus -l
    
tmux -2u -f ${HOME}/Codebase/dotfiles/tmux.conf new-session -AP -s icer_xrb_sens bash -l
