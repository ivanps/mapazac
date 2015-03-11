library(mapazac)

# Mapa Electoral
data("ife2013")
data("secciones")
ife2013$logln <- log10(ife2013$ln)
dfy <- mapay(ife2013, "secc", "logln")
mapaChoroDiscreto(secciones, dfy, lname = "LOG(LN)")

# Mapa AGEBS
data("censo2010")
data("agebs")
censo2010$logpobtot <- log10(censo2010$POBTOT+1)
dfy <- mapay(censo2010, "AGEB", "logpobtot")
mapaChoroDiscreto(agebs, dfy, lname = "LOG(POBTOT)")

# Mapa Municipios
data("censo2010")
data("munis")
pob <- summarise(group_by(censo2010, MUN = as.numeric(MUN)), 
                 out = log10(sum(POBTOT)))
dfy <- mapay(pob, "MUN", "out")
mapaChoroDiscreto(munis, dfy, lname = "LOG(POBTOT)")
