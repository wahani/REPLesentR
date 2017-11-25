#' Create Screen
#'
#' @param .width,.height (NULL | integer)
#'
#' @export
Screen <- function(.width = NULL, .height = NULL) {
  modules::module({
    width <- function() if (is.null(.width)) options("width")$width else .width
    height <- function() if (is.null(.height)) 36 else .height
  })
}
