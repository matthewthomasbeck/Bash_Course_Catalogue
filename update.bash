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
############### UPDATE COURSE ###############
#############################################


########## USER INPUT ##########

##### department code #####

isValid=false # initialize as false

while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

    echo "" # add space

    read -p "Enter department code: " input # take input from user

    input=$(echo "$input" | tr '[:upper:]' '[:lower:]') # convert the string with unix utility to lowercase
    # I attempted to use input="${input,,}" but could not get that to work

    if [[ "$input" =~ ^[[:alnum:]]{2,3}$ ]]; then # if input is a valid 2-3 character string...

        dept_code=$input # take valid input from user

        isValid=true # break the loop

    else # if input is not a valid 2-3 character string...

        echo -e "\nERROR: please enter a two-to-three character long string" # throw invalid input error
    fi
done

##### department name #####

read -p "enter department name: " dept_name # ask for dept name and save

##### course number #####

isValid=false # initialize as false

while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

    read -p "Enter course number: " input # take input from user

    if [[ "$input" =~ ^[0-9]+$ && ${#input} -eq 4 ]]; then # if input is a valid integer...

        course_num=$input # take valid input from user

        isValid=true # break the loop

    else # if input is not a valid integer...

        echo -e "\nERROR: please enter a valid integer 4 numbers long" # throw invalid input error
    fi
done

##### course name #####

read -p "enter course name: " course_name # ask for course name and save

##### course schedule #####

isValid=false # initialize as false

while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

    read -p "Enter course schedule: " input # take input from user

    input=$(echo "$input" | tr '[:lower:]' '[:upper:]') # convert the string with unix utility to uppercase
    # I attempted to use input="${input^^}" but could not get that to work

    if [[ "$input" == "MWF" || "$input" == "TH" ]]; then # if input is correct string MWF or TH...

        course_sched=$input # take valid input from user

        isValid=true # break the loop

    else # if input is not a valid schedule...

        echo -e "\nERROR: please enter a valid schedule (MWF or TH)" # throw invalid input error
    fi
done

##### start date #####

isValid=false # initialize as false

while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

    read -p "Enter course start: " input # take input from user

    if [[ "$input" =~ ^([0-9]{1,2}/){2}[0-9]{2}$ ]]; then # if input valid date string...

        start_date=$input # take valid input from user

        isValid=true # break the loop

    else # if input is not a valid date string...

        echo -e "\nERROR: please enter a valid end date (MM/DD/YY)" # throw invalid input error
    fi
done

##### end date #####

isValid=false # initialize as false

while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

    read -p "Enter course start: " input # take input from user

    if [[ "$input" =~ ^([0-9]{1,2}/){2}[0-9]{2}$ ]]; then # if input valid date string...

        end_date=$input # take valid input from user

        isValid=true # break the loop

    else # if input is not a valid date string...

        echo -e "\nERROR: please enter a valid end date (MM/DD/YY)" # throw invalid input error
    fi
done

##### credit hours #####

isValid=false # initialize as false

while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

    read -p "Enter credit hours: " input # take input from user

    if [[ "$input" =~ ^[0-9]+$ ]]; then # if input is a valid integer...

        credit_hours=$input # take valid input from user

        isValid=true # break the loop

    else # if input is not a valid integer...

        echo -e "\nERROR: please enter an unsigned integer" # throw invalid input error
    fi
done

##### initial enrollment #####

isValid=false # initialize as false

while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

    read -p "Enter course enrollment: " input # take input from user

    if [[ "$input" =~ ^[0-9]+$ ]]; then # if input is a valid integer...

        initial_enrollment=$input # take valid input from user

        isValid=true # break the loop

    else # if input is not a valid integer...

        echo -e "\nERROR: please enter an unsigned integer" # throw invalid input error
    fi
done


########## SEARCH FOR FILE ##########

course_file="data/${dept_code}${course_num}.crs" # build file path needed for 'search engine' functionality

if [ ! -e "$course_file" ]; then # if course has not been created...

    echo -e "\nERROR: course not found\n" # print course created error statement

    isValid=false # initialize as false

    while [ "$isValid" == false ]; do # loop as long as the user keeps messing up

        # ask for failure course of action
        read -p "Want to make a course instead? (enter yes: (y, Y), no: (n, N)): " input

        if [[ "$input" =~ ^[yYnN]$ ]]; then # if user enters correct yes/no input of any kind...

            isValid=true # break the loop

            case $input in # yes/no case (inspired by my work with switch statements in python for Receipt_Analyzer_3.0)

                y|Y|yes|Yes) # if user selects yes...

                    echo -e "\nCreated $course_file\n" # print course creation statement
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

echo -e "\n" # print new line for legibility

##### update log #####

echo "[$(date)] UPDATED: $dept_code $course_num $course_name" >> data/queries.log # update the log

##### return to main menu #####

./assign1.bash # send user back to main menu