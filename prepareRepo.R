
read <- slider::Read()
rawText <- read$rmd("tests/test-presentation.Rmd")

slideDeck(rawText)
