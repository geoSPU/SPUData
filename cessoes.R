library(sf)

cessoes <- read_sf("cessoes.geojson")

canteiro <- st_zm(st_read("cessoes/8105002065003-Canteiro de Obra das Pontes.kml"))

attr <- data.frame(
  destinacao = "cessao",
  tipo = "terrestre",
  rip = "8105 00206.500-3",
  interessado = "Governo do Estado de Santa Catarina",
  area = st_area(canteiro),
  area_uniao = st_area(canteiro),
  inicio = NA,
  prazo = NA,
  vigencia = NA,
  cnpj = NA,
  nup = "05022.000023/2001-79",
  protocolo = NA,
  ref = NA,
  concedida = TRUE,
  municipio = 8105,
  logradouro = NA,
  aval = NA,
  dataaval = NA,
  refaval = NA,
  onerosa = FALSE)

canteiro <- st_sf(attr, geometry = st_geometry(canteiro))

cessoes <- rbind(cessoes, canteiro)

st_write(cessoes, "cessoes.geojson", delete_dsn = TRUE)
