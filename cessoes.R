library(sf)

cessoes <- read_sf("cessoes.geojson")


paulas <- st_read("cessoes/SFS_Paulas.geojson")

cessoes <- rbind(cessoes, paulas)

st_write(cessoes, "cessoes.geojson", delete_dsn = TRUE)
