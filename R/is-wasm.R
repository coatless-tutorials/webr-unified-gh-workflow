#' Detect if version of R is built using Web Assembly (WASM)
#' 
#' The function checks whether the compiled version of _R_ shows an architecture
#' that matches `"wasm32"`. If its the case, we're likely using webR to access
#' R.
#' 
#' @examples
#' # Check to see if WASM is active
#' is_r_using_wasm()
is_r_using_wasm <- function() { R.Version()$arch == "wasm32"}
