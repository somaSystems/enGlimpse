% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/enGlimpse.R
\name{enGlimpse}
\alias{enGlimpse}
\title{Add together two numbers}
\usage{
enGlimpse(
  picked_dataframe,
  picked_rownames = "Row",
  picked_colnames = "Column",
  nRows = 8,
  nCols = 12,
  picked_variable = NULL,
  picked_summary = c("mean"),
  hue_low = "navyblue",
  hue_high = "darkorange",
  hue_breaks = 256
)
}
\arguments{
\item{picked_dataframe}{dataframe to visualse.}

\item{picked_rownames}{column with rownumbers.}

\item{nRows}{Number of rows if not 8.}

\item{nCols}{Number of columns if not 12.}

\item{picked_variable}{Variable to visualise.}

\item{hue_low}{Rcolors color or HEX code.}

\item{hue_high}{Rcolors color or HEX code.}

\item{hue_breaks}{a number (defaults 256).}
}
\value{
A plot of summarised data
}
\description{
Add together two numbers
}