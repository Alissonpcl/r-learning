invoices = read.csv("sample-datasets/invoices.csv",
                    colClasses = c("issue_date" = "Date"))

revenue_by_uf <- invoices_filtered %>%
  select(uf, value) %>%
  filter(nchar(uf) > 0) %>%
  group_by(uf = toupper(uf)) %>%
  summarise(value = sum(value))

require("ggplot2")
ggplot(revenue_by_uf, mapping = aes(x = uf, y = value)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = scales::number)