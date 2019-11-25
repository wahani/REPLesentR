# Render Module
#
# This module should not be used interactively. See \link{newPresentation}
# instead. The module handles everything around printing a slide to the
# console.
#
# @param layout (Layout) an instance of \link{Layout}
# @param screen (Screen) an instance of \link{Screen}
#
# @export
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
      content <- wrapBorder(align(content, attr(slide$content, "lineFormats")))
      c(border(), padding(), content, padding(), border())
    }

    prepare.center <- function(slide) {
      missingLines <- floor((contentHeight() - length(slide$content)) / 2)
      if (missingLines < 0) return(prepare.default(slide))
      missingLines <- rep("", missingLines)
      content <- slide$content
      content <- c(missingLines, content, missingLines)
      attr(content, "lineFormats") <- c(
        rep("left", length(missingLines)), attr(slide$content, "lineFormats"))
      slide$content <- content
      prepare.default(slide)
    }

    wrapBorder <- function(s) {
      paste0(
        layout$border,
        paste0(rep(" ", layout$padding), collapse = ""),
        s,
        paste0(rep(" ", layout$padding), collapse = ""),
        layout$border, "\n"
      )
    }

    align <- function(content, format) {
      if (length(format) > length(content)) format <- format[seq_along(content)]
      format <- map(format, ~ get(paste0("align.", .), mode = "function"))
      flatmap(content ~ format, f(content, format) ~ format(content))
    }

    align.left <- function(st) {
      filledUp <- paste0(st, paste(rep(" ", contentWidth()), collapse = ""))
      strtrim(filledUp, contentWidth())
    }

    align.center <- function(s) {
      missingLength <- contentWidth() - nchar(s)
      missingWhites <- paste(rep(" ", floor(missingLength / 2)), collapse = "")
      align(paste(missingWhites, s, missingWhites), "left")
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
      emptyLines <- flatmap(rep(" ", layout$padding), ~ align(., "left"))
      wrapBorder(emptyLines)
    }

  })
}
