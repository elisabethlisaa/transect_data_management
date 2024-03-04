rm(list=ls())
library(readxl)
library(openxlsx)
library(writexl)
library(dplyr)
library(here)

# merge multiple excel file (located in 1 organisation folder) into one
# list all tallysheet data in the folder
earth_list <- list.files(path = "use your actual filepath/1. Database/Earth",
                       pattern = ".xlsx", full.names = TRUE)
data_list <- list()
# read all excel data with loop
for (file_path in earth_list) {
  data <- read.xlsx(file_path, startRow = 2) # the header of the tallysheet is 2 first row
  data_list[[file_path]] <- data
}
# merge all excel data
earth_all <- do.call(rbind, data_list)

# read new header for tallysheet
new_header <- read.xlsx("use your actual filepath/1. Database/header.xlsx")

# rename tallysheet's header into a new one
colnames(earth_all) <- new_header

# save merged file into one csv
write.csv(earth_all, file= here("1. Database", "_merge", "earth.csv"))
