#' Get Collection Data from Lens
#'
#' @family Get Data
#' @importFrom  httr GET
#' @importFrom  httr add_headers
#' @param collection_id Collection ID number in Lens.org
#' @param token Your Lens.org API token, add to .Renviron via add_token()
#'     function
#' @return Content from Lens Scholarly Data
#'
#'
#'@export
get_collection <- function(collection_id, token = NULL) {

  if (is.null(collection_id)) stop("A collection ID should be given")

  if (is.null(token)) token <- Sys.getenv("LENS_TOKEN")

  url <- paste0("https://api.lens.org/collections/", collection_id)

  headers <- c("Authorization" = token, "Content-Type" = "application/json")

  httr::GET(url = url,
             httr::add_headers(.headers = headers)
             )
}
