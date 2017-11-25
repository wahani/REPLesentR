#' Create Slide
#'
#' @param rawText (character)
#' @param number,totalNumber (integer)
#'
#' @export
Slide <- function(rawText, number = NULL, totalNumber = NULL) {
  modules::module({

    .extractCode <- function(rawText) {
      pos <- grep("//code", rawText)
      flatmap(pos, function(p) {
        s <- extract(rawText, (p + 2):length(rawText))
        posWithCode <- grep(" {4}", s)
        posWithCode <- extract(posWithCode, posWithCode == seq_along(posWithCode))
        s <- gsub("^ {4}", "", s)
        extract(s, posWithCode)
      })
    }

    .extractContent <- function(rawText) {
      pos <- grep("^//code$", rawText)
      if (length(pos) == 0) return(rawText)
      extract(rawText, -c(pos, pos + 1))
    }

    format <- "default"
    content <- .extractContent(rawText)
    number <- number
    totalNumber <- totalNumber
    code <- .extractCode(rawText)

 })
}
