## 1. create github repository
## 2. create RStudio project from new Version Control
## 3. clone github repository into the new RStudio project
## 4. download and unzip the bookdown demo file (https://github.com/rstudio/bookdown-demo/archive/master.zip) into the RStudio project
## 5. modify the _bookdown.yml, _output.yml
## 6. create .nojekyll file
file.create('.nojekyll')
### add to git (not shown up in RStudio): git add .nojekyll
## 7. add output_dir: "docs" to the configuration file _bookdown.yml

bookdown::render_book(input = "index.Rmd", output_format = "bookdown::pdf_book", output_dir = "docs")

## create bib file
library(knitcitations)
refs <- lapply(c("10.1371/journal.pntd.0005498"), bib_metadata)
write.bibtex(refs[[1]], file="refs.bib")

"10.1002/sim.6265"
