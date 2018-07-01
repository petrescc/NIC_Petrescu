require(rngWELL)
library(rngWELL)
library(randtoolbox)


#CONGRURAND- testing all prngs in R

# (1) the Park Miller sequence
#


setSeed(1)
congruRand(10, echo=TRUE)
#Output:
# Park Miller sequence, i.e. mod = 2^31-1, mult = 16807, incr=0
# the first 10 seeds used in Park Miller sequence
# 16807          1
# 282475249          2
# 1622650073          3
# 984943658          4
# 1144108930          5
# 470211272          6
# 101027544          7
# 1457850878          8
# 1458777923          9
# 2007237709         10
setSeed(1614852353) #seed for the 9997th term
congruRand(5, echo=TRUE)
#Output:
# the 9998+ th terms 
# 925166085       9998
# 1484786315       9999
# 1043618065      10000
# 1589873406      10001
# 2010798668      10002

# (2) the SF Mersenne Twister algorithm
SFMT(1000)

#Kolmogorov Smirnov test
#KS statistic should be around 0.037
ks.test(SFMT(1000), punif) 

#KS statistic should be around 0.0076
ks.test(SFMT(10000), punif) 

#different mersenne exponent with a fixed parameter set
#period of length 2^(m)-1; m given by mexp
SFMT(10, mexp = 607, usepset = FALSE)
SFMT(10, mexp = 1279, usepset = FALSE)
SFMT(10, mexp = 2281, usepset = FALSE)
SFMT(10, mexp = 4253, usepset = FALSE)
SFMT(10, mexp = 11213, usepset = FALSE)
SFMT(10, mexp = 19937, usepset = FALSE)
SFMT(10, mexp = 44497, usepset = FALSE)
SFMT(10, mexp = 86243, usepset = FALSE)
SFMT(10, mexp = 132049, usepset = FALSE)
SFMT(10, mexp = 216091, usepset = FALSE)

#use different sets of parameters [default when possible]
#
for(i in 1:7) print(SFMT(1, mexp = 607))
for(i in 1:7) print(SFMT(1, mexp = 2281))
for(i in 1:7) print(SFMT(1, mexp = 4253))
for(i in 1:7) print(SFMT(1, mexp = 11213))
for(i in 1:7) print(SFMT(1, mexp = 19937))

#use a fixed set and a fixed seed
#should be the same output
setSeed(08082008)
SFMT(1, usepset = FALSE)
setSeed(08082008)
SFMT(1, usepset = FALSE)


# (3) WELL generator
#

# 'basic' calls
# WELL512
WELL(10, order = 512)
# WELL1024
WELL(10, order = 1024)
# WELL19937
WELL(10, order = 19937)
# WELL44497
WELL(10, order = 44497)
# WELL19937 with tempering 
WELL(10, order = 19937, temper = TRUE)
# WELL44497 with tempering
WELL(10, order = 44497, temper = TRUE)

# tempering vs no tempering
setSeed4WELL(08082008)
WELL(10, order =19937)
setSeed4WELL(08082008)
WELL(10, order =19937, temper=TRUE)

# (4) Knuth TAOCP generator
#
knuthTAOCP(10)
knuthTAOCP(10, 2) 


# (5) How to set the seed?
# all example is duplicated to ensure setSeed works

# congruRand
setSeed(1302)
congruRand(1)
setSeed(1302)
congruRand(1)
# SFMT
setSeed(1302)
SFMT(1, usepset=FALSE)
setSeed(1302)
SFMT(1, usepset=FALSE)
# BEWARE if you do not set usepset to FALSE
setSeed(1302)
SFMT(1)
setSeed(1302)
SFMT(1)
# WELL
setSeed(1302)
WELL(1)
setSeed(1302)
WELL(1)
# Knuth TAOCP
setSeed(1302)
knuthTAOCP(1)
setSeed(1302)
knuthTAOCP(1)



# (7) computation times on my laptop, mean of 1000 runs
#

## Not run: 
# # algorithm			time in seconds for n=10^6
# # classical Mersenne Twister  			
# # SF Mersenne Twister  	       			
# # WELL generator				
# # Knuth TAOCP					
# # Park Miller  		      			
 n <- 1e+06
mean( replicate( 1000, system.time( runif(n), gcFirst=TRUE)[3]) ) #0.04026
mean( replicate( 1000, system.time( SFMT(n), gcFirst=TRUE)[3]) )  #0.01339
mean( replicate( 1000, system.time( WELL(n), gcFirst=TRUE)[3]) )  #0.00993
mean( replicate( 1000, system.time( knuthTAOCP(n), gcFirst=TRUE)[3]) )  # 0.00529
mean( replicate( 1000, system.time( congruRand(n), gcFirst=TRUE)[3]) )  # 0.01949
## End(Not run)
