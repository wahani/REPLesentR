# SlideDeck Module
#
# This module has one method 'new' with one argument 'rawText' and knows how to
# convert the raw text from a file into a slide deck (a list of slides). You do
# not need to use this module interactively: see \link{newPresentation}.
#
# @param slideSep (character) see \link{newPresentation}.
# @param newSlide (Slide) see \link{Slide}; the constructor function for a
#   single slide.
#
# @export
SlideDeck <- function(slideSep = rep("", 3), newSlide = Slide) {
  modules::module({

    modules::export("new")

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
