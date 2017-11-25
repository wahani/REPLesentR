#' Create a presentation
#'
#' @param fileName (fileName)
#' @param read (Read)
#' @param render (Render)
#' @param slideDeck (SlideDeck)
#'
#' @export
Presentation <- function(fileName, read, render, slideDeck, evaluate) {
  modules::module({

    modules::export("start")
    rawText <- read$auto(fileName)
    slideDeck <- slideDeck$new(rawText)
    currentSlide <- CurrentSlide(length(slideDeck))

    start <- function() {
      jumpTo(currentSlide$current())
    }

    jumpTo <- function(pos) {
      render$singleSlide(extract2(slideDeck, pos))
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
      message("command is unknown -- type 'q' to quite or 'h' for help")
      prompt()
    }

    unknown <- function(command) {
      !is.element(command, c(
        "n", "p", "l", "f", "q", "h", "current", "e", "ee"
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
      evaluate$slideDeck(slideDeck[1:currentSlide$current()])
      prompt()
    }
    e <- function() {
      evaluate$slide(slideDeck[[currentSlide$current()]])
      prompt()
    }

  })
}

