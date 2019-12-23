#!/bin/zsh

## Reflection & Revision Note script
#   This script is part of my "gitterdone" framework.  It quickly appends notes
#   from the shell to ~/Codebase/gitterdone/this_week.md, which should be
#   guaranteed to end with a section for collecting R&R notes


#User has tried to make a note
#   TODO: Add error checks 
#       file should exist
#       file should always have just one line with specifically formatted data
#   TODO: make directories variables instead of hard-coded
    
#get user's note
#    TODO: error checking, make this a proper script
if [[ $# -gt 0 ]]; then
    user_note=$1

    #Append note to this_week.md r&r section, echo entry to user
    # TODO: Hard-coded directories below, big no-no!
    echo "    " `date +"%H:%M:%S"` '-' $user_note >> ~/Codebase/gitterdone/this_week.md
    echo "appended to ~/Codebase/gitterdone/this_week.md: "
    echo "    `date +"%H:%M:%S"` '-' $user_note"
fi
