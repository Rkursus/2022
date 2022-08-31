# Helping script
# Script that renders all .Rmd files within directory (recursive)

# Setting up workspace
setwd(dirname(rstudioapi::getActiveDocumentContext()[[2]]))

# List all file
files <- list.files(pattern = "[.][Rr]md$", recursive = TRUE)

# Render each file
for (f in files) rmarkdown::render(f)

# Remove <HTML> tags from lab session HTML files
#  Otherwise this ugly tag will be shown in the top of lab session webpages

# TODO

