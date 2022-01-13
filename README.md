# Supercharge-your-R-code-with-wrapr

The details of the codeset and plots are included in the attached Microsoft Word Document (.docx) file in this repository. 
You need to view the file in "Read Mode" to see the contents properly after downloading the same.

Seplyr Package - A Brief Introduction
=======================================
The R package seplyr supplies improved standard evaluation interfaces for some common dplyr data plying tasks.This project is used in production to avoid exposing all of the details of rlang at the user level, and a demonstration of what can be done through value-oriented programming. Alternately one could use another value-oriented data manipulation system ‘rquery’/‘rqdatatable’.

To get started we suggest visiting the seplyr site, and checking out some examples.

One quick example:

# Assume this is set elsewhere,
# supplied by a user, function argument, or control file.

        orderTerms <- c('cyl', 'desc(gear)')

# load packages

        library("seplyr")

#  Loading required package: wrapr

        Library("wrapr")

# where we are actually working (perhaps in a re-usable  script or function)
        datasets::mtcars %.>% 
          arrange_se(., orderTerms) %.>% 
          head(.)
         #                 mpg cyl  disp  hp drat    wt  qsec vs am gear carb
         #  Porsche 914-2 26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
         #  Lotus Europa  30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
         #  Datsun 710    22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
         #  Merc 240D     24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
         #  Merc 230      22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
         #  Fiat 128      32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1

The concept is: in writing re-usable code or scripts you pretend you do not know the actual column names you will be asked to work with (that these will be supplied as values later at analysis time). This forces you to write scripts that can be used even if data changes, and are re-usable on new data you did not know about when writing the script.

To install this package please either install from CRAN with:

           install.packages('seplyr')

Please see help("%.>%", package="wrapr") for details on “dot pipe.”

In addition to standard interface adapters seplyr supplies some non-trivial statement transforms:

            partition_mutate_se():
            if_else_device():   

Note:
=====

        Note: seplyr is meant only for “tame names”, that is: variables and column names that are also valid simple (without quotes) R variables names.
        
Wrapr Package - A Brief Introduction
====================================

wrapr is an R package that supplies powerful tools for writing and debugging R code.

Introduction
=============
Primary wrapr services include:

            %.>% (dot arrow pipe)
            unpack/to (assign to multiple values)
            as_named_list (build up a named list quickly)
            build_frame() / draw_frame() ( data.frame builders and formatters )
            bc() (blank concatenate)
            qc() (quoting concatenate)
            := (named map builder)
            %?% (coalesce)
            %.|% (reduce/expand args)
            uniques() (safe unique() replacement)
            partition_tables() / execute_parallel()
            DebugFnW() (function debug wrappers)
            λ() (anonymous function builder)
            let() (let block)
            evalb()/si() (evaluate with bquote / string interpolation)
            sortv() (sort a data.frame by a set of columns).
            stop_if_dot_args() (check for unexpected arguments)

            library(wrapr)
            packageVersion("wrapr")
        
%.>% (dot pipe or dot arrow).%.>% dot arrow pipe is a pipe with intended semantics:

            “a %.>% b” is to be treated approximately as if the user had written “{ . <- a; b };” with “%.>%” being treated as left-associative.

The following two expressions should be equivalent:

cos(exp(sin(4)))

         #  [1] 0.8919465

4 %.>% sin(.) %.>% exp(.) %.>% cos(.)

         #  [1] 0.8919465

The notation is quite powerful as it treats pipe stages as expression parameterized over the variable “.”. This means you do not need to introduce functions to express stages. The following is a valid dot-pipe:

1:4 %.>% .^2 

         #  [1]  1  4  9 16

The notation is also very regular as we show below.

        1:4 %.>% sin
         #  [1]  0.8414710  0.9092974  0.1411200 -0.7568025
        1:4 %.>% sin(.)
         #  [1]  0.8414710  0.9092974  0.1411200 -0.7568025
        1:4 %.>% base::sin
         #  [1]  0.8414710  0.9092974  0.1411200 -0.7568025
        1:4 %.>% base::sin(.)
         #  [1]  0.8414710  0.9092974  0.1411200 -0.7568025

        1:4 %.>% function(x) { x + 1 }
         #  [1] 2 3 4 5
        1:4 %.>% (function(x) { x + 1 })
         #  [1] 2 3 4 5

        1:4 %.>% { .^2 } 
         #  [1]  1  4  9 16
        1:4 %.>% ( .^2 )
         #  [1]  1  4  9 16

