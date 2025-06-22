#' Fetch Assignment Corrections
#'
#' Call this function to fetch and display the latest assignment corrections.
#'
#' @param course_id Should match the subdirectory within GitHub (e.g., `"2025-sum-dsan5650"`)
#' @param assignment_id Should match the beginning of the corrections .md filename on GitHub
#'
#' @export
fetchCorrections <- function(course_id, assignment_id) {
  libs <- c("stringr", "httr2", "base64enc", "IRdisplay")
  invisible(lapply(libs, library, character.only = TRUE)) |> suppressPackageStartupMessages()
  exec_ts <- Sys.time() |> strftime("%c", tz="America/New_York", usetz=TRUE)
  base_url <- paste0("https://api.github.com/repos/jpowerj/dsan-content/contents/",course_id,"/")
  course_code <- toupper(stringr::str_split_1(course_id, "-")[3])
  assignment_suffix <- paste0(course_code,"_",assignment_id,"_Corrections.md?ref=main")
  gh_url <- paste0(base_url, assignment_suffix)
  resp_data <- httr2::request(gh_url) |> httr2::req_perform() |> httr2::resp_body_json()
  decoded_str <- base64enc::base64decode(resp_data$content) |> rawToChar()
  output_str <- paste0(decoded_str, "\n\n*Last fetched: ",exec_ts,"*")
  IRdisplay::display_markdown(output_str)
  #return(knitr::asis_output(output_str))
}
