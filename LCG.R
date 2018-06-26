#Multiplicative Congruential Generator (c=0) "minimal congruential generator"

# declare function of 100 000 numbers in the sequence
lcg.rand <- function(n=100000) {

# declare vector of the same length    
  rng <- vector(length = n)
  
  m <- 2 ** 31-1 #modulus
  a <- 16807     #multiplier
  c <- 0         #increment
  
  # set the seed using the current system time in microseconds
  Xn <- as.numeric(Sys.time()) * 1000
  
  for (i in 1:n) {
    Xn <- (a * Xn + c) %% m
    rng[i] <- Xn / m
  }
  
  return(rng)
}

lcg.rand()
hist(lcg.rand())


