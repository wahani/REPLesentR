
read <- slider::Read()
rawText <- read$rmd("tests/test-presentation.Rmd")

slideDeck(rawText)


presi <- Presentation(
  "inst/sample-presentation.plain",
  Read(),
  Render(Layout(), Screen(.height = 22)),
  SlideDeck(),
  Evaluate()
)

presi$start()

