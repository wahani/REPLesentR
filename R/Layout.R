# Layout Module
#
# The function returns a list with it's arguments as elements. You do not need
# to use this function interactively: see \link{newPresentation}.
#
# @param border (character) see \link{newPresentation}.
# @param padding (integer) see \link{newPresentation}.
#
# @export
Layout <- function(border = "*", padding = 1) {
  modules::module({
    # margin <- NULL
    border <- border
    padding <- padding
  })
}
