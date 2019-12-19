#!/bin/zsh

## Clock Note script
#   In collaboration with clin.zsh, clout.zsh, and clest.zsh, it maintains these files:
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
#       ~/.clock_log/clin_notes     --> A log of timestamped, one-line notes
#                                       describing actions, notes, ideas that you want to log while clocked in
#                                       It is an error to try to modify this
#                                       while not clocked in.
#                                       This file only ever contains a log for
#                                       the current session.  This is then
#                                       written out to a .log file and deleted.

###Algorithm outline

#User has tried to make a clock note. check state
#   TODO: Add error checks 
#       file should exist
#       file should always have just one line with specifically formatted data
#   TODO: make directories variables instead of hard-coded
cur_state=`cat ~/.clock_log/clin_time | head -n1 | awk '{$1=$1;print}'` #awk magic trims outer spaces and squeezes internal spaces to 1
if [[ cur_state == 'OUT' ]]; then
    #We're here, so state was clocked out.
    echo "You're clocked out, cannot make a note!"
else
    #We're here, so state should be clock-in time YYYY-MM-DD HH:MM:SS

    #get user's note
    #    TODO: error checking, make this a proper script
    if [[ $# -gt 0 ]]; then
        user_note=$1
    fi

    #Append note to clocked in log, echo entry to user
    echo "    " `date +"%H:%M:%S"` '-' $user_note >> ~/.clock_log/clin_notes
    echo "    " `date +"%H:%M:%S"` '-' $user_note
fi
