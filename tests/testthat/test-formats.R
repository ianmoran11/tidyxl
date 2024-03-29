context("formats")

examples <- "examples.xlsx"
cells <- xlsx_cells(examples, "Sheet1")
style <- function(address) {cells[cells$address == address, ]$style_format}
local_id <- function(address) {cells[cells$address == address, ]$local_format_id}
styles <- xlsx_formats(examples)$style
locals <- xlsx_formats(examples)$local

test_that("number formats inherit from styles", {
  expect_equal(unname(styles$numFmt[style("A12")]), "0%")
  expect_equal(locals$numFmt[local_id("A12")], "0%")
})

test_that("number styles are independent of local formats", {
  expect_equal(unname(styles$numFmt[style("A6")]), "General")
  expect_equal(locals$numFmt[local_id("A6")], "d-mmm-yy")
})

test_that("the 'General' number format is parsed correctly", {
  expect_equal(unname(styles$numFmt[style("A1")]), "General")
  expect_equal(locals$numFmt[local_id("A1")], "General")
})

test_that("custom formats are parsed correctly", {
  expect_equal(locals$numFmt[local_id("A7")], "[$-1409]d mmmm yyyy;@")
})

test_that("escape-backslashes in custom formats are omitted", {
  expect_equal(locals$numFmt[local_id("A7")], "[$-1409]d mmmm yyyy;@")
})

test_that("font formats inherit from styles", {
  expect_equal(unname(styles$font$name[style("A26")]), "Arial")
  expect_equal(locals$font$name[local_id("A26")], "Arial")
})

test_that("font styles are independent of local formats", {
  expect_equal(unname(styles$font$name[style("A27")]), "Arial")
  expect_equal(locals$font$name[local_id("A27")], "Calibri")
})

test_that("font names are parsed correctly", {
  expect_equal(unname(styles$font$name[style("A27")]), "Arial")
  expect_equal(locals$font$name[local_id("A27")], "Calibri")
})

test_that("font italics are parsed correctly", {
  expect_equal(locals$font$italic[local_id("A26")], FALSE)
  expect_equal(locals$font$italic[local_id("A27")], TRUE)
})

test_that("font bold is parsed correctly", {
  expect_equal(locals$font$bold[local_id("A27")], FALSE)
  expect_equal(locals$font$bold[local_id("A28")], TRUE)
})

test_that("font underline is parsed correctly", {
  expect_equal(locals$font$underline[local_id("A28")], NA_character_)
  expect_equal(locals$font$underline[local_id("A29")], "single")
  expect_equal(locals$font$underline[local_id("A30")], "double")
  expect_equal(locals$font$underline[local_id("A133")], "singleAccounting")
  expect_equal(locals$font$underline[local_id("A134")], "doubleAccounting")
})

test_that("font subscript and superscript is parsed correctly", {
  expect_equal(locals$font$vertAlign[local_id("A135")], NA_character_)
  expect_equal(locals$font$vertAlign[local_id("A136")], "superscript")
  expect_equal(locals$font$vertAlign[local_id("A137")], "subscript")
})

test_that("font sizes are parsed correctly", {
  expect_equal(locals$font$size[local_id("A39")], 11)
  expect_equal(locals$font$size[local_id("A40")], 12)
})

test_that("fonts colours and colors in general are parsed correctly", {
  expect_equal(locals$font$color$rgb[local_id("A1")], NA_character_)
  expect_equal(locals$font$color$theme[local_id("A1")], NA_character_)
  expect_equal(locals$font$color$indexed[local_id("A1")], NA_integer_)
  expect_equal(locals$font$color$tint[local_id("A1")], NA_real_)
  expect_equal(locals$font$color$rgb[local_id("A35")], "FFFF0000")
  expect_equal(locals$font$color$theme[local_id("A35")], NA_character_)
  expect_equal(locals$font$color$indexed[local_id("A35")], NA_integer_)
  expect_equal(locals$font$color$tint[local_id("A35")], NA_real_)
  expect_equal(locals$font$color$rgb[local_id("A36")], "FF4F81BD")
  expect_equal(locals$font$color$theme[local_id("A36")], "accent1")
  expect_equal(locals$font$color$indexed[local_id("A36")], NA_integer_)
  expect_equal(locals$font$color$tint[local_id("A36")], NA_real_)
  expect_equal(locals$font$color$rgb[local_id("A138")], "FFF79646")
  expect_equal(locals$font$color$theme[local_id("A138")], "accent6")
  expect_equal(locals$font$color$indexed[local_id("A138")], NA_integer_)
  expect_equal(locals$font$color$tint[local_id("A138")], -0.2499771) # Excel's precision
  expect_equal(locals$font$color$theme[local_id("A47")], "background1")
  expect_equal(locals$font$color$theme[local_id("A57")], "text1")
  expect_equal(locals$font$color$theme[local_id("A58")], "background2")
  expect_equal(locals$font$color$theme[local_id("A59")], "text2")
  expect_equal(locals$font$color$theme[local_id("A60")], "accent1")
  expect_equal(locals$font$color$theme[local_id("A61")], "accent2")
  expect_equal(locals$font$color$theme[local_id("A62")], "accent3")
  expect_equal(locals$font$color$theme[local_id("A63")], "accent4")
  expect_equal(locals$font$color$theme[local_id("A64")], "accent5")
  expect_equal(locals$font$color$theme[local_id("A65")], "accent6")
  expect_equal(locals$font$color$theme[local_id("A66")], "hyperlink")
  # I can't get Excel to write the followed-hyperlink theme to a file
})

