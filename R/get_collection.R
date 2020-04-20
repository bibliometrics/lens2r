#' Get Collection Data from Lens
#'
#' @family Get Data
#' @import httr
#' @param collection_id Collection ID number in Lens.org
#' @param token Your Lens.org API token, add to .Renviron via add_token()
#'     function
#' @return Content from Lens Scholarly Data
#'
get_collection <- function(collection_id, token = NULL) {
  if (is.null(collection_id)) stop("A collection ID should be given")

  if (is.null(token)) token <- Sys.getenv("LENS_TOKEN")

  url <- "https://api.lens.org/collections/"

  headers <- c("Authorization" = token, "Content-Type" = "application/json")

  httr::POST(url = url,
             httr::add_headers(.headers = headers),
             body = collection_id)
}
