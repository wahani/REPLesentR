#' Read Module
#'
#' Read creates a new module with one method: 'auto'. This method selects an
#' appropriate procedure for reading in the content of the file depending on the
#' file extension. It should not be necessary to call this function
#' interactively, please go to the docs for \link{newPresentation}.
#'
#' @seealso \link{newPresentation}
#'
#' @export
Read <- function() {
  modules::module({

    modules::export("auto")

    auto <- function(fileName, ...) {
      fileName <- normalizePath(fileName, mustWork = TRUE)
      fileExt <- tolower(tools::file_ext(fileName))
      stopifnot(fileExt %in% c("plain", "md", "rmd"))
      get(fileExt, mode = "function")(fileName, ...)
    }

    plain <- function(fileName, ...) {
      stopifnot(file.exists(fileName))
      readLines(fileName)
    }

    md <- function(fileName, ...) {
      stopifnot(file.exists(fileName))
      plainFile <- knitr::pandoc(fileName, format = "plain")
      plain(plainFile)
    }

    rmd <- function(fileName, ...) {
      stopifnot(file.exists(fileName))
      regex <- sprintf("%s$", tools::file_ext(fileName))
      mdFile <- sub(regex, "md", fileName)
      knitr::knit(fileName, mdFile, ...)
      md(mdFile)
    }

  })
}
