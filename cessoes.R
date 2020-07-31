library(sf)

cessoes <- read_sf("cessoes.geojson")

beira_mar_continental <- st_zm(st_read("cessoes/8105006055002 - Cessão Beira Mar continental - Estreito.kml"))

attr <- data.frame(
  destinacao = "cessao",
  tipo = "terrestre",
  rip = "8105 00605.500-2",
  interessado = "Prefeitura Municipal de Florianópolis",
  area = st_area(beira_mar_continental),
  area_uniao = st_area(beira_mar_continental),
  inicio = NA,
  prazo = NA,
  vigencia = NA,
  cnpj = "82.892.282/0001-43",
  nup = "04972.001214/2004-07",
  protocolo = NA,
  ref = 9087623,
  concedida = TRUE,
  municipio = 8105,
  logradouro = NA,
  aval = NA,
  dataaval = NA,
  refaval = NA,
  onerosa = FALSE)

beira_mar_continental <- st_sf(attr, geometry = st_geometry(beira_mar_continental))

cessoes <- rbind(cessoes, beira_mar_continental)

st_write(cessoes, "cessoes.geojson", delete_dsn = TRUE)
