### Tydzień 13 ANOVA time!

# 1) Import danych
# 2) Exploracja i założenia
# 3) Analiza
# 4) Wizualizacja + wykresy

# libraries
library(tidyverse)
library(ggpubr)
library(rstatix)
library(datarium)
library(skimr)

# 1) Data import
data("headache")

# Schemat analizy
# Przeprowadzono jednoczynnikową analize wariancji w schemacie miedzygrupowym gdzie porownano trzy rodzaje leczenia (X, Y, Z) pod wzgledem nasilenia bolu glowy.

# 2) Exploration & Assumptions

## Założenia (podobne do testów t) 
# Niezależność (poza tym, co modelujemy jako powtarzane pomiary)
# Brak obserwacji odstających  (wewnątrz warunków)
# Rozkład normalny reszt (w ramach warunku/celki)
# Homogeniczność wariancji
# Grupy albo duze, albo o zblizonej liczebnosci
# Zmienna zalezna musi byc ilosciowa 

# Podsumowanie danych / statystyki opisowe
str(headache)
summary(headache)
skimr::skim(headache)

# tidyvers syntax
headache %>% 
  group_by(treatment) %>%
  skim()

# rstatix
headache %>%
  group_by(treatment) %>%
  get_summary_stats(pain_score, type = "mean_sd")

# Quick and dirty
ggboxplot(headache, x = "treatment", y = "pain_score")

# Założenia:

# Przypadki odstające

headache %>%
  group_by(treatment) %>%
  identify_outliers(pain_score)
  
# ANOVA to tak naprawdę specjalny przypadek modelu liniowego, więc
# faktycznym założeniem jest normalność RESZT

# możemy zrobić sobie model regresji i popatrzeć na reszty
mod <- lm(pain_score ~ treatment, data = headache)
ggqqplot(residuals(mod))

# Można nawet przeprowadzić TEST normalności rozkładu reszt
shapiro_test(residuals(mod))

# Możemy też popatrzeć na podgrupy osobno (choć ma to w sumie raczej mniej sensu w tym wypadku, bo są malutkie)
headache %>%
  group_by(treatment) %>%
  shapiro_test(pain_score)

# qqplots w podgrupach
ggqqplot(headache, "pain_score", facet.by = "treatment")

# Zalozenie o homogenicznosci (rownosci) wariancji w grupie
# reszty standaryzowane w podgrupach
plot(mod, 5)

# formal test równości wariancji
headache %>% levene_test(pain_score ~ treatment) # po lewej ZAWSZE zmienna zalezna

# 3) Właściwa analiza
# H0: NIE ma istotnych roznic w SREDNIM poziomie BOLU GLOWY miedzy roznymi rodzajami leczenia (X, Y, Z). 
# H1: Sa istotne roznice w SREDNIM poziomie BOLU GLOWY miedzy roznymi RODZAJAMI LECZENIA (X, Y, Z).

res.aov <- headache %>% anova_test(pain_score ~ treatment)
res.aov

# Schemat analizy
# Przeprowadzono jednoczynnikową analize wariancji w schemacie miedzygrupowym gdzie porownano trzy rodzaje leczenia (X, Y, Z) pod wzgledem nasilenia bolu glowy.
# Statystyki opisowe zawiera Tabela 1.
# Wyniki nie wykazaly istotnych roznic w srednim nasileniu bolu glowy w zaleznosci od rodzaju leczeni, F(2, 69) = 2.63, p = 0.079, uogolnione eta2 = 0.071.

# jeżeli złamane są założenia o homogeniczności wariancji, możemy użyć
# testu z poprawką White'a
res.aov_white <- headache %>% anova_test(pain_score ~ treatment, white.adjust = TRUE)
res.aov_white

# 4) Porównania parami inaczej testy post-hoc (jezeli wyniki ANOVY sa istotne)
# Tukey HSD
pwc <- headache %>% tukey_hsd(pain_score ~ treatment)
pwc

# Bonferroni
# pwc <- headache %>% pairwise_t_test(pain_score ~ treatment)

# Box plot z wpisanymi wartościami p
pwc <- pwc %>% add_xy_position(x = "treatment")
ggboxplot(headache, x = "treatment", y = "pain_score") +
  stat_pvalue_manual(pwc, hide.ns = FALSE, step.increase = .02) +
  labs(
    subtitle = get_test_label(res.aov, detailed = TRUE),
    caption = get_pwc_label(pwc)
  )

# !!! barplot z przedziałami ufności !!!
bp <- ggbarplot(
  headache, x = "treatment", y = "pain_score", fill = "treatment",
  palette = "grey", add = c("mean_ci"))

# Podstawowy bar plot
bp

# wypasiony bar plot
pwc <- pwc %>% add_xy_position(x = "treatment", fun = "mean_sd")

(ready <- bp  +
  stat_pvalue_manual(pwc, hide.ns = FALSE, step.increase = .12) +
  labs(
     subtitle = get_test_label(res.aov, detailed = TRUE),
     caption = get_pwc_label(pwc)
   ) +
  xlab("Treatment") +
  ylab("Pain score") +
  theme(legend.title = element_blank(), legend.position = "none"))
 
# "Drukujemy" obrazek
jpeg(ready, file = "fig_1.jpeg", width = 6, height = 4, res = 600, units = "in")
ready
dev.off()

# library(ggstatsplot)
# library(report)

# all in one
# ggbetweenstats( headache, x = treatment, y = pain_score)
# 
# # zautomatyzowane raportowania
# aov_model <- aov(pain_score ~ treatment, data = headache)
# report(aov_model) # default output
# report(headache) # works on dataframes as well!

# saving the results
# r <- report(aov_model) 
# # various methods available
# print(r)
# as.data.frame(r)
# report_statistics(aov_model)
