# 14 June 2017
# Sam Lee
# Example code for how to process a raw csv and generate a boxplot for enzyme activity
# Written for the SBS coding club

library(tidyverse)

f_dir <- "/Users/slee/programming/codingclub/data/june_14"

raw_aromatase <- read_csv(file.path(f_dir, "Aromatase.csv"))

aromatase_tidy <- raw_aromatase %>%
  gather(key = replicate, value = aromatase, 3:5) %>%
  mutate(condition = paste(`cell-type`, treatment, sep = "_")) %>%
  select(-`cell-type`, -treatment)


ggplot(aromatase_tidy, aes(condition, aromatase)) +
  geom_boxplot() +
  labs(x = "condition", y = "aromatase OD", title = "example plot one") +
  theme_minimal()
