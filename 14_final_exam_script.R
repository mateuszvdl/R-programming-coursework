### Egzamin 2023/24 | Statystyka | 1. termin



# Proszę a) ściągnąć z platformy pliki z danymi TestB oraz FA1

# b) stworzyć projekt tak, aby plik z danymi był dla R Studio „widoczny”

# c) stworzyć skrypt

# d) Wkleić do skryptu CAŁĄ treść tego maila i zapisać skrypt



# Proszę wykonać następujące polecenia wpisując za każdym razem kod

# bezpośrednio pod poszczególnymi instrukcjami.

# Odpowiedzi słowne proszę wpisywać jako komentarze w skrypcie.

# Po zakończeniu egzaminu zmodyfikowany SKRYPT proszę przesłać

# na classroom. Proszę uważać i nie wysyłać pliku Rproj czy jakiegoś innego

# Wysyłamy SKYRPT (plik z rozszerzeniem .R).

# 1



# Proszę często zapisywać skrypt, aby uniknąć katastrof :)



# ZADANIE 1.

# Tu wszystkie pakiety, jakich bede potrzebowal :)
library(readxl)
library(readr)
library(janitor)
library(tidyverse)
library(ggpubr)
library(rstatix)
library(datarium)
library(skimr) 
library(PerformanceAnalytics)
library(openxlsx)
library(PogromcyDanych)
library(ggrepel)
library(ggthemes)
library(hrbrthemes)
library(sjPlot)
library(ggfortify)
library(broom)
library(haven)
library(report)
library(ggstatsplot)

# Proszę wczytać plik danych TestB

library(readxl)
testB <- read_excel("testB.xlsx")

# proszę zamienić zmienną f na factor i dodać etykiety

testB$f <- factor(testB$f, labels = c("pacjenci", "kontrola"))

# Proszę porównać wyniki dla zmiennej stres (poziom stresu) przy wykorzystaniu
# testu t dla prób niezależnych a następnie opisać wyniki zgodnie ze standardami APA.

# zmienna zależna (dependent variable): poziom stresu
# zmienna niezależna (independent variable): wiek

# H0: NIE MA istotnej różnicy w ŚREDNIM poziomie STRESU między grupami WIEKOWYMI (młode vs. stare)
# H1: JEST istotna różnica w ŚREDNIM poziomie STRESU między grupami WIEKOWYMI (młode vs. stare)

# Założenia:
# a) zmienna zależna musi być zmienną ilościową - TAK
# b) grupy muszą być w miarę równoliczne lub duże - TAK
# c) rozkład zmiennej zależnej w każdej z grup powinien być zbliżony do normalnego - TAK
# d) skontrolowany wpływ przypadków odstających - OK

testB |>
  skim()

testB |>
  group_by(wiek) |>
  get_summary_stats(stres, type = "mean_sd")

ggboxplot(testB, x = "wiek", y = "stres")

testB |>
  na.omit() |>
  t_test(stres ~ wiek)

testB |>
  cohens_d(stres ~ wiek)

# Wartość p duża -> H0: NIE MA istotnej różnicy w ŚREDNIM poziomie STRESU między grupami WIEKOWYMI 

# OPIS:
# Analiza testem t dla prób niezależnych (z poprawką na nierówność wariancji Welcha) wykazała że,
# średni poziom stresu w młodej grupie wiekowej (15 lat) (N = 11 , M = 14, SD = 3.35)
# nie roznil sie istotnie od starszej grupy wiekowej (87) (N = 1, M = 14 , SD = 3.88), 
# t(73.3) = 3.24, p > 0.05, d Cohena = 3.35 .

# Korzystając z pakietu ggpubr proszę stworzyć właściwy wykres ilustrujący wyniki w grupach



# ZADANIE 2. Korzystając z tych samych danych

# Proszę zbudować model regresji w którym poziom stresu (stres)
# będzie przewidywana na podstawie wieku (wiek) i zmiennej f

regresja <- lm(stres ~ wiek + f, data = testB)

summary(regresja)

library(sjPlot)
tab_model(regresja)

# Ile wynosi współczynnik regresji dla zmiennej f?

  # wspolczynnik regresji dla zmiennej f wynosi 0.22

