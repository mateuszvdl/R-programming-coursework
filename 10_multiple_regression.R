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
d |>
  group_by(plec) |>
  skim()

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
# ten sam efekt, bardziej tradycyjny zapis
reg_wzrost <- lm(waga ~ wzrost, data = d) # efekt ten sam

summary(reg_wzrost)

# ladniejsze podsumowanie

tab_model(reg_wzrost)
tab_model(reg_wzrost, show.stat = TRUE)

# rysowanie modelu

plot_model(reg_wzrost, type = "eff", terms = "wzrost")

# przewidujemy wage na podstawie wieku - DONE
# 1) czy ten model dziala? - patrzymy na F / istotnosc modelu - model JEST istotny
# 2) jak jest precyzyjny? - albo patrzymy na blad standardowy reszt albo na R^2 - model wyjasnia tylko 2 procent wariancji
# 3) jak wyglada rownanie regresji? - 69.41137 + wiek * 0.10513
# 4) jak wyglada wykres wynikow przewidywanych? - zrobilismy ladny obrazek 
# 5) ile wazy dr Bielecki (45 lat) zdaniem naszego modelu? - okolo 74,14222 kg
# 6) ktory model jest lepszy (dla wzrostu czy dla wieku)? - porownac mozemy R^2 albo reszty - reszty sa wieksze, % wyjasnionej wariancji - znacznie mniejszy. Model dla wzrostu lepszy

# model regresji dla wieku

reg_wiek <- d %>%
  lm(waga ~ wiek, data = .)

summary(reg_wiek)
tab_model(reg_wiek)
plot_model(reg_wiek, type = "eff", terms = "wiek")

# robimy model dla wzrostu i wieku jako predyktorow 

reg_wzrost_wiek <- d %>%
  lm(waga ~ wzrost + wiek, data = .)

summary(reg_wzrost_wiek)
tab_model(reg_wzrost_wiek)
plot_model(reg_wzrost_wiek, type = "eff", terms = "wzrost")
plot_model(reg_wzrost_wiek, type = "eff", terms = "wiek")

# 1) jak dobrze ten model dziala? czu jest lepszy od poprzednich? - R^2 jest wyzsze!
# 2) jakie jest rownanie regresji tym razem? - -106,78531 + wzrost * 1,00 + wiek * 0,25
# 3) jak interpretowac poszczegolne wspolczynniki? - 0.25227 oznacza ze PRZEWIDYWANA waga zmieni sie o 0.25 kg jezeli czyjs wiek rosnie o 1 POD WARUNKIEM ze wartosci pozostalych predyktorow pozostaja bez zmian
# 4) ktore predyktory w modelu sa istotne? - na przyklad istotnosc dla wieku (p < .001) interpretujemy tak:
# wiek jest istotnym predyktorem wagi po UWZGLEDNIENIU w modelu efektu wzrostu

# model regresji dla plci

reg_plec <- d %>%
  lm(waga ~ plec, data = .)

summary(reg_plec)
tab_model(reg_plec)
plot_model(reg_plec, type = "eff", terms = "plec")

# jakie jest rownanie regresji? - 81.6313 + -12.8421 * plec(???)

contrasts(d$plec)

# Jak interpretujemy wspolczynniki?

# Na wynos: zrobcie model dla plci i wzrostu i porownajcie go z modelami jednozmiennowymi (sama plec i sam wzrost)
# Jak zmienia sie R^2?
# jak interpretujemy wspolczynniki?