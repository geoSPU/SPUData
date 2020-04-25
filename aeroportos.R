library(sf)

sbnf <- st_read("aeroportos/SBNF.geojson")

sbfl <- st_read("aeroportos/SBFL.geojson")

sbfl <- st_sf(st_drop_geometry(sbnf), 
              geometry = st_combine(st_geometry(sbfl)))

sbfl$nup <- NA
sbfl$protocolo <- NA
sbfl$ref <- NA

sbfl$perimetro <- st_length(st_geometry(sbfl))
sbfl$area <- st_area(sbfl)

sbfl$municipio <- 8105

aeroportos <- rbind(sbnf, sbfl)

st_write(aeroportos, "aeroportos.geojson", delete_dsn = TRUE)
