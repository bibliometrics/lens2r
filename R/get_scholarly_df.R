#' Get Scholarly Data from Lens
#'
#' @family Get Data
#' @importFrom  httr POST
#' @importFrom  httr add_headers
#' @importFrom jsonlite fromJSON
#' @param query Your query
#' @param token Your Lens.org API token, add to .Renviron via add_token()
#'      function
#' @param output select df (dataframe) of json, default is df
#' @return Content from Lens Collection as dataframe or json
#'
#'
#'@export
get_scholarly_df <- function(query, token = NULL, output = "df") {
  if (is.null(token)) token <- Sys.getenv("LENS_TOKEN")

  url <- "https://api.lens.org/scholarly/search"

  headers <- c("Authorization" = token, "Content-Type" = "application/json")

  cont <- httr::POST(url = url, httr::add_headers(.headers = headers), body = query)

  cont <- httr::content(cont, "text")

  if (output == "df") {

    mydata <- jsonlite::fromJSON(cont, flatten = TRUE)

    mydata <- mydata$data

    return(mydata)

  } else if (output == "json") {

    return(cont)

  }

}
