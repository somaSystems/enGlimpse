#' Add together two numbers
#'
#' @param csv_path path to the csv you wish to read as RDS if you can!
#' @return A plot of summarised data
#' @import readr
#' @import tools
#' @export

fastloadr <- function(csv_path) {
  # Check if the provided path is a csv file
  if(tolower(file_ext(csv_path)) != "csv") {
    stop("Provided path is not a CSV file.")
  }

  # Derive the RDS file path from the CSV file path
  rds_path <- paste0(file_path_sans_ext(csv_path), ".RDS")

  # If the RDS file exists, read it and return it
  if(file.exists(rds_path)) {
    message("RDS file exists. Reading RDS file...")
    data <- readRDS(rds_path)
  } else { # If the RDS file does not exist, read the CSV, save it as RDS, and return it
    message("RDS file does not exist. Reading CSV file and saving as RDS...")
    data <- read.csv(csv_path)
    saveRDS(data, rds_path)
  }

  return(data)
}
