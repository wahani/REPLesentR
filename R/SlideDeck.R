slideDeck <- function(rawText, slideSep = rep("", 3)) {

  splitRawTextIntoSlides <- function(rawText, slideSep) {
    ind <- numeric(length(rawText))
    ind[seq_along(slideSep)] <- 0
    for (i in seq_along(rawText)[-seq_along(slideSep)]) {
      pos <- (i - length(slideSep) + 1):i
      if (identical(rawText[pos], slideSep)) ind[i] <- 1
      else ind[i] <- 0
    }
    split(rawText, cumsum(ind))
  }

  slideDeck <- splitRawTextIntoSlides(rawText, slideSep)
  map(slideDeck ~ seq_along(slideDeck) ~ length(slideDeck), Slide)

}