Regularity can be a big advantage in teaching and comprehension. Please see “In Praise of Syntactic Sugar” for more details. Some formal documentation can be found here.

    Some obvious “dot-free”" right-hand sides are rejected. Pipelines are meant to move values through a sequence of transforms, and not just for side-effects. Example: `5 %.>% 6` deliberately stops as `6` is a right-hand side that obviously does not use its incoming value. This check is only applied to values, not functions on the right-hand side.
    Trying to pipe into a an “zero argument function evaluation expression” such as `sin()` is prohibited as it looks too much like the user declaring `sin()` takes no arguments. One must pipe into either a function, function name, or an non-trivial expression (such as `sin(.)`). A useful error message is returned to the user: `wrapr::pipe does not allow direct piping into a no-argument function call expression (such as "sin()" please use sin(.))`.
    Some reserved words can not be piped into. One example is `5 %.>% return(.)` is prohibited as the obvious pipe implementation would not actually escape from user functions as users may intend.
    Obvious de-references (such as `$`, `::`, `@`, and a few more) on the right-hand side are treated performed (example: `5 %.>% base::sin(.)`).
    Outer parenthesis on the right-hand side are removed (example: `5 %.>% (sin(.))`).
    Anonymous function constructions are evaluated so the function can be applied (example: `5 %.>% function(x) {x+1}` returns 6, just as `5 %.>% (function(x) {x+1})(.)` does).
    Checks and transforms are not performed on items inside braces (example: `5 %.>% { function(x) {x+1} }` returns `function(x) {x+1}`, not 6).
    The dot arrow pipe has S3/S4 dispatch (please see ). However as the right-hand side of the pipe is normally held unevaluated, we don’t know the type except in special cases (such as the rigth-hand side being referred to by a name or variable). To force the evaluation of a pipe term, simply wrap it in `.()`.

The dot pipe is also user configurable through standard S3/S4 methods.

unpack/to multiple assignments:
================================

Unpack a named list into the current environment by name (for a positional based multiple assignment operator please see zeallot, for another named base multiple assigment please see vadr::bind).

        d <- data.frame(
          x = 1:9,
          group = c('train', 'calibrate', 'test'),
          stringsAsFactors = FALSE)

        unpack[
          train_data = train,
          calibrate_data = calibrate,
          test_data = test
          ] := split(d, d$group)

        knitr::kable(train_data)

            x 	group
        1 	1 	train
        4 	4 	train
        7 	7 	train
        as_named_list

        Build up named lists. Very convenient for managing workspaces when used with used with unpack/to.

        as_named_list(train_data, calibrate_data, test_data)
         #  $train_data
         #    x group
         #  1 1 train
         #  4 4 train
         #  7 7 train
         #  
         #  $calibrate_data
         #    x     group
         #  2 2 calibrate
         #  5 5 calibrate
         #  8 8 calibrate
         #  
         #  $test_data
         #    x group
         #  3 3  test
         #  6 6  test
         #  9 9  test

build_frame() / draw_frame():

build_frame() is a convenient way to type in a small example data.frame in natural row order. This can be very legible and saves having to perform a transpose in one’s head. draw_frame() is the complimentary function that formats a given data.frame (and is a great way to produce neatened examples).

        x <- build_frame(
           "measure"                   , "training", "validation" |
           "minus binary cross entropy", 5         , -7           |
           "accuracy"                  , 0.8       , 0.6          )

        print(x)

         #                       measure training validation
         #  1 minus binary cross entropy      5.0       -7.0
         #  2                   accuracy      0.8        0.6
        str(x)
         #  'data.frame':   2 obs. of  3 variables:
         #   $ measure   : chr  "minus binary cross entropy" "accuracy"
         #   $ training  : num  5 0.8
         #   $ validation: num  -7 0.6

        cat(draw_frame(x))

         #  x <- wrapr::build_frame(
         #     "measure"                     , "training", "validation" |
         #       "minus binary cross entropy", 5         , -7           |
         #       "accuracy"                  , 0.8       , 0.6          )

qc() (quoting concatenate)
==========================
qc() is a quoting variation on R’s concatenate operator c(). This code such as the following:

        qc(a = x, b = y)
         #    a   b 
         #  "x" "y"

        qc(one, two, three)
         #  [1] "one"   "two"   "three"

qc() also allows bquote() driven .()-style argument escaping:

        aname <- "I_am_a"
        yvalue <- "six"

        qc(.(aname) := x, b = .(yvalue))
         #  I_am_a      b 
         #     "x"  "six"

Notice the := notation is required for syntacitic reasons.

        := (named map builder)

:= is the “named map builder”. It allows code such as the following:

        'a' := 'x'
         #    a 
         #  "x"

