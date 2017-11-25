#' Create Slide
#'
#' @param rawText (character)
#' @param number,totalNumber (integer)
#'
#' @export
Slide <- function(rawText, number = NULL, totalNumber = NULL) {
  modules::module({

    .extractCode <- function(rawText) {
      pos <- grep("&nbsp;", rawText)
      flatmap(pos, function(p) {
        s <- extract(rawText, (p + 1):length(rawText))
        posWithCode <- grep(" {4}", s)
        extract(s, posWithCode == seq_along(posWithCode))
      })
    }

    format <- "default"
    content <- rawText
    number <- number
    totalNumber <- totalNumber
    code <- .extractCode(rawText)

 })
}
