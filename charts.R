sales = read.csv("sample-datasets/sales.csv",
                 colClasses = c("payment_date" = "Date"))
# Usefull to check the data type of a column
class(sales$payment_date)

# Convert the data type of a column
# In this example, read.csv was already chaged
# to import the column with the correct type
sales = transform(sales, payment_date = as.Date(payment_date))

# Generates a chart with line type with
# values(Y) by day(X)
plot(sales$payment_date, sales$value, type = "l")

# To use a character field as the X vector
# we must convert to factor
plot(factor(sales$plan), sales$value, type = "l")

# Generates histogram for different ranges (breaks)
hist(sales$payment_date, breaks = "weeks")
hist(sales$payment_date, breaks = 4) #only 4 breaks
hist(sales$payment_date, breaks = "days")

# Making the historgram beautiful
hist(sales$payment_date,
     breaks = "weeks",
     main = "Vendas por semana",
     ylab = "Vendas",
     xlab = "Semana",
     col = "blue"
)

# SAVE CHART TO FILE
# Opens a new file to write an histogram
jpeg("out.jpeg", )

# Writes the histogram in the jpeg buffer
hist(sales$payment_date,
     breaks = "weeks",
     main = "Vendas por semana",
     ylab = "Vendas",
     xlab = "Semana",
     col = "blue"
)

# Close the buffer written the file
dev.off()