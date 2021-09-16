# Load a CSV file and set its memory address to a variable
sales <- read.csv("sample-datasets/sales.csv")

# Group by salesperson and sum the value sold
# The first function is a formula saying to
# aggregate values for all salespeople
aggregate(value ~ salesperson, sales, sum)

# Grouping using dplyr
require(dplyr)
sales %>%
  group_by(salesperson) %>%
  summarise(total_vendido = sum(value))

# Group and get the percentage
sales %>%
  group_by(salesperson) %>%
  summarise(sold = sum(value)) %>%
  mutate(perc = prop.table(sold) * 100)

# Grouping by mutiple columns
customers <- read.csv("sample-datasets/customers.csv",
                      colClasses = c("churn_date" = "Date"))

customers %>%
  group_by(type) %>%
  summarise(customers = n(), churns = sum(!is.na(churn_date))) %>%
  mutate(perc_costumers = prop.table(customers) * 100, perc_churn = prop.table(churns) * 100) %>%
  relocate(perc_costumers, .after = customers) %>%
  bind_rows(summarise(., across(where(is.numeric), sum), across(where(is.character), ~"Total"))) #Add total row

# Result
# A tibble: 2 × 5
# type  customers perc_costumers churns perc_churn
# <chr>     <int>          <dbl>  <int>      <dbl>
# 1 F          6557           75.2   1353       76.6
# 2 J          2163           24.8    414       23.4
# 3 Total      8720          100     1767      100

# FILTERING DATA
customers %>%
  group_by(type) %>%
  filter(!is.na(churn_date)) %>%
  summarise(first_churn = min(churn_date), last_churn = max(churn_date), mean_churn = mean(churn_date))

invoices = read.csv("sample-datasets/invoices.csv",
                    colClasses = c("issue_date" = "Date"))

# Counting records in a date range
invoices_filtered <- invoices %>%
  select(issue_date, customer_id, value, uf) %>%
  filter(between(issue_date, as.Date("2020-01-01"), as.Date("2020-12-31")))

count(invoices_filtered)

# Grouping and summarizing filtered records
revenue_by_uf <- invoices_filtered %>%
  select(uf, value) %>%
  filter(nchar(uf) > 0) %>%
  group_by(uf = toupper(uf)) %>%
  summarise(value = sum(value))

# Generating a chart of the grouped records

# To generate a plot chart first we need to convert the X
# field to factor because charts can't be generated with
# character fieldsa

require("ggplot2")
ggplot(revenue_by_uf, mapping = aes(x = uf, y = value)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = scales::number)