
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pipertts

<!-- badges: start -->

[![R-CMD-check](https://github.com/muschellij2/pipertts/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/muschellij2/pipertts/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of `pipertts` is to wrap the
[piper](https://github.com/rhasspy/piper) Python module for translation
of text to other languages.

# Package Installation

You can install the development version of `pipertts` like so:

``` r
remotes::install_github("muschellij2/pipertts")
```

To install `TTS`, you can either run `install_piper`, which calls
`reticulate::py_install()`, If you already have a `conda` environment
enacted, use `reticulate::py_install` or simply `install_piper`:

``` r
library(pipertts)
install_piper()
```

Or you can run `create_piper_condaenv()`, which calls
`reticulate::conda_create()` and creates a `conda` environment for
`piper`, named `piper`.

``` r
create_piper_condaenv()
```

If you use this method, you should run
`reticulate::use_condaenv("piper")` before enabling Python.

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(pipertts)
model = tempfile(fileext = ".onnx")
config = tempfile(fileext = ".json")
res = piper_download_voice(voice = "ljspeech", quality = "high",
                           model = model, config = config)
voice = piper_voice(model = res$model, config = res$config)
text = c(
  "Who knows what it's like to be a human?  ", 
  "Definitely not me.  I'm a computer.  ", 
  "Just a silly computer, but I'm learning.  And when I learn, whew, watch out."
)
output = piper_synthesize(voice, text = text)
output
#> [1] "/var/folders/1s/wrtqcpxn685_zk570bnx9_rr0000gr/T//RtmpGfpq07/file1367625970c92.wav"
```

``` r
system2("play", output)
```
