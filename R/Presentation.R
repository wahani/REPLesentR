# Presentation Module
#
# The module to put all components together. If this is your first contact: see
# \link{newPresentation}. This module provides methods to construct and
# navigate inside presentations. All logic concerning rendering, parsing
# slides, evaluation of code, etc. is provided by other modules and may be
# modified. If you have questions feel free to file an issue on GitHub.
#
# @param fileName (fileName) see \link{newPresentation}.
# @param read (function) a function which knows how to read in \code{fileName}.
# @param render (Render) see \link{Render}.
# @param slideDeck (SlideDeck) see \link{SlideDeck}.
# @param evaluate (Evaluate) see \link{Evaluate}.
#
# @examples
# ## As an example consider the implementation of newPresentation:
# newPresentation <- function(fileName, width = NULL, height = NULL, border = "*",
#                            padding = 1, slideSep = rep("", 3)) {
#   Presentation(
#     fileName,
#     Read()$auto,
#     Render(Layout(border, padding), Screen(width, height)),
#     SlideDeck(slideSep),
#     Evaluate()
#   )
# }
# @export
Presentation <- function(fileName, read, render, slideDeck, evaluate) {
  modules::module({

    modules::export("start")
    rawText <- slideDeckVal <- currentSlide <- NULL

    init <- function() {
      rawText <<- read(fileName)
      slideDeckVal <<- slideDeck$new(rawText)
      currentSlide <<- CurrentSlide(length(slideDeckVal))
    }

    init() # No reason to delay init

    start <- function() {
      jumpTo(currentSlide$current())
    }

    jumpTo <- function(pos) {
      render$singleSlide(extract2(slideDeckVal, pos))
      prompt()
    }

    prompt <- function() {
      command <- readline(": ")
      if (command == "") command <- "n"
      if (command == "c") command <- "current"
      if (unknown(command)) return(noSuchCommand())
      get(command, mode = "function")()
    }

    noSuchCommand <- function() {
      message("command is unknown -- type 'q' to quit or 'h' for help")
      prompt()
    }

    unknown <- function(command) {
      !is.element(command, c(
        "n", "p", "l", "f", "q", "h", "current", "e", "ee", "cc"
      ))
    }

    n <- function() jumpTo(currentSlide$n())
    p <- function() jumpTo(currentSlide$p())
    f <- function() jumpTo(currentSlide$f())
    l <- function() jumpTo(currentSlide$l())
    q <- function() invisible(NULL)
    current <- function() jumpTo(currentSlide$current())
    h <- function() {
      render$singleSlide(helpPage())
      prompt()
    }
    ee <- function() {
      evaluate$slideDeckVal(slideDeckVal[1:currentSlide$current()])
      prompt()
    }
    e <- function() {
      evaluate$slide(slideDeckVal[[currentSlide$current()]])
      prompt()
    }
    cc <- function() {
      val <- currentSlide$current()
      init()
      jumpTo(currentSlide$set(val))
    }

  })
}

