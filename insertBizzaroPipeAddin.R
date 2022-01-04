#' Insert ->.; .
#'
#' Call this function as an addin to insert \code{->.;} (Bizarro Pipe, \url{http://www.win-vector.com/blog/2016/12/magrittrs-doppelganger/}) at the cursor position.
#'
#' @export
insertBizzaroPipeAddin <- function() {
  rstudioapi::insertText(" ->.; ")
}
