
calls <- read.csv("calls.csv")

summary(calls)
require(dplyr)

callsR <- tbl_df(calls) %>% filter(Content==call|Content==Call)

callsR <- filter(callsR, (Content=="Call")|(Content=="call"))

callsR <- filter(callsR, (Length>15)&(Length<45))
