
# Das Ziel des Befehles ist eien Datensatz generieren.
# ----
# Die Parameter sind:
# ----
## Number.of.Observation: Die Anzahl der Beobachtungen
## alpha: Niveauparamter
## beta: Steigungsparameter: 
## Number.of.Simulations: Die Anzahl der Simulationen
## exp.u: Erwartungswert der Störgröße
## sigma: Standardabweichung der Störgrößen
## sim: Kontrolle über den Zufallsprozess

data.gen <- function(Number.of.Observation, alpha, beta, Number.of.Simulations=100,
                     exp.u = 0, sigma = 0, sim=0){
    # Parameteranpassung
    par(mfrow=c(1,3))
    par(mar=c(5,5,2,5), mgp = c(3, 1.2, 0) )
    
    # Der 'Seed' wird festgelegt in Abhängigkeit von 'sim' 
    set.seed(16 + sim)
    
    # Folgende Bedingung wird vorausgesetzt
        if(Number.of.Observation == 3){
                x <- c(10,30,50)
        }else{
            repeat {
                x <- rnorm(Number.of.Observation, 45, 18)
                if ((length(which(x < 0)))==0){break}
            } 
            
        }
        
        # Simulation
        # Die generierten Werten werden in den Matrizen M und N gespeichert.
        # Wobei in der Matrix M fließen Informationen über die geschätzten Parameter,
        # Und in Matrix N werden die erzeugten endogenen Werte 'untergebracht'. 
        M <- matrix(NA, Number.of.Simulations,  2)
        N <- matrix(NA, Number.of.Simulations, Number.of.Observation)
        for (i in 1:Number.of.Simulations){
                k <- rep(1,Number.of.Simulations)
                y <- alpha + beta*x + rnorm(k[i]*Number.of.Observation,
                                            exp.u, sqrt(sigma))
                ols <- lm(y ~ x)
                M[i, 1:2] <- coef(ols)
                N[i,] <- y
        }
        return(list(M, N, x))
}





