#'chinstall is the chill way to install and load packages that you may or may
#'not already have installed in R. It is a terse wrapper around the common and
#' verbose pattern of:
#'1. Checking if a package can be loaded
#'2. Installing if you do not have the required package
#'
#'Created by LD and TPC
#'
#'
#' @param package_as_string dataframe to visualse.
#' @export

chinstall <- function(package_as_string){
  notString <-  package_as_string
  if(!require(notString, character.only = TRUE)){install.packages(package_as_string)}
}
