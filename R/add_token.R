#' Set Lens Access Token
#'
#' This helper function allows you to set your API key in .Renviron file
#'
#' modified from \url{https://github.com/cwthom/TargomoR/blob/master/R/setup.R}
#'
#' @family token
#' @param token Your Lens.org API token
#' @param overwrite Whether to overwrite existing token
#' @return Invisibly, the API key
#'
#' @examples
#' \dontrun{
#' # write to a global file at Sys.getenv("HOME")
#' addtoken(token = "YOUR_LENS_TOKEN")
#' }
#'
#' @export
add_token <- function(token = NULL, overwrite = FALSE) {
  if (is.null(token)) token <- Sys.getenv("LENS_TOKEN")

  renv <- file.path(Sys.getenv("HOME"), ".Renviron")

  renv_exists <- file.exists(renv)

  if (!renv_exists) {
    message(
      "Creating .Renviron file at:\n",
      renv, "\n"
    )
    file.create(renv)
  }

  vars <- readLines(renv)
  prior <- grepl("^LENS_TOKEN=", vars)

  if (any(prior)) {
    if (overwrite) {
      vars <- vars[!prior]
    } else {
      message(
        "Pre-existing LENS_TOKEN in .Renviron.\n",
        "Set overwrite = TRUE to change."
      )
      return(invisible(NULL))
    }
  }

  vars <- c(
    vars,
    paste0("LENS_TOKEN=", token)
  )

  writeLines(vars, renv)
  message(
    "Writing LENS_TOKEN to .Renviron file:\n",
    renv, "\n\n",
    "Restart R for these environment variables to take effect."
  )

  return(invisible(token))
}
