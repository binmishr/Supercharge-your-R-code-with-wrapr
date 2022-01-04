
#' Insert user chosen text or operation.
#'
#' Call this function as an addin to insert user chosen text or operation at the cursor position.
#' To set the option do something like the example.
#'
#' @examples
#'
#' # options("addinexamplesWV.usrFn1" = function() { rstudioapi::insertText(" := ") })
#'
#' @export
insertUsr1Addin <- function() {
  fn <-  options("addinexamplesWV.usrFn1")
  if(length(fn)>0) {
    # unpack from list
    fn[[1]]()
  }
}

#' Insert user chosen text or operation.
#'
#' Call this function as an addin to insert user chosen text or operation at the cursor position.
#' To set the option do something like the example.
#'
#' @examples
#'
#' # options("addinexamplesWV.usrFn2" = function() { rstudioapi::insertText(" := ") })
#'
#' @export
insertUsr2Addin <- function() {
  fn <-  options("addinexamplesWV.usrFn2")
  if(length(fn)>0) {
    # unpack from list
    fn[[1]]()
  }
}

#' Insert user chosen text or operation.
#'
#' Call this function as an addin to insert user chosen text or operation at the cursor position.
#' To set the option do something like the example.
#'
#' @examples
#'
#' # options("addinexamplesWV.usrFn3" = function() { rstudioapi::insertText(" := ") })
#'
#' @export
insertUsr3Addin <- function() {
  fn <-  options("addinexamplesWV.usrFn3")
  if(length(fn)>0) {
    # unpack from list
    fn[[1]]()
  }
}
