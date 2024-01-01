#' Generate a Plate Visualization
#'
#' This function takes in plate data and generates a visualization based on the specified parameters.
#' It allows customization of colors, summary statistics, row and column names, and more.
#'
#' @param plate_data A data frame representing the plate data.
#' @param variable_to_squiz The variable of interest to visualize.
#' @param low_col The color for the low end of the gradient.
#' @param high_col The color for the high end of the gradient.
#' @param rowNames The name to be used for rows in the plate visualization.
#' @param colNames The name to be used for columns in the plate visualization.
#' @param summary The summary statistic to use (default is mean).
#' @param numRows The number of rows in the plate.
#' @param numCols The number of columns in the plate.
#' @param discrete Whether the fill scale is discrete or not.
#' @return A ggplot object representing the plate visualization.
#' @export
#'
#' @examples
#' new_emGeezen(plate_data = yourData,
#'              variable_to_squiz = "yourVariable",
#'              low_col = "darkblue",
#'              high_col = "hotpink")
new_emGeezen <- function(plate_data = NULL,
                         variable_to_squiz = NULL,
                         low_col = "darkblue",
                         high_col = "hotpink",
                         rowNames = "Row",
                         colNames = "Column",
                         summary = "mean",
                         numRows = 8,
                         numCols = 12,
                         discrete = FALSE) {
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
    dplyr::summarise(mean_of_data = mean(!!rlang::sym(variable_to_squiz), na.rm = TRUE),
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
      theme_classic()+
      ggtitle(variable_to_squiz)

  }


  emgeezen_discrete_plot <- function(joined_plate_data, low_col, high_col){
    # emGeezen_plot <- ggplot2::ggplot(joined_plate_data, aes(!!rlang::sym(rowNames), !!rlang::sym(colNames))) +
    #   geom_tile(aes(fill = !!rlang::sym(variable_to_squiz), color = "black")) +
    #   scale_fill_gradient(low = low_col, high = high_col)+
    #   coord_flip()+
    #   scale_x_reverse(breaks = pretty_breaks(n = length(unique(joined_plate_data$Row)) ))+
    #   scale_y_continuous(breaks = pretty_breaks(n = length(unique(joined_plate_data$Column)) ) )+
    #   # scale_x_continuous()+w
    #   theme_classic()
    emGeezen_plot <- ggplot2::ggplot(joined_plate_data, aes(!!rlang::sym(rowNames), !!rlang::sym(colNames))) +
      geom_tile(aes(fill = !!rlang::sym(variable_to_squiz), color = "black")) +
      scale_fill_viridis(discrete = TRUE)+
      coord_flip()+
      scale_x_reverse(breaks = pretty_breaks(n = length(unique(joined_plate_data$Row)) ))+
      scale_y_continuous(breaks = pretty_breaks(n = length(unique(joined_plate_data$Column)) ) )+
      # scale_x_continuous()+w
      theme_classic()+
      ggtitle(variable_to_squiz)
  }

  if(discrete == TRUE){
    print("discrete_value_workflow")
    my_platey <- platey(nRows,nCols)

    joined_plate_data <- add_missing_rows_and_cols(my_platey,plate_data)

    emgzn <- emgeezen_discrete_plot(joined_plate_data, low_col, high_col)
    emgzn
  }else{
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
}
