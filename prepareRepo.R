library(REPLesentR)


system.file()

advertise <- newPresentation(
  system.file("advertise.Rmd", package = "REPLesentR"),
  width = 90, height = 19)
advertise$start()
