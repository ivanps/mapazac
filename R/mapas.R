# Mapas

mapay <- function(df, sid, svar) {
    y <- data.frame(id = df[, sid], 
                    out = cut(df[, svar], breaks = 9))
}

mapaChoroDiscreto <- function(dfmap, dfout, pal=2, lname="", lpos="right") {
    #  dfmap = Data frame con el mapa. Contiene la variable "id" que
    #          que identifica a cada polígono
    #  dfout = Data frame que contiene la respuesta y a graficar. Contiene
    #          la variable "id" con el valor a graficar para el polígono y en 
    #          la variable "out" esta la respuesta. 
    #  pal   = Número de pallette Brewer que se usa
    
    ggplot(data=dfmap, aes(map_id=id)) + 
        geom_map(map=dfmap, aes(x=long, y=lat), color="#0e0e0e", 
                 fill="white", size=0.2) +
        geom_map(data=dfout, map=dfmap, aes(fill=out),
                 color="#0e0e0e", size=0.2) +
        scale_fill_brewer(type="seq", palette=pal, name=lname) +
        coord_equal() +
        theme_bw() +
        scale_y_continuous(breaks = NULL) +
        scale_x_continuous(breaks = NULL) + xlab("") + ylab("") +
        theme(panel.grid.minor = element_line(colour = NA),
              panel.grid.major = element_line(colour = NA),
              panel.border = element_rect(fill = NA, colour = NA),
              panel.background = element_rect(fill = NA, colour = NA),
              plot.background = element_rect(fill = NA, colour = NA),
              legend.position = lpos)    
    
}