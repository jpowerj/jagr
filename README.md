RStudio JAG Addins
==================

RStudio addins are R functions that can be called through RStudio. This package
provides a set of addins for JAG, allowing submission to the autograder using
the RStudio UI (or via keyboard shortcuts).

Installation
------------

You can install this package into RStudio by running the following code in the R console:

```r
if (!requireNamespace("devtools", quietly = TRUE))
  install.packages("devtools")

devtools::install_github("jpowerj/jagr")
```

What's an Addin?
----------------

Addins are just R functions with a bit of special registration metadata. This
package exports two simple addins: one function,
[insertInAddin](https://github.com/rstudio/addinexamples/blob/master/R/insertInAddin.R),
can be used to insert ' %in% ' at the cursor position. Another,
[findAndReplaceAddin](https://github.com/rstudio/addinexamples/blob/master/R/findAndReplaceAddin.R),
can be used to interactively refactor code in a document, using a Shiny application.
These addins are registered through a Debian Control File, located at
[inst/rstudio/addins.dcf](https://github.com/rstudio/addinexamples/blob/master/inst/rstudio/addins.dcf).

When RStudio is launched, it will automatically discover addins registered by
installed R packages, and register them so that they can be invoked through
keyboard shortcuts and other UI gestures. See the
[RStudio Addins website](http://rstudio.github.io/rstudioaddins/)
for more details.
