dat <- mtcars |>
  select(score = mpg, proficiency = drat, group = am, age = cyl) |>
  mutate(
    score = (score - min(score)) / (max(score) - min(score)), 
    proficiency = ((proficiency - mean(proficiency)) / sd(proficiency)), 
    group = if_else(group == 1, "bilingual", "monolingual"), 
    age = case_when(
      age == 4 ~ "young", 
      age == 6 ~ "older", 
      age == 8 ~ "oldest"
    ), 
    age = fct_relevel(age, "young", "older")
  ) |>
  mutate_if(is.numeric, round, digits = 2)

rownames(dat) <- NULL

ggplot(data = dat) + 
  aes(x = proficiency, y = score) + 
  geom_point()

ggplot(data = dat) + 
  aes(x = group, y = score) + 
  geom_point()

ggplot(data = dat) + 
  aes(x = group, y = score) + 
  facet_wrap(. ~ age) + 
  geom_point()

saveRDS(dat, file = here("misc", "new_data.RDS"))
