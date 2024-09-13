#' Synthesize Text from Piper Voice
#'
#' @param voice A voice object form [piper_voice]
#' @param text Text to by synthesized
#' @param wav_file output file for the wav file
#' @param speaker_id integer of the speaker ID
#' @param length_scale  speaking speed (default: 1.0)
#' @param noise_scale noise added to the generator (default: 0.667)
#' @param noise_w phoneme width noise (default: 0.8)
#' @param sentence_silence number of seconds of silence after each sentence
#' (default: 0.2)
#'
#' @return A path to a wave file
#' @export
#'
#' @examples
#' if (is_piper_installed()) {
#'
#' }
piper_synthesize = function(
    voice,
    text,
    wav_file = NULL,
    speaker_id = NULL,
    length_scale = NULL,
    noise_scale = NULL,
    noise_w = NULL,
    sentence_silence = 0
) {
  if (is.null(wav_file)) {
    wav_file = tempfile(fileext = ".wav")
  }
  if (!is.null(speaker_id)) {
    speaker_id = as.integer(speaker_id)
  }
  assertthat::assert_that(
    assertthat::is.count(speaker_id) | is.null(speaker_id),
    assertthat::is.number(noise_w) | is.null(noise_w),
    assertthat::is.number(length_scale) | is.null(length_scale) ,
    assertthat::is.number(noise_scale) | is.null(noise_scale) ,
    assertthat::is.number(sentence_silence)
  )
  sentence_silence = as.numeric(sentence_silence)

  pywave = reticulate::import("wave", convert = FALSE)
  wave_file_obj = pywave$Wave_write(f = wav_file)

  text = paste(text, collapse = "\n")
  res = voice$synthesize(
    text = text,
    wav_file = wave_file_obj,
    speaker_id = speaker_id,
    length_scale = length_scale,
    noise_scale = noise_scale,
    noise_w = noise_w,
    sentence_silence = sentence_silence
  )
  return(wav_file)
}


# https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_US/lessac/high/en_US-lessac-high.onnx?download=true
