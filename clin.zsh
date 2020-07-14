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
#Use matching regex (date) sentinel to get state
cur_state=`cat ~/.clock_log/clin_time        | awk '{$1=$1;print}'` #awk magic ($1=$1 has side-effect of re-evaluating $0 and rebuilding with default separators) trims outer spaces and squeezes internal spaces to 1
#Use matching regex (three capital letter code) sentinel to get context (optional! if blank, ignore)
cur_context=`cat ~/.clock_log/clin_time      | awk '$1 ~ /[A-Z]{3}:/             {$1=$1;print}'` 
cur_context_code=`cat ~/.clock_log/clin_time | awk '$1 ~ /[A-Z]{3}:/             {$1=$1;printf "%.3s", $1}'` 
cur_context_desc=`cat ~/.clock_log/clin_time | awk '$1 ~ /[A-Z]{3}:/             {$1="";print $0}'` 
if [[ $cur_state == 'OUT' ]]; then
    #We're here, so state was clocked out.
    #Good, that's what's expected for a clock in operation.

    #If the optional context is provided, prepare directories
    if [[ $# -gt 0 ]]; then
        #TODO: Assuming proper form for now, need to error-check
        #Take all arguments except the first/0th (name of script)
        cur_context=${@:1:${#@[@]}} #We assume form "XXX: human-readable desc of XXX"
    fi

    #Use matching regex (three capital letter code) sentinel to get context details
    cur_context_code=`echo $cur_context  | awk '$1 ~ /[A-Z]{3}:/             {$1=$1;printf "%.3s", $1}'` 
    cur_context_desc=`echo $cur_context  | awk '$1 ~ /[A-Z]{3}:/             {$1="";print $0}'` 
    with_slash=""
    if [[ ! -d ~/.clock_log/$cur_context_code ]]; then
        mkdir -p ~/.clock_log/$cur_context_code
        with_slash=$cur_context_code/
    fi
    
    #Store any clocked out log in ~/.clock_log/YYYY-MM-DD.log
    #Also, if a context code is given, store context-specific notes in their logs
    if [[ -f ~/.clock_log/clout_notes ]]; then
        if [[ -n $cur_context_code ]]; then
            echo "Context code: $cur_context_code" >>  ~/.clock_log/`date +"%F"`.log
            cat ~/.clock_log/clout_notes >>  ~/.clock_log/`date +"%F"`.log
            cat ~/.clock_log/clout_notes >>  ~/.clock_log/${with_slash}`date +"%F"`.log
        else
            cat ~/.clock_log/clout_notes >>  ~/.clock_log/`date +"%F"`.log
        fi
        rm ~/.clock_log/clout_notes
    fi

    date +"%F %H:%M:%S" > ~/.clock_log/clin_time
    with_parens=''
    if [[ -n $cur_context_code ]]; then
        echo $cur_context >> ~/.clock_log/clin_time
        with_parens=\(${cur_context_code}\)
    fi
    date +"IN${with_parens} %H:%M" > ~/.clock_log/state

    #The state's updated,
    #my POWERLEVEL9K configuration has a custom segment that reads the state
    #file, so this is all we need to do to update the prompt
else
    echo "You've already clocked in!"
    #We can now be guaranteed the state info is available, so grab it
    cur_state=`cat ~/.clock_log/clin_time        | awk '$1 ~ /[0-9]{4}-[0-9]{2}-[0-9]{2}/ {$1=$1;print}'` #awk magic ($1=$1 has side-effect of re-evaluating $0 and rebuilding with default separators) trims outer spaces and squeezes internal spaces to 1
    echo "    IN@  " $cur_state
    if [[ -n $cur_context ]]; then
        echo "    ctx: " $cur_context
    fi
fi

#       TODO implement clest? I'm kinda OK with just clnote... we'll see
#
#       `clest HH:MM:SS` to estimate the time they clocked out or
#       `clest +HH:MM:SS` to estimate the time they worked after last clocking in
