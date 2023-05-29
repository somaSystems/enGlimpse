README
================
LGD
20/05/2023

-   [Installation](#installation)
-   [Demonstration data](#demonstration-data)
-   [glancer](#glancer)
-   [squiz](#squiz)

enGlimpse is a package of tools for **glimpsing** the
output of plate based biology experiments. The two main functions are
**glancer** and **squiz** which both visualise experiment results
in a plate format. The functions have different flavours, and
**glancer** is recommended.

## Installation

``` r
#install devtools if needed
if(!require("devtools")) install.packages("devtools")
#load devtools
library(devtools)

#install lifeTimes from github
install_github("somaSystems/enGlimpse")
```

## Demonstration data

``` r
#demonstration data in the format of a 96 well plate

set.seed(1)
df_to_glimpse <- data.frame(
  Row = rep(c(1:8), times = 12), #Rows as numbers
  Column = rep(c(1:12), each = 8), #Columns as numbers 
  exp_value = runif(96,-10,10)) #Measured variables
```

## glancer

``` r
library(enGlimpse)
glancer(df_to_glimpse, variable_to_squiz ="exp_value" )
```

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

## squiz

``` r
squiz(df_to_glimpse, picked_variable = "exp_value")
```

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->
