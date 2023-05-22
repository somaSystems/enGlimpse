#' Add together two numbers
#'
#' @param plate_data dataframe to visualse.
#' @param rowNames column with rownumbers.
#' @param colNames colNames
#' @param numRows Number of rows if not 8.
#' @param numCols Number of columns if not 12.
#' @param summary summary statistic to calculate
#' @param variable_to_squiz Variable to visualise.
#' @param low_col Rcolors color or HEX code.
#' @param high_col Rcolors color or HEX code.
#' @return A plot of summarised data
#' @import ggplot2
#' @import dplyr
#' @import scales
#' @import rlang
#' @export

glancer <- function(plate_data = NULL,
                     variable_to_squiz = NULL,
                     low_col = "darkblue",
                     high_col = "hotpink",
                     rowNames = "Row",
                     colNames = "Column",
                     summary = "mean",
                     numRows = 8,
                     numCols = 12
){
  # library(ggplot2)
  # library(scales)
  # library(dplyr)
  # library(rlang)

  # `%>%` <- magrittr::`%>%`

  #function to make an empty plate to fill in missing rows
  platey <- function(nRows,nCols){
    plate_c_rows <-  c(paste(1:numRows))
    plate_c_cols <-  c(paste(1:numCols))
    char_df <-   data.frame(Row = c(paste(rep(plate_c_rows,length(plate_c_cols)))), Column = c(paste(rep(plate_c_cols, each = length(plate_c_rows)))) )
    num_df <- apply(char_df,2, as.numeric)
    num_df <- as.data.frame(num_df)
  }

  # cat("rownames is called...",rowNames)
  #function to Join filler plate to original data
  add_missing_rows_and_cols <- function(my_platey,plate_data){
    joined_plate_data <- dplyr::left_join(my_platey, plate_data, by = c("Row" = rowNames, "Column" = colNames))
  }

  #function to generate summaries of chosen variable
  summarise_data <- function(joined_plate_data) {sum_data <- joined_plate_data%>%
    dplyr::group_by(!!rlang::sym(rowNames),!!rlang::sym(colNames))%>%
    dplyr::summarise(mean_of_data = mean(!!rlang::sym(variable_to_squiz)),
                     sd_of_data = sd(!!rlang::sym(variable_to_squiz)),
                     min_of_data= min(!!rlang::sym(variable_to_squiz)),
                     max_of_data = max((!!rlang::sym(variable_to_squiz))))
  }

  #plot chosen summary
  #part 2 is plot data


  #function to plot summary statistic of data
  emgeezen_plot <- function(sum_data, low_col, high_col){
    emGeezen_plot <- ggplot2::ggplot(sum_data, aes(!!rlang::sym(rowNames), !!rlang::sym(colNames))) +
      geom_tile(aes(fill = mean_of_data), colour = "black") +
      scale_fill_gradient(low = low_col, high = high_col)+
      coord_flip()+
      scale_x_reverse(breaks = pretty_breaks(n = length(unique(sum_data$Row)) ))+
      scale_y_continuous(breaks = pretty_breaks(n = length(unique(sum_data$Column)) ) )+
      # scale_x_continuous()+
      theme_classic()
  }

  #call empty plate of correct dimensions
  my_platey <- platey(nRows,nCols)
  #call join of empty plate and plate_data
  joined_plate_data <- add_missing_rows_and_cols(my_platey,plate_data)
  #call summarise full plate data
  sum_data <- summarise_data(joined_plate_data)
  #call plot of data
  emgzn <- emgeezen_plot(sum_data, low_col, high_col)
  emgzn
}

