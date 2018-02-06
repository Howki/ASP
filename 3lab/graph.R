#!/usr/bin/env Rscript
cache_test <- read.table("cache_test")
plot(cache_test$V1, cache_test$V2, xlab="N", ylab="Times", type="b")
