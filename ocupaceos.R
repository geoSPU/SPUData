library(sf)

ocupacoes <- st_read("ocupacoes.geojson")

gdc <- st_read("ocupacao/gomes-da-costa.geojson")

ocupacoes <- rbind(ocupacoes, gdc)

st_write(ocupacoes, "ocupacoes.geojson", delete_dsn = TRUE)
