#' Create Slide
#'
#' @param rawText (character)
#' @param number,totalNumber (integer)
#'
#' @export
Slide <- function(rawText, number = NULL, totalNumber = NULL) {
  modules::module({
    format <- "default"
    content <- rawText
    number <- number
    totalNumber <- totalNumber
  })
}
