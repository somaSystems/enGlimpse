#' Count Distinct Values in a Dataframe
#'
#' This function takes a dataframe and performs a count of distinct values based on a minimal description of interest and a grouping for counting.
#' @param data A dataframe to process.
#' @param id_cols Vector of column names that form the minimal unique identity of interest.
#' @param group_cols Vector of column names used for grouping and counting.
#' @return A dataframe with counts of distinct values based on specified groupings.
#' @export
#' @examples
#' data(mtcars)
#' countThings(mtcars, c("gear", "carb"), c("cyl"))
countThings <- function(data, id_cols, group_cols) {
  # Load required package
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("dplyr package is not installed. Please install it using install.packages('dplyr')")
  }

  # Select, distinct, group, and count
  result <- data %>%
    dplyr::select(!!!rlang::syms(id_cols), !!!rlang::syms(group_cols)) %>%
    dplyr::distinct() %>%
    dplyr::group_by(!!!rlang::syms(group_cols)) %>%
    dplyr::count()

  return(result)
}
