library(sf)

cessoes <- read_sf("cessoes.geojson") 

cessao_nova <- read_sf("cessoes/10154-139616-2021-11.geojson")

# cessao_nova <- read_sf("G:/.shortcut-targets-by-id/1nUTlixFUMjdbt5j123GxmYTojiaoNMMS/SPUVIZ_Projeto EAN Portos/polígonos e tabelas já feitas/GEOJSON_criados/04972.000936_2005-17.geojson")

cessao_nova$cnpj <- NULL

# cessaoNova <- read_sf("cessoes/10154-146304-2021-55_terra.geojson")
# cessaoNova2 <- read_sf("cessoes/10154-146304-2021-55_agua.geojson")
# 
cessoes <- rbind(cessoes, cessao_nova)

st_write(cessoes, "cessoes.geojson", delete_dsn = TRUE)
