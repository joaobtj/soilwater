#' Water Balance
#'
#' @param data0 A data.frame with three columns: month, evapotranspiration (et0) and precipitation (p)
#' @param awc Available water capacity
#' @param start_month Month of beginning of the water balance
#'
#' @importFrom dplyr mutate
#' @importFrom magrittr %>%
#'
#' @export
#'
#' @examples
#' \dontrun{
#' data0 <- tibble::tribble(
#' ~month,	 ~et0,   ~p,
#' "Jan",	117,	275,
#' "Feb",	102,	218,
#' "Mar",	104,	180,
#' "Apr",	 79,	 60,
#' "May",	 60,	 25,
#' "Jun",	 49,	 20,
#' "Jul",	 54,	 15,
#' "Aug",	 74,   12,
#' "Sep",	 93,	 48,
#' "Oct",	107,	113,
#' "Nov",	108,	180,
#' "Dec",	117,	245)
#' water_balance(data0, awc=125, start_month="Mar")
#' }
water_balance <- function(data0, awc, start_month){

# awc=125
# start_month <- "Mar"

x <- which(data0$month==start_month)

order_month <- data0$month[c(x:12, 1:(x-1))]

data <- data0[match(order_month, data0$month), ]

data <-  data %>% mutate(pmet0 = p - et0,
                         nac=0,
                         a=awc,
                         da=0,
                         eta=0,
                         def=0,
                         exc=0)

for (i in 2:12) {
  data$nac[i] <- with(data,
                      ifelse(pmet0[i] < 0,
                             nac[i - 1] + pmet0[i],
                             awc * log(a[i] / awc)))
  data$a[i] <- with(data,
                    ifelse(pmet0[i]<0,
                           awc*exp(-abs(nac[i]/awc)),
                    a[i-1]+pmet0[i]))


}

data$a <- ifelse(data$a>awc, awc, data$a)


for (i in 2:12)  { data$da[i] <- data$a[i]-data$a[i-1]}


for (i in 1:12){ data$eta[i] <- with(data,
                                     ifelse(pmet0[i]<0,
                                            p[i]+abs(da[i]),
                                            et0[i]))
}

data$def <- data$et0-data$eta


for (i in 1:12){
  data$exc[i] <- with(data,
                   ifelse(a[i]<awc,
                          0,
                          pmet0[i]-da[i]))
}

return(data)
}

