# Screen Module
#
# A list with two functions for determining the height and width of the space
# in which to print the slide. The two methods do not have any arguments. You
# do not need to use this function interactively: see \link{newPresentation}.
#
# @param .width,.height (NULL | integer) see \link{newPresentation}.
#
# @export
Screen <- function(.width = NULL, .height = NULL) {
  modules::module({
    width <- function() if (is.null(.width)) options("width")$width else .width
    height <- function() if (is.null(.height)) 22 else .height
  })
}
