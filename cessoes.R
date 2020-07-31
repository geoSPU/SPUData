library(sf)

cessoes <- read_sf("cessoes.geojson")

policiaAmbiental <- st_zm(st_read("cessoes/8105001725000 - Polícia Ambiental.kml"))

attr <- data.frame(
  destinacao = "cessao",
  tipo = "terrestre",
  rip = "8105 00172.500-0",
  interessado = "Estado de Santa Catarina",
  area = st_area(policiaAmbiental),
  area_uniao = st_area(policiaAmbiental),
  inicio = as.Date("2017-06-06"),
  prazo = NA,
  vigencia = NA,
  cnpj = "82.951.229/0001-76",
  nup = "11452.002315/00-27",
  protocolo = NA,
  ref = 3932180,
  concedida = TRUE,
  municipio = 8105,
  logradouro = NA,
  aval = NA,
  dataaval = NA,
  refaval = NA,
  onerosa = FALSE)

policiaAmbiental <- st_sf(attr, geometry = st_geometry(policiaAmbiental))

cessoes <- rbind(cessoes, policiaAmbiental)

st_write(cessoes, "cessoes.geojson", delete_dsn = TRUE)
