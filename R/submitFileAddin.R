#' Submit File
#'
#' Call this function as an addin to submit the active file to JAG.
#'
#' @export
submitFile <- function() {
  # Using rstudio api
  rs_result <- rstudioapi::getSourceEditorContext()

  # Get the content of the editor pane
  rs_content <- rs_result$contents
  # And collapse into a single string
  rs_content_str <- paste(rs_content, collapse='\n')
  # User identity
  rs_ident <- rstudioapi::userIdentity()
  # System username
  rs_user <- rstudioapi::systemUsername()

  # As a "backup", we also use env vars
  rs_ident_env <- Sys.getenv("RSTUDIO_USER_IDENTITY_DISPLAY")
  rs_user_env <- Sys.getenv("USER")

  # Send to grading server
  req <- httr2::request("https://submit-test-uzg6ezfp6q-uc.a.run.app/")
  req <- req |> httr2::req_body_json(list(
    ident = rs_ident,
    user = rs_user,
    ident_env = rs_ident_env,
    user_env = rs_user_env,
    content = rs_content_str
  ))
  result <- req |> httr2::req_perform()
  result_str <- result |> httr2::resp_body_string()
  out_stream <- file("jag_result.html")
  writeLines(result_str, out_stream)
  close(out_stream)
  rstudioapi::viewer("jag_result.html")
}
