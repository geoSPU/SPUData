library(sf)

sbnf <- st_read("aeroportos/SBNF.geojson")

sbfl <- st_read("aeroportos/SBFL.geojson")

sbfl <- st_sf(st_drop_geometry(sbnf), 
              geometry = st_combine(st_geometry(sbfl)))

sbfl$nup <- NULL
sbfl$protocolo <- NULL
sbfl$ref <- NULL

sbfl$perimetro <- st_length(st_geometry(sbfl))
sbfl$area <- st_area(sbfl)

sbfl$municipio <- 8105
