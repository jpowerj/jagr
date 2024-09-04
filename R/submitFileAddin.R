#' Submit File
#'
#' Call this function as an addin to submit the active file to JAG.
#'
#' @export
submitFile <- function() {
  rs_doc_context <- rstudioapi::getActiveDocumentContext()
  rs_contents <- rs_doc_context$contents
  print(head(rs_contents))
  rs_identity <- rstudioapi::userIdentity()
  rstudioapi::insertText(rs_identity)
}
