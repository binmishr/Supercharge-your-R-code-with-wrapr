#' Insert := .
#'
#' Call this function as an addin to insert \code{:=} (Named map builder, \url{https://winvector.github.io/wrapr/reference/named_map_builder.html}) at the cursor position.
#'
#' @export
insertColonEqual <- function() {
  rstudioapi::insertText(" := ")
}
