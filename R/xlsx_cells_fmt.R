
#' Produce dataframe from excel file, storing formats as an attribute. 
#' @description
#' This function produces a data frame from excel file, storing formats as an attribute
#' @param path path to excel file
#' @param sheets sheet to be extracted.
#'
#' @export

xlsx_cells_fmt <-  function(path, sheets = NA) {
  sheets <- sheets
  cells <- tidyxl::xlsx_cells(path, sheets = sheets)
  
  
  cells <-
    cells %>% select(address,row,col,data_type,character, numeric,date,logical,error, is_blank,local_format_id, everything(), sheet)
  
  
  attr(cells, "formats") <- tidyxl::xlsx_formats(path)
  cells
}
