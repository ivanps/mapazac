# Construye data frames para la libreria

library(maptools)
library(dplyr)
library(openxlsx)
library(ggplot2)

# Datos IFE 2013
load("./inst/data/dbife.RData")
ife2013 <- dbife
names(ife2013)[1] <- "dtoloc"
names(ife2013)[3] <- "tipo"
names(ife2013)[5] <- "dtofed"
names(ife2013)[6] <- "muni"
names(ife2013)[11] <-"ln"
save(ife2013, file="./data/ife2013.rda")

# Shapefile Electoral
secciones <- readShapePoly(system.file("shapes/secciones_32.shp", 
                            package = "mapazac")[1], IDvar = "CLAVEGEO")
# Identificador es número de sección
secciones <- fortify(secciones, "CLAVEGEO")
secciones$id_dtofed <- as.numeric(substr(secciones$id,3,5))
secciones$id_muni <- as.numeric(substr(secciones$id,6,8))
secciones$id_secc <- as.numeric(substr(secciones$id,9,13))
secciones$id <- secciones$id_secc
save(secciones, file="./data/secciones.rda")

# Librerías AGEBS
agebsmx <- readShapePoly(system.file("shapes/AGEB_urb_2010_5.shp", 
                            package = "mapazac")[1], IDvar="CVEGEO")
agebsmx$estado <- as.numeric(substr(agebsmx$CVEGEO,1,2))
agebs <- agebsmx[agebsmx$estado == "32",]
agebs <- fortify(agebs, "CVEGEO")
agebs$muni <- as.numeric(substr(agebs$id,3,5))
agebs$loc <- as.numeric(substr(agebs$id,6,9))
agebs$ageb <- substr(agebs$id,10,13)
agebs$id <- agebs$ageb
save(agebs, file="./data/agebs.rda")

# Datos Censo
censo <- read.xlsx(system.file("data/RESAGEBURB_32XLS10.xlsx", 
                package = "mapazac")[1], colNames = TRUE) 
censo2010 <- filter(censo, NOM_LOC == "Total AGEB urbana")
for (ivar in colnames(select(censo2010, POBTOT:VPH_INTER))) {
    censo2010[, ivar] <- as.numeric(censo2010[, ivar])
}
censo2010[is.na(censo2010)] <- 0
save(censo2010, file="./data/censo2010.rda")

# Data DENUE
denueall <- readShapePoints(system.file("shapes/Inegi_DENUE_30012015.shp", 
                                        package = "mapazac")[1])
denue <- denueall[denueall$entidad == "ZACATECAS",]
save(denue, file="./data/denue.rda")

# Municipios
munisall <- readShapePoly(system.file("shapes/MUNICIPIOS.shp", 
                                      package = "mapazac")[1])
munis <- munisall[munisall$CVE_ENT == "32",]
tmpfile <- paste(tempdir(), "fmunizac", sep="/")
writePolyShape(munis, tmpfile)
getinfo.shape(paste(tmpfile, ".shp", sep=""))
munis <- readShapePoly(tmpfile, IDvar = "CVE_MUN")
munis <- fortify(munis, "CVE_MUN")
munis$id <- as.numeric(munis$id)
save(munis, file="./data/munis.rda")

