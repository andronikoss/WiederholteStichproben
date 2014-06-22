calcul <- function(L, alpha = 0.25, beta=0.125, Number.of.Simulations=100,
                   type=c("einzeln", "alle"),
                   dichte=FALSE, select=select){
    M <- L[[1]]
    N <- L[[2]]
    x <- L[[3]]
    par(mfrow=c(1,3))
    par(mar=c(5,5,5,5), mgp = c(3, 1.2, 0) )
    select <- as.integer(select)
    
    
    if(type=="alle"){
        plot(seq(1,100,length=10), seq(-5,20,length=10), type="n", xlab="", ylab="", main="")
        title(main= paste("KQ-Schaetzgeraden aller", select, "Stichproben"),
              xlab="Rechnungsbetrag", ylab="Trinkgeld", cex.main =1.8, cex.lab = 1.5)
        pal <- gray.colors(Number.of.Simulations, start = 0.1, end = 0.6, gamma = 2.2, alpha = 0.5)
        pal <- rev(pal)
        for(i in 1:select){
            abline(a = M[i,1], b = M[i,2], col= pal[i], lwd=1.2)        
        }
        abline(a = M[select,1], b = M[select,2], lwd=1.5)
        
    }
    
    if(type=="einzeln"){
        plot(seq(1,100,length=10), seq(-5,20,length=10), type="n", xlab="", ylab="", main="")
        title(main=paste("KQ-Schaetzgerade der", select,". Stichprobe"), 
              xlab="Rechnungsbetrag", ylab="Trinkgeld", cex.main =1.8, cex.lab = 1.5)
        abline(M[select,], col= "darkblue", lwd=1.2)
        points(x,N[select,], pch=19, col=rgb(0,0,0,0.3))
        
    }
    
    # Diechtfunktion wird berechnet
    
    den.alpha <- density(M[1:select,1], bw = 0.3)
    den.beta <- density(M[1:select,2], bw = 0.01)
    
    
    # Zweite Grafik fr Steigungsparameter
    par(mar=c(15,5,15,4))
    hist.den.beta <- hist(M[1:select,2], plot=F,breaks=15)
    hist(M[1:select,2],breaks=15,freq=F,col="lightgrey",
         main="",
         ylim=c(0,max(den.beta$y,hist.den.beta$density )), xlab="", ylab="")
    title(main=expression(paste("Histogramm ", (beta))), xlab = bquote(hat(beta)),
          ylab="Dichte", cex.main =1.8, cex.lab = 1.5)
    if(dichte == TRUE){
        lines(den.beta)
        polygon(den.beta,col="darkred",density=20)    
    }
    if(type=="einzeln"){
            abline(v=M[select,2], col="darkblue", lwd=1.5)
    }
    #abline(v=mean(M[,2]), lty=2)
    axis(1, at= beta, labels=expression(beta), cex.axis=0.7,
         tcl = -0.25, padj= -1.5)
    abline(v = beta, lwd = 2)
    
    # Erste Grafik fr Niveauparameter
    hist.den.alpha <- hist(M[1:select,1], plot=F,breaks=15)
    hist(M[1:select,1],freq=F,col="lightgrey",breaks=15,
         main="",
         ylim=c(0, max(den.alpha$y, hist.den.alpha$density)), xlab="", ylab="")
    title(main=expression(paste("Histogramm ", (alpha))), ylab="Dichte",
          xlab = bquote(hat(alpha)), cex.main =1.8, cex.lab = 1.5)
    if(dichte == TRUE){
        lines(den.alpha)
        polygon(den.alpha,col="darkred", density=20)
    }
    if(type=="einzeln"){
            abline(v=M[select,1], col="darkblue", lwd=1.5)
    }
    #abline(v=mean(M[,1]), lty=2)
    axis(1, at= alpha, labels=expression(alpha), cex.axis=0.7,
         padj= -2.8)
    abline(v = alpha, lwd = 2)
    
    # Parameteranpassung
    par(mfrow=c(1,1))
    par(mar=c(5,5,2,5))
    par(oma=c(1,1,3,1))
}