test_that("fill pattern colours are parsed correctly", {
  expect_equal(locals$fill$patternFill$fgColor$rgb[local_id("A69")], NA_character_)
  expect_equal(locals$fill$patternFill$fgColor$rgb[local_id("A70")], "FF00B0F0")
  expect_equal(locals$fill$patternFill$bgColor$rgb[local_id("A69")], NA_character_)
  expect_equal(locals$fill$patternFill$bgColor$rgb[local_id("A70")], "FFFF0000")
})

test_that("fill pattern types are parsed correctly", {
  expect_equal(locals$fill$patternFill$patternType[local_id("A69")], "darkUp")
  expect_equal(locals$fill$patternFill$patternType[local_id("A70")], "solid")
  expect_equal(locals$fill$patternFill$patternType[local_id("A71")], "darkGray")
  expect_equal(locals$fill$patternFill$patternType[local_id("A72")], "mediumGray")
  expect_equal(locals$fill$patternFill$patternType[local_id("A73")], "lightGray")
  expect_equal(locals$fill$patternFill$patternType[local_id("A74")], "gray125")
  expect_equal(locals$fill$patternFill$patternType[local_id("A75")], "gray0625")
  expect_equal(locals$fill$patternFill$patternType[local_id("A76")], "darkHorizontal")
  expect_equal(locals$fill$patternFill$patternType[local_id("A77")], "darkVertical")
  expect_equal(locals$fill$patternFill$patternType[local_id("A78")], "darkDown")
  expect_equal(locals$fill$patternFill$patternType[local_id("A79")], "darkUp")
  expect_equal(locals$fill$patternFill$patternType[local_id("A80")], "darkGrid")
  expect_equal(locals$fill$patternFill$patternType[local_id("A81")], "darkTrellis")
  expect_equal(locals$fill$patternFill$patternType[local_id("A82")], "lightHorizontal")
  expect_equal(locals$fill$patternFill$patternType[local_id("A83")], "lightVertical")
  expect_equal(locals$fill$patternFill$patternType[local_id("A84")], "lightDown")
  expect_equal(locals$fill$patternFill$patternType[local_id("A85")], "lightUp")
  expect_equal(locals$fill$patternFill$patternType[local_id("A86")], "lightGrid")
  expect_equal(locals$fill$patternFill$patternType[local_id("A87")], "lightTrellis")
})

test_that("fill pattern types are consistently NA when not set", {
  expect_equal(locals$fill$patternFill$patternType[local_id("A68")], NA_character_)
  expect_equal(locals$fill$patternFill$patternType[local_id("A88")], NA_character_)
  expect_equal(locals$fill$patternFill$patternType[local_id("A89")], NA_character_)
  expect_equal(locals$fill$patternFill$patternType[local_id("A90")], NA_character_)
  expect_equal(locals$fill$patternFill$patternType[local_id("A91")], NA_character_)
  expect_equal(locals$fill$patternFill$patternType[local_id("A92")], NA_character_)
  expect_equal(locals$fill$patternFill$patternType[local_id("A93")], NA_character_)
  expect_equal(locals$fill$patternFill$patternType[local_id("A94")], NA_character_)
})

test_that("fill gradient colours are parsed correctly", {
  expect_equal(locals$fill$gradientFill$stop1$color$rgb[local_id("A87")], NA_character_)
  expect_equal(locals$fill$gradientFill$stop1$color$rgb[local_id("A88")], "FFFFFFFF")
  expect_equal(locals$fill$gradientFill$stop2$color$rgb[local_id("A88")], "FF4F81BD")
  expect_equal(locals$fill$gradientFill$stop1$color$rgb[local_id("A139")], "FFF79646")
  expect_equal(locals$fill$gradientFill$stop2$color$rgb[local_id("A139")], "FF4F81BD")
})

test_that("fill gradient stop positions are parsed correctly", {
  expect_equal(locals$fill$gradientFill$stop1$position[local_id("A87")], NA_real_)
  expect_equal(locals$fill$gradientFill$stop1$position[local_id("A88")], 0)
  expect_equal(locals$fill$gradientFill$stop2$position[local_id("A88")], 1)
  expect_equal(locals$fill$gradientFill$stop2$position[local_id("A141")], 0.5)
})

test_that("fill gradient types are parsed correctly", {
  expect_equal(locals$fill$gradientFill$type[local_id("A91")], NA_character_)
  expect_equal(locals$fill$gradientFill$type[local_id("A92")], "path")
})

