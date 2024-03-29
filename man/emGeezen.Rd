% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/emGeezen.R, R/emGeezenR.R
\name{emGeezen}
\alias{emGeezen}
\title{updated emGeezen to include ability to plot discrete variables}
\usage{
emGeezen(
  plate_data = NULL,
  variable_to_squiz = NULL,
  low_col = "darkblue",
  high_col = "hotpink",
  rowNames = "Row",
  colNames = "Column",
  summary = "mean",
  numRows = 8,
  numCols = 12
)

emGeezen(
  plate_data = NULL,
  variable_to_squiz = NULL,
  low_col = "darkblue",
  high_col = "hotpink",
  rowNames = "Row",
  colNames = "Column",
  summary = "mean",
  numRows = 8,
  numCols = 12
)
}
\arguments{
\item{plate_data}{dataframe to visualse.}

\item{variable_to_squiz}{Variable to visualise.}

\item{low_col}{Rcolors color or HEX code.}

\item{high_col}{Rcolors color or HEX code.}

\item{rowNames}{column with rownumbers.}

\item{colNames}{colNames}

\item{summary}{summary statistic to calculate}

\item{numRows}{Number of rows if not 8.}

\item{numCols}{Number of columns if not 12.}
}
\value{
A plot of summarised data

A plot of summarised data
}
\description{
updated emGeezen to include ability to plot discrete variables

Add together two numbers
}
