# From page 26 of Microsoft's published xlsx extensions [Excel (.xlsx) extensions to the office openxml spreadsheetml file format p.24](https://msdn.microsoft.com/en-us/library/dd922181(v=office.12).aspx).

#' Names of all Excel functions
#'
#' A dataset containing the names of all functions available in Excel.  This is
#' useful for identifying user-defined functions in formulas tokenized by
#' [xlex()].
#'
#' Note that this includes future function names that are already reserved.
#'
#' @format A character vector of length 600.
#' @source Pages 26--27 of Microsoft's document "Excel (.xlsx) extensions to the
#' office openxml spreadsheetml file format p.24"
#' \url{https://msdn.microsoft.com/en-us/library/dd922181(v=office.12).aspx},
#' revision 8.0 2017-06-20.
"excel_functions"

#' Names and RGB values of Excel standard colours
#'
#' A dataset containing the names and RGB colour values of Excel's standard
#' palette.
#'
#' @format A data frame with 10 rows and 2 variables:
#'   * `name` Name of the colour
#'   * `rgb`  RGB value of the colour
"xlsx_color_standard"

#' @rdname xlsx_color_standard
"xlsx_colour_standard"
