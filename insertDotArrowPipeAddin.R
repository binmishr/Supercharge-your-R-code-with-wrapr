#' Insert \%.>\% .
#'
#' Call this function as an addin to insert \code{\link[wrapr]{\%.>\%}} (dot pipe, \url{https://winvector.github.io/wrapr/articles/dot_pipe.html}) at the cursor position.
#'
#' @export
insertDotArrowPipeAddin <- function() {
  rstudioapi::insertText(" %.>% ")
}
