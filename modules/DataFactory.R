library(readxl)

AddYearAndMonth <- function(inputData, yearAndMontSourceName){
  result <- inputData 
  dataColumn = dplyr::pull(result, yearAndMontSourceName)
  result$Year <- as.numeric(format(dataColumn, "%Y"))
  result$Month <- as.numeric(format(dataColumn, "%m"))
  result$MonthName <- month.name[result$Month]
  return(result)
}

#====================================================================================================

LoadDailyStatistics <- function(activitiesFileName){
  dailyStatisticsRaw = readxl::read_xlsx(activitiesFileName, sheet = "Daily Activities")
  dailyStatistics <- dailyStatisticsRaw %>%
    select(-c(`1 Day Increment?`))
  
  originalColumnNames <- colnames(dailyStatistics)
  dailyStatistics <- AddYearAndMonth(inputData = dailyStatistics, yearAndMontSourceName= "Date")
 
  result <- dailyStatistics %>% select(c("Year", "Month", "MonthName", originalColumnNames))
  return(result)
}

#====================================================================================================

LoadDailyExercises <- function(activitiesFileName){
  dailyExercisesRaw = readxl::read_xlsx(activitiesFileName, sheet = "All Activities")
  
  dailyExercises <- dailyExercisesRaw  %>%
    dplyr::rename("Duration (minutes)" = "Duration") %>%
    mutate(`Duration (minutes)` = `Duration (milliseconds)`/60000) %>%
    select(-c(`Is Increasing?`))
  
  originalColumnNames <- colnames(dailyExercises)
  
  dailyExercises <- dailyExercises %>% 
    rowwise() %>%  
    mutate(Year = format(`Start Time`, "%Y"),
           Month = as.numeric(format(`Start Time`, "%m")),
           MonthName = month.name[Month])
  result <- dailyExercises %>% select(c("Year", "Month", "MonthName", originalColumnNames))
  return(result)
}

#====================================================================================================

LoadMuscleGroups <- function(activitiesFileName){
  muscleGroupsRaw = readxl::read_xlsx(activitiesFileName, sheet = "Muscle Groups")
  
  muscleGroups <- muscleGroupsRaw  %>%
    dplyr::rename("Date" = "End Date") %>%
    filter(!is.na(Date), !(Date %in% c("Total", "Average"))) %>%
    select(-c("Gym %")) %>%
    mutate(Date = as.Date(as.numeric(Date), origin = "1899-12-30"))
  
  originalColumnNames <- colnames(muscleGroups)
  
  muscleGroups <- muscleGroups %>% 
    rowwise() %>%  
    mutate(Year = format(`Date`, "%Y"),
           Month = as.numeric(format(`Date`, "%m")),
           MonthName = month.name[Month])
  result <- muscleGroups %>% select(c("Year", "Month", "MonthName", originalColumnNames))
  return(result)
}

#====================================================================================================

LoadMeasurements <- function(activitiesFileName){
  measurementsRaw = readxl::read_xlsx(activitiesFileName, sheet = "Measurements")
  
  measurements <- measurementsRaw  %>%
    select(c(`Date`, `Waist (cm)`, `Weight (kg)`, `Body Fat %`, `Body Muscle %`,
             `Chest (cm)`, `Left Arm (cm)`, `Right Arm (cm)`, `Left Forearm (cm)`,`Right Forearm (cm)`))
  
  originalColumnNames <- colnames(measurements)
  
  measurements <- measurements %>% 
    rowwise() %>%  
    mutate(Year = format(`Date`, "%Y"),
           Month = as.numeric(format(`Date`, "%m")),
           MonthName = month.name[Month])
  result <- measurements %>% select(c("Year", "Month", "MonthName", originalColumnNames))
  return(result)
}

#====================================================================================================

LoadTreadmillDetails <- function(activitiesFileName){
  treadmillRaw = readxl::read_xlsx(activitiesFileName, sheet = "Treadmill")
  
  treadmill <- treadmillRaw  %>%
    mutate(`Duration (minutes)` = lubridate::hour(Duration)*60+
             lubridate::minute(Duration)+
             lubridate::second(Duration)/60,
           `Speed (km/h)` = `Distance (km)` * 60/`Duration (minutes)`,
           `Calories (cal/min)` = Calories/`Duration (minutes)`) %>%
    select(c(`Date`, `Distance (km)`, `Duration (minutes)`, `Speed (km/h)`, Calories, `Calories (cal/min)`))
  
  originalColumnNames <- colnames(treadmill)
  
  treadmill <- treadmill %>% 
    rowwise() %>%  
    mutate(Year = format(`Date`, "%Y"),
           Month = as.numeric(format(`Date`, "%m")),
           MonthName = month.name[Month])
  result <- treadmill %>% select(c("Year", "Month", "MonthName", originalColumnNames))
  return(result)
}