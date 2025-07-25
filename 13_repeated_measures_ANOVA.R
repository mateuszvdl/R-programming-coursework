### Tydzień 13 - ANOVA w powtarzanym pomiarze

# Jezeli jest analiza w powtarzanym pomiarze - zakazane slowo GRUPY!!!!!

# Import danych
# Wstępne założenia
# Data preparation
# Statystyki opisowe
# Wizualizacja
# Analiza
# Sferyczność
# Testy post-hoc
# Raportowanie

# Założenia:
# Brak przypadków odstających 
# Normalność
# Sferyczność

library(tidyverse)
library(ggpubr)
library(rstatix)
library(datarium)
library(haven)

# library(report)
# library(ggstatsplot)


# Import
# Czego potrzebujemy? 
# Danych w formacie "długim"
# Ze zmienną pozwalającą zidentyfikować poszczególne osoby

s <- read_sav("Stroop.sav")
s <- s %>% pivot_longer(2:5, names_to = "warunek", values_to = "rt") %>%
  convert_as_factor(Nr, warunek)

# quick & dirty
bxp <- ggboxplot(s, x = "warunek", y = "rt", add = "jitter")
bxp

# statystyki opisowe:
summ <- s %>% group_by(warunek) %>% 
  get_summary_stats(rt, type = "common") %>%
  mutate(ci_lower = mean - ci, ci_higher = mean + ci)

# outliers detection
s %>%
  group_by(warunek) %>%
  identify_outliers(rt)

# normalność
s %>%
  group_by(warunek) %>%
  shapiro_test(rt)

ggqqplot(s, "rt", facet.by = "warunek")

# Podstawowa ANOVA
# data = dane, dv = zmienna zależna, wid = zmienna identyfikująca osoby, within = zmienna określająca warunki
res.aov <- anova_test(data = s, dv = rt, wid = Nr, within = warunek, effect.size = "ges")
res.aov
get_anova_table(res.aov) # Tu robimy ladniejsza tabelke

# Założenie o sferyczności - stosowane jest domyślnie, ale można je wyłączyć (nie polecam...)
get_anova_table(res.aov, correction = "none")

# Post-hoc tests
# pairwise comparisons
pwc <- s %>%
  pairwise_t_test(
    rt ~ warunek, paired = TRUE,
    p.adjust.method = "bonferroni"
  )
pwc

pwc <- pwc %>% add_xy_position(x = "warunek")

# bxp + 
#   stat_pvalue_manual(pwc) +
#   labs(
#     subtitle = get_test_label(res.aov, detailed = TRUE),
#     caption = get_pwc_label(pwc)
#   )
# 

pwc <- pwc %>% add_xy_position(x = "warunek", fun = "mean_ci")

# Robimy cuda na wykresie (let's try to control our excitement)
brp <- ggbarplot(s, x = "warunek", y = "rt", add = "mean_ci", 
                 fill = "warunek", palette = c("#00AFBB", "#E7B800", "#FC4E07", "#6aac00"))

# kolorowy barplot

brp + 
  stat_pvalue_manual(pwc, hide.ns = TRUE) +
  labs(
    subtitle = get_test_label(res.aov, detailed = TRUE),
    caption = get_pwc_label(pwc)
  )

# # ggstats plot
# ggwithinstats(s, x = "warunek", y = "rt")
# 
# # Spaghetti plots
# (spag <- ggplot() + 
#     geom_line(data = s, aes (x = warunek, y = rt, group = Nr, color = Nr), alpha = .3) +
#     geom_point(data = s, aes (x = warunek, y = rt, group = Nr, color = Nr), alpha = .3) +
#     geom_errorbar(data = summ, aes(x = warunek, ymin= ci_lower,
#                                    max=ci_higher), width=0.1, size=1, color="black") +
#     stat_summary(data = summ, fun = mean, geom= "line", lwd=1, color = "black", aes(group=1, x = warunek, y = mean))
# )
# 
# 
# # Podejście nieparametryczne
# res.fried <- s %>% friedman_test(rt ~ warunek |Nr)
# res.fried
# # effect size
# s %>% friedman_effsize(rt ~ warunek |Nr)
# 
# # post-hocs
# pwc <- s %>%
#   wilcox_test(rt ~ warunek, paired = TRUE, p.adjust.method = "holm")
# pwc
# 
