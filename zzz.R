
addinexamplesWV_default_options <- list(
  addinexamplesWV.usrFn1 = function() { rstudioapi::insertText(" -> ") },
  addinexamplesWV.usrFn2 = function() { rstudioapi::insertText(" := ") },
  addinexamplesWV.usrFn3 = function() { rstudioapi::insertText(" [[ ]] ") }
)

.onLoad <- function(libname, pkgname) {
  op <- options()
  toset <- setdiff(names(addinexamplesWV_default_options), names(op))
  if(length(toset)>0) {
    options(addinexamplesWV_default_options[toset])
  }
  invisible()
}
