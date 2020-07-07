library(sf)

cartas <- st_read("cartas-estado-sc.geojson")

limites <- st_geometry(cartas[1, ])
