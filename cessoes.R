library(sf)

cessoes <- read_sf("cessoes.geojson")

parqueCoqueiros <- st_zm(st_read("cessoes/8105001735005 - Parque de Coqueiros.kml"))

attr <- data.frame(
  destinacao = "cessao",
  tipo = "terrestre",
  rip = "8105 00173.500-5",
  interessado = "Prefeitura Municipal de Florianopolis",
  area = st_area(parqueCoqueiros),
  area_uniao = st_area(parqueCoqueiros),
  inicio = NA,
  prazo = NA,
  vigencia = NA,
  cnpj = "82.892.282/0001-43",
  nup = "11452.001000/0081",
  protocolo = NA,
  ref = NA,
  concedida = TRUE,
  municipio = 8105,
  logradouro = NA,
  aval = NA,
  dataaval = NA,
  refaval = NA,
  onerosa = FALSE)

parqueCoqueiros <- st_sf(attr, geometry = st_geometry(parqueCoqueiros))

cessoes <- rbind(cessoes, parqueCoqueiros)

st_write(cessoes, "cessoes.geojson", delete_dsn = TRUE)
