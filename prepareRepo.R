library(slider)

fileName <- system.file("example.Rmd", package = "slider")
fileName <- "inst/example.Rmd"
readLines(fileName)
presi <- newPresentation(fileName)
presi$start()
