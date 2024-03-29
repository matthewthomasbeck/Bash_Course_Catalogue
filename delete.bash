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
############### DELETE COURSE ###############
#############################################


########## USER INPUT ##########

##### department code and course number #####

valid=false # initialize as false

while [ "$valid" == false ]; do # loop as long as the user keeps messing up

    echo "" # add space to make good looking

    read -p "Enter a department code and course number: " dept_code course_num # take input from user

    dept_code=$(echo "$dept_code" | tr '[:upper:]' '[:lower:]') # convert dept code to lowercase
    # I attempted to use dept_code="${dept_code,,}" but could not get that to work

    # if both department code and course number are valid...
    if [[ "$dept_code" =~ ^[[:alnum:]]{2,3}$ && "$course_num" =~ ^[0-9]+$ && ${#course_num} -eq 4 ]]; then

        valid=true # break the loop

    else # if either department code or course number is not valid...

        # throw invalid input error
        echo -e "\nERROR: Please enter a valid department code (2-3 characters) and a valid integer course number \
        (4 numbers)."
    fi
done


########## SEARCH FOR FILE ##########

course_file="data/${dept_code}${course_num}.crs" # build file path needed for 'search engine' functionality

if [ ! -e "$course_file" ]; then # if file has not been found...

    echo -e "\nERROR: course not found\n" # print course not found error statement

    ###### loop below added for complex version #####

    valid=false # initialize as false

    while [ "$valid" == false ]; do # loop as long as the user keeps messing up

        # ask for failure course of action
        read -p "Want to continue? (enter yes: (y, Y), no: (n, N)): " input

        if [[ "$input" =~ ^[yYnN]$ ]]; then # if user enters correct yes/no input of any kind...

            valid=true # break the loop

            case $input in # yes/no case (inspired by my work with switch statements in python for Receipt_Analyzer_3.0)

                y|Y) # if user selects yes...

                    ./read.bash # recursively call the script to restart the process
                    ;;

                n|N) # if user selects no...

                    ./assign1.bash # send user back to main menu
                    ;;
            esac

        else # if user does not enter correct yes/no input...

            echo -e "\nERROR: invalid input (enter yes: (y, Y), no: (n, N))\n" # print error statement
        fi
    done

else # if file has been found...

    valid=false # initialize as false

    while [ "$valid" == false ]; do # loop as long as the user keeps messing up

        echo "" # add space

        # ask for deletion course of action
        read -p "Course found, are you sure you want to delete? (enter yes: (y, Y), no: (n, N)): " input

        if [[ "$input" =~ ^[yYnN]$ ]]; then # if user enters correct yes/no input of any kind...

            valid=true # break the loop

            case $input in # yes/no case (inspired by my work with switch statements in python for Receipt_Analyzer_3.0)

                y|Y) # if user selects yes...

                    echo -e "\nDeleted $course_file\n" # print course deletion statement
                    ;;

                n|N) # if user selects no...

                    exit 0 # close process
                    ;;
            esac

        else # if user does not enter correct yes/no input...

            echo -e "\nERROR: invalid input (enter yes: (y, Y), no: (n, N))\n" # print error statement
        fi
    done
fi


########## READ FILE ##########

while read; do # loop through the entire contents of the course file

    ##### read values #####

    read # pass
    read course_name # take course name from second line for log
    read # pass
    read # pass
    read # pass

done < "$course_file" # read from course file


########## DELETE FILE ##########

##### delete the selected file #####

rm "$course_file" # delete the course file

##### update log #####

echo "[$(date)] DELETED: $dept_code $course_num $course_name" >> data/queries.log # update the log

##### return to main menu #####

exit 0 # close process