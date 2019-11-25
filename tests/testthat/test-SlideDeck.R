testthat::context("SlideDeck")

testthat::test_that("Testing the introduction presentation", {
  fname <- system.file("Introduction.plain", package = "REPLesentR", mustWork = TRUE)
  file.copy(fname, tfname <- tempfile(fileext = ".plain"))
  rawText <- Read()$auto(tfname, quiet = TRUE)
  slideDeck <- SlideDeck()$new(rawText)
  testthat::expect_true(length(slideDeck) == 10)
  lapply(slideDeck, function(slide) {
    testthat::expect_true(all(c("content", "format", "number") %in% names(slide)))
  })
})
