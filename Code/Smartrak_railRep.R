rm(list=ls(all=TRUE))

# Run next 3 lines only if using source() to run the script
work_dir <- dirname(parent.frame(2)$ofile)
setwd(work_dir)
setwd(getwd())

library(dplyr)
library(magrittr)
library(lubridate)
library(xlsx)
library(data.table)
library(filesstrings)

###########################
# STEP 1: Load the data
###########################

source('..\\Code\\readFile.R')

###########################
# STEP 2: Clean the data
###########################

if(nrow(buses)!=0) {
  
  source('..\\Code\\cleanBuses.R')
  
  ###########################
  # STEP 3: Assign Bus Routes
  ###########################
  
  source('..\\Code\\assignRoutes.R')
  
  ###########################
  # STEP 4: Calculate Metrics
  ###########################
  
  source('..\\Code\\calculateMetrics.R')
  
}

#######################
# STEP 5: Load Tables
#######################
#CODE FOR RRB TABLE
source('..\\Code\\railRep.R')

if (nrow(railRep)>0) {
  
  #CODE FOR TRAVEL TIMES TABLE
  source('..\\Code\\travelTimes.R')
  
  #CODE FOR JOURNEY TIMES TABLE
  source('..\\Code\\journeyTimes.R')

  #Refresh/create files with yesterdays and todays Peak travel information
  source('..\\Code\\writeFile.R')
}

#remove uneccessary variables
remove(list=setdiff(ls(),c("railRep")))
gc()