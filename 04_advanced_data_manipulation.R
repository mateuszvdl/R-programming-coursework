# Zajęcia 3 - piękno tidyverse

# import danych
library(readxl)
diagnoses <- read_excel("diagnoses.xlsx")
View(diagnoses)

library(readr)
ptsd <- read_delim("ptsd.csv", delim = ";", 
                   escape_double = FALSE, trim_ws = TRUE)
View(ptsd)

# porządki w nazwach zmiennych
library(janitor)

ptsd <- clean_names(ptsd)
diagnoses <- clean_names(diagnoses)

names(diagnoses)[2:3] <- c("ptsd", "wiek")

# Factors, czyli zmienne nominalne w R-ze
diagnoses$ptsd <- factor( diagnoses$ptsd, labels = c("bez PTSD", "PTSD") )


# FILTER - wyberanie wierszy
library(tidyverse)

# filtrowanie wg. dwóch warunków
ptsd |>
  filter(session == 1, block != "TreningProc")

# SELECT - wybieranie kolumn
ptsd |>
  filter(session == 1, block != "TreningProc") |>
  select(1, 3, 4, 5, 6)

ptsd |>
  filter(session == 1, block != "TreningProc") |>
  select(1, 3:6)

ptsd |>
  filter(session == 1, block != "TreningProc") |>
  select(-2)

ptsd |>
  filter(session == 1, block != "TreningProc") |>
  select(subject, 3:6)

ptsd |>
  filter(session == 1, block != "TreningProc") |>
  select( starts_with("s") )

ptsd |>
  filter(session == 1, block != "TreningProc") |>
  select( contains("a") )

# MUTATE - modyfikacja / dodawanie zmiennych
ready <- ptsd |>
  filter(session == 1, block != "TreningProc") |>
  select(-2)

table(ready$block)

nazwy <- c("neg", "neu", "pos", "wyp")

ready <- ready |>
  mutate( block = factor(block, labels = nazwy) )

# Liczymy średnią poprawność wykonania zadania "po osobach" 

acc <- ready |>
  group_by(subject) |>
  summarise( acc_m = mean(acc) ) |>
  arrange(acc_m)

# Zajecia nr 4 - cd. tidyverse

# Liczymy sredni czas POPRAWNYCH reakcji dla kazdej osoby i warunku
rt_long <- ready |>
  filter(acc == 1) |>
  group_by(subject, block) |>
  summarize(rt_m = mean(rt))

# zmieniamy dane dlugie na dane szerokie, czyli PIVOT WIDER
# nazwy kolumn z kolumny block, wartosci z kolumny rt_m
# do nazwy dodajemy prefix rt_

rt_wide <- rt_long |>
  pivot_wider(names_from = block,
              values_from = rt_m,
              names_prefix = "rt_")

# zamieniamy dane szerokie z powrotem w dane dlugie
rt_long2 <- rt_wide |>
  pivot_longer(cols = 2:5,
               names_to = "block",
               values_to = "rt_m")

# Laczenie ramek danych
dane_full <- full_join(diagnoses, rt_wide)
dane_kompletne <- inner_join(diagnoses, rt_wide)

# Przykazania Bieleckiego dot. statystyki
# 1) Wyniki opisujemy ZDANIAMI. Zdania przekazuja sens wynikow - liczby sa dodatkiem
# 2) Hipotezy statystyczne i testowanie istotnosci dotyczy POPULACJI
# 3) Nalezy zawsze umiec podac KONKRETNE brzmienie hipotezy zerowej i alternatywnej 
# 4) Co robic z liczbami w opisach wynikow
# a) "Srednia poprawnosc na tescie wynosila 22,5%"
# b) "Test okazal sie byc bardzo trudny dla uczestnikow (M = 22,5% dla poprawnosci wynikow) w najblizszym czasie planujemy poprawe."
# c) "Poprawnosc na tescie byla bardzo niska; M = 22,5%"


# Co chcemy zrobic - sprawdzic, czy osoby z PTSD istotnie roznia sie srednimi czasami rekacji w probach "wypadkowych" od osob bez PTSD?"

# H0: Nie ma roznicy w srednim czasie reakcji na material wypadkowy miedzy osobami z PTSD i bez.
# H1: Jest roznica w srednim czasie reakcji na material wypadkowy miedzy osobami z PTSD i bez.

# Zmienna zalezna: czas reakcji na zdjecia "wypadkowe"
# Zmienna niezalezna: wystepowanie lub brak PTSD

# robimy test t
t.test(rt_wyp ~ ptsd, data = dane_kompletne)
