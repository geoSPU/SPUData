library(sf)

cessoes <- read_sf("cessoes.geojson")

cessaoNova <- read_sf("cessoes/10154-137136-2019-92.geojson")

cessoes <- rbind(cessoes, cessaoNova)

st_write(cessoes, "cessoes.geojson", delete_dsn = TRUE)
