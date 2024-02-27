#!/bin/bash

################################################################################
# This code and its associated files were created at the instruction of        #
# professors at the University of Texas at San Antonio during my time as a     #
# student at the university. I, as a student, was not responsible for the idea #
# behind this code (i.e. project guidelines, functionality, and end purpose),  #
# but I, Matthew Thomas Beck, can confirm that myself and any project partners #
# (if applicable) were the ones responsible for writing it.                    #
################################################################################





##################################################
############### STUDENT ENROLLMENT ###############
##################################################


########## USER INPUT ##########

##### department code and course number #####

valid=false # initialize as false

while [ "$valid" == false ]; do # loop as long as the user keeps messing up

    echo "" # add space to make good looking

    read -p "Enter a department code and course number: " dept_code course_num # take input from user

    dept_code=$(echo "$dept_code" | tr '[:upper:]' '[:lower:]') # convert dept code to lowercase
    # I attempted to use input="${input,,}" but could not get that to work

    # if both department code and course number are valid...
    if [[ "$dept_code" =~ ^[[:alnum:]]{2,3}$ ]] && [[ "$course_num" =~ ^[0-9]+$ && ${#course_num} -eq 4 ]]; then

        valid=true # break the loop

    else # if either department code or course number is not valid...

        # throw invalid input error
        echo -e "\nERROR: Please enter a valid department code (2-3 characters) and a valid integer course number \
        (4 numbers)."
    fi
done

##### new enrollment #####

valid=false # initialize as false

while [ "$valid" == false ]; do # loop as long as the user keeps messing up

    read -p "Enter enrollment change amount: " input # take input from user

    if [[ "$input" =~ ^[+-]?[0-9]+$ ]]; then # if input is a valid signed integer...

        change_amt=$input # take valid input from user

        valid=true # break the loop

    else # if input is not a valid integer...

        echo -e "\nERROR: please enter an integer" # throw invalid input error
    fi
done


########## SEARCH FOR FILE ##########

course_file="data/${dept_code}${course_num}.crs" # build file path needed for 'search engine' functionality

if [ ! -e "$course_file" ]; then # if file has not been found...

    echo -e "\nERROR: course not found\n" # print course not found error statement

    valid=false # initialize as false

    while [ "$valid" == false ]; do # loop as long as the user keeps messing up

        # ask for failure course of action
        read -p "Want to continue? (enter yes: (y, Y), no: (n, N)): " input

        if [[ "$input" =~ ^[yYnN]$ ]]; then # if user enters correct yes/no input of any kind...

            valid=true # break the loop

            case $input in # yes/no case (inspired by my work with switch statements in python for Receipt_Analyzer_3.0)

                y|Y) # if user selects yes...

                    ./read.bash # recursively call the script to restart the process

                    exit 0 # close process
                    ;;

                n|N) # if user selects no...

                    exit 0 # close process
                    ;;
            esac

        else # if user doess not enter correct yes/no input...

            echo -e "\nERROR: invalid input (enter yes: (y, Y), no: (n, N))\n" # print error statement
        fi
    done
fi


########## READ OLD FILE ##########

while read line; do # loop through the entire contents of the course file

    ##### read values #####

    read dept_code dept_name <<< "$line" # take code and dept name from first line with here string
    read course_name # take course name from second line
    read course_sched start_date end_date # take schedule start and end from third line
    read credit_hours # take hours from fourth line
    read initial_enrollment # take population from fifth line
done < "$course_file"


########## SET NEW VALUE ##########

initial_enrollment=$((initial_enrollment + change_amt)) # set new initial enrollment value


########## FILE OUTPUT ##########

##### create file #####

data_folder="data" # set directory to store file

mkdir -p "$data_folder"  # make data directory to avoid annoying 'nO sUcH fIlE oR dIrEcToRy'

##### fill file #####

dept_code=$(echo "$dept_code" | tr '[:lower:]' '[:upper:]') # department code to uppercase for the file
# I attempted to use dept_code="${dept_code^^}" but could not get that to work

# move data into course file (trick I picked up from Python, use \ if your code line is too long)
echo -e "$dept_code $dept_name\n$course_name\n$course_sched $start_date $end_date\n$credit_hours\n$initial_enrollment" >\
"$course_file"

##### export file #####

mv -f "$course_file" "$data_folder/" # move new course data file to data directory and -f to ignore errors

echo "" # print new line for legibility

##### update log #####

echo "[$(date)] ENROLLMENT: $dept_code $course_num $course_name changed by $change_amt" >> data/queries.log # update the log

##### return to main menu #####

exit 0 # close process