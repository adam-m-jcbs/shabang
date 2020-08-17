#!/usr/bin/env bash
##!/bin/bash

#You cannot quite "save" tmux sessions, and given it's a multiplex of live
#shells you can imagine how infeasible robust saving would be

#Instead, as advised in "The Pragmatic Bookshelf" tmux book and various Stack*,
#you can design a session structure and encode it in a script that builds it up
#when needed and attaches to a running session when available, offering the feel
#of persistent sessions across reboots/systems/etc.

#This script is a template for engaging a user-provided tmux session.  However,
#in most cases you will want to write a script like this for each session so you
#can compose panes, windows, workingd dir, etc as wanted.

#Get the session name from user, assuming it's the first arg
#TODO: Add arg error-checking, usage info
SESSION_NAME=$1
tmux has-session -t $SESSION_NAME &> /dev/null

if [ $? != 0 ]; then
    tmux new-session -s $SESSION_NAME -n $SESSION_NAME -d
    #tmux send-keys -t $SESSION_NAME "/path/to/script" C-m
fi

tmux attach -t $SESSION_NAME
