#' Install piper
#'
#' @param packages character vector of packages to install. `"piper-tts"`
#' is automatically added to the vector, passed to [reticulate::py_install()]
#' @param pip Boolean; use pip for package installation?
#' Passed to [reticulate::py_install()]
#' @param ... additional arguments to pass to  [reticulate::py_install()].
#'
#' @return Nothing (`invisible(NULL)`).  Command is called for side effects
#' @export
#'
#' @examples
#' \dontrun{
#'   if (!is_piper_installed()) {
#'     install_piper()
#'   }
#' }
install_piper = function(
    packages = NULL,
    pip = TRUE,
    ...) {
  packages = unique(c(packages, "piper-tts"))
  reticulate::py_install(
    packages = packages,
    pip = pip,
    ...
  )
}

#' @export
#' @rdname install_piper
is_piper_installed = function() {
  reticulate::py_module_available("piper-tts")
}