# Jak możemy zinterpretować tę wartość?

  # Grupa (f) jest kodowana jak widać według schematu: pacjenci= 0, kontrolna = 1 
  # A zatem efekt "f/pacjenci" oznacza, że kiedy zmienia się grupa ("rośnie o jeden") 
  # (tak naprawdę - "przenosimy się" z kategorii pacjenci do kategorii kontrola), 
  # to przewidywany poziom stresu wzrasta o 0.22
.
# Proszę napisać równanie regresji opisujące
# wyniki przewidywane w przypadku osób z grupy „naukowcy”
# Proponuję sprawdzić jak kodowana jest zmienna f!

contrasts(testB$f)

  # Ogólna wersja równania regresji wygląda następująco:
  # przewidywane y = b0 + b1*x1 + b2*x2 + b3*x3 + ... + bn*xn
  # W przypadku uzywanych danych ogólna wersja równania wygląda następująco:
  # przewidywany poziom stresu = 16.02 + (-0.03)* wiek + 0.22 * f(pacjenci = 0, kontrola = 1)
  
  # Wersja dotycząca tylko grupy pacjentów (gdzie f = 0):
  # przewidywany poziom stresu =  16.02 + (-0.03)* wiek

# Proszę stworzyć wykresy diagnostyczne i sprawdzić, czy założenia homoskedastyczności i normalności reszt są spełnione
  
library(ggplot2)

ggplot(testB, aes(x = wiek, y = stres, color = f)) +
  geom_smooth(method = "lm")
  
plot_model(regresja, type = "diag") 
plot(regresja) 

# homoskedastyczność -> TAK, patrząc na wykres "Homoscedasticy (constant variance of residuals)". Ilość oraz odległość od siebie punktów na wykresie powyżej i poniżej linii wykresu jest równa, a niektóre z nich są "randomly spread"
# normalność reszt -> NIE, patrząc na wykres "Non-normality of residuals and outliers". Punkty od pewnego momentu są położone wzdłuż linii, lecz na początku od niej znacząco odstają.


# ZADANIE 3.
  
  # Proszę wczytać do R-a dane z pliku FA1

library(readxl)
library(dplyr)
library(tidyr)
library(car)
library(multcomp)

data <- read_excel("FA1.xlsx")

# Proszę wybrać z danych kolumny osoba oraz kolumny nazwane w1, w2, w4
# Proszę zmienić nazwy kolumny od 2 do 4 tak, żeby miały nazwy wysoki, sredni i niski.

selected_data <- data %>% 
  select(osoba, w1, w2, w4) %>% 
  rename(wysoki = w1, sredni = w2, niski = w4)

# Będzie to zmienna oznaczająca poziom hałasu w różnych warunkach zadania, w których testowano cały czas tę samą grupę uczestników.
# Wartości w kolejnych kolumnach to ilość zadań matematycznych, które udało się wykonać uczestnikom badania w danej sytuacji.

# Jaka będzie hipoteza zerowa w analizie wariancji, którą można by zastosować dla tych danych?

# H0: Nie ma istotnej różnicy w Średniej ilości zadań matematycznych wykonanych przez uczestników ze względu na poziom halasu

# Proszę zamienić dane na format długi i zrealizować odpowiednią ANOVĘ oraz (ewentualnie) testy post-hoc Bonferroniego (bez ich opisywania).

long_data <- selected_data %>% 
  pivot_longer(cols = -osoba, names_to = "poziom_halasu", values_to = "ilosc_zadan")

anova_result <- aov(ilosc_zadan ~ poziom_halasu, data = long_data)
summary(anova_result)

post_hoc_result <- glht(anova_result, linfct = mcp(poziom_halasu = "Tukey"))
summary(post_hoc_result)

confint(post_hoc_result)


# Proszę napisać czy grupy niska i wysoka różnią się od siebie istotnie wynikami? (proszę napisać tak/nie i podać odpowiednią informację, która to uzasadnia)

# NIE. Patrzac na wyniki testow post-hoc Bonferroniego, P-wartość dla porównania między grupami "niska" i "wysoka" była znacznie wyższa niz 0.05.