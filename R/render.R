#' @export
render <- modules::module({

  contentWidth <- function() {
    screen$width - (nchar(layout$border) + layout$padding) * 2
  }

  wrapBorder <- function(s) {
    paste0(
      layout$border, rep(" ", layout$padding), s,
      rep(" ", layout$padding), layout$border, "\n"
    )
  }

  leftAlign <- function(s) {
    strtrim(sprintf(paste0("%-", contentWidth(), "s"), s), contentWidth())
  }

  border <- function() {
    c(rep(layout$border, screen$width), "\n")
  }

  padding <- function() {
    emptyLines <- flatmap(rep(" ", layout$padding), leftAlign)
    wrapBorder(emptyLines)
  }

  prepare <- function(slide) {
    content <- wrapBorder(leftAlign(slide))
    c(border(), padding(),
      content,
      padding(), border())
  }

  singleSlide <- function(slide) {
    renderInformation <- prepare(slide)
    lapply(renderInformation, cat, sep = "")
    invisible(NULL)
  }

})

screen <- modules::module({
  width <- options("width")$width
  height <- 36
})

layout <- modules::module({
  # margin <- NULL
  border <- "*"
  padding <- 1
})
