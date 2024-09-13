## code to prepare `piper_voices` dataset goes here
library(dplyr)
library(tidyr)
url = "https://raw.githubusercontent.com/rhasspy/piper/master/VOICES.md"
res = readLines(url)
res = res[!trimws(res) %in% ""]
res = res[!grepl("^#", res)]

df = tibble(
  x = res
)
df = df %>%
  mutate(
    is_lanugage = grepl("^[*]", x),
    is_voice = grepl("^    [*]", x),
    is_quality = grepl("^      \\s*[*]", x),
    is_something = is_lanugage + is_voice + is_quality
  )
stopifnot(all(df$is_something == 1))
df = df %>%
  select(-is_something)
df = df %>%
  mutate(
    orig_x = x,
    x = sub("^[*]", "", trimws(x)),
    x = trimws(x),
    language = ifelse(is_lanugage, x, NA_character_),
    voice = ifelse(is_voice, x, NA_character_),
    quality = ifelse(is_quality, x, NA_character_),
  )
df = df %>%
  tidyr::fill(c(language, voice, quality), .direction = "down")

df = df %>%
  select(language, quality, voice) %>%
  filter(!is.na(quality))
df = df %>%
  mutate(
    name_quality = trimws(sub(" -.*", "", quality)),
    quality = trimws(sub(".* -", "", quality)),
  )
ss = strsplit(df$quality, "]", fixed = TRUE)
ss = lapply(ss, trimws)
ss = lapply(ss, function(x) sub("\\[\\[", "", x))
ss = sapply(ss, function(x) gsub("\\(|\\)", "", x))
stopifnot(all(ss[1,] == "model"))
stopifnot(all(ss[3,] == "config"))

df$url_model = ss[2,]
df$url_config = ss[4,]
df = df %>%
  select(-quality) %>%
  rename(quality = name_quality)
df = df %>%
  mutate(
    code_language = sub(".*`(.*)`.*", "\\1", language)
    )
df = df %>%
  mutate(
    code_language = sub(".*\\(", "", code_language),
    code_language = sub("\\).*", "", code_language)
  )
df = df %>%
  select(code_language, language, voice, quality, url_model, url_config)
piper_voices = df


usethis::use_data(piper_voices, overwrite = TRUE)
