#' Create Slide
#'
#' @param rawText (character)
#' 
#' @export
Slide <- function(rawText) {
  modules::module({
    format <- "default"
    content <- rawText
  })
}
