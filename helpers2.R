
# Der Befehl calcul ermÃ¶glicht die Visualisierung
# ----
# Die Parameter sind:
# ----
## L: Die Anzahl der Beobachtungen
## alpha: Niveauparamter
## beta: Steigungsparameter: 
## Number.of.Simulations: Die Anzahl der Simulationen
## type: Die grafische Darstellun der Regressionsgeraden 
## dichte: Die geschÃ¤tzte Dichtefunktion wird aktiviert
## select: Die Anzahl von Stichproben, die man abbilden will
library(MASS)
calcul <- function(L, alpha = 0.2, beta = 0.13, Number.of.Simulations = 100,
                   type = c("einzeln", "alle"),
                   dichte = FALSE, select = select){
    # Die einzelne Teile von L werden isoliert.
    M <- L[[1]]
    N <- L[[2]]
    x <- L[[3]]
    
    # Parameteranpassungen
    par(mfrow = c(1, 3))
    par(mar = c(7, 5, 5, 1), mgp = c(3, 1.2, 0), oma = c(0, 0, 0, 0))
    select <- as.integer(select)
    
    
    # Bedingung fÃ¼r 'type'=='alle' wird definiert
    if(type == "alle"){
        plot(seq(1, 100,length = 10), seq(-5, 20, length = 10),
             type = "n", xlab = "", ylab = "", main = "",
             axes=F, xaxs="i", yaxs="i")
        axis(1, at=0, labels=0,cex.axis = 1.8)
        axis(1, at=seq(0,100,20),cex.axis = 1.8)
        axis(2,cex.axis = 1.8, las=1)
        if(select == 1){
                title(main = paste("KQ-Regressionsgerade \n der 1. Stichprobe"),
                      xlab = "Rechnungsbetrag", ylab="Trinkgeld", cex.main = 1.8,
                      cex.lab = 1.8, font.main = 1)
        }else{
                title(main = paste("KQ-Regressionsgeraden \n aller", select, "Stichproben"),
                      xlab = "Rechnungsbetrag", ylab = "Trinkgeld", cex.main = 1.8,
                      cex.lab = 1.8, font.main = 1)
        }
     
        pal <- gray.colors(Number.of.Simulations, start = 0.1,
                           end = 0.6, gamma = 2.2)
        pal <- rev(pal)
        for(i in 1:select){
            abline(a = M[i, 1], b = M[i, 2], col = pal[i], lwd=1.2)        
        }
        abline(a = M[select, 1], b = M[select, 2], lwd = 1.5)
        
    }
    # Bedingung fÃ¼r 'type'=='einzeln' wird definiert
    if(type == "einzeln"){
        plot(seq(1, 100, length = 10), seq(-5, 20, length = 10), type = "n",
             xlab = "", ylab = "", main = "",
              axes=F, xaxs="i", yaxs="i")

        axis(1, at=seq(-20,100,20), cex.axis = 1.8)
        axis(2, cex.axis = 1.8, las=1)
        l <- paste(select, ".")
        l <- gsub(" ", "", l)
        title(main = paste("KQ-Regressionsgerade \n der", l, "Stichprobe"), 
              xlab = "Rechnungsbetrag", ylab="Trinkgeld", cex.main = 1.8, cex.lab = 1.8,
              font.main = 1)
        abline(M[select, ], col = "red", lwd = 1.2)
        abline(h = 0, lty = 2)
        points(x, N[select, ], pch = 19, col = rgb(0,0,0,0.3))
        
    }
 # --------------------------------------   
 #   Diechtfunktionen werden berechnet
 # -------------------------------------- 
 # -------
 # o Erste Grafik fÃ¼r Steigungsparameter
 # -------   
    # Parameteranpassungen
    par(mar = c(7,6,5,1), mgp = c(4, 2.4, 0))
    
    # Das Histogram fÃ¼r den Steigungsparameter 'beta' wird gebildet
    hist.den.beta <- hist(M[1:select, 2], plot = F,breaks = 15)
    
    # Im Falle einer beobachtung wird keine Dichte berechnet, weil fÃ¼r die
    # Berechnung der Bandbreite mindestens zwei Werte notwendig sind.
    if(select != 1){
        den.beta <- density(M[1:select, 2])
    } else {
        den.beta <- list(y = 0)
    }
 
    # Das Histogramm wird geplottet
 truehist(M[1:select, 2],nbins = 15,col = "lightgrey",
         main = "",xlim=c(0, 0.25),
         ylim = c(0, 60), xlab = "", ylab = "", xaxs="i", yaxs="i",
         axes=F)
#  mtext(side=2, "Dichte", cex=1.2)
 axis(1,cex.axis = 1.8)
 axis(2, labels=F, tck=-0.03)
    # Die Achsen werden entsprechend definiert
    title(main=expression(paste("Histogramm ", (beta))),cex.main = 1.8)
    
    par(mar = c(7,6,5,1), mgp = c(2.5, 2.4, 0))
    title(ylab = "Dichte", cex.lab = 1.8, font.lab = 1)

    par(mar = c(7,6,5,1), mgp = c(4.7, 2, 0))
    title(xlab = bquote(hat(beta)), cex.main = 1.8, cex.lab = 1.8, font.main = 1)
    # Ãberschrift wird ergÃ¤nzt
#     mtext(expression(paste("Histogramm ", (beta))), side = 3, cex = 1.2)
    
    # FÃ¼r den Fall mit nur einer Stichprobe wird folgende Bedingung definiert.
    if(dichte == TRUE & select != 1){
        lines(den.beta)
        polygon(den.beta, col = "darkred", density = 20)    
    }
    if(type == "einzeln"){
            abline(v = M[select, 2], col = "red", lwd = 1.5)
    }
 
    #abline(v=mean(M[,2]), lty=2)
    # Parametteranpassung
    par(mgp = c(4, 1.3, 0))
    
    # Beta-Wert wird auf der x-Achse angezeigt 
    axis(1, at = beta, labels = expression(beta), cex.axis = 1.8)
    abline(v = beta, lwd = 1)
 
 # -------
 # o Zweite Grafik fÃ¼r Niveauparameter
 # -------
    # Parameteranpassung
    par(mar = c(7,6,5,1), mgp = c(4, 2.4, 0))
    hist.den.alpha <- hist(M[1:select, 1], plot = F, breaks = 15)
    
    if(select != 1){
        den.alpha <- density(M[1:select, 1])
    } else {
        den.alpha <- list(y = 0)
    }
    # Histogramm wird abgebildet
    truehist(M[1:select, 1], col = "lightgrey", nbins = 15,
         main = "", ylim = c(0, 2),xlim=c(-4,4), xaxs="i", yaxs="i",
         xlab = "", ylab = "",  font.main = 1, axes=F)
 axis(1,cex.axis = 1.8)
 axis(2, labels=F, tck=-0.03)
#  mtext(side=2, "Dichte", cex=1.2)
    # Die Achsen werden entsprechend beschriftet
    title(main=expression(paste("Histogramm ", (alpha))),cex.main = 1.8)
    par(mar = c(7,6,5,1), mgp = c(2.5, 2.4, 0))
    title(ylab = "Dichte", cex.lab = 1.8, font.lab = 1)
    
    par(mar = c(7,6,5,1), mgp = c(4.7, 2.4, 0))
    title(xlab = bquote(hat(alpha)), cex.lab = 1.8, font.lab = 1)
    # Ãberschrift wird ergÃ¤nzt
#     mtext(expression(paste("Histogramm ", (alpha))),side = 3, cex = 1.2)
 
    # FÃ¼r den Fall mit nur einer Stichprobe wird folgende Bedingung definiert.
    if(dichte == TRUE & select != 1){
        lines(den.alpha)
        polygon(den.alpha, col = "darkred", density = 20)
    }
    if(type == "einzeln"){
            abline(v = M[select, 1], col = "red", lwd = 1.5)
    }
    #abline(v=mean(M[,1]), lty=2)
    par(mgp = c(4, 0.8, 0))
    axis(1, at = alpha, labels = expression(alpha), cex.axis = 1.8)
    abline(v = alpha, lwd = 1)
    
    # Parameteranpassung
    par(mfrow = c(1,1))
    par(mar = c(5,5,2,5))
    par(oma = c(1,1,3,1))
}
