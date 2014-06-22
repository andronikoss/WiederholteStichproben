data.gen <- function(Number.of.Observation, alpha, beta, Number.of.Simulations=100,
                     exp.u = 0, sigma = 0, sim=0){
        par(mfrow=c(1,3))
        par(mar=c(5,5,2,5), mgp = c(3, 1.2, 0) )
        
        set.seed(12+sim)
        if(Number.of.Observation==3){
                x <- c(10,30,50)
        }else{
                x <- rnorm(Number.of.Observation, 40, 7)   
        }
        
        
        
        # Simulation
        
        M <- matrix(NA, Number.of.Simulations,  2)
        N <- matrix(NA, Number.of.Simulations, Number.of.Observation)
        for (i in 1:Number.of.Simulations){
                k <- rep(1,Number.of.Simulations)
                y <- alpha + beta*x + rnorm(k[i]*Number.of.Observation, exp.u, sqrt(sigma))
                ols <- lm(y ~ x)
                M[i, 1:2] <- coef(ols)
                N[i,] <- y
        }
        return(list(M, N, x))
}





