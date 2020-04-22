#' Get Scholarly Data from Lens
#'
#' @family Get Data
#' @importFrom  httr POST
#' @importFrom  httr add_headers
#' @param query Your query
#' @param token Your Lens.org API token, add to .Renviron via add_token()
#'      function
#' @return Content from Lens Collection
#'
#'
#'@export
get_scholarly_data <- function(query, token = NULL) {
  if (is.null(token)) token <- Sys.getenv("LENS_TOKEN")

  url <- "https://api.lens.org/scholarly/search"

  headers <- c("Authorization" = token, "Content-Type" = "application/json")

  httr::POST(url = url, httr::add_headers(.headers = headers), body = query)
}
