
# Der Befehl calcul ermöglicht die Visualisierung
# ----
# Die Parameter sind:
# ----
## L: Die Anzahl der Beobachtungen
## alpha: Niveauparamter
## beta: Steigungsparameter: 
## Number.of.Simulations: Die Anzahl der Simulationen
## type: Die grafische Darstellun der Regressionsgeraden 
## dichte: Die geschätzte Dichtefunktion wird aktiviert
## select: Die Anzahl von Stichproben, die man abbilden will

calcul <- function(L, alpha = 0.2, beta=0.13, Number.of.Simulations=100,
                   type=c("einzeln", "alle"),
                   dichte=FALSE, select=select){
    # Die einzelne Teile von L werden isoliert.
    M <- L[[1]]
    N <- L[[2]]
    x <- L[[3]]
    
    # Parameteranpassungen
    par(mfrow = c(1, 3))
    par(mar = c(5, 5, 5, 1), mgp = c(3, 1.2, 0), oma=c(0, 0, 0, 0))
    select <- as.integer(select)
    
    
    # Bedingung für 'type'=='alle' wird definiert
    if(type=="alle"){
        plot(seq(1,100,length=10), seq(-5,20,length=10),
             type="n", xlab="", ylab="", main="",
             cex.axis = 1.5)
        if(select==1){
                title(main= paste("KQ-Regressionsgerade \n der 1. Stichprobe"),
                      xlab="Rechnungsbetrag", ylab="Trinkgeld", cex.main = 1.8,
                      cex.lab = 1.5, font.main=1)
        }else{
                title(main= paste("KQ-Regressionsgeraden \n aller", select, "Stichproben"),
                      xlab="Rechnungsbetrag", ylab="Trinkgeld", cex.main = 1.8,
                      cex.lab = 1.5, font.main=1)
        }
     
        pal <- gray.colors(Number.of.Simulations, start = 0.1, end = 0.6, gamma = 2.2, alpha = 0.5)
        pal <- rev(pal)
        for(i in 1:select){
            abline(a = M[i,1], b = M[i,2], col= pal[i], lwd=1.2)        
        }
        abline(a = M[select,1], b = M[select,2], lwd=1.5)
        
    }
    # Bedingung für 'type'=='einzeln' wird definiert
    if(type=="einzeln"){
        plot(seq(1,100,length=10), seq(-5,20,length=10), type="n", xlab="", ylab="", main="",
             cex.axis = 1.5)
        l <- paste(select, ".")
        l <- gsub(" ", "", l)
        title(main=paste("KQ-Regressionsgerade \n der", l, "Stichprobe"), 
              xlab="Rechnungsbetrag", ylab="Trinkgeld", cex.main =1.8, cex.lab = 1.5,
              font.main=1)
        abline(M[select,], col= "red", lwd=1.2)
        abline(h=0, lty=2)
        points(x,N[select,], pch=19, col=rgb(0,0,0,0.3))
        
    }
 # --------------------------------------   
 #   Diechtfunktionen werden berechnet
 # -------------------------------------- 
 # -------
 # o Erste Grafik für Steigungsparameter
 # -------   
    # Parameteranpassungen
    par(mar=c(15,5.5,15,1), mgp = c(4, 2, 0))
    
    # Das Histogram für den Steigungsparameter 'beta' wird gebildet
    hist.den.beta <- hist(M[1:select,2], plot=F,breaks=15)
    
    # Im Falle einer beobachtung wird keine Dichte berechnet, weil für die
    # Berechnung der Bandbreite mindestens zwei Werte notwendig sind.
    if(select != 1){
        den.beta <- density(M[1:select,2])
    } else {
        den.beta <- list(y=0)
    }
 
    # Das Histogramm wird geplottet
    hist(M[1:select,2],breaks=15,freq=F,col="lightgrey",
         main="",
         ylim=c(0,max(den.beta$y,hist.den.beta$density )), xlab="", ylab="",
         cex.axis = 1.5)
    
    # Die Achsen werden entsprechend definiert
    title( xlab = bquote(hat(beta)),
          ylab="Dichte", cex.main = 1.8, cex.lab = 1.4, font.main=1)
    # Überschrift wird ergänzt
    mtext(expression(paste("Histogramm ", (beta))), side=3, cex=1.2)
    
    # Für den Fall mit nur einer Stichprobe wird folgende Bedingung definiert.
    if(dichte == TRUE & select != 1){
        lines(den.beta)
        polygon(den.beta,col="darkred",density=20)    
    }
    if(type=="einzeln"){
            abline(v=M[select,2], col="red", lwd=1.5)
    }
 
    #abline(v=mean(M[,2]), lty=2)
    # Parametteranpassung
    par(mgp = c(4, 1, 0))
    
    # Beta-Wert wird auf der x-Achse angezeigt 
    axis(1, at= beta, labels=expression(beta), cex.axis=1.3)
    abline(v = beta, lwd = 2)
 
 # -------
 # o Zweite Grafik für Niveauparameter
 # -------
    # Parameteranpassung
    par(mar=c(15,5.5,15,1), mgp = c(4, 2, 0))
    hist.den.alpha <- hist(M[1:select,1], plot=F,breaks=15)
    
    if(select != 1){
        den.alpha <- density(M[1:select,1])
    } else {
        den.alpha <- list(y = 0)
    }
    # Histogramm wird abgebildet
    hist(M[1:select,1],freq=F,col="lightgrey",breaks=15,
         main="",ylim=c(0, max(den.alpha$y, hist.den.alpha$density)),
         xlab="", ylab="", cex.axis = 1.5, font.main=1)
    # Die Achsen werden entsprechend beschriftet
    title(ylab="Dichte",xlab = bquote(hat(alpha)),
          cex.main = 1.8, cex.lab = 1.4)
 
    # Überschrift wird ergänzt
    mtext(expression(paste("Histogramm ", (alpha))),side=3, cex=1.2 )
 
    # Für den Fall mit nur einer Stichprobe wird folgende Bedingung definiert.
    if(dichte == TRUE & select != 1){
        lines(den.alpha)
        polygon(den.alpha,col="darkred", density=20)
    }
    if(type=="einzeln"){
            abline(v=M[select,1], col="red", lwd=1.5)
    }
    #abline(v=mean(M[,1]), lty=2)
    par(mgp = c(4, 1, 0))
    axis(1, at= alpha, labels=expression(alpha), cex.axis=1.3)
    abline(v = alpha, lwd = 2)
    
    # Parameteranpassung
    par(mfrow=c(1,1))
    par(mar=c(5,5,2,5))
    par(oma=c(1,1,3,1))
}
