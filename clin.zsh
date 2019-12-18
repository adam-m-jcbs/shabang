#!/bin/zsh

## Clock In script
#   In collaboration with clout.zsh and clest.zsh, it maintains these files:
#       ~/.clock_log/clin_time      --> ASCII one line
#                                       if clocked in: the output of `date +"%F %H:%M:%S"` recording when you clocked in
#                                       if clocked out: OUT
#                                       acts as CLOCK STATUS (am I in or out?)
#       ~/.clock_log/YYYY-MM-DD.log --> log of that day's in/outs
#       ~/.clock_log/state          --> short, human-readable current status
#                                       "IN HH:MM" w/ HH:MM the time clocked in , or
#                                       "OUT"
#                                       TODO: it would be awesome to have IN
#                                       show time elapses since clock in, but
#                                       that would need some hooks/triggers for
#                                       every time prompt is redrawn.  Do it
#                                       some day if you can.

#User has tried to clock in, so check state
#   TODO: Add error checks 
#       file should exist
#       file should always have just one line with specifically formatted data
#   TODO: make directories variables instead of hard-coded
cur_state=`cat ~/.clock_log/clin_time | head -n1 | awk '{$1=$1;print}'` #awk magic trims outer spaces and squeezes internal spaces to 1
if [[ $cur_state == 'OUT' ]]; then
    #We're here, so state was clocked out.
    #Good, that's what's expected for a clock in operation.
    date +"%F %H:%M:%S" > ~/.clock_log/clin_time
    date +"IN %H:%M" > ~/.clock_log/state

    #The state's updated,
    #my POWERLEVEL9K configuration has a custom segment that reads the state
    #file, so this is all we need to do to update the prompt
else
    echo "You've already clocked in, use clest if you forgot to clock out"
    echo "    IN@ " $cur_state
fi

#       TODO implement clest
#
#       `clest HH:MM:SS` to estimate the time they clocked out or
#       `clest +HH:MM:SS` to estimate the time they worked after last clocking in
