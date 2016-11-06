library(dplyr)

birds <- read.csv("calls.csv", header = T, stringsAsFactors = T)

birds$Quality <- as.factor(birds$Quality)

birds <- tbl_df(birds)
birds$Content <- as.factor(birds$Content)


## Subset Ideas
# - similar lengths
# - random sample of species
# - minimize background species 
# - 

summary(birds[which(birds$Content == "call, song"), 24])
summary(birds[which(birds$Content == "Call, Song"), 24])
summary(birds[which(birds$Content == "song"), 24])
summary(birds[which(birds$Content == "Song"), 24])
summary(birds[which(birds$Content == "call"), 24])
summary(birds[which(birds$Content == "Call"), 24])

birds$Content <- tolower(birds$Content)

## Need Data cleaning!

birds_filtered <- filter(birds, Length > 15 & Length < 45) %>% 
  filter(str_detect(tolower(Content), 'call')) %>% 
  mutate(GenusSpecies = as.factor(paste(Genus, Species)))

fileCounts <- data.frame(table(birds_filtered$GenusSpecies), ncols = 2)
colnames(fileCounts) <- c("GenusSpecies", "Counts")
  

hist(table(birds_filtered$GenusSpecies), 
     main = "Histogram of Call Files by Species", freq = F, 
     xlab = "Number of Call Files")

birds_filtered$fileCount <- rep(NA, dim(birds_filtered)[1])

for(i in 1:dim(birds_filtered)[1]){
  
birds_filtered$fileCount[i] <- fileCounts[which(birds_filtered$GenusSpecies[i] == 
                                       fileCounts$GenusSpecies), 2]
}

birds_filtered <- filter(birds_filtered, fileCount > 9)
birds_filtered <- droplevels(birds_filtered)

