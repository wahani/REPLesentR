#' Create a slide deck
#'
#' @param slideSep (character) what is used to indicate a slide break
#' @param newSlide (Slide) the 'Slide' constructor
#'
#' @export
SlideDeck <- function(slideSep = rep("", 3), newSlide = Slide) {
  modules::module({

    export("new")

    new <- function(rawText) {
      slideDeck <- splitRawTextIntoSlides(rawText, slideSep)
      map(slideDeck ~ seq_along(slideDeck) ~ length(slideDeck), newSlide)
    }

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

  })
}
