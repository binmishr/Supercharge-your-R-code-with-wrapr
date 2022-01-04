#' Insert \%>\% .
#'
#' Call this function as an addin to insert \code{\link[magrittr]{\%>\%}} (Magrittr pipe, \url{https://CRAN.R-project.org/package=magrittr}) at the cursor position.
#'
#' @export
insertMagrittrPipeAddin <- function() {
  rstudioapi::insertText(" %>% ")
}
