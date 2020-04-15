library(sf)

## Lê o arquivo no R
polUniao <- st_zm(st_read("Poligonos_LPM_Homologada.geojson"))

## Verifica qual o polígno de área igual ao valor citado, obtida no visualizador.
which(polUniao$AREA_M2_FM == 507119.30)

## Polígono 200: plotagem para verificação.
plot(polUniao[200, 1])

## Extrai as coordenadas do polígono
coords <- st_coordinates(polUniao[200, ])

## Remove a coordenada problemática (-48.6068 -27.870194)
coords <- coords[-181, ]

## Refaz o polígono
pol <- st_sfc(st_polygon(list(coords)))

## Extrai os metadados
metadados <- st_drop_geometry(polUniao[200, ])

## Junta o novo polígono aos metadados
spdf <- st_sf(metadados, geometry = pol, crs = 4326)

## Substitui o polígono original com o modificado
polUniao <- rbind(polUniao[1:199,], st_zm(spdf), polUniao[201:231,])

## Remove o polígono duplicado
polUniao <- polUniao[-141, ]

## Reescreve o arquivo dos polígonos
st_write(polUniao, "Poligonos_LPM_Homologada.geojson", delete_dsn = TRUE)
