#' Submit File
#'
#' Call this function as an addin to submit the active file to JAG.
#'
#' @export
submitFile <- function() {
  rs_result <- rstudioapi::getSourceEditorContext()
  rs_content <- rs_result$contents
  rs_content_str <- paste(rs_content, collapse='\n')
  rs_ident <- rstudioapi::userIdentity()
  req <- httr2::request("https://submit-test-uzg6ezfp6q-uc.a.run.app/")
  req <- req |> httr2::req_body_json(list(ident = rs_ident, content = rs_content_str))
  result <- req |> httr2::req_perform()
  result_str <- result |> httr2::resp_body_string()
  out_stream <- file("jag_result.html")
  writeLines(result_str, out_stream)
  close(out_stream)
  rstudioapi::viewer("jag_result.html")
}
