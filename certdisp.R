library(sf)

certdisp <- read_sf("certdisp.geojson")


flomar_ilha <- st_read("certdisp/Flomar-BMNorte.geojson")
flomar_estreito <- st_read("certdisp/Flomar-Estreito.geojson")
flomar_sj <- st_read("certdisp/Flomar-SJ.geojson")

certdisp <- rbind(certdisp, flomar_ilha, flomar_estreito, flomar_sj)

st_write(certdisp, "certdisp.geojson", delete_dsn = TRUE)
