# Load a CSV file and set its memory address to a variable
sales = read.csv("sample-datasets/sales.csv")

min(sales$payment_date)

# Median day of the dataset
mean(sales$payment_date)