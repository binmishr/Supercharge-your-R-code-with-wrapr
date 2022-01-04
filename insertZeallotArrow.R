#' Insert \%<-\% .
#'
#' Call this function as an addin to insert \code{\%<-\%} (Zeallot Arrow, \url{https://CRAN.R-project.org/package=zeallot}) at the cursor position.
#'
#' @export
insertZeallotArrow <- function() {
  rstudioapi::insertText(" %<-% ")
}