The important property of named map builder is it accepts values on the left-hand side allowing the following:

        name <- 'variableNameFromElsewhere'
        name := 'newBinding'
         #  variableNameFromElsewhere 
         #               "newBinding"

A nice property is := commutes (in the sense of algebra or category theory) with R’s concatenation function c(). That is the following two statements are equivalent:

        c('a', 'b') := c('x', 'y')
         #    a   b 
         #  "x" "y"

        c('a' := 'x', 'b' := 'y')
         #    a   b 
         #  "x" "y"

The named map builder is designed to synergize with seplyr.
        %?% (coalesce)

The coalesce operator tries to replace elements of its first argument with elements from its second argument. In particular %?% replaces NULL vectors and NULL/NA entries of vectors and lists.

Example:

        c(1, NA) %?% list(NA, 20)
         #  [1]  1 20

        %.|% (reduce/expand args)

x %.|% f stands for f(x[[1]], x[[2]], ..., x[[length(x)]]). v %|.% x also stands for f(x[[1]], x[[2]], ..., x[[length(x)]]). The two operators are the same, the variation just allowing the user to choose the order they write things. The mnemonic is: “data goes on the dot-side of the operator.”

        args <- list('prefix_', c(1:3), '_suffix')

        args %.|% paste0
         #  [1] "prefix_1_suffix" "prefix_2_suffix" "prefix_3_suffix"
        # prefix_1_suffix" "prefix_2_suffix" "prefix_3_suffix"

        paste0 %|.% args
         #  [1] "prefix_1_suffix" "prefix_2_suffix" "prefix_3_suffix"
        # prefix_1_suffix" "prefix_2_suffix" "prefix_3_suffix"

DebugFnW()

DebugFnW() wraps a function for debugging. If the function throws an exception the execution context (function arguments, function name, and more) is captured and stored for the user. The function call can then be reconstituted, inspected and even re-run with a step-debugger. Please see our free debugging video series and vignette('DebugFnW', package='wrapr') for examples.

λ() (anonymous function builder)
=================================
λ() is a concise abstract function creator or “lambda abstraction”. It is a placeholder that allows the use of the -character for very concise function abstraction.

Example:

        # Make sure lambda function builder is in our enironment.
        wrapr::defineLambda()

        # square numbers 1 through 4
        sapply(1:4, λ(x, x^2))
         #  [1]  1  4  9 16

let()
======
let() allows execution of arbitrary code with substituted variable names (note this is subtly different than binding values for names as with base::substitute() or base::with()).

The function is simple and powerful. It treats strings as variable names and re-writes expressions as if you had used the denoted variables. For example the following block of code is equivalent to having written “a + a”.

        a <- 7

        let(
          c(VAR = 'a'),

          VAR + VAR
        )
         #  [1] 14

This is useful in re-adapting non-standard evaluation interfaces (NSE interfaces) so one can script or program over them.

We are trying to make let() self teaching and self documenting (to the extent that makes sense). For example try the arguments “eval=FALSE” prevent execution and see what would have been executed, or debug=TRUE to have the replaced code printed in addition to being executed:

        let(
          c(VAR = 'a'),
          eval = FALSE,
          {
            VAR + VAR
          }
        )
         #  {
         #      a + a
         #  }

        let(
          c(VAR = 'a'),
          debugPrint = TRUE,
          {
            VAR + VAR
          }
        )
         #  $VAR
         #  [1] "a"
         #  
         #  {
         #      a + a
         #  }
         #  [1] 14

Please see vignette('let', package='wrapr') for more examples. Some formal documentation can be found here. wrapr::let() was inspired by gtools::strmacro() and base::bquote(), please see here for some notes on macro methods in R.

wrapr supplies unified notation for quasi-quotation and string interpolation.

        angle = 1:10
        variable <- "angle"

        # execute code
        evalb(
          plot(x = .(-variable), y = sin(.(-variable)))
        )

        # alter string
        si("plot(x = .(variable), y = .(variable))")
         #  [1] "plot(x = \"angle\", y = \"angle\")"

        The extra .(-x) form is a shortcut for .(as.name(x)).
        sortv() (sort a data.frame by a set of columns)

This is the sort command that is missing from R: sort a data.frame by a chosen set of columns specified in a variable.

        d <- data.frame(
          x = c(2, 2, 3, 3, 1, 1), 
          y = 6:1,
          z = 1:6)
        order_cols <- c('x', 'y')

        sortv(d, order_cols)
         #    x y z
         #  6 1 1 6
         #  5 1 2 5
         #  2 2 5 2
         #  1 2 6 1
         #  4 3 3 4
         #  3 3 4 3

Installation
==============
Install with:

        install.packages("wrapr")




