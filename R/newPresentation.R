#' Create a new presentation
#'
#' Creates a new instance of a presentation.
#'
#' @param fileName (character) the file containing the presentation. Currently
#'   one of: .Rmd, md, or plain.
#' @param width (integer) the number of columns to use. By default:
#'   \code{options('width')}.
#' @param height (integer) the number of rows to use. By default set to 22.
#' @param border (character) the character user as a border.
#' @param padding (integer) the number of whitespaces / empty rows between
#'   border and content.
#' @param slideSep (character) how to determine a 'slide break'.
#'
#' @return The function returns an instance of the presentation. It has only one
#'   method: \code{start} without any arguments. \code{start} will start the
#'   presentation and also resume where you left.
#'
#' @details You can completely reconfigure or redefine parts of this package.
#'   All components are modules and can be extended or replaced. This is just a
#'   default configuration for a \link{Presentation} and for added flexibility
#'   this can make sense; for plug and play use this function here is more user
#'   friendly.
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
#' ## Start with the example:
#' \dontrun{
#' fileName <- system.file("example.Rmd", package = "slider")
#' presi <- newPresentation(fileName)
#' ## Once we call the start method we enter 'presentation mode': type h to get
#' ## help on navigation.
#' presi$start()
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
