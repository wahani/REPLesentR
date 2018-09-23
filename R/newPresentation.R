#' Create a new presentation
#'
#' Creates a new instance of a presentation. Currently it has only one method:
#' \code{start} which is called without any arguments. It starts a presentation
#' or resumes where you left off. A presentation runs inside your R console and
#' the idea is to maximize the window on your screen for a presentation mode.
#'
#' @param fileName (character) the file containing the presentation. Currently
#'   one of: .Rmd, md, or plain.
#' @param width (integer) the number of columns to use. By default:
#'   \code{options('width')}.
#' @param height (integer) the number of rows to use. By default set to 22.
#' @param border (character) the character used as a border to frame a single
#'   slide.
#' @param padding (integer) the number of white-spaces / empty rows between
#'   border and content.
#' @param slideSep (character) the slide separator: how to determine a 'slide
#'   break'.
#'
#' @return The function returns an instance of the presentation. It has only one
#'   method: \code{start} without any arguments. \code{start} will start the
#'   presentation and also resume where you left.
#'
#' @details
# You can completely reconfigure or redefine parts of this package.
#   All components are modules and can be extended or replaced. This is just a
#   default configuration for a \link{Presentation}.
#'
#' To convert from Rmd to md formats \code{knitr::knit} is used. To convert from
#'   md to plain \code{knitr::pandoc(file, format = "plain")} is used. If you
#'   want to configure the process of this conversion please see the
#'   documentation of these two functions.
#'
#' For navigation inside the presentation mode, please see the examples below.
#'   Or start a presentation and type 'h' for help.
#'
#' @examples
#' \dontrun{
#' ## Start with the example:
#' introPresentation() # in presentation mode type 'h'
#'
#' ## The same presentation but with manual configuration:
#' file <- system.file("Introduction.Rmd", package = "REPLesentR")
#' myPresentation <- newPresentation(
#'   file, width = 80, height = 23, border = "O", padding = 1)
#' myPresentation$start()
#' }
#' @export
newPresentation <- function(fileName, width = NULL, height = NULL, border = "*",
                            padding = 1, slideSep = rep("", 3)) {
  Presentation(
    fileName,
    Read()$auto,
    Render(Layout(border, padding), Screen(width, height)),
    SlideDeck(slideSep),
    Evaluate()
  )
}

#' @rdname newPresentation
#' @export
introPresentation <- function() {
  fileName <- system.file("Introduction.Rmd", package = "REPLesentR")
  introduction <- newPresentation(fileName)
  introduction$start()
}
