#' Module for evaluation
#'
#' @param envir (environment)
#' @param quiet (logical)
#' 
#' @export
Evaluate <- function(envir = .GlobalEnv, quiet = FALSE) {
  modules::module({

    slide <- function(slide) {
      if (is.null(slide$code)) return(NULL)
      if (!quiet) lapply(paste0(slide$code, "\n"), cat)
      try(eval(parse(text = slide$code), envir = envir))
    }

    slideDeck <- function(slideDeck) {
      map(slideDeck, slide)
    }

  })
}
