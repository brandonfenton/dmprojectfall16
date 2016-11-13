
files <- list.files(path="mfccs/", pattern="*.wav_st.csv")
filesR <- paste("mfccs/",files, sep="")

myread <- function(input) {
  tmp <- read.csv(input, header=F)[,9:21]
  return(tmp)
}

birdcalls <- lapply(filesR, myread)


####

getk.summary <- function(x) {
  call.dim <- dim(x)
  
  call.within <- numeric()
  call.between <- numeric()
  
  for(i in 1:9) {
    tmp <- kmeans(x,centers=i+1,nstart=25)
    call.within[[i]] <- tmp$tot.withinss
    call.between[[i]] <- tmp$betweenss
  }
  
  nk <- call.dim[1]-(2:10)
  
  psued <- (call.between/(1:9))/(call.within/nk)
  call.out <- data.frame(k=2:10, WithinSS=call.within, 
                         PsuedoF=psued)
  return(call.out)
}

calls.elbow <- lapply(birdcalls,getk.summary)


#######

plot(4,4, type="n", xlim=c(1,11), ylim=c(0,1))
psued.opt <- numeric()

for(i in 1:1280) {
  x <- unlist(calls.elbow[[i]][1])
  y <- unlist(calls.elbow[[i]][3])/max(calls.elbow[[i]][3])
  psued.opt[i] <- which(y==1)
  points(x,y,type="l", col=rgb(0.25,0.45,0.25,0.25))
}
  

keeps <- which(psued.opt==9)

plot(4,4, type="n", xlim=c(1,11), ylim=c(0,5667))

for(i in keeps) {
  x <- 2:10
  y <- unlist(calls.elbow[[i]][2])
  points(x,y,type="l", col=rgb(0.25,0.45,0.25,0.25))
}

kay <- 4:6
som <- dim(3,1280)

testout <- lapply(birdcalls, kmeans, center=5)

for(i in 1:3) {
  som[i] <- lapply(birdcalls, kmeans, center=kay[i])
}


