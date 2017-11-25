#' Read in Presentation
#'
#' @export
Read <- function() {
  modules::module({

    modules::export("rmd", "md", "plain")

    plain <- function(fileName) {
      stopifnot(file.exists(fileName))
      readLines(fileName)
    }

    md <- function(fileName) {
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
