library(sf)

cessoes <- read_sf("cessoes.geojson")

ifsc <- st_zm(st_read("cessoes/8105002225000 - IFSC.kml"))

attr <- data.frame(
  destinacao = "cessao",
  tipo = "terrestre",
  rip = "8105 00222.500-0",
  interessado = "Instituto Federal de Educação, Ciência e Tecnologia de Santa Catarina",
  area = st_area(ifsc),
  area_uniao = st_area(ifsc),
  inicio = NA,
  prazo = NA,
  vigencia = NA,
  cnpj = "11.402.887/0001-60",
  nup = "04972.000705/2006-94",
  protocolo = NA,
  ref = NA,
  concedida = TRUE,
  municipio = 8105,
  logradouro = NA,
  aval = NA,
  dataaval = NA,
  refaval = NA,
  onerosa = FALSE)

ifsc <- st_sf(attr, geometry = st_geometry(ifsc))

cessoes <- rbind(cessoes, ifsc)

st_write(cessoes, "cessoes.geojson", delete_dsn = TRUE)
