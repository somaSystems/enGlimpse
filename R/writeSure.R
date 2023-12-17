#' Write Data to CSV with Assured Directory Creation
#'
#' `writeSure` writes a data frame or similar object to a CSV file, ensuring that the directory for the
#' file exists. If the directory does not exist, it is created, including any necessary parent directories.
#'
#' @param data A data frame, matrix, or other object convertible to CSV format.
#' @param file_path The file path where the CSV file will be saved, including both the directory path and
#' the file name. If the directory does not exist, it will be created.
#' @param ... Additional arguments to be passed to `write.csv`.
#' @return Invisible NULL. This function is used for its side effect of writing a file.
#' @examples
#' my_data <- data.frame(column1 = 1:5, column2 = letters[1:5])
#' writeSure(my_data, "path/to/your/directory/filename.csv")
#' @export
writeSure <- function(data, file_path, ...) {
  # Extract the directory path from the file path
  dir_path <- dirname(file_path)

  # Create the directory if it doesn't exist (recursively)
  if (!dir.exists(dir_path)) {
    dir.create(dir_path, recursive = TRUE, showWarnings = FALSE)
  }

  # Write the data to the CSV file
  write.csv(data, file_path, ...)
}
