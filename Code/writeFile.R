# #Refresh/create files with yesterdays and todays Peak travel information
write.csv(filter(journey_times,
                 (peak=="AM Peak" | peak=="PM Peak"),
                 Date == Sys.Date()-1),
          paste0("..\\Output\\RRBJourneyTimes_",Sys.Date()-1,".csv"))

write.csv(filter(journey_times,
                 (peak=="AM Peak" | peak=="PM Peak"),
                 Date == Sys.Date()),
          paste0("..\\Output\\RRBJourneyTimes_",Sys.Date(),".csv"))

#Save tables as flat files for powerBI
fwrite(railRep %>% mutate(departure=as.character(departure),arrival=as.character(arrival)),"..\\PowerBI_flat_files\\railRep.csv",dateTimeAs = "ISO")
fwrite(travel_times %>% mutate(Departure=as.character(Departure),Arrival=as.character(Arrival)),"..\\PowerBI_flat_files\\travel_times.csv")
fwrite(journey_times %>% mutate(Date=as.character(Date)),"..\\PowerBI_flat_files\\journey_times.csv")

# Remove processed files
setwd("..\\Data\\")

tfv_file <- list.files()
numFiles <- length(tfv_file)

if(numFiles>0) {
  
  for(i in 1:numFiles)
  {
    timenow <- Sys.time()
    file.rename(tfv_file[i],paste0(timenow,"_",i,"_OneDrive.csv"))
    if (file.exists(paste0(timenow,"_",i,"_OneDrive.csv"))) {
      file.move(paste0(timenow,"_",i,"_OneDrive.csv"),"..\\Data_hist")
    }
  }
}

setwd("..\\Dropbox\\Data\\")

tfv_file <- list.files()
numFiles <- length(tfv_file)

if(numFiles>0) {
  
  for(i in 1:numFiles)
  {
    timenow <- Sys.time()
    file.rename(tfv_file[i],paste0(timenow,"_",i,"_DropBox.csv"))
    if (file.exists(paste0(timenow,"_",i,"_DropBox.csv"))) {
      file.move(paste0(timenow,"_",i,"_DropBox.csv"),"..\\..\\Data_hist")
    }
  }
}

setwd("..\\")