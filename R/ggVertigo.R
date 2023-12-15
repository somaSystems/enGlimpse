#' ggVertigo
#'
#' Rotates ggplot x axis
#'
#' @param angle the angle of rotation.
#' @return returns theme function with arguments to rotate axis labels
#' @export
#'
ggVertigo <- function(angle = 90) {
  theme(axis.text.x = element_text(angle = angle, hjust = 1))
}
