#' Module for evaluation
#'
#' @export
Evaluate <- function(envir = .GlobalEnv, quiet = FALSE) {
  modules::module({

    slide <- function(slide) {
      if (is.null(slide$code)) return(NULL)
      if (!quiet) lapply(paste0(trimws(slide$code), collapse = "\n"), cat)
      try(eval(parse(text = slide$code), envir = envir))
    }

    slideDeck <- function(slideDeck) {
      map(slideDeck, slide)
    }

  })
}
