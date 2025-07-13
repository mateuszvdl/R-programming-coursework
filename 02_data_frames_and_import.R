# Zajecia 02

# robimy prosty wektor

kolejne <- 1:20
odwrotnie <- 20:1

# seq - tworzenie sekwencji wartosci 
s <- seq(from = 10, to = 100, by = 7)
s2 <- seq(from = 10, to = 100, length.out = 33)
prosty <- c(1, 3, 5)

# adresowanie wektorow
kolejne[2] # tak wyjmujemy pojedyncze elementy
odwrotnie[2:5] # adresujemy elementy 2 do 5
s[ c(1, 5, 10) ] # adresujemy wektor za pomoca innego wektora
s[ c(1, 5, 20) ] # zaadresowalismy wektor i wrzucilismy element, ktorego nie ma 

# zamiana elementow - nadpisujemy wartosc w wektorze
kolejne[1:2] <- c(100,200) # wymieniam 2 elementy na inne dwa
odwrotnie[1:5] <- 10 # wymieniam 5 elementow na te sama wartosc 

# wartosci specjalne w R-ze
NA # zadeklarowalismy brak danych
TRUE # wartosci logiczne 
FALSE 
0/0
NaN # not a number
-100/0
Inf #infinity 

# wlaczamy pakiet titanic
library(titanic)

t <- titanic_test # kopia z danych z pakietu do obiektu t
class(t) # sprawdzamy 

# adresowanie danych 
t[2,3] # wartosc z drugiego wiersza i trzeciej kolumny 
t[2, ] # drugi wiersz, wszystkie kolumny 
t[ ,3] # trzecia kolumna, wszystkie wiersze 

# jak adresujemy zmienne po nazwie
t$Age # adresowanie zmiennej po nazwie - notacja z $

summary(t$Age) # statystyki opisowe dla zmiennej Age
mean(t$Age) # sa braki danych wiec odpowiedz to NA
mean(t$Age, na.rm = TRUE) # dodajemy argument usuwajacy braki danych 

# nasz pierwszy wykres - HISTOGRAM
hist(t$Fare)

# screening danych 
# zobaczyc czy zgadzaja sie typy zmiennych 
# patrzymy na poczatek i koniec pliku 
head(t) # poczatek ramki danych
tail(t) # koniec ramki danych
# patrzymy na statystyki opisowe 

# IMPORT DANYCH
library(readxl)
diagnoses <- read_excel("diagnoses.xlsx", 
                        sheet = "Sheet1")
View(diagnoses)

