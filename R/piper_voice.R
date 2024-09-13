#' Load a Piper Voice
#'
#' @param model A .onnx model file, such as en_US-lessac-medium.onnx
#' @param config A .onnx.json config file, such as en_US-lessac-medium.onnx.json
#'
#' @return A `PiperVoice` object
#' @seealso [piper_voices] and also
#' \url{https://github.com/sweetbbak/Neural-Amy-TTS/tree/main/models}
#' @export
piper_voice = function(
    model,
    config
) {
  piper = pypiper(convert = FALSE)
  model = path.expand(model)
  config = path.expand(config)
  voice = piper$PiperVoice(session = model, config = config)
  voice = voice$load(model_path = voice$session, config_path = voice$config)
}

