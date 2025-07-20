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
mod_wzrost <- d %>%
  lm(waga ~ wzrost, data = .)
# ten sam efekt, bardziej tradycyjny zapis
mod_wzrost <- lm(waga ~ wzrost, data = d) # efekt ten sam

summary(mod_wzrost)