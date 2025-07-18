## Skrypt - zajęcia 06 cz. 2 | korelacje

library(skimr)
library(janitor)
library(PerformanceAnalytics)
library(tidyverse)
library(rstatix)

# otwieramy dane i nazywamy je "o"
library(readr)
o <- read_csv("osobowosc.csv")
# Czyścimy nazwy zmiennych za pomocą clean_names
o <- clean_names(o)

# przeglądamy dane
skim(o)

# wybieramy z danych kolumny dot wyników BIG 5 i nazywamy ramkę "s"
s <- o |>
  select(4:8)

# zapisujemy ramkę jako obiekt .Rdat
save(s, file = "s.Rdat") # zapisujemy dane do natywnego formatu R-a

# usuwamy obiekt s z environment
rm(s)

# ponownie ładujemy dane z pliku do environment
load("s.Rdat")

# rysujemy wszyskto
chart.Correlation(s)

# opis statystyczny dla wszystkich zmiennych
s |>
  get_summary_stats()

s |>
  get_summary_stats(type = "mean_sd")

# macierz korelacji
# H0: Nie ma istotnej korelacji LINIOWEJ miedzy poziomem ekstrawersji i stabilnosci emocjonalnej
# H1: Jest istotna korelacja LINIOWA miedzy poziomem ekstrawersji i stabilnosci emocjonalnej (r Pearsona)

# macierz korelacji + gwiazdki
s|>
  cor_mat() |>
  cor_mark_significant()

# korelacje parami - zapisujemy do ramki danych
tab_korelacji <- s |>
  cor_test()

# eksportujemy do Excela
library(xlsx)
# Ten pakiet korzysta z Javy - musi byc odpowiednia wersja zainstalowana (32 vs 64)
# Sa tez pakiety niewymagajace Javy

write.xlsx(
  tab_korelacji,
  file = "tabelka_korelacji.xlsx",
  sheetName = "korelacja")
  
# raportowanie
# Analiza wykazala istotna dodatnia korelacje liniowa ekstrawersji i stabilnosci emocjonalnej, r(2300) = 0,37, p < 0.001.
# Stopnie swobody wpisujemy w nawiasie - jest to liczba analizowanych case'ow - 2

# korelacje nieparametryczne
s %>%
  cor_test(use = "complete", method = "spearman")
