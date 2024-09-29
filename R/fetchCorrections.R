#' Fetch Assignment Corrections
#'
#' Call this function to fetch and display the latest assignment corrections.
#'
#' @param assignment_id Should match the beginning of the corrections .md filename on GitHub
#'
#' @export
fetchCorrections <- function(assignment_id) {
  libs <- c("httr2", "base64enc")
  invisible(lapply(libs, library, character.only = TRUE)) |> suppressPackageStartupMessages()
  exec_ts <- Sys.time() |> strftime(tz="America/New_York", usetz=TRUE)
  base_url <- "https://api.github.com/repos/jpowerj/dsan-content/contents/2024-fall-ppol6805/"
  gh_url <- paste0(base_url,assignment_id,"_Corrections.md?ref=main")
  resp_data <- httr2::request(gh_url) |> httr2::req_perform() |> httr2::resp_body_json()
  decoded_str <- base64enc::base64decode(resp_data$content) |> rawToChar()
  output_str <- paste0(decoded_str, "\n\n*Last fetched: ",exec_ts,"*")
  return(knitr::asis_output(output_str))
}
