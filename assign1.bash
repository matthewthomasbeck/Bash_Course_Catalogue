#!/bin/bash

################################################################################
# This code and its associated files were created at the instruction of        #
# professors at the University of Texas at San Antonio during my time as a     #
# student at the university. I, as a student, was not responsible for the idea #
# behind this code (i.e. project guidelines, functionality, and end purpose),  #
# but I, Matthew Thomas Beck, can confirm that myself and any project partners #
# (if applicable) were the ones responsible for writing it.                    #
################################################################################





#########################################################
############### ASSIGNMENT MAIN INTERFACE ###############
#########################################################


########## COURSE CATALOGUE MENU ##########

while true; do # display the menu until CTRL-D is pressed

    ##### print menu #####

    echo "Enter one of the following actions or press CTRL-D to exit:" # ask user for input
    echo "C - create a new course record" # select c to call create.bash
    echo "R - read an existing course record" # select r to call read.bash
    echo "U - update an existing course record" # select u to call update.bash
    echo "D - delete an existing course record" # select d to call delete.bash
    echo "E - update enrolled student count of existing course" # select e to call enroll.bash
    echo -e "T - show total course count\n" # select t to call total.bash

    ##### take user input #####

    read -n 1 input # read single character input from user

    echo ""  # move to next line for space

    ##### check if exit #####

    if [[ ! "$input" ]]; then # if user input empty (written specifically for use with .txt redirect)...

        exit 0 # stop the program
    fi

    ##### menu input functionality #####

    # create vase statement to display options (case statements inspired by my use of switch statements in python)
    case $input in

        C|c) # if user wants to create a course record...

            ./create.bash # call create.bash to create course record
            ;;

        R|r) # if user wants to read a course record...

            ./read.bash # call read.bash to read a course record
            ;;

        U|u) # if user wants to update a course record...

            ./update.bash # call update.bash to update a course record
            ;;

        D|d) # if user wants to delete a course record...

            ./delete.bash # call delete.bash to delete a course record
            ;;

        E|e) # if user wants to update enrolled student count of a course...

            ./enroll.bash # call enroll.bash to update enrolled student count
            ;;

        T|t) # if user wants to see course count...

            ./total.bash # call total.bash to show total course count
            ;;

        *) # if user input is invalid...

            echo -e "ERROR: select a valid response\n" # throw invalid input error
            ;;
    esac
done