#' Insert \%<>\% .
#'
#' Call this function as an addin to insert \code{\link[magrittr]{\%<>\%}} (Magrittr pipe, \url{https://github.com/tidyverse/magrittr}) at the cursor position.
#'
#' @export
insertMagrittrCompoundPipeAddin <- function() {
  rstudioapi::insertText(" %<>% ")
}
