#' Download Piper Voice
#'
#' @param voice name of the voice from [piper_voices]
#' @param quality quality of the voice model.  Must be specified if
#' multiple qualities are in [piper_voices]
#' @param model Path to download the model `.onnx` file
#' @param config Path to download the config `.json` file
#'
#' @return A list of the model and config paths
#' @export
#'
#' @examples
#' model = tempfile(fileext = ".onnx")
#' config = tempfile(fileext = ".json")
#' if (curl::has_internet()) {
#'   res = piper_download_voice(voice = "ljspeech", quality = "high",
#'                              model = model, config = config)
#' }
piper_download_voice = function(
    voice,
    model,
    config,
    quality = NULL
) {
  df = piper_voices[piper_voices$voice %in% voice,]
  if (nrow(df) == 0) {
    stop("No voice was found, please search through piper_voices")
  }
  if (nrow(df) > 1 & is.null(quality)) {
    stop(
      paste0(
        "Multiple quality of voice has been found:",
        paste(df$quality, collapse= ", "),
        ".  You must specify quality:")
    )
  }
  if (!is.null(quality)) {
    df = df[df$quality == quality,]
    if (nrow(df) == 0) {
      stop("No quality matched the quality given")
    }
  }
  stopifnot(nrow(df) == 1)
  curl::curl_download(df$url_model, destfile = model)
  curl::curl_download(df$url_config, destfile = config)
  list(
    model = model,
    config = config
  )
}
