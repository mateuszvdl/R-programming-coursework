### Lab 10 - Regresja ###

# Włączamy pakiety
library(PogromcyDanych)
library(sjPlot)
library(ggfortify)
library(skimr)
library(broom)

# wybieramy i cywilizujemy dane
# Co robia kolejne polecenia?

d <- diagnoza %>% select(wiek = wiek2013,
                         edu = eduk4_2013,
                         plec = plec,
                         wzrost = gp60,
                         waga = gp61) %>%
  slice(1:2000) %>%
  na.omit()

# paczamy na dane
skim(d)

# wykres z trendem
d %>%
  ggplot( aes(x = wzrost, y = waga )) +
  geom_point(alpha = .1) +
  geom_smooth()

# Zamieniamy na trend liniowy
d %>%
  ggplot( aes(x = wzrost, y = waga )) +
  geom_point(alpha = .1) +
  geom_smooth(method = "lm")

# Filtrujemy tylko wzrost powyżej 140 cm i zapisujemy to jako d
d <- d %>%
  filter(wzrost > 140)

# Startujemy z regresją
reg_wzrost <- d %>%
  lm(waga ~ wzrost, data = .)
# Patrzymy na podsumowanie modelu
summary(reg_wzrost)

# ładniejsze podsumowanie
tab_model(reg_wzrost)
tab_model(reg_wzrost, show.stat = TRUE)

# rysowanie modelu
plot_model(reg_wzrost, type = "eff", terms = "wzrost")

# Model regresji dla wieku

reg_wiek <- d %>%
  lm(waga ~ wiek, data = .)
# Patrzymy na podsumowanie modelu
summary(reg_wiek)

# ładniejsze podsumowanie
tab_model(reg_wiek)

# rysowanie modelu
plot_model(reg_wiek, type = "eff", terms = "wiek")


# Przewidujemy wagę na podstawie wieku
# 1) Czy ten model działa? -> patrzymy na F / istotność modelu - model JEST istotny, czyli "działa"
# 2) jak jest precyzyjny? -> albo patrzymy na błąd standardowy reszt albo na R2 -> model wyjaśnia tylko 2% wariancji, czyli niezbyt dużą proporcję wariancji. Błąd reszt też jest duży - średnio mylimy się o DUŻĄ wartość przewidując na podstawie modelu.
# 3) jak wygląda równanie regresji? -> 69.41137 + wiek * 0.10513 
# 4) jak wygląda wykres wyników przewidywanych? -> zrobiliśmy ładny obrazek
# 5) ile waży dr Bielecki (45 lat) zdaniem naszego modelu?
# 69.41137 + 45 * 0.10513  = 74.14222
# Czemu tak mało? Bo model uwzględnia TYLKO wiek, czyli nie "wie", jakiego jestem wzrostu, płci etc.
# 6) który model jest lepszy (dla wzrostu czy dla wieku) 
# Porównać możemy R2 albo reszty - reszty są większe, % wyjaśnionej wariancji - znacznie mniejszy dla wieku, czyli model dla wzrostu jest LEPSZY.


# Robimy model dla wzrostu i wieku jako predyktorów

reg_ww <- d %>%
  lm(waga ~ wzrost + wiek, data = .)
# Patrzymy na podsumowanie modelu
summary(reg_ww)

# ładniejsze podsumowanie
tab_model(reg_ww)

# rysowanie modelu
plot_model(reg_ww, type = "eff", terms = "wzrost")
plot_model(reg_ww, type = "eff", terms = "wiek")

# 1) jak dobrze ten model działa? czy jest lepszy od poprzednich? -> R2 jest wyższe! 
# 2) jakie jest równanie regresji tym razem?
# -106.79 + wzrost * 1.00 + wiek * 0.25
# 3) jak interpretować poszczególne współczynniki?
# współczynnik 0.25227 oznacza że PRZEWIDYWANA waga zmieni się o 0.25kg jeżeli czyjśc wiek rośnie o 1 
# POD WARUNKIEM, że wartości pozostałych predyktorów pozostają bez zmian
# 4) które predyktory w modelu są istotne?
# # np. istotność dla wieku (p < .001) interpretujemy tak:
# Wiek jest istotnym predyktorem wagi PO UWZGLĘDNIENIU w modelu efektu wzrostu

# Model dla płci

# Model regresji dla wieku i wzrostu
reg_plec <- d %>%
  lm(waga ~ plec, data = .)
# Patrzymy na podsumowanie modelu
summary(reg_plec)

# ładniejsze podsumowanie
tab_model(reg_plec)

# rysowanie modelu
plot_model(reg_plec, type = "eff", terms = "plec")

# Jakie jest równanie regresji:
# 81.6313 + -12.8421 * plec(???)

contrasts(d$plec)

# Jak interpretujemy współczynniki?
# Po pierwsze, płeć kodowana jest jak widać wg. schematu M = 0, K = 1
# A zatem efekt "plec / kobieta" oznacza, że kiedy zmienna płeć "rośnie o jeden" 
# (tak naprawdę - "przenosimy się" z kategorii mężczyzna do kategorii kobieta), 
# to przewidywana średnia waga spada o 8 kg.


# Na wynos: zróbcie model dla płci i wzrostu i porównajcie go z modelami
# jednozmiennowymi (sama płeć i sam wzrost)
# Jak zmienia się R2?
# Jak interpretujemy współczynniki?

# zalozenia regresji:
# Te zalozenia mozna sprawdzic PRZED ana;oza
# 1) zmienna zalezna jest ilosciowa (zmienna przedzialowa lub ilorazowa)
# 2) predyktory - ilosciowe albo nominalne (ale wtedy sa przekodowywane np. 0/1)
# 3) wymagania dotyczace liczebnosci proby - jedna z czesto stosowanych regul - nie mniej niz 15/20 obserwacji na predyktor
# 4) niezaleznosc obserwacji

# zalozenia weryfikowane sa na podstawie wykresow (dla KONKRETNEGO policzonego modelu)
# 5) zalozenie o homoskedastycznosci wariancji reszt - jezeli jest zlamane, to mamy klopot z wartosciami p. Co zrobic? Sa metody analizy regresji, ktore sa heteroscedasticisy consistent (wykres nr 1)
# 6) normalnosc rozkladu reszt - patrzymy na ksztalt rozkladu gestosci(wykres nr 2)
# 7) wspolliniowosc predyktorow (wobec siebie) nie powinna byc za wysoka
# zalozenie o LINIOWOSCI zaleznosci predyktorow - 

# Weryfikacja zalozen regresji
plot_model(reg_ww, type ="diag") # ladne wykresy
plot(reg_ww) # "base" R
