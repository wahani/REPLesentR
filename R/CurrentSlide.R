CurrentSlide <- function(maxVal) {
  modules::module({
    val <- 1
    set <- function(x) {
      val <<- max(min(x, maxVal), 1)
      val
    }
    n <- function() set(val + 1)
    p <- function() set(val - 1)
    current <- function() val
    f <- function() set(1)
    l <- function() set(maxVal)
  })
}
