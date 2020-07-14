#!/bin/zsh

## Clock In script
#   In collaboration with clout.zsh, clnote.zsh, and clp_state.zsh, it maintains/uses/parses these files:
#       ~/.clock_log/clin_time      --> ASCII one line
#                                       if clocked in: the output of `date +"%F %H:%M:%S"` recording when you clocked in
#                                       if clocked out: OUT
#                                       acts as CLOCK STATUS (am I in or out?)
#       ~/.clock_log/YYYY-MM-DD.log --> log of that day's in/outs
#       ~/.clock_log/state          --> short, human-readable current status
#                                       "IN HH:MM" w/ HH:MM the time clocked in , or
#                                       "OUT"
#       ~/.clock_log/clin_notes     --> A log of timestamped, one-line notes
#                                       describing actions, notes, ideas that you want to log while clocked in
#                                       It is an error to try to modify this
#                                       while not clocked in.
#                                       This file only ever contains a log for
#                                       the current session.  This is then
#                                       written out to a .log file and deleted.
#       ~/.clock_log/clout_notes    --> A log of timestamped, one-line notes
#                                       describing actions, notes, ideas that occur when 
#                                       you're not focusing on a particular project/outcome
#                                       It is an error to try to modify this
#                                       while clocked in (this is for focused or
#                                       potentially billable time).
#                                       This file only ever contains a log for
#                                       the current session.  This is then
#                                       written out to a .log file and deleted.


#User has tried to clock in, so check state
#   TODO: Add error checks 
#       file should exist
#       file should always have specifically formatted data
#   TODO: make directories variables instead of hard-coded
#
cur_state=`cat ~/.clock_log/clin_time | head -n1 | awk '{$1=$1;print}'` #awk magic trims outer spaces and squeezes internal spaces to 1
cur_context=`cat ~/.clock_log/clin_time | head -n2 | tail -n1 |  awk '{$1=$1;print}'` #second line should be optional, has context
if [[ $cur_state == 'OUT' ]]; then
    #We're here, so state was clocked out.
    #Good, that's what's expected for a clock in operation.
    
    #Store any clocked out log in ~/.clock_log/YYYY-MM-DD.log
    if [[ -f ~/.clock_log/clout_notes ]]; then
        cat ~/.clock_log/clout_notes >>  ~/.clock_log/`date +"%F"`.log
        rm ~/.clock_log/clout_notes
    fi

    date +"%F %H:%M:%S" > ~/.clock_log/clin_time
    date +"IN %H:%M" > ~/.clock_log/state

    #The state's updated,
    #my POWERLEVEL9K configuration has a custom segment that reads the state
    #file, so this is all we need to do to update the prompt
else
    echo "You've already clocked in!"
    echo "    IN@ " $cur_state
fi

#       TODO implement clest? I'm kinda OK with just clnote... we'll see
#
#       `clest HH:MM:SS` to estimate the time they clocked out or
#       `clest +HH:MM:SS` to estimate the time they worked after last clocking in
