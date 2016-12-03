library(parallel)

clust <- makeCluster(detectCores())
clusterSetRNGStream(clust, 1800)
set.seed(1800)

temp = list.files(path = "./calls", pattern="*.wav.csv")
myfiles = lapply(temp, read.delim)


cluster.function <- function(x){
  PseudoF <- rep(NA, 10)
  
  for(i in 2:11){
  clusters <- kmeans(bird_call_1[, 1], centers = i)
  PseudoF[i] <- (clusters$betweenss/(i-1))/(clusters$withinss/(length(bird_call_1[, 1]) - i))
  }
  choice <- which(PseudoF == min(PseudoF))
}


## columns 9-21 are MFCCS in bird data, look at pyAudioAnaysis wiki

bird_call_1 <- read.csv(file.choose(), header = F)
bird_call_1 <- select(bird_call_1, 9:21)



clusterExport(clust, c("x", "summary", "pt", "acf", "sqrt", "abs", "ifelse"))

t_type_1 <- parApply(clust, sim_data, 2, t_function)

t_ar_type_1 <- parApply(clust, ar_sim_data, 2, t_function)

t_ma_type_1 <- parApply(clust, ma_sim_data, 2, t_function)

# Since the seed is set for the cores, the output won't change between runs

save(t_type_1, t_ar_type_1, t_ma_type_1, file = "p3d.Rdata")

