#!/bin/zsh

## Clock Out script
#   In collaboration with clin.zsh and clest.zsh, it maintains these files:
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

###Algorithm outline

#User has tried to clock out, so check state
#   TODO: Add error checks 
#       file should exist
#       file should always have just one line with specifically formatted data
#   TODO: make directories variables instead of hard-coded
cur_state=`cat ~/.clock_log/clin_time | head -n1 | awk '{$1=$1;print}'` #awk magic trims outer spaces and squeezes internal spaces to 1
if [[ cur_state == 'OUT' ]]; then
    #We're here, so state was clocked out.
    echo "You've already clocked out!"
else
    #We're here, so state should be clock-in time YYYY-MM-DD HH:MM:SS

    #calculate time clocked in (requires dateutils linux package)
    cl_start=$cur_state
    cl_end=`date +"%F %H:%M:%S"`
    time_elapsed_record=`datediff --format="%d %H:%M:%S" $cl_start $cl_end`
    time_elapsed_human=`datediff --format="%H:%M" $cl_start $cl_end`

    #get any user note
    #    TODO: error checking, make this a proper script
    if [[ $# -gt 0 ]]; then
        user_note=$1
    fi

    #store record in ~/.clock_log/YYYY-MM-DD.log
    echo ${cl_start} -- ${cl_end} >>  ~/.clock_log/`date +"%F"`.log
    echo "    " $user_note >> ~/.clock_log/`date +"%F"`.log
    echo "     Days H:M:S - " $time_elapsed_record >> ~/.clock_log/`date +"%F"`.log
    
    #tell user gist of what happened
    echo "clocked out!"
    echo "    note:           " $user_note
    echo "    focus duration: " $time_elapsed_human
    
    #update state variables
    echo "OUT" > ~/.clock_log/clin_time
    echo "OUT" > ~/.clock_log/state

    #The state's updated,
    #my POWERLEVEL9K configuration has a custom segment that reads the state
    #file, so this is all we need to do to update the prompt
fi
