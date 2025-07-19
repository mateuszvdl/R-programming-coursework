# skrypt 08 - GGPLOT

library(PogromcyDanych)
library(rstatix)

head(koty_ptaki)

#najprostszy wykres rozrzutu
plot(koty_ptaki$waga, koty_ptaki$predkosc)

# ten sam wykres, ale w ggplot
koty_ptaki |>
  ggplot(aes(x = waga, y = predkosc, color = druzyna)) +
  geom_point() +
  xlab("Waga [kg]") +
  ylab("Prędkość [km/h]") +
  ggtitle("Oh my, ale pięknie!")

# dodajemy kolor
koty_ptaki |>
  ggplot(aes(x = waga, y = predkosc, color = druzyna)) +
  geom_point() +
  xlab("Waga [kg]") +
  ylab("Prędkość [km/h]") +
  ggtitle("Oh my, ale pięknie!")

# wykresy w ggplot sa obiektami
fig1 <- koty_ptaki |>
  ggplot(aes(x = waga, y = predkosc, color = druzyna))
fig1
fig1 + geom_point()

# dodajemy kolor i ksztalt
koty_ptaki |>
  ggplot(aes(x = waga, y = predkosc, color = druzyna, shape = druzyna)) +
  geom_point() +
  xlab("Waga [kg]") +
  ylab("Prędkość [km/h]") +
  ggtitle("Oh my, ale pięknie!")

# dodajemy kolor, ktory pokazuje zmienna NUMERYCZNA zywotnosc
koty_ptaki |>
  ggplot(aes(x = waga, y = predkosc, color = zywotnosc, shape = druzyna)) +
  geom_point() +
  xlab("Waga [kg]") +
  ylab("Prędkość [km/h]") +
  ggtitle("Oh my, ale pięknie!")

# skad ten blad? niektore estetyki wymagaja okreslonych typow danych (np. shape wymaga zmiennych typu factor)
koty_ptaki |>
  ggplot(aes(x = waga, y = predkosc, color = druzyna, shape = zywotnosc)) +
  geom_point() +
  xlab("Waga [kg]") +
  ylab("Prędkość [km/h]") +
  ggtitle("Oh my, ale pięknie!")

# dodajemy kolor i ksztalt
koty_ptaki |>
  ggplot(aes(x = waga, y = predkosc, color = druzyna, shape = druzyna, label = gatunek)) +
  geom_point() +
  geom_text(hjust = -.1, vjust = -.4) +
  xlab("Waga [kg]") +
  ylab("Prędkość [km/h]") +
  ggtitle("Oh my, ale pięknie!") + 
  xlim(0, 350) # wydluzamy os x-ow

library(ggrepel)

# lpesze etykiety z ggrepel
koty_ptaki |>
  ggplot(aes(x = waga, y = predkosc, color = druzyna, shape = druzyna, label = gatunek)) +
  geom_point() +
  geom_text_repel() +
  xlab("Waga [kg]") +
  ylab("Prędkość [km/h]") +
  ggtitle("Oh my, ale pięknie!")

# robimy czarne punkty: czym sie roznia aesthetics od wlasciwosci
# wszystko kolorujemy w zaleznosci od druzyny, ale potem teksty "przemalowuje" na czarno
koty_ptaki |>
  ggplot(aes(x = waga, y = predkosc, color = druzyna, shape = druzyna, label = gatunek)) +
  geom_point() +
  geom_text_repel(color = "black") +
  xlab("Waga [kg]") +
  ylab("Prędkość [km/h]") +
  ggtitle("Oh my, ale pięknie!")

# kolor wprowadzamy TYLKO dla punktow 
koty_ptaki |>
  ggplot(aes(x = waga, y = predkosc, shape = druzyna, label = gatunek)) +
  geom_point(aes(color = druzyna)) +
  geom_text_repel() +
  xlab("Waga [kg]") +
  ylab("Prędkość [km/h]") +
  ggtitle("Oh my, ale pięknie!")

# Themes
library(ggthemes)
library(jtools)

fig2 <- koty_ptaki |>
  ggplot(aes(x = waga, y = predkosc, color = druzyna, shape = druzyna)) +
  geom_point() +
  xlab("Waga [kg]") +
  ylab("Prędkość [km/h]") +
  ggtitle("Oh my, ale pięknie!")

fig2 + theme_classic()
fig2 + theme_apa()
fig2 + theme_excel()

# kolory jako nazwy "black" lub w hex codes 
