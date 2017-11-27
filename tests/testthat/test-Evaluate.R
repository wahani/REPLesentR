testthat::context("Evaluate")

testthat::test_that("", {
  e <- new.env(parent = environment())
  fname <- system.file("example.Rmd", package = "slider")
  slideDeck <- SlideDeck()$new(Read()$auto(fname, quiet = TRUE))
  evaluate <- Evaluate(e, quiet = TRUE)
  evaluate$slideDeck(slideDeck)
  l <- as.list(e)
  testthat::expect_true(all(names(l) %in% c("x", "y", "z")))
  testthat::expect_true(l$x == 1)
  testthat::expect_true(l$y == 2)
  testthat::expect_true(l$z == 3)
})
