# Create Slide
#
# Constructs a list representing a single slide. \code{format}, \code{content},
# \code{number}, \code{totalNumber} and \code{code} are its elements. You
# should not need to call this constructor interactively but use
# \link{newPresentation} instead.
#
# @param rawText (character) the raw text from which to extract the contents,
#   code etc.
# @param number,totalNumber (NULL | integer) the total number of slides in the
#   slide deck and the number of the slide in this deck.
#
# @export
Slide <- function(rawText, number = NULL, totalNumber = NULL) {
  modules::module({

    modules::export("format", "content", "number", "totalNumber", "code")

    extractCode <- function(rawText) {
      pos <- grep("^//code", rawText)
      flatmap(pos, function(p) {
        s <- extract(rawText, (p + 2):length(rawText))
        posWithCode <- grep(" {4}", s)
        posWithCode <- extract(posWithCode, posWithCode == seq_along(posWithCode))
        s <- gsub("^ {4}", "", s)
        extract(s, posWithCode)
      })
    }

    extractContent <- function(rawText) {
      content <- trimEmptyLines(rawText)
      content <- rev(trimEmptyLines(rev(content)))
      content <- removeEmptyTags(content)
      content <- removeCodeTags(content)
      useLineFormats(content)
    }

    trimEmptyLines <- function(rawText) {
      pos <- Position(function(x) x != "", rawText)
      if (pos == 1) return(rawText)
      else extract(rawText, -(1:(pos - 1)))
    }

    removeEmptyTags <- function(rawText) {
      pos <- grep("^//empty", rawText, ignore.case = TRUE)
      if (length(pos) == 0) return(rawText)
      replace(rawText, pos, "")
    }

    removeCodeTags <- function(rawText) {
      pos <- grep("^//code$", rawText, ignore.case = TRUE)
      if (length(pos) == 0) return(rawText)
      extract(rawText, -c(pos, pos + 1))
    }

    useLineFormats <- function(content) {
      lineFormats <- rep("left", length(content))
      for (format in c("center")) {
        lformat <- sprintf("^//%s ", format)
        lineFormats <- replace(lineFormats, grep(lformat, content, TRUE), format)
        content <- sub(lformat, "", content, TRUE)
      }
      attr(content, "lineFormats") <- lineFormats
      content
    }

    extractFormat <- function(rawText) {
      isEmpty <- any(grepl("^//CENTER", rawText))
      if (isEmpty) "center"
      else "default"
    }

    format <- extractFormat(rawText)
    content <- extractContent(rawText)
    number <- number
    totalNumber <- totalNumber
    code <- extractCode(rawText)

  })
}
