library(sf)

cessoes <- read_sf("cessoes.geojson")

terminalRitaMaria <- st_zm(st_read("cessoes/8105006785000 - Terminal Rita Maria.kml"))

attr <- data.frame(
  destinacao = "cessao",
  tipo = "terrestre",
  rip = "8105 00678.500-0",
  interessado = "Governo do Estado de Santa Catarina",
  area = st_area(terminalRitaMaria),
  area_uniao = st_area(terminalRitaMaria),
  inicio = as.Date("2020-07-31"),
  prazo = 20,
  vigencia = as.Date("2040-07-31"),
  cnpj = "82.951.229/0001-76",
  nup = "04972.002534/2008-08",
  protocolo = NA,
  ref = NA,
  concedida = TRUE,
  municipio = 8105,
  logradouro = NA,
  aval = 24000000,
  dataaval = as.Date("2020-02-06"),
  refaval = 6358411,
  onerosa = TRUE)

beira_mar_continental <- st_sf(attr, geometry = st_geometry(beira_mar_continental))

cessoes <- rbind(cessoes, beira_mar_continental)

st_write(cessoes, "cessoes.geojson", delete_dsn = TRUE)
