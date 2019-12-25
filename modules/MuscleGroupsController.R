MuscleGroupsViewDataColumns <- c("Month", "MonthName")
MuscleGroupsViewDataRows <- "Year"
MuscleGroupsViewHiddenFromAggregators <- c("Month", "Year", "MonthName", "Date")
MuscleGroupsViewHiddenFromDragDrop <- c("Date", "Chest", "Biceps", "Back", "Abs", "Triceps", "Shoulders", 
                                        "Lower Back", "Forearms", "Legs", "Gym Attended", "Cardio")

MuscleGroupsViewRawDataNumericColumns <- c("Chest", "Biceps", "Back", "Abs", "Triceps", "Shoulders", 
                                           "Lower Back", "Forearms", "Legs", "Gym Attended", "Cardio",
                                           "Gym Attended", "Cardio")
MuscleGroupsViewSpecificMuscleGroupHiddenFromDragDrop <- MuscleGroupsViewHiddenFromDragDrop

getMuscleGroupsPivotTable <- function(muscleGroups){
  
  result <- rpivotTable(aggregatorName = "Sum",
                        vals = "Gym Attended",
                        rendererName = "Line Chart",
                        data = muscleGroups,
                        cols = MuscleGroupsViewDataColumns,
                        rows = MuscleGroupsViewDataRows,
                        hiddenFromAggregators = MuscleGroupsViewHiddenFromAggregators,
                        hiddenFromDragDrop = MuscleGroupsViewHiddenFromDragDrop)
  return(result)
}

#====================================================================================================

getSpecificMuscleGroupPivotTable <- function(muscleGroups, 
                                             muscleGroupType,
                                             aggregatorName,  
                                             rendererName){
  filteredMuscleGroup <- muscleGroups %>% select(c(MuscleGroupsViewDataColumns,
                                                   MuscleGroupsViewDataRows,
                                                   muscleGroupType))
  
  result <- rpivotTable(aggregatorName = aggregatorName,
                        vals = muscleGroupType,
                        rendererName = rendererName,
                        data = filteredMuscleGroup, 
                        cols = MuscleGroupsViewDataColumns, 
                        rows = MuscleGroupsViewDataRows, 
                        hiddenFromAggregators = MuscleGroupsViewHiddenFromAggregators,
                        hiddenFromDragDrop = MuscleGroupsViewSpecificMuscleGroupHiddenFromDragDrop)
  return(result)
}

getStandardSpecificMuscleGroupPivotTable <- function(muscleGroups, 
                                                     muscleGroupType){
  
  result <- getSpecificMuscleGroupPivotTable(muscleGroups = muscleGroups,
                                             muscleGroupType = muscleGroupType,
                                             aggregatorName = "Integer Sum",  
                                             rendererName = "Table")
  return(result)
}

getChestPivotTable <- function(muscleGroups){
  result <- getStandardSpecificMuscleGroupPivotTable(muscleGroups = muscleGroups, muscleGroupType = "Chest")
  return(result)
}

getBicepsPivotTable <- function(muscleGroups){
  result <- getStandardSpecificMuscleGroupPivotTable(muscleGroups = muscleGroups, muscleGroupType = "Biceps")
  return(result)
}


getBackPivotTable <- function(muscleGroups){
  result <- getStandardSpecificMuscleGroupPivotTable(muscleGroups = muscleGroups, muscleGroupType = "Back")
  return(result)
}

getAbsPivotTable <- function(muscleGroups){
  result <- getStandardSpecificMuscleGroupPivotTable(muscleGroups = muscleGroups, muscleGroupType = "Abs")
  return(result)
}

getTricepsPivotTable <- function(muscleGroups){
  result <- getStandardSpecificMuscleGroupPivotTable(muscleGroups = muscleGroups, muscleGroupType = "Triceps")
  return(result)
}

getShouldersPivotTable <- function(muscleGroups){
  result <- getStandardSpecificMuscleGroupPivotTable(muscleGroups = muscleGroups, muscleGroupType = "Shoulders")
  return(result)
}

getLowerBackPivotTable <- function(muscleGroups){
  result <- getStandardSpecificMuscleGroupPivotTable(muscleGroups = muscleGroups, muscleGroupType = "Lower Back")
  return(result)
}

getForearmsPivotTable <- function(muscleGroups){
  result <- getStandardSpecificMuscleGroupPivotTable(muscleGroups = muscleGroups, muscleGroupType = "Forearms")
  return(result)
}

getLegsPivotTable <- function(muscleGroups){
  result <- getStandardSpecificMuscleGroupPivotTable(muscleGroups = muscleGroups, muscleGroupType = "Legs")
  return(result)
}

getGymAttendedPivotTable <- function(muscleGroups){
  result <- getStandardSpecificMuscleGroupPivotTable(muscleGroups = muscleGroups, muscleGroupType = "Gym Attended")
  return(result)
}

getCardioPivotTable <- function(muscleGroups){
  result <- getStandardSpecificMuscleGroupPivotTable(muscleGroups = muscleGroups, muscleGroupType = "Cardio")
  return(result)
}

#====================================================================================================

getMuscleGroupsFrequencyTable <- function(muscleGroups){
  muscleGroupsFiltered <- muscleGroups %>% select(-c(`Gym Attended`, `Cardio`))
  muscleGroupsAnalysis = melt(muscleGroupsFiltered, id.vars = c("Date", "Year","Month","MonthName"), 
                              variable.name = "Muscle Type") %>%
    group_by(Year, Month, MonthName, `Muscle Type`) %>% 
    summarise(Frequency = sum(value, na.rm = TRUE))
  
  result <- rpivotTable(aggregatorName = "Integer Sum",
                        vals = "Frequency",
                        rendererName = "Bar Chart",
                        data = muscleGroupsAnalysis, 
                        rows = "Year",
                        cols = "Muscle Type",
                        hiddenFromAggregators = c("Year", "Month", "MonthName", "Muscle Type"),
                        hiddenFromDragDrop = c("Frequency"))
  
  return(result)
}

#====================================================================================================

getMuscleGroupsRawDataTable <- function(muscleGroups){
  result <- getCopyCsvButtonsTable(inputData = muscleGroups, pageLength = 7,
                                   numberColumnNames = MuscleGroupsViewRawDataNumericColumns)
  return(result)
}