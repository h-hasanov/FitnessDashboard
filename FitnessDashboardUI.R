ui <- dashboardPage(skin = "red",
                    dashboardHeader(title = "HH Fitness Tracker"),
                    dashboardSidebar(
                      sidebarUserPanel("Hasan Hasanov",
                                       subtitle = a(href = "#", icon("circle", class = "text-success"), "Online"),
                                       image = "Hasan Hasanov.jpg"),
                      sidebarMenu(
                        menuItem("Measurements", tabName = "Measurements", icon = icon("weight")),
                        menuItem("Statistics", tabName = "DailyStatistics", icon = icon("chart-line")),
                        menuItem("Exercises",  icon = icon("walking"), startExpanded = TRUE,
                                 menuSubItem("Summary",  tabName = "DailyExercises", icon = icon("street-view")),
                                 menuSubItem("Strength",  tabName = "StrengthTraining", icon = icon("dumbbell")),
                                 menuSubItem("Treadmill",  tabName = "Treadmill", icon = icon("walking")))
                      )),
                    dashboardBody(
                      includeCSS("www/bootstrap.css"),
                      tags$script(HTML("$('body').addClass('sidebar-mini');")),
                      tabItems(
                        tabItem(tabName = "Measurements",fluidRow(
                          tabBox(id = "tabset1",  
                                 width = 12,
                                 tabPanel("Weight (kg)", icon = icon("weight"), div(id="ScrollBox", rpivotTableOutput("BodyWeightPivotTable", height = "100%"))),
                                 tabPanel("Waist (cm)", icon = icon("tape"), div(id="ScrollBox", rpivotTableOutput("WaistPivotTable", height = "100%"))),
                                 tabPanel("Body Fat (%)", icon = icon("burn"), div(id="ScrollBox", rpivotTableOutput("BodyFatPivotTable", height = "100%"))),
                                 tabPanel("Body Muscle (%)", icon = icon("weight-hanging"), div(id="ScrollBox", rpivotTableOutput("BodyMusclePivotTable", height = "100%"))),
                                 tabPanel("All Measurements", icon = icon("database"), div(id="ScrollBox", rpivotTableOutput("MeasurementsPivotTable", height = "100%")))
                          ))),
                        tabItem(tabName = "DailyStatistics",fluidRow(
                          tabBox(id = "tabset2",  
                                 width = 12,
                                 tabPanel("Resting Heart Rate", icon = icon("heartbeat"), div(id="ScrollBox", rpivotTableOutput("DailyHeartRatePivotTable", height = "100%"))),
                                 tabPanel("Steps", icon = icon("shoe-prints"), div(id="ScrollBox", rpivotTableOutput("DailyStepsPivotTable", height = "100%"))),
                                 tabPanel("Calories (Total)", icon = icon("fire"), div(id="ScrollBox", rpivotTableOutput("DailyCaloriesTotalPivotTable", height = "100%"))),
                                 tabPanel("Calories (Activity)", icon = icon("burn"), div(id="ScrollBox", rpivotTableOutput("DailyCaloriesActivityPivotTable", height = "100%"))),
                                 tabPanel("Sedentary Minutes", icon = icon("tv"), div(id="ScrollBox", rpivotTableOutput("DailySedentaryMinutesPivotTable", height = "100%"))),
                                 tabPanel("Very Active Minutes", icon = icon("walking"), div(id="ScrollBox", rpivotTableOutput("DailyVeryActiveMinutesPivotTable", height = "100%"))),
                                 tabPanel("All Statistics", icon = icon("database"), div(id="ScrollBox", rpivotTableOutput("DailyStatisticsPivotTable", height = "100%")))
                          ))),
                        tabItem(tabName = "DailyExercises", fluidRow(
                          tabBox(id = "tabset3",
                                 width = 12,
                                 tabPanel("Treadmill", icon = icon("walking"), div(id="ScrollBox", rpivotTableOutput("DailyTreadmillPivotTable", height = "100%"))),
                                 tabPanel("Weights", icon = icon("dumbbell"), div(id="ScrollBox", rpivotTableOutput("DailyWeightsPivotTable", height = "100%"))),
                                 tabPanel("Generic Workout", icon = icon("football-ball"),div(id="ScrollBox", rpivotTableOutput("DailyGenericWorkoutPivotTable", height = "100%"))),
                                 tabPanel("Walking", icon = icon("walking"), div(id="ScrollBox", rpivotTableOutput("DailyWalkingPivotTable", height = "100%"))),
                                 tabPanel("Outdoor Running", icon = icon("route"), div(id="ScrollBox", rpivotTableOutput("DailyOutdoorRunningPivotTable", height = "100%"))),
                                 tabPanel("Bike", icon = icon("bicycle"), div(id="ScrollBox", rpivotTableOutput("DailyBikePivotTable", height = "100%"))),
                                 tabPanel("Elliptical", icon = icon("times"), div(id="ScrollBox", rpivotTableOutput("DailyEllipticalPivotTable", height = "100%"))),
                                 tabPanel("All Exercises", icon = icon("database"), div(id="ScrollBox", rpivotTableOutput("DailyExercisesPivotTable", height = "100%")))
                          ))),
                        tabItem(tabName = "StrengthTraining", fluidRow(
                          tabBox(id = "tabset4",
                                 width = 12,
                                 tabPanel("Muscle Groups", icon = icon("dumbbell"), div(id="ScrollBox", rpivotTableOutput("MuscleGroupFrequencyTable", height = "100%"))),
                                 tabPanel("Chest", icon = icon("user"), div(id="ScrollBox", rpivotTableOutput("ChestPivotTable", height = "100%"))),
                                 tabPanel("Biceps", icon = icon("dumbbell"), div(id="ScrollBox", rpivotTableOutput("BicepsPivotTable", height = "100%"))),
                                 tabPanel("Back", icon = icon("caret-down"), div(id="ScrollBox", rpivotTableOutput("BackPivotTable", height = "100%"))),
                                 tabPanel("Abs", icon = icon("cubes"), div(id="ScrollBox", rpivotTableOutput("AbsPivotTable", height = "100%"))),
                                 tabPanel("Triceps", icon = icon("dumbbell"), div(id="ScrollBox", rpivotTableOutput("TricepsPivotTable", height = "100%"))),
                                 tabPanel("Shoulders", icon = icon("user"), div(id="ScrollBox", rpivotTableOutput("ShouldersPivotTable", height = "100%"))),
                                 tabPanel("Lower Back", icon = icon("caret-down"), div(id="ScrollBox", rpivotTableOutput("LowerBackPivotTable", height = "100%"))),
                                 tabPanel("Gym Sessions", icon = icon("dumbbell"), div(id="ScrollBox", rpivotTableOutput("GymAttendedPivotTable", height = "100%"))),
                                 tabPanel("Cardio Sessions", icon = icon("walking"), div(id="ScrollBox", rpivotTableOutput("CardioPivotTable", height = "100%"))),
                                 tabPanel("All Strength", icon = icon("database"), div(id="ScrollBox", rpivotTableOutput("MuscleGroupsPivotTable", height = "100%")))
                          ))),
                        tabItem(tabName = "Treadmill", fluidRow(
                          tabBox(id = "tabset5",
                                 width = 12,
                                 tabPanel("Distance (km)", icon = icon("tape"), div(id="ScrollBox", rpivotTableOutput("TreadmillDistancePivotTable", height = "100%"))),
                                 tabPanel("Duration (minute)", icon = icon("clock"), div(id="ScrollBox", rpivotTableOutput("TreadmillDurationPivotTable", height = "100%"))),
                                 tabPanel("Speed (km/h)", icon = icon("tachometer-alt"), div(id="ScrollBox", rpivotTableOutput("TreadmillSpeedPivotTable", height = "100%"))),
                                 tabPanel("Calories", icon = icon("burn"), div(id="ScrollBox", rpivotTableOutput("TreadmillCaloriesPivotTable", height = "100%"))),
                                 tabPanel("Calories (cal/min)", icon = icon("burn"), div(id="ScrollBox", rpivotTableOutput("TreadmillCaloriesPerMinutePivotTable", height = "100%"))),
                                 tabPanel("All Treadmill Details", icon = icon("database"), div(id="ScrollBox", rpivotTableOutput("TreadmillDetailsPivotTable", height = "100%")))
                          )))
                      )))