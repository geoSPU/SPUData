library(sf)

cessoes <- read_sf("cessoes.geojson")

beira_mar_sj <- st_zm(st_read("cessoes/8327000585003 - Beira-Mar de São José.kml"))

attr <- data.frame(
  destinacao = "cessao",
  tipo = "terrestre",
  rip = "8327 00058.500-3",
  interessado = "Prefeitura Municipal de São José",
  area = st_area(beira_mar_sj),
  area_uniao = st_area(beira_mar_sj),
  inicio = NA,
  prazo = NA,
  vigencia = NA,
  cnpj = "81.140.303/0001-01",
  nup = "11452.000729/99-82",
  protocolo = NA,
  ref = NA,
  concedida = TRUE,
  municipio = 8327,
  logradouro = NA,
  aval = NA,
  dataaval = NA,
  refaval = NA,
  onerosa = FALSE)

beira_mar_sj <- st_sf(attr, geometry = st_geometry(beira_mar_sj))

cessoes <- rbind(cessoes, beira_mar_sj)

st_write(cessoes, "cessoes.geojson", delete_dsn = TRUE)
