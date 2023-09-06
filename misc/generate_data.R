dat <- mtcars |>
  select(score = mpg, proficiency = drat, group = am) |>
  mutate(
    score = (score - min(score)) / (max(score) - min(score)), 
    proficiency = ((proficiency - mean(proficiency)) / sd(proficiency)), 
    group = if_else(group == 1, "bilingual", "monolingual")
  )

rownames(dat) <- NULL

ggplot(data = dat) + 
  aes(x = proficiency, y = score) + 
  geom_point()

ggplot(data = dat) + 
  aes(x = group, y = score) + 
  geom_point()

saveRDS(dat, file = here("misc", "new_data.RDS"))
