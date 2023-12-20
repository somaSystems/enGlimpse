#' Perform Paired T-Test and Display Pairing
#'
#' This function performs a paired t-test on a specified variable within a
#' dataframe, grouped by a specified grouping variable. It also creates a
#' dataframe showing the pairs as used in the test, allowing users to check
#' the pairing.
#'
#' @param data A dataframe containing the data to be analyzed.
#' @param variable The name of the column in \code{data} containing the variable
#'   to test.
#' @param group The name of the column in \code{data} that defines the groups
#'   for pairing.
#' @param paringID A vector of column names in \code{data} used as identifiers
#'   for pairing.
#' @return A list containing the results of the t-test and a dataframe
#'   showing the paired data.
#' @examples
#' # Assuming 'df' is a dataframe with columns 'relative_change', 'treatment',
#' # and 'cDNA_template_ng'
#' result <- perform_paired_t_test(df, "relative_change", "treatment",
#'                                c("cDNA_template_ng"))
#' print(result$TestResult)
#' print(result$PairedData)
#' @export
perform_paired_t_test <- function(data, variable, group, paringID) {
  # Ensure the data is sorted by the group variable to align the pairs correctly
  data_sorted <- data[order(data[[group]]), ]

  # Split the data into two groups based on the grouping variable
  group_levels <- levels(as.factor(data_sorted[[group]]))
  if (length(group_levels) != 2) {
    stop("Grouping variable must have exactly two levels for a paired t-test.")
  }

  data_group1 <- subset(data_sorted, data_sorted[[group]] == group_levels[1])
  data_group2 <- subset(data_sorted, data_sorted[[group]] == group_levels[2])

  # Perform the paired t-test
  t_test_result <- t.test(data_group1[[variable]], data_group2[[variable]], paired = TRUE)

  # Select only the specified paringID columns along with the variable for each group
  selected_columns_group1 <- c(paringID, variable)
  selected_columns_group2 <- c(paringID, variable)
  data_group1_selected <- data_group1[selected_columns_group1]
  data_group2_selected <- data_group2[selected_columns_group2]

  # Rename columns with Group1 and Group2 prefixes
  names(data_group1_selected) <- paste("Group1", names(data_group1_selected), sep="_")
  names(data_group2_selected) <- paste("Group2", names(data_group2_selected), sep="_")

  # Arrange the columns so that the variables and IDs are next to each other
  paired_variable_columns <- c(paste("Group1", variable, sep="_"), paste("Group2", variable, sep="_"))
  paired_id_columns <- c(paste("Group1", paringID, sep="_"), paste("Group2", paringID, sep="_"))
  all_columns <- c("Pair", paired_id_columns, paired_variable_columns)

  # Create a new dataframe to show the pairs with selected columns
  paired_data <- cbind(Pair = seq_along(data_group1_selected[[paste("Group1", variable, sep="_")]]),
                       data_group1_selected, data_group2_selected)[all_columns]

  # Return the t-test result and the paired data
  list(TestResult = t_test_result, PairedData = paired_data)
}
