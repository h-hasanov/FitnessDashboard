library(dplyr)
library(tidyr)
library(shiny)
library(shinydashboard)
library(DT)
library(readxl)
library(reshape)
library(data.table)
library(ggplot2)
library(rpivotTable)
library(lubridate)


#setwd("G:/FitnessDashboard/")
#options(browser = "C:/Program Files (x86)/Mozilla Firefox/firefox.exe")
source("./modules/DataFactory.R")
source("./modules/StatisticsController.R")
source("./modules/ExercisesController.R")
source("./modules/MuscleGroupsController.R")
source("./modules/MeasurementsController.R")
source("./modules/TreadmillDetailsController.R")
source("./modules/ControllerHelpers.R")
source("./FitnessDashboardServer.R")
source("./FitnessDashboardUI.R")

shinyApp(ui = ui, server = server, options = list(port = 8080, maxRequestSize = 9*1024^2, launch.browser = TRUE))