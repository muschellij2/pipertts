#' Install Piper Conda Environment
#'
#' @param envname The name of, or path to, a `conda` environment.
#' @param packages character vector of packages to install.  ``piper-tts"`
#' is automatically added to the vector, passed to [reticulate::py_install()]
#' @param ... additional arguments to pass to  [reticulate::conda_create()].
#'
#' @return Returns the path to the Python binary associated with the
#' newly-created `conda` environment.
#' @export
#'
#' @examples
#' \dontrun{
#'   if (!is_piper_installed()) {
#'     create_piper_condaenv()
#'   }
#' }
create_piper_condaenv = function(
    envname = "piper",
    packages = "piper-tts",
    ...) {

  reticulate::conda_create(
    envname = envname,
    packages = packages,
    ...,
  )
}
