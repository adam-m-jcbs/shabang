#!/bin/zsh

## Clock Out script
#   In collaboration with clin.zsh, clnote.zsh, and clp_state.zsh, it maintains/uses/parses these files:
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



#User has tried to clock out, so check state
#   TODO: Add error checks 
#       file should exist
#       file should always have just one line with specifically formatted data
#   TODO: make directories variables instead of hard-coded
#Use matching regex (date) sentinel to get state
cur_state=`cat ~/.clock_log/clin_time        | awk '$1 ~ /[0-9]{4}-[0-9]{2}-[0-9]{2}/ {$1=$1;print}'` #awk magic ($1=$1 has side-effect of re-evaluating $0 and rebuilding with default separators) trims outer spaces and squeezes internal spaces to 1
#Use matching regex (three capital letter code) sentinel to get context (optional! if blank, ignore)
cur_context=`cat ~/.clock_log/clin_time      | awk '$1 ~ /[A-Z]{3}:/             {$1=$1;print}'` 
cur_context_code=`cat ~/.clock_log/clin_time | awk '$1 ~ /[A-Z]{3}:/             {$1=$1;printf "%.3s", $1}'` 
cur_context_desc=`cat ~/.clock_log/clin_time | awk '$1 ~ /[A-Z]{3}:/             {$1="";print $0}'` 
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

    #If the optional context is provided, prepare directories
    with_slash=""
    if [[ ! -d ~/.clock_log/$cur_context_code ]]; then
        mkdir -p ~/.clock_log/$cur_context_code
        with_slash=$cur_context_code/
    fi
 
    #store record in ~/.clock_log/YYYY-MM-DD.log
    echo ${cl_start} -- ${cl_end} >>  ~/.clock_log/`date +"%F"`.log
    if [[ -f ~/.clock_log/clin_notes ]]; then
        cat ~/.clock_log/clin_notes >>   ~/.clock_log/${with_slash}`date +"%F"`.log
    fi
    echo "    " $user_note >> ~/.clock_log/${with_slash}`date +"%F"`.log
    echo "     Days H:M:S - " $time_elapsed_record >> ~/.clock_log/${with_slash}`date +"%F"`.log
    
    #tell user gist of what happened
    echo "clocked out!"
    if [[ -f ~/.clock_log/clin_notes ]]; then
        echo "    log:"
        cat ~/.clock_log/clin_notes
    fi
    echo "    note:           " $user_note
    echo "    focus duration: " $time_elapsed_human
    
    #update state variables and reset state for clock in
    echo "OUT" > ~/.clock_log/clin_time
    echo "OUT" > ~/.clock_log/state
    if [[ -f ~/.clock_log/clin_notes ]]; then
        rm ~/.clock_log/clin_notes
    fi

    #The state's updated,
    #my zsh prompt configuration has a custom segment that reads the state
    #file, so this is all we need to do to update the prompt
fi
