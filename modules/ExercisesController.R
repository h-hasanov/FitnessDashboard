ExercisesViewDataColumns <- c("Month", "MonthName")
ExercisesViewDataRows <- "Year"
ExercisesViewHiddenFromAggregators <- c("Month", "Year", "MonthName", "Date", "Start Time", "Details", "Activity Type")
ExercisesViewHiddenFromDragDrop <- c("Start Time", "Steps", "Distance", "Duration (milliseconds)", "Duration (minutes)", "Calories",
                                     "Sedentary Minutes", "Lightly Active Minutes", "Fairly Active Minutes", "Very Active Minutes",
                                     "Details",  "Is Increasing?")
ExercisesViewRawDataNumericColumns <- c("Steps", "Distance", "Duration (milliseconds)", "Duration (minutes)", "Calories",
                                        "Sedentary Minutes", "Lightly Active Minutes", "Fairly Active Minutes", "Very Active Minutes")

ExercisesViewSpecificActivityHiddenFromDragDrop <- c(ExercisesViewHiddenFromDragDrop, "Activity Type")

getAllActivitiesPivotTable <- function(dailyExercises){
  
  result <- rpivotTable(aggregatorName="Average",
                        vals = "Very Active Minutes",
                        rendererName = "Line Chart",
                        data = dailyExercises, 
                        cols = ExercisesViewDataColumns, 
                        rows = ExercisesViewDataRows, 
                        hiddenFromAggregators = ExercisesViewHiddenFromAggregators,
                        hiddenFromDragDrop = ExercisesViewHiddenFromDragDrop)
  return(result)
}

#====================================================================================================

getSpecificActivitiesPivotTable <- function(dailyExercises, 
                                            activityType,
                                            aggregatorName,  
                                            vals,
                                            rendererName){
  filteredDailyExercises <-dailyExercises %>% filter(`Activity Type` == activityType)
  
  result <- rpivotTable(aggregatorName = aggregatorName,
                        vals = vals,
                        rendererName = rendererName,
                        data = filteredDailyExercises, 
                        cols = ExercisesViewDataColumns, 
                        rows = ExercisesViewDataRows, 
                        hiddenFromAggregators = ExercisesViewHiddenFromAggregators,
                        hiddenFromDragDrop = ExercisesViewSpecificActivityHiddenFromDragDrop)
  return(result)
}

getWeightActivitiesPivotTable <- function(dailyExercises){
  result <- getSpecificActivitiesPivotTable(dailyExercises = dailyExercises, 
                                            activityType = "Weights",
                                            aggregatorName = "Average",  
                                            vals = "Very Active Minutes",
                                            rendererName = "Line Chart")
  return(result)
}

getTreadmillActivitiesPivotTable <- function(dailyExercises){
  result <- getSpecificActivitiesPivotTable(dailyExercises = dailyExercises, 
                                            activityType = "Treadmill", 
                                            aggregatorName = "Sum",  
                                            vals = "Steps",
                                            rendererName = "Table")
  return(result)
}


getWalkingActivitiesPivotTable <- function(dailyExercises){
  result <- getSpecificActivitiesPivotTable(dailyExercises = dailyExercises, 
                                            activityType = "Walk", 
                                            aggregatorName = "Sum",  
                                            vals = "Steps",
                                            rendererName = "Table")
  return(result)
}

getGenericWorkoutActivitiesPivotTable <- function(dailyExercises){
  result <- getSpecificActivitiesPivotTable(dailyExercises = dailyExercises, 
                                            activityType = "Workout", 
                                            aggregatorName = "Sum",  
                                            vals = "Very Active Minutes",
                                            rendererName = "Table")
  return(result)
}

getEllipticalActivitiesPivotTable <- function(dailyExercises){
  result <- getSpecificActivitiesPivotTable(dailyExercises = dailyExercises, 
                                            activityType = "Elliptical", 
                                            aggregatorName = "Sum",  
                                            vals = "Very Active Minutes",
                                            rendererName = "Table")
  return(result)
}

getOutdoorRunningActivitiesPivotTable <- function(dailyExercises){
  result <- getSpecificActivitiesPivotTable(dailyExercises = dailyExercises, 
                                            activityType = "Run", 
                                            aggregatorName = "Sum",  
                                            vals = "Steps",
                                            rendererName = "Table")
  return(result)
}

getBikeActivitiesPivotTable <- function(dailyExercises){
  result <- getSpecificActivitiesPivotTable(dailyExercises = dailyExercises, 
                                            activityType = "Bike", 
                                            aggregatorName = "Sum",  
                                            vals = "Very Active Minutes",
                                            rendererName = "Table")
  return(result)
}

#====================================================================================================

getDailyExercisesRawDataTable <- function(dailyExercises){
  result <- getCopyCsvButtonsTable(inputData = dailyExercises, pageLength = 7,
                         numberColumnNames = ExercisesViewRawDataNumericColumns)
  return(result)
}