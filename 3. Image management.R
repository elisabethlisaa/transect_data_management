rm(list=ls())
library(fs)


# Read the CSV file containing image
earth <- read.csv("use your actual filepath/1. Database/_merge/dataformatted_earth.csv")

# add extension for old ID_Foto
earth$ID_Foto_old <- ifelse(earth$ID_Foto == "-", "", paste(earth$ID_Foto))

# add new column for old ID_Foto's filepath
earth$ID_Foto_old_filepath <- ifelse(earth$ID_Foto == "-", "", 
                            paste("use your actual filepath/3. Dokumentasi/Earth/",
                                  earth$ID_Foto_old, ".jpg", sep = ""))

# add new column and fill it with new ID_Foto
earth$ID_Foto_new <- ifelse(earth$ID_Foto == "-", "", sapply(earth$ID_Foto, function(row) {
  paste(earth$Lembaga, "_", earth$Lokasi_Survei,"_", earth$ID_Petak, "_",
        earth$ID_Waypoint, "_", earth$Tipe_Temuan, "_", earth$Temuan..Jejak_Spesies.Gangguan.,
        ".jpg", sep = "")
}))

# add new column for new ID_Foto's filepath
earth$ID_Foto_new_filepath <- ifelse(earth$ID_Foto == "-", "", 
                                    paste("use your actual filepath/3. Dokumentasi/_Renamed/", 
                                          earth$ID_Foto_new))

# copy photo file into another folder and rename them
file.copy(earth$ID_Foto_old_filepath, earth$ID_Foto_new_filepath)

# Write the modified data frame back to a xlsx file
write.xlsx(earth, file= here("3. Dokumentasi", "earthphoto.xlsx"))
