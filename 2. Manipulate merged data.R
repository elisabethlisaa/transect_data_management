rm(list=ls())
library(rgdal)
library(sp)
library(sf)
library(lubridate)

earth_all <- read.csv("use your actual filepath/1. Database/_merge/earth.csv")
SWTS_grid <- read.csv("use your actual filepath/4. Additional Data/Grid Sumatera/GridSWTS.csv")

# add "Organization" information
earth_all$Lembaga <- "Earth"

# add "DateTime"
earth_all <- earth_all %>%
  mutate(DateTime = ymd_hms(paste(Tanggal, Jam)))

# perform "vlookup" to fill "zone+hemishphere" column
earth_all <- merge(earth_all, SWTS_grid, by = "ID_Petak")


# add other coordinate system: DD (for visualization) and UTM (for distance measurement)
# add decimal degree (DD) coordinate
earth_all$Lokasi_Temuan_Lat <- ifelse(earth_all$Y_N.S == "S", 
                                    -1 * (((earth_all$Y_Detik / 60) / 60) + (earth_all$Y_Menit / 60) + earth_all$Y_Derajat), 
                                    (((earth_all$Y_Detik / 60) / 60) + (earth_all$Y_Menit / 60) + earth_all$Y_Derajat))
earth_all$Lokasi_Temuan_Lon <- ifelse(earth_all$X_E == "W", 
                                    -1 * (((earth_all$X_Detik / 60) / 60) + (earth_all$X_Menit / 60) + earth_all$X_Derajat), 
                                    (((earth_all$X_Detik / 60) / 60) + (earth_all$X_Menit / 60) + earth_all$X_Derajat))
# add UTM coordinate
earth_all_47N <- earth_all %>% 
  dplyr::filter(Zone == '47N')
earth_all_47N_sp <- SpatialPoints(cbind(earth_all_47N$Lokasi_Temuan_Lon, earth_all_47N$Lokasi_Temuan_Lat),
                                CRS("+proj=longlat +ellps=WGS84 +datum=WGS84"))
plot(earth_all_47N_sp)
utm_coord_47N <- spTransform(earth_all_47N_sp, CRS ("+proj=utm +zone=47 +datum=WGS84 +units=m +no_defs"))
utm_coord_47N_sp <- as.data.frame(utm_coord_47N)
earth_all <- cbind(earth_all_47N, utm_coord_47N_sp)

# apply LEFT formula to a "Tipe_Temuan", "Temuan", "Usia", "Habitat", and "Substrat"
earth_all$Tipe_Temuan <- substr(earth_all$Tipe_Temuan, start = 1, stop = 3)
earth_all$Temuan..Jejak_Spesies.Gangguan. <- substr(earth_all$Temuan..Jejak_Spesies.Gangguan., start = 1, stop = 3)
earth_all$Usia <- substr(earth_all$Usia, start = 1, stop = 3)
earth_all$Habitat <- substr(earth_all$Habitat, start = 1, stop = 3)
earth_all$Substrat <- substr(earth_all$Substrat, start = 1, stop = 3)

# manage column order
names(earth_all)
earth_all <- earth_all[, c("X", "ID_Petak", "Lembaga", "Lokasi_Survei", "ID_GPS",
                       "Hujan_dalam_24_jam_terakhir", "Tim_Ketua.Inisial",
                       "Tim_Anggota_1", "Tim_Anggota_2", "Tim_Anggota_3", "No.", 
                       "Tanggal", "Jam", "DateTime", "Km", "Meter", "Y_N.S", 
                       "Y_Derajat", "Y_Menit", "Y_Detik", "X_E", "X_Derajat", 
                       "X_Menit", "X_Detik", "Lokasi_Temuan_Lat", "Lokasi_Temuan_Lon", 
                       "Zone", "coords.x1", "coords.x2", "ID_Waypoint", 
                       "Tipe_Temuan", "Temuan..Jejak_Spesies.Gangguan.", 
                       "Bukaan_tajuk_.Densiometer.", "Usia", "Yakin_.Ya.Tidak.", 
                       "Habitat", "Temuan_Di_Jalur_.Ya.Tidak.", "Substrat", 
                       "ID_Foto", "ID_Sampel", "Catatan")]

# save manipulated data into csv
write.csv(earth_all, file= here("1. Database", "_merge", "dataformatted_earth.csv"))
