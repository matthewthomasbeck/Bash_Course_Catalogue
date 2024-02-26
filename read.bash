#!/bin/bash

################################################################################
# This code and its associated files were created at the instruction of        #
# professors at the University of Texas at San Antonio during my time as a     #
# student at the university. I, as a student, was not responsible for the idea #
# behind this code (i.e. project guidelines, functionality, and end purpose),  #
# but I, Matthew Thomas Beck, can confirm that myself and any project partners #
# (if applicable) were the ones responsible for writing it.                    #
################################################################################





###########################################
############### READ COURSE ###############
###########################################


########## USER INPUT ##########

##### department code #####

isValid=false # initialize as false (functionality inspired by Dr. Gomez's Programming I Project I)

while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

    echo "" # add space

    read -p "Enter department code: " input # take input from user

    input=$(echo "$input" | tr '[:lower:]' '[:upper:]') # convert the string with unix utility to uppercase

    if [[ "$input" =~ ^[[:alnum:]]{2,3}$ ]]; then # if input is a valid 2-3 character string...

        dept_code=$input # take valid input from user

        isValid=true # break the loop

    else # if input is not a valid 2-3 character string...

        echo -e "\nERROR: please enter a two-to-three character long string" # throw invalid input error
    fi
done

##### course number #####

isValid=false # initialize as false (functionality inspired by Dr. Gomez's Programming I Project I)

while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

    read -p "Enter course number: " input # take input from user

    if [[ "$input" =~ ^[0-9]+$ && ${#input} -eq 4 ]]; then # if input is a valid integer...

        course_num=$input # take valid input from user

        isValid=true # break the loop

    else # if input is not a valid integer...

        echo -e "\nERROR: please enter a valid integer 4 numbers long" # throw invalid input error
    fi
done


########## SEARCH FOR FILE ##########

course_file="data/${dept_code}${course_num}.txt" # build file path needed for 'search engine' functionality

if [ -e "$course_file" ]; then # if file has been found...

    course_object=$(<"$course_file") # read the contents of the file path to usable object that I can play with later :)

    echo "File found: $course_file" # print that the file has been found

else # if file has not been found (does not exist or entered wrong)...

    echo -e "\nERROR: course not found\n" # print course not found error statement

    isValid=false # initialize as false (functionality inspired by Dr. Gomez's Programming I Project I)

    while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

        # ask for failure course of action
        read -p "Want to continue? (enter yes: (y, Y), no: (n, N)): " input

        if [[ "$input" =~ ^[yYnN]$ ]]; then # if user enters correct yes/no input of any kind...

            isValid=true # break the loop

            case $input in # yes/no case (inspired by my work with switch statements in python for Receipt_Analyzer_3.0)

                y|Y|yes|Yes) # if user selects yes...

                    ./read.bash # recursively call the script to restart the process
                    ;;

                n|N|no|No) # if user selects no...

                    ./assign1.bash # send user back to main menu
                    ;;
            esac

        else # if user doess not enter correct yes/no input...

            echo -e "\nERROR: invalid input (enter yes: (y, Y), no: (n, N))\n" # print error statement
        fi
    done
fi

########## READ FILE ##########

echo -e "$course_object\n" # print course contents