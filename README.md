# Supercharge-your-R-code-with-wrapr

The details of the codeset and plots are included in the attached Microsoft Word Document (.docx) file in this repository. 
You need to view the file in "Read Mode" to see the contents properly after downloading the same.

A Brief Introduction
=====================

This package supplies the following RStudio add-ins:

    "Insert %.>%" inserts "%.>%" (wrapr's "dot arrow pipe"")
    "Insert (.)" inserts "(.)" ("argument stand-in")
    "Insert ->.;" inserts "->.;" ("Bizarro pipe")
    "Insert :=" inserts ":=" (wrapr's "named map builder")
    "Insert %>.%" inserts "%>.%" (wrapr's "to dot pipe"")
    "Insert %>%" inserts "%>%" ("Magrittr pipe", also usually available as a separate RStudio editor binding as Shift-ALT-m)
    "Insert %<>%" inserts "%<>%" ("Magrittr compound pipe")
    "Insert %<-%" inserts "%<-%" ("Zeallot assign")

The above are useful when bound to keyboard shortcuts in RStudio.
Installation

The R code to install is below.

We first ensure that you have the latest CRAN release versions of:

    devtools
    htmltools
    shiny
    miniUI
    formatR
    wrapr

install.packages(c("devtools", "htmltools", "shiny", 
                   "miniUI", "formatR", "wrapr"))

Finally bind "Insert %.>%" to F9 (which has a right-facing glyph on some Mac keyboards) via Tools->Addins->BrowseAddins->KeyboardShortCuts.
Use

Once you have installed and configured all of the above you can press F9 to "Insert %.>%" where you are typing. "%.>%" is the wrapr "dot pipe" (an alternative to the magrittr %>% pipe). This allows easy conversion of nested function application into left to right sequential pipe notation.

For example:

sin(sqrt(exp(4)))

## [1] 0.893855

library("wrapr")

4 %.>%
    exp(.) %.>%
    sqrt(.) %.>%
    sin(.)

## [1] 0.893855

Dot pipe insists on explicit marking of function arguments with ".". If you also bind "Insert (.)" to F10 typing the above pipelines can become very fast and efficient.

Basically:

    You type a function name and then press F10. This gives you the template for function arguments which you either leave alone (if the function only takes one argument) or edit to add in the additional arguments you need. This replaces pressing space after you type in a function name. You press F9 when you are done with a pipeline step and then enter or return. Try the above in the RStudio editor and the RStudio console, it works really well both places. Bizarro pipe can be used the same way as we just used dot pipe (but does not require any package for implementation, as it is an emergent behavior of pre-existing base-R semantics):

4 ->.;
    exp(.) ->.;
    sqrt(.) ->.;
    sin(.)

## [1] 0.893855

Be aware that the value of a Bizarro pipeline comes off the right bottom end of the pipeline (not the top left end as with dot pipe). So to pick up the Bizarro pipeline value you need to use a right assignment of the form -> at the end of the pipeline (or use {}). This is, however, one of the features that makes Bizarro pipe superior for step debugging.

Both of these pipes also work with more complicated function signatures, and with dplyr:

# assuming you have dplyr installed
suppressPackageStartupMessages(library("dplyr"))

starwars %.>%
    group_by(., name) %.>%
    summarize(., mean_height = mean(height)) %.>%
    ungroup(.) %.>%
    left_join(data_frame(name = c("Han Solo", 
                                "Luke Skywalker")), 
            ., 
            by = 'name') %.>%
    arrange(., desc(name))

## # A tibble: 2 x 2
##   name           mean_height
##   <chr>                <dbl>
## 1 Luke Skywalker        172.
## 2 Han Solo              180.

Another set of good choices for binding are:

    Alt-Enter for "Insert %.>%" (or even Alt-;)
    Alt-Space for "Insert (.)"
    Alt-= for "Insert :=".

That way you are treating the argument list as a space-like separator and the pipe symbol as a line-end-like separator.
User mappings Three user controllable add-ins are registered as part of this package: insert usr1, insert usr2, and insert usr3. 
The user at run-time can change what function is called when the add-in is activated. 
For example to re-bind the first user add-in to insert := run the following R code:

options("addinexamplesWV.usrFn1" = function() { rstudioapi::insertText(" := ") })
