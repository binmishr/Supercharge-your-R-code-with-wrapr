#' Insert \%>.\% .
#'
#' Call this function as an addin to insert \code{\link[wrapr]{\%>.\%}} (dot pipe, \url{https://winvector.github.io/wrapr/reference/grapes-greater-than-.-grapes.html}) at the cursor position.
#'
#' @export
insertToDotPipeAddin <- function() {
  rstudioapi::insertText(" %>.% ")
}
