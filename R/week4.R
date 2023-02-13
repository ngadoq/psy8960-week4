# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

# Data Import
import_tbl <- read_delim("../data/week4.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
glimpse(import_tbl)
wide_tbl <- import_tbl |> separate(qs, into = paste0("q",1:5), sep = " - ", convert = TRUE)
# c - combine create a vector of character
# paste - create a single vector
# paste - remove separator 
paste(1,2, 3, sep = "list")
paste0("q", 1:5)

sapply(wide_tbl[c("q1",  "q2", "q3", "q4", "q5")], as.integer)
# Matrix
wide_tbl[,paste0("q", 1:5)] <- sapply(wide_tbl[,paste0("q", 1:5)], as.integer)
# List 
wide_tbl[paste0("q", 1:5)] <- sapply(wide_tbl[paste0("q", 1:5)], as.integer)
# Inside [] has to be position/index 
wide_tbl[c(1, 6, 9), c("q1", "q5")]

wide_tbl$datadate <- as.POSIXct(wide_tbl$datadate, format = "%b %d %Y, %H:%M:%S")
wide_tbl$datadate <- as.POSIXct(wide_tbl[["datadate"]], format = "%b %d %Y, %H:%M:%S")

wide_tbl[paste0("q", 1:5)][wide_tbl[paste0("q", 1:5)] == 0] <- NA
wide_tbl[,paste0("q", 1:5)][wide_tbl[,paste0("q", 1:5)] == 0] <- NA

wide_tbl <- wide_tbl[!is.na(wide_tbl$q2),]
wide_tbl <- drop_na(wide_tbl, q2)

long_tbl <- wide_tbl |> pivot_longer(c(q1:q5), names_to = "question", values_to = "response", names_prefix = "q")
