#' Add together two numbers
#'
#' @param picked_dataframe dataframe to visualse.
#' @param picked_rownames column with rownumbers.
#' @param nRows Number of rows if not 8.
#' @param nCols Number of columns if not 12.
#' @param picked_variable Variable to visualise.
#' @param hue_low Rcolors color or HEX code.
#' @param hue_high Rcolors color or HEX code.
#' @param hue_breaks a number (defaults 256).
#' @return A plot of summarised data
#' @export

squiz <- function(picked_dataframe,
                      picked_rownames = "Row",
                      picked_colnames = "Column",
                      nRows = 8,
                      nCols = 12,
                      picked_variable = NULL,
                      picked_summary = c("mean"),
                      hue_low = "navyblue",
                      hue_high = "darkorange",
                      hue_breaks = 256) {


#VARIABLE DEFINITIONS

  picked_variable <- picked_variable
  picked_dataframe <- picked_dataframe
  picked_rownames <- picked_rownames
  picked_colnames <- picked_colnames
  picked_dataframe  # picked_variable <- picked_variable
  picked_summary <- picked_summary
  nRows <- nRows
  nCols <- nCols
  hue_low <- hue_low
  hue_high <- hue_high
  hue_breaks <- hue_breaks



#FUNCTION DEFINITIONS

#DEFINE select numeric column, for absence of picked variable
# selects the first numeric column in a dataframe that is not named "Row" or "Column":
# returns the selected numeric column name

# select_numeric_column <- function(picked_dataframe, picked_rownames, picked_colnames ) {
#   picked_rownames <- picked_rownames
#   picked_colnames <- picked_colnames
#   col_names <- colnames(picked_dataframe)
#   for (col in col_names) {
#     if (col != !!sym(picked_rownames) && col != !!sym(picked_colnames) && is.numeric(picked_dataframe[[col]])) {
#       picked_variable <- (col)
#       print("the picked variable is: ", picky_variable)
#       print("the structure of the picked variable is: ", str(picky_variable))
#       cat("Warning: No variable selected to summarise, defaulting to: ",picked_variable)
#     }
#   }
# cat("Warning: No numeric variable found for summary")
# (NULL) # If no suitable column is found
# }



#DEFINE function in function
  platey <- function(nRows,nCols){
    plate_c_rows <-  c(paste(1:nRows))
    plate_c_cols <-  c(paste(1:nCols))

    char_df <-   data.frame(Row = c(paste(rep(plate_c_rows,length(plate_c_cols)))), Column = c(paste(rep(plate_c_cols, each = length(plate_c_rows)))) )

    num_df <- apply(char_df,2, as.numeric)
    num_df <- as.data.frame(num_df)
  }

#DEFINE picky function to summarise data
  picky <- function(picked_dataframe = picked_dataframe ,
                    picky_rownames = picked_rownames,
                    picky_colnames = picked_colnames ,
                    picky_variable = picked_variable,
                    picky_summary = picked_summary){

    # if( is.null(picky_variable)){
    #   # print("Definitely no colname chosen") # remove after working
    #   # Function to select the first numeric column
    #   picky_variable <- select_numeric_column(picked_dataframe, picky_variable, picky_colnames)
    #
    #
    # }


    #group by rows and columns, then summarise
    sum_picked_dataframe <- picked_dataframe %>%
      dplyr::group_by(!!sym(picky_rownames), !!sym(picky_colnames))%>%
      dplyr::summarise(mean = mean(!!sym(picky_variable)),
                       st_dev = sd(!!sym(picky_variable)),
                       min = min(!!sym(picky_variable)),
                       max = max(!!sym(picky_variable))
      )
    sum_picked_dataframe
  }





#DEFINE emheaten to widen data, make matrix, and make heatmap
  emheaten <- function(my_platey, my_picky, picked_summary){
    emjoined <- dplyr::left_join(my_platey, my_picky, by = c(Row = colnames(my_picky[1]), Column = colnames(my_picky[2])))

    pre_matrix <-  tidyr::pivot_wider(emjoined,
                                      id_cols = Row,
                                      names_from = Column,
                                      names_prefix = "Col_",
                                      values_from = all_of(picked_summary)
    )

  #Make widened data into a matrix
  picked_matrix <- as.matrix(pre_matrix[-1])
  row.names(picked_matrix) <- paste0("Row_",t(pre_matrix[1]))
  final_picked_matrix <- apply(picked_matrix,2,rev)
  }

#DEFINE emheaten aesthetics
  emheaten_colour <- colorRampPalette(c(hue_low, hue_high))(hue_breaks)
  # emheaten_colour <- colorRampPalette(brewer.pal(10, "RdYlBu"))(256)

    # ?colorRampPalette
#FUNCTION CALLS

  #1. call my_platey to make an empty plate
  my_platey <- platey(nRows, nCols)

  #2. call my_picky to summarise the picked variable
  my_picky <- picky(picked_dataframe = picked_dataframe)

  #3. call emheaten to widen data and make a matrix
  my_emheaten <- emheaten(my_platey, my_picky, picked_summary)

  #4. call heatmap with no sorting to visualise
  heatmap(my_emheaten, Rowv = NA, Colv = NA, na.rm = TRUE, col = emheaten_colour )

}


