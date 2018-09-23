# Evaluation Module
#
# This module knows how to evaluate code on a slide. It has two methods:
# 'slide' and 'slideDeck' consuming either a Slide or SlideDeck. You do not
# need to use this interactively: see \link{newPresentation}.
#
# @param envir (environment) the environment in which to evaluate.
# @param quiet (logical) whether to print the code being evaluated prior to
#   evaluation.
#
# @export
Evaluate <- function(envir = .GlobalEnv, quiet = FALSE) {
  modules::module({

    slide <- function(slide) {
      if (is.null(slide$code)) return(NULL)
      if (!quiet) lapply(paste0(slide$code, "\n"), cat)
      try(eval(parse(text = slide$code), envir = envir), silent = quiet)
    }

    slideDeck <- function(slideDeck) {
      map(slideDeck, slide)
    }

  })
}
