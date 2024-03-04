rm(list=ls())
library(sf)
library(raster)
library(ggplot2)
library(dplyr)


# Read the CSV file containing coordinates
earth_all <- read.csv("use your actual filepath/3. Dokumentasi/earthphoto.csv")

# Convert the CSV data frame to a spatial data frame
earth_all_sf <- st_as_sf(earth_all, coords = c("Lokasi_Temuan_Lon", "Lokasi_Temuan_Lat"), crs = 4326)



## check if the points are inside or outside forest cover

# Read the forest cover shapefile (polygon)
forest_cover <- st_read("use your actual filepath/4. Additional Data/Forest Cover/Forest_Cover.shp")
forest_cover <- st_make_valid(forest_cover)

# check the coordinate system of the 2 shapefile
projection(forest_cover)
projection(earth_all_sf)

# check if the points are inside forest cover polygon
inside <- st_within(earth_all_sf, forest_cover)

# assign labels based on whether coordinates are inside (1) or outside (0) polygons
Verif_ForestCover <- ifelse(apply(inside, 1, any), "1", "0")

# Add labels to the coordinates data frame
earth_all_sf$Verif_ForestCover <- Verif_ForestCover

# check forest verification
earth_all_sf$Verif_ForestCover %>% table()
earth_all_sf <- subset(earth_all_sf, Verif_ForestCover == "1")

# Overlay transect track (belum)
ggplot() +
  geom_sf(data = earth_all_sf, aes(color = Verif_ForestCover)) +
  scale_color_manual(values = c("grey", "red"))



## check the grid name and location, add new id based on points location

# read the grid shapefile (polygon) and transform the projection to WGS84 (same with the points shp)
grid <- st_read("use your actual filepath/4. Additional Data/Grid Sumatera/Grid17km_47N.shp")
grid <- st_transform(grid, 4326)
projection(grid)

# perform spatial join based on the points location within each grid
sp_join <- st_join(earth_all_sf, grid, join = st_within)

# extract the IDgrid from the joined data
ID <- sp_join$ID

# Add the grid code to the points data frame
earth_all_sf$newIDGrid <- ID

# compare old id and new id to see if they are different or not
# extract old and new grid IDs
old_id <- earth_all_sf$ID_Petak
new_id <- earth_all_sf$newIDGrid

# Compare old and new IDs and create label
earth_all_sf$Verif_IDGrid <- ifelse(old_id == new_id, "1", "0")

# check ID verification
earth_all_sf$verif_IDGrid %>% table()

# plot transect (grey) and wrong IDGrid (red)
ggplot() +
  geom_sf(data = earth_all_sf, aes(color = Verif_IDGrid)) +
  scale_color_manual(values = c("red", "grey"))



# verif confirmed tiger feces

# read the CSV file containing confirmed tiger feces coordinate
FES_PAT <- read.csv("use your actual filepath/4. Additional Data/PAT Feces/PAT_FES.csv")

# join them
earth_all_sf$verif_tigerfeces <- left_join(earth_all_sf, FES_PAT, by = "ID_Sampel")


# filter data terverifikasi