# Load a CSV file and set its memory address to a variable
sales <- read.csv("sample-datasets/sales.csv")

# Group by salesperson and sum the value sold
# The first function is a formula saying to
# aggregate values for all salespeople
aggregate(value ~ salesperson, sales, sum)

# Grouping using dplyr
require(dplyr)
agg2 <- sales %>%
  group_by(salesperson) %>%
  summarise(total_vendido = sum(value))

# Group and get the percentage
sales %>%
  group_by(salesperson) %>%
  summarise(sold = sum(value)) %>%
  mutate(perc = prop.table(sold) * 100)

# Grouping by mutiple columns
customers <- read.csv("sample-datasets/customers.csv")

customers %>%
  group_by(type) %>%
  summarise(customers = n(), churns = sum(churn_date != "")) %>%
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