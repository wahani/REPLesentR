testthat::context("SlideDeck")

testthat::test_that("Testing the introduction presentation", {
  fname <- system.file("Introduction.Rmd", package = "REPLesentR", mustWork = TRUE)
  rawText <- Read()$auto(fname, quiet = TRUE)
  slideDeck <- SlideDeck()$new(rawText)
  testthat::expect_true(length(slideDeck) == 10)
  lapply(slideDeck, function(slide) {
    testthat::expect_true(all(c("content", "format", "number") %in% names(slide)))
  })
})
