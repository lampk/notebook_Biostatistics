
# setup -------------------------------------------------------------------

# working directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# R libraries
library(foreign)
library(mice)
library(VIM)
library(norm)
library(lattice)
library(Hmisc)

# data
library(haven)
mccs <- read_dta(file = file.path("..", "data", "mccs.dta"))


# explore data ------------------------------------------------------------

dim(mccs)
describe(mccs)


# scenario 1: nonlinear association in analysis model ---------------------



# Q1A: Inspection of the missing data -------------------------------------


