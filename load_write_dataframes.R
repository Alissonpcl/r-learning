# Load a CSV file and set its memory address to a variable
sales = read.csv("sample-datasets/sales.csv")

# Prints ID list
sales["id"]
sales$id

# Sets the global maximum amount of values printed
# when not informed when calling functions
options(max.print = 99999)

# Print the first IDs in the list
head(sales["id"], n = 15)
head(sales$id, n = 15)

# Sorts ID list and prints the greatest
head(sort(sales$id, decreasing = T), n = 1)

head(sales)

# Sets the value of the cell in row 1 and
# column 6 to the literal text Alisson
# It only changes the value in memory
sales[1, 6]<- "Alisson"

# Gets unique values
unique(sales$salesperson)

# How many unique items a column has
length(unique(sales$salesperson))

# Gets unique values, how much
# times it is int the csv file
# and prints it in table format
table(sales$salesperson)

# Loads library that will be use to manipulate the data frame
library("dplyr")

# Count how many times a value appears in the dataset
count(sales, sales$salesperson, name = "count")

# Creates an intermediate dataset set to be
# manipulated and then written to a csv file
auxiliar = count(sales, sales$salesperson, name = "count")

# Renames a column
rename(auxiliar, salesperson = "sales$salesperson")

# Write dataset to a CSV file
write.csv(auxiliar, file = "sample-datasets/out.csv")

# Remove the dataset from memory
rm()