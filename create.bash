#!/bin/bash

################################################################################
# This code and its associated files were created at the instruction of        #
# professors at the University of Texas at San Antonio during my time as a     #
# student at the university. I, as a student, was not responsible for the idea #
# behind this code (i.e. project guidelines, functionality, and end purpose),  #
# but I, Matthew Thomas Beck, can confirm that myself and any project partners #
# (if applicable) were the ones responsible for writing it.                    #
################################################################################





#############################################
############### CREATE COURSE ###############
#############################################


########## USER INPUT ##########

##### department code #####

isValid=false # initialize as false (functionality inspired by Dr. Gomez's Programming I Project I)

while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

    read -p "Enter department code: " input # take input from user

    if [[ "$input" =~ ^[[:alnum:]]{2,3}$ ]]; then # if input is a valid 2-3 character string...

        dept_code=$input # take valid input from user

        isValid=true # break the loop

    else # if input is not a valid 2-3 character string...

        echo "ERROR: please enter a two-to-three character long string" # throw invalid input error
    fi
done

##### department name #####

read -p "enter department name: " dept_name # ask for dept name and save

##### course number #####

isValid=false # initialize as false (functionality inspired by Dr. Gomez's Programming I Project I)

while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

    read -p "Enter course number: " input # take input from user

    if [[ "$input" =~ ^[0-9]+$ && ${#input} -eq 4 ]]; then # if input is a valid integer...

        course_num=$input # take valid input from user

        isValid=true # break the loop

    else # if input is not a valid integer...

        echo "ERROR: please enter a valid integer 4 numbers long" # throw invalid input error
    fi
done

##### course name #####

read -p "enter course name: " course_name # ask for course name and save

##### course schedule #####

isValid=false # initialize as false (functionality inspired by Dr. Gomez's Programming I Project I)

while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

    read -p "Enter course schedule: " input # take input from user

    if [[ "$input" == "MWF" || "$input" == "TH" ]]; then # if input is correct string MWF or TH...

        course_sched=$input # take valid input from user

        isValid=true # break the loop

    else # if input is not a valid schedule...

        echo "ERROR: please enter a valid schedule (MWF or TH)" # throw invalid input error
    fi
done

##### start date #####

isValid=false # initialize as false (functionality inspired by Dr. Gomez's Programming I Project I)

while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

    read -p "Enter course start: " input # take input from user

    if [[ "$input" =~ ^[0-9]{2}/[0-9]{2}/[0-9]{4}$ ]]; then # if input valid date string...

        start_date=$input # take valid input from user

        isValid=true # break the loop

    else # if input is not a valid date string...

        echo "ERROR: please enter a valid end date (MM/DD/YYYY)" # throw invalid input error
    fi
done

##### end date #####

isValid=false # initialize as false (functionality inspired by Dr. Gomez's Programming I Project I)

while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

    read -p "Enter course start: " input # take input from user

    if [[ "$input" =~ ^[0-9]{2}/[0-9]{2}/[0-9]{4}$ ]]; then # if input valid date string...

        end_date=$input # take valid input from user

        isValid=true # break the loop

    else # if input is not a valid date string...

        echo "ERROR: please enter a valid end date (MM/DD/YYYY)" # throw invalid input error
    fi
done

##### credit hours #####

isValid=false # initialize as false (functionality inspired by Dr. Gomez's Programming I Project I)

while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

    read -p "Enter credit hours: " input # take input from user

    if [[ "$input" =~ ^[0-9]+$ ]]; then # if input is a valid integer...

        credit_hours=$input # take valid input from user

        isValid=true # break the loop

    else # if input is not a valid integer...

        echo "ERROR: please enter an unsigned integer" # throw invalid input error
    fi
done

##### initial enrollment #####

isValid=false # initialize as false (functionality inspired by Dr. Gomez's Programming I Project I)

while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

    read -p "Enter course enrollment: " input # take input from user

    if [[ "$input" =~ ^[0-9]+$ ]]; then # if input is a valid integer...

        initial_enrollment=$input # take valid input from user

        isValid=true # break the loop

    else # if input is not a valid integer...

        echo "ERROR: please enter an unsigned integer" # throw invalid input error
    fi
done

##### test #####

# test to show data
echo "department code: $dept_code"
echo "department name: $dept_name"
echo "course number: $course_num"
echo "course name: $course_name"
echo "course schedule: $course_sched"
echo "course start date: $start_date"
echo "course end date: $end_date"
echo "course credit hours: $credit_hours"
echo "initial course enrollment: $initial_enrollment"


########## FILE OUTPUT ##########