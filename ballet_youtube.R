##########
# How to make a grouped bar chart in R with the lattice package
#
# We are comparing the number of dances choreographed by men and women, grouped by year
#
# Step 1
# Put your data into Excel into the right format

# Step 2
# import the package "lattice"
library(lattice)

# Step 3
# import your data in, in the right format (usually comma separated)
# the table will be tab-separated in Excel, so we have to convert to comma-separated for R
# Convert the windows endline (/r/n) to newline (/n)
# convert all the "\t" to ", "
# and put it into a table variable
ballet_table <- read.table(text = "Year, Gender, Number_of_dances
[2012], Female choreographer, 7
[2012], Male choreographer, 0
[2013], Female choreographer, 2
[2013], Male choreographer, 2
[2014], Female choreographer, 0
[2014], Male choreographer, 3
[2015], Female choreographer, 1
[2015], Male choreographer, 2
[2016], Female choreographer, 0
[2016], Male choreographer, 3
[2017], Female choreographer, 0
[2017], Male choreographer, 6
[2018], Female choreographer, 0
[2018], Male choreographer, 0
",
                           # we want to tell the read table that we have headers
                           header = TRUE,
                           # we want to set the separater value
                           sep = ",",
)


ballet_table


# Let's make the bar chart
# We are going to plot the number of dances choreographed (y axis)
# by the gender of the choreographers (x axis)
# grouped by year (groups)

# in my experience, lattice doesn't like it when you declare color in side the barplot function
# so we have to declare it outside
colors = c("hotpink", "royalblue2")

# open up a blank image that we want to save our chart in
png(filename = "ballet_chart.png",
    width = 10,
    height = 10,
    units = "in",
    res = 600)

barchart(

  # Input the data in
  data = ballet_table,
  
  # y axis by x axis
  Number_of_dances ~ Year,
  
  # set the groups
  # This is what the x axis is grouped by
  groups = Gender,
  
  # Turn the graph 90 degrees
  horizontal = FALSE,
  
  # Add a title to our graph
  # I want the font of the title to be bigger
  main = list(
    
    label = "Prix de Lausanne contemporary ballet dances",
    cex = 2.2
  ),
  
  
  # label the x axis
  # make the font bigger
  xlab = list (
    label = "Years",
    cex = 1.5
  ),
  
  # label the y axis
  # make the font bigger
  ylab = list(
    label = "Number of dances choreographed",
    cex = 1.5
  ),
  
  # Let's change the scale tick marks font size
  # x and y axis marks
  # we want to make their font a little bigger
  scales = list (
    x = list (
      # if you want to rotate your values
      # rot = 90
      cex = 1.2
    ),
    
    y = list (
      # if you want to rotate your values
      # rot = 90
      cex = 1.2
    )
  ),
  
  # add a legend
  auto.key = list (
    space = list (space = "top"),
    columns = 2,
    title = "Colors",
    cex.title = 1.1
  ),
  
  # set the origin so that values start at 0
  origin = 0,
  
  # set colors
  par.settings = list(superpose.polygon = list(col = colors))
)

# save our image
dev.off()