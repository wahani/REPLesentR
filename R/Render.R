#' Render Module
#'
#' This module should not be used interactively. See \link{newPresentation}
#' instead. The module handles everything around printing a slide to the
#' console.
#'
#' @param layout (Layout) an instance of \link{Layout}
#' @param screen (Screen) an instance of \link{Screen}
#'
#' @export
Render <- function(layout, screen) {
  modules::module({

    modules::export("singleSlide")

    singleSlide <- function(slide) {
      renderInformation <- prepare(slide)
      lapply(renderInformation, cat, sep = "")
      invisible(NULL)
    }

    prepare <- function(slide) {
      get(paste0("prepare.", slide$format), mode = "function")(slide)
    }

    prepare.default <- function(slide) {
      content <- slide$content
      content <- correctHeight(content)
      content <- wrapBorder(leftAlign(content))
      c(border(), padding(), content, padding(), border())
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

    correctHeight <- function(content) {
      truncate <- function() extract(content, 1:contentHeight())
      append <- function() c(content, rep("", contentHeight() - length(content)))
      if (length(content) > contentHeight()) truncate()
      else if (length(content) < contentHeight()) append()
      else content
    }

    contentWidth <- function() {
      screen$width() - (nchar(layout$border) + layout$padding) * 2
    }

    contentHeight <- function() {
      screen$height() - (nchar(layout$border) + layout$padding) * 2
    }

    border <- function() {
      x <- paste0(rep(layout$border, screen$width()), collapse = "")
      paste0(x, "\n")
    }

    padding <- function() {
      emptyLines <- flatmap(rep(" ", layout$padding), leftAlign)
      wrapBorder(emptyLines)
    }

  })
}
