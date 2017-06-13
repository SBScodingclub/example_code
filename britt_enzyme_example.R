# 14 June 2017
# Sam Lee
# Example code for how to process a raw csv and generate a boxplot for enzyme activity
# Written for the SBS coding club

library(tidyverse)

f_dir <- "/Users/slee/programming/codingclub/data/june_14"


# read and tidy data ------------------------------------------------------

raw_aromatase <- read_csv(file.path(f_dir, "Aromatase.csv"))

aromatase_tidy <- raw_aromatase %>%
  gather(key = replicate, value = OD, 3:5) %>%
  mutate(condition = paste(`cell-type`, treatment, sep = "_")) %>%
  mutate(enzyme = "aromatase") %>%
  select(-`cell-type`, -treatment)

hsd17_tidy <- read_csv(file.path(f_dir, "17B-HSD.csv")) %>%
  gather(key = replicate, value = OD, 3:5) %>%
  mutate(condition = paste(`cell-type`, treatment, sep = "_")) %>%
  mutate(enzyme = "17B-HSD") %>%
  select(-`cell-type`, -treatment)

hsd3_tidy <- read_csv(file.path(f_dir, "3B-HSD.csv")) %>%
  gather(key = replicate, value = OD, 3:5) %>%
  mutate(condition = paste(`cell-type`, treatment, sep = "_")) %>%
  mutate(enzyme = "3B-HSD") %>%
  select(-`cell-type`, -treatment)

total_data <- bind_rows(
  aromatase_tidy,
  hsd17_tidy,
  hsd3_tidy
)

# plotting ----------------------------------------------------------------



ggplot(aromatase_tidy, aes(condition, OD)) +
  geom_boxplot() +
  labs(x = "condition", y = "OD", title = "Aromatase") +
  theme_minimal()

ggplot(hsd17_tidy, aes(condition, OD)) +
  geom_boxplot() +
  labs(x = "condition", y = "OD", title = "17B-HSD") +
  theme_minimal()

ggplot(hsd3_tidy, aes(condition, OD)) +
  geom_boxplot() +
  labs(x = "condition", y = "OD", title = "3B-HSD") +
  theme_minimal()

ggplot(total_data, aes(condition, OD)) +
  geom_boxplot() +
  facet_grid(enzyme ~ .) +
  labs(x = "condition", y = "OD", title = "Total data") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
