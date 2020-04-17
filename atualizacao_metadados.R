library(sf)
library(lubridate)
library(tibble)
library(dplyr)

cessoes <- st_read("cessoes.geojson")

cessoes <- cessoes %>% 
  add_column(rip = c(NA, NA, 8161001175000, NA, 8221000245002, 8105006665005, 
                     8319000815008, NA, NA, NA, 8039000175004, 8319000795007,
                     8319000675001, 8161001415001, NA, NA, NA),
  .before = "interessado"
)

cessoes <- cessoes %>% 
  add_column(inicio = as.Date(c(NA, NA, "11-11-2015", NA, "28-11-2019", 
                                 "17-12-2018", "06-12-2019", NA, NA, NA, 
                                 "12-02-2014", "21-03-2018", "01-07-2014" , NA, 
                                 NA, NA, NA), format = "%d-%m-%Y"),
             prazo = 20,
             vigencia = inicio + years(prazo),
             .before = "cnpj")

cessoes$area <- NULL

polUniao <- st_read("Poligonos_LPM_Homologada.geojson")

areaUniao <- function(x, y){
  z = vector()
  for (i in seq_len(nrow(x))) {
    a <- st_intersection(x[i, ], y)
    if (dim(a)[1] == 0) {
      z[[i]] <- 0
    } else {
      z[[i]] <- sf::st_area(a)
    }
  }
  set_units(z, m^2)
}

cessoes <- cessoes %>% 
  add_column(area = st_area(.),
             area_uniao = areaUniao(., polUniao),
             .before = "inicio")

cessoes <- cessoes %>%
  add_column(destinacao = "cessao",
             tipo = factor(c("terrestre", "terrestre", "aquatica", "terrestre", "mista",
                      "mista", "aquatica", "aquatica", "mista", "terrestre",
                      "aquatica", "aquatica", "aquatica", "aquatica", "mista",
                      "terrestre", "terrestre")),
             .before = "rip")

cessoes$inicio <- as.POSIXct(cessoes$inicio/1000, origin = "1970-01-01")
cessoes$vigencia <- as.POSIXct(cessoes$vigencia/1000, origin = "1970-01-01")

st_write(cessoes, "cessoes.geojson", delete_dsn = TRUE)


###############################################################################

ocupacoes <- st_read("ocupacoes.geojson")

ocupacoes <- ocupacoes[, c(5, 1, 3, 4, 2, 6)]

ocupacoes <- ocupacoes %>% 
  add_column(area = st_area(.),
             .before = "area_total")

ocupacoes <- ocupacoes %>%
  add_column(destinacao = "ocupacao",
             .before = "rip")

st_write(ocupacoes, "ocupacoes.geojson", delete_dsn = TRUE)

###############################################################################

autobras <- st_read("autobras.geojson")

st_crs(autobras) <- 31982

autobras <- st_transform(autobras, crs = 4326)

autobras$area <- NULL

autobras <- autobras %>% 
  add_column(area = st_area(.),
             area_uniao = areaUniao(., polUniao),
             .before = "cnpj")

autobras <- autobras %>% 
  add_column(destinacao = "autorizacao",
             .before = "interessado")

st_write(autobras, "autobras.geojson", delete_dsn = TRUE)

###############################################################################

certdisp <- st_read("certdisp.geojson")

certdisp$area <- NULL

certdisp <- certdisp %>% 
  add_column(area = st_area(.),
             area_uniao = 0,
             .before = "nup")

certdisp <- certdisp %>% 
  add_column(destinacao = "certidao de disponibilidade",
             .before = "interessado")

st_write(certdisp, "certdisp.geojson", delete_dsn = TRUE)
