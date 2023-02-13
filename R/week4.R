# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

# Data Import
import_tbl <- read_delim("../data/week4.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
glimpse(import_tbl)
wide_tbl <- import_tbl |> separate(qs, into = c("q1", "q2", "q3", "q4", "q5"), sep = " - ", convert = TRUE)
sapply(wide_tbl[c("q1",  "q2", "q3", "q4", "q5")], as.integer)
wide_tbl$datadate <- as.POSIXct(wide_tbl$datadate, format = "%b %d %Y, %H:%M:%S")
wide_tbl[c("q1",  "q2", "q3", "q4", "q5")][wide_tbl[c("q1",  "q2", "q3", "q4", "q5")] == 0] <- NA




wide_tbl <- wide_tbl[!is.na(wide_tbl$q2),]
long_tbl <- wide_tbl |> pivot_longer(c(q1:q5), names_to = "question", values_to = "response", names_prefix = "q")
