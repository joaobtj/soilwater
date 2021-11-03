
<!-- README.md is generated from README.Rmd. Please edit that file -->

# soilwater

<!-- badges: start -->
<!-- badges: end -->

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("joaobtj/soilwater")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(soilwater)
data0 <- tibble::tribble(
 ~month,     ~et0,   ~p,
 "Jan", 117,    275,
 "Feb", 102,    218,
 "Mar", 104,    180,
 "Apr",  79,     60,
 "May",  60,     25,
 "Jun",  49,     20,
 "Jul",  54,     15,
 "Aug",  74,   12,
 "Sep",  93,     48,
 "Oct", 107,    113,
 "Nov", 108,    180,
 "Dec", 117,    245)
 water_balance(data0, awc=125, start_month="Mar")
#> # A tibble: 12 x 10
#>    month   et0     p pmet0   nac     a     da   eta   def   exc
#>    <chr> <dbl> <dbl> <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl> <dbl>
#>  1 Mar     104   180    76     0 125     0    104    0      76 
#>  2 Apr      79    60   -19   -19 107.  -17.6   77.6  1.37    0 
#>  3 May      60    25   -35   -54  81.2 -26.2   51.2  8.78    0 
#>  4 Jun      49    20   -29   -83  64.3 -16.8   36.8 12.2     0 
#>  5 Jul      54    15   -39  -122  47.1 -17.2   32.2 21.8     0 
#>  6 Aug      74    12   -62  -184  28.7 -18.4   30.4 43.6     0 
#>  7 Sep      93    48   -45  -229  20.0  -8.67  56.7 36.3     0 
#>  8 Oct     107   113     6     0  26.0   6    107    0       0 
#>  9 Nov     108   180    72     0  98.0  72    108    0       0 
#> 10 Dec     117   245   128     0 125    27.0  117    0     101.
#> 11 Jan     117   275   158     0 125     0    117    0     158 
#> 12 Feb     102   218   116     0 125     0    102    0     116
```