test_that("fill gradient degrees are parsed correctly", {
  expect_equal(locals$fill$gradientFill$degree[local_id("A88")], 90L)
  expect_equal(locals$fill$gradientFill$degree[local_id("A89")], 0L)
  expect_equal(locals$fill$gradientFill$degree[local_id("A92")], NA_integer_)
})

test_that("fill gradient directions are parsed correctly", {
  expect_equal(locals$fill$gradientFill$left[local_id("A91")], NA_real_)
  expect_equal(locals$fill$gradientFill$right[local_id("A92")], 0)
  expect_equal(locals$fill$gradientFill$right[local_id("A93")], 0.5)
})

test_that("borders are parsed correctly", {
  expect_equal(locals$border$outline[local_id("A49")], FALSE)
  expect_equal(locals$border$diagonalUp[local_id("A49")], FALSE)
  expect_equal(locals$border$diagonalUp[local_id("A50")], TRUE)
  expect_equal(locals$border$diagonalDown[local_id("A50")], FALSE)
  expect_equal(locals$border$diagonalDown[local_id("A51")], TRUE)
  expect_equal(locals$border$right$style[local_id("A51")], NA_character_)
  expect_equal(locals$border$right$style[local_id("A151")], "hair")
  expect_equal(locals$border$right$style[local_id("A152")], "dotted")
  expect_equal(locals$border$right$style[local_id("A153")], "dashDotDot")
  expect_equal(locals$border$right$style[local_id("A154")], "dashDot")
  expect_equal(locals$border$right$style[local_id("A155")], "dashed")
  expect_equal(locals$border$right$style[local_id("A156")], "thin")
  expect_equal(locals$border$right$style[local_id("A157")], "mediumDashDotDot")
  expect_equal(locals$border$right$style[local_id("A158")], "slantDashDot")
  expect_equal(locals$border$right$style[local_id("A159")], "mediumDashDot")
  expect_equal(locals$border$right$style[local_id("A160")], "mediumDashed")
  expect_equal(locals$border$right$style[local_id("A161")], "medium")
  expect_equal(locals$border$right$style[local_id("A162")], "thick")
  expect_equal(locals$border$right$style[local_id("A163")], "double")
  expect_equal(locals$border$diagonal$style[local_id("A164")], "hair")
  expect_equal(locals$border$diagonalUp[local_id("A166")], TRUE)
  expect_equal(locals$border$diagonalDown[local_id("A166")], TRUE)
})

test_that("alignments are parsed correctly", {
  expect_equal(locals$alignment$horizontal[local_id("A167")], "general")
  expect_equal(locals$alignment$horizontal[local_id("A168")], "left")
  expect_equal(locals$alignment$horizontal[local_id("A169")], "center")
  expect_equal(locals$alignment$horizontal[local_id("A170")], "right")
  expect_equal(locals$alignment$horizontal[local_id("A171")], "fill")
  expect_equal(locals$alignment$horizontal[local_id("A172")], "justify")
  expect_equal(locals$alignment$horizontal[local_id("A173")], "centerContinuous")
  expect_equal(locals$alignment$horizontal[local_id("A174")], "distributed")
  expect_equal(locals$alignment$vertical[local_id("A175")], "top")
  expect_equal(locals$alignment$vertical[local_id("A176")], "center")
  expect_equal(locals$alignment$vertical[local_id("A177")], "bottom")
  expect_equal(locals$alignment$vertical[local_id("A178")], "justify")
  expect_equal(locals$alignment$vertical[local_id("A179")], "distributed")
  expect_equal(locals$alignment$indent[local_id("A179")], 0L)
  expect_equal(locals$alignment$indent[local_id("A180")], 1L)
  expect_equal(locals$alignment$wrap[local_id("A177")], FALSE)
  expect_equal(locals$alignment$wrap[local_id("A181")], TRUE)
  expect_equal(locals$alignment$shrinkToFit[local_id("A177")], FALSE)
  expect_equal(locals$alignment$shrinkToFit[local_id("A182")], TRUE)
  expect_equal(locals$alignment$readingOrder[local_id("A184")], "context")
  expect_equal(locals$alignment$readingOrder[local_id("A185")], "left-to-right")
  expect_equal(locals$alignment$readingOrder[local_id("A186")], "right-to-left")
  expect_equal(locals$alignment$textRotation[local_id("A186")], 0L)
  expect_equal(locals$alignment$textRotation[local_id("A187")], 105L)
})

test_that("protections are parsed correctly", {
  expect_equal(locals$protection$locked[local_id("A43")], TRUE)
  expect_equal(locals$protection$locked[local_id("A44")], FALSE)
  expect_equal(locals$protection$hidden[local_id("A187")], FALSE)
  expect_equal(locals$protection$hidden[local_id("A188")], TRUE)
})

test_that("themes from an Excel 2016 file don't cause crashes", {
  expect_error(xlsx_formats("themes-2016.xlsx"), NA)
})
