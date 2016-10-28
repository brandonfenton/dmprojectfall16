setwd("~/TrainingSet/")
lengths <- read.csv("lengths.csv", header=F)
hist(lengths[,2], nclass=2000)

lengths <- lengths[lengths[,2] <500,]
hist(lengths[,2], nclass=2000)

