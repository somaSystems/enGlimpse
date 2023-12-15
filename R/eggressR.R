#' takes a dataframe and two variables (a response and predictor),
#' creates a linear model, and uses this model to predict and normalise the
#' response variable. The function generates predictions,
#' and normalises the response variable.
#' It outputs model visualisation and parameters (R^2 and coefficients)
#' along the way.
#'
#' Function can be applied to the original data frame, or a second one
#' supplied by the user.
#'
#' @param data_frame_to_build_model dataframe to visualse.
#' @param response_var column with rownumbers.
#' @param predictor_variable colNames
#' @param data_frame_to_apply_model Number of rows if not 8.#'
#' @return A dataframe with prediction and normalised variables
#' @import ggplot2
#' @import dplyr
#' @import rlang
#' @export

egressR <- function(data_frame_to_build_model,
                                  response_var,
                                  predictor_variable,
                                  data_frame_to_apply_model = NULL){

  if (is.null(data_frame_to_apply_model)) {
    data_frame_to_apply_model <- data_frame_to_build_model
  }

  check_column_names <- function(data_frame_to_build_model, data_frame_to_apply_model, response_var, predictor_variable) {
    col1_present_df1 <- response_var %in% names(data_frame_to_build_model)
    col2_present_df1 <- predictor_variable %in% names(data_frame_to_build_model)
    col1_present_df2 <- response_var %in% names(data_frame_to_apply_model)
    col2_present_df2 <- predictor_variable %in% names(data_frame_to_apply_model)

    if (!col1_present_df1) {
      cat("Column '", response_var, "' is not present in the first data frame.\n")
    }

    if (!col2_present_df1) {
      cat("Column '", predictor_variable, "' is not present in the first data frame.\n")
    }

    if (!col1_present_df2) {
      cat("Column '", response_var, "' is not present in the second data frame.\n")
    }

    if (!col2_present_df2) {
      cat("Column '", predictor_variable, "' is not present in the second data frame.\n")
    }

    return(col1_present_df1 && col2_present_df1 && col1_present_df2 && col2_present_df2)
  }

  #DEFINE function takes variables as input and creates formula that can be used to
  # https://stackoverflow.com/questions/55877110/pass-dynamically-variable-names-in-lm-formula-inside-a-function
  results_LM <- function(data_frame_to_build_model,response_var, predictor_variable) {
    fm <- as.formula(paste(response_var, "~", predictor_variable))
    lm(fm, data_frame_to_build_model)}

  #DEFINE function to plot regression model
  #https://sejohnston.com/2012/08/09/a-quick-and-easy-function-to-plot-lm-results-in-r/
  ggplotRegression <- function (fit) {
    # require(ggplot2)
    ggplot(fit$model, aes_string(x = names(fit$model)[2], y = names(fit$model)[1])) +
      geom_point() +
      stat_smooth(method = "lm", col = "dodgerblue") +
      labs(title = paste("Adj R2 = ",signif(summary(fit)$adj.r.squared, 5),
                         "Intercept =",signif(fit$coef[[1]],5 ),
                         " Slope =",signif(fit$coef[[2]], 5),
                         " P =",signif(summary(fit)$coef[2,4], 5)))+
      theme_classic()}

  #DEFINE function to regress variable
  create_predicted_variable <- function(data_frame_to_regress,response_var, predictor_variable, model_for_regressing) {
    new_variable_name <- paste0("predicted_", response_var,"from_",predictor_variable)
    data_frame_to_regress[[new_variable_name]] <- model_for_regressing$coefficients[1] +
      (model_for_regressing$coefficients[2] * data_frame_to_regress[[predictor_variable]])
    return(data_frame_to_regress)
  }


  #DEFINE function to normalise variable
  #requires response and predictor variable is in both dataframe
  create_normalised_variable <- function(data_frame_to_regress,response_var, predictor_variable, model_for_regressing) {
    new_variable_name <- paste0("normalised", response_var,"from_",predictor_variable)
    data_frame_to_regress[[new_variable_name]] <- data_frame_to_regress[[response_var]]-
      (model_for_regressing$coefficients[1] + (model_for_regressing$coefficients[2] * data_frame_to_regress[[predictor_variable]]))
    return(data_frame_to_regress)
  }

  ##CALLS to functions
  #1 call function to make model
  regression_model <- results_LM(data_frame_to_build_model, response_var, predictor_variable)

  #2 call regression plotting to make a plot
  ggR <- ggplotRegression(regression_model)
  print(ggR)

  #3 call to regress the variable
  regressed_data_frame_with_prediction <- create_predicted_variable(data_frame_to_apply_model,response_var,predictor_variable,regression_model)

  regressed_data_frame_with_pred_and_norm <- create_normalised_variable(regressed_data_frame_with_prediction,response_var,predictor_variable,regression_model)

  return(regressed_data_frame_with_pred_and_norm)
}
