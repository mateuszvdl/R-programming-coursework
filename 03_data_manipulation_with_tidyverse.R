# Zajęcia 3 - magia tidyverse

# import danych z dwoch plikow
library(readxl)
diagnoses <- read_excel("diagnoses.xlsx")
View(diagnoses)

library(readr)
ptsd <- read_delim("ptsd.csv", delim = ";", 
                   escape_double = FALSE, trim_ws = TRUE)
View(ptsd)

# robimy porzadek z nazwami zmiennych
library(janitor)
ptsd <- clean_names(ptsd)
diagnoses <- clean_names(diagnoses)

# upiekniamy nazwy w ramce diagnoses
names(diagnoses)[2:3] <- c("ptsd", "wiek")

# wlaczamy TIDYVERSE!
library(tidyverse)

# nasz pierwszy faktor, czyli zmienne nominalne w R-ze
diagnoses$ptsd <- factor(diagnoses$ptsd, labels = c("bez PTSD", "PTSD"))

# filter - filtrowanie wierszy

ptsd |>
  filter(session == 1, block != "TreningProc")

# select - wybieranie kolumn
ptsd |>
  filter(session == 1, block != "TreningProc") |>
  select(1, 3, 4, 5, 6) # kolumny wybieramy po numerach

ptsd |>
  filter(session == 1, block != "TreningProc") |>
  select(1, 3:6) # tak tez mozna

ptsd |>
  filter(session == 1, block != "TreningProc") |>
  select(-2) # tak tez

ptsd |>
  filter(session == 1, block != "TreningProc") |>
  select(subject, 3:6) # oraz tak

ptsd |>
  filter(session == 1, block != "TreningProc") |>
  select(contains("t")) # contains - zawiera cos

ptsd |>
  filter(session == 1, block != "TreningProc") |>
  select(starts_with("s")) # starts_with - zawiera cos

# mutate - tworzenie nowych zmiennych 
ptsd <- ptsd |>
  filter(session == 1, block != "TreningProc") |>
  select(1, 3:6) 

table(ptsd$block)
lab <- c("neg", "neu", "pos", "wyp")

ptsd <- ptsd |>
  mutate(block = factor(block, labels = lab))

# liczymy srednia poprawnosc dla kazdej osoby
acc <- ptsd |>
  group_by(subject) |> # grupujemy
  summarize(acc_m = mean(acc)) |> # podsumowujemy
  arrange(acc_m) # sortujemy
  