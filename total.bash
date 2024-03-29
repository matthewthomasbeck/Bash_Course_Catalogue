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
############### TOTAL COURSES ###############
#############################################


########## COUNT TOTAL COURSES ##########

##### count courses #####

data_path="data" # set path to data

cd "$data_path" || exit 1 # change to data directory or exit if failure

course_count=$(ls -1 *.crs | wc -l) # list any .crs files and count lines

##### print courses #####

echo -e "\nTotal course records: $course_count\n" # print course count

cd - || exit 1 # return to prev dir or exit if failure

##### return to main menu #####

exit 0 # close process