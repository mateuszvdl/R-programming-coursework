# Zajecia 05 - testy t

# libraries
library(tidyverse)
library(skimr) # robi podsumowania
library(rstatix) # analizy statystyczne zgodne z tidyverse
library(datarium) # tu sa dane 
library(ggpubr) # ladne wykresy zgodne z publikacyjnymi standardami 

(.packages()) # wszystkie aktywne w danym momencie pakiety

# jezeli teraz uzyje funkcji filter, to ona bedzie z pakietu rstatix (bo jest ostatni wlaczony)

# taki zapis jak ponizej uruchamia konkretna funkcje z konkretnego pakietu
stats::filter()

# 1) wlaczamy dane z pakietu datarium
data("heartattack")

# 2) myslimy o testach t
# IV - zmienna niezalezna to poziom ryzyka (niskie vs wysokie)
# DV - zmienna zalezna to poziom cholesterolu
# dwie niezalezne grupy -> test t dla prob niezaleznych

# H0: NIE ma roznic w SREDNIM poziomie CHOLESTEROLU pomiedzy GRUPAMI RYZYKA (niskie vs wysokie).
# H0: JEST roznica w SREDNIM poziomie CHOLESTEROLU pomiedzy GRUPAMI RYZYKA (niskie vs wysokie).

# 3) Typowa kolejnosc: 
# A) patrzymy na dane
# B) decydujemy jaki test zastosowac
# C) liczymy statystyki opisowe 
# D) obliczamy test
# E) robimy wykresy

# Kiedy mozemy uzyc testow t - zalozenia testu t dla prob niezaleznych
# 1) zmienna zalezna ilosciowa
# 2) albo duze grupy, albo podobne co do wielkosci, co najmiej kilkanascie obserwacji na grupe
# 3) rozklad danych w kazdej grupie zblizony do rozkladu normalnego - patrzymy na wykresy
# 4) nie chcemy miec obserwacji wplywowych - patrzymy na wykresy

# Patrzymy na typy danych, patrzymy na liczebnosc grup itd.
skim(heartattack)

# Robimy sobie wykres
ggboxplot(heartattack, x = "risk", y = "cholesterol")

# czy sa przypadki ekstremalne
# czy rozklady w grupach sa mniej wiecej symetryczne / czy sa zblizone do rozkladu normalnego

# statystyki opisowe 
heartattack |>
  group_by(risk) |>
  get_summary_stats(cholesterol, type = "mean_sd")

# robimy test t
heartattack |>
  t_test(cholesterol ~risk)

# liczymy d Cohena - miare WIELKOSCI efektu
heartattack |>
  cohens_d(cholesterol ~risk)

# jak psychologowie podaja wartosci p?
# dokladna liczba do 3 miejsc po przecinku LUB (jezeli to prawda) p < 0.001

#Analiza testem t-studenta dla prob niezaleznych wykazala, ze osoby z grupy wysokiego ryzyka (N = 36, M = 5.46, SD = 0.42) maja istotnie wyzszy srednio poziom cholesterolu niz osoby z grupy niskiego ryzyka (N = 36, M = 4.80, SD = 0.308), t(63.8) = 7.55, p < 0.001, d Cohena = 1.78

