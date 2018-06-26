#Matrix Congruential Generator

# declare function of 100 000 numbers in the sequence
lcg.rand <- function(n=9) {

# declare matrix
  d <- 3
  rng <- matrix(nrow = d,ncol = d)
  
  m <- 10**5 #modulus
  A <- matrix(c(sample(1:m-1,9)), nrow = 3,ncol = 3,byrow = T)     #multiplier
  c <- rep(0,3)         #increment
  # set the seed using the current system time in microseconds
  Xn <- as.numeric(Sys.time()) * 1000
  
  for (i in 1:n) {
    Xn <- (A * Xn + c) %% m
    rng[i] <- Xn / m
  }
  
  return(rng)
}

lcg.rand()
A


