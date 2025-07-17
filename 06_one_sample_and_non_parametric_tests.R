### Tydzień 06 - część 1.

### 06 - Wilcox test | test t dla jednej próby | korelacje

# libraries

library(tidyverse)
library(ggpubr)
library(rstatix)
library(datarium)
library(skimr)

# 1) Importujemy dane z pliku i nazywamy je "d". Uwaga na braki danych!

library(readxl)
d <- read_excel("dane_06.xlsx")

# 2) Przeprowadzamy analizę testem t dla JEDNEJ PRÓBY i sprawdzamy, czy
# wyniki testu w naszej grupie istotnie różnią się od średniej wartości w populacji
# wynoszącej 55 Raportujemy wyniki razem z odpowiednimi statystykami opisowymi

# Robimy wykres i piszemy tytuł

ggboxplot(d, y = "test")
gghistogram(d, x = "test")

# Liczymy statystyki opisowe

d |>
  get_summary_stats(test, type = "mean_sd")

# H0: NIE ma istotnej roznicy miedzy srednim wynikiem testu w badanej grupie a srednia w populacji wynoszaca 55.
# H1: WYSTEPUJE istotna roznica miedzy srednim wynikiem testu w badanej grupie a srednia w populacji wynoszaca 55.

# Liczymy test i wielkość siły efektu
d |>
  t_test(test ~ 1, mu = 55)

d |>
  cohens_d(test ~ 1, mu = 55)

# Piszemy opis wyników
# Analiza testem t dla jednej proby nie wykazala istotnej roznicy miedzy srednim wynikiem testu w badanej grupie (N = 130, M = 55.8, SD = 14.5) a srednim wynikiem testu w populacji wynoszacy, 55, t(129) = 0.603, p = 0.548, d = 0.05

# 2) przekształcamy dane tak, żeby porównać testem nieparametrycznym 
# warunki łatwy i trudny pod względem czasów reakcji.

# Wybieramy zmienne, wyrzucamy braki danych i przekształcamy dane do formatu długiego i

l <- d |>
  select(nr, latwe, trudne) |>
  na.omit() |>
  pivot_longer(cols = c(latwe, trudne),
               names_to = "warunek",
               values_to = "rt")

# Liczymy statystyki opisowe

l |>
  group_by(warunek) |>
  get_summary_stats(rt, type = "median_iqr")

ggboxplot(l, x = "warunek", y = "rt")

# Liczymy test i wielkość siły efektu

# H0: NIE ma istotnej roznicy miedzy MEDIANA czasu reakcji miedzy WARUNKIEM latwym i trudnym

l |>
  rstatix::wilcox_test(rt ~ warunek, paired = TRUE)

l |>
  wilcox_effsize(rt ~ warunek, paired = TRUE)

# Robimy wykres i piszemy tytuł


# Piszemy opis wyników

# Test Wilcoxona dla prob zaleznych wykazal, ze mediana czasow reakcji w warunkach trundych (N = 172, Med = 1020, IQR = 177) jest istotnie dluzsza niz w warunkach latwych (Med = 900, IQR = 129), W = 7, p < 0.001. r = 0.87
