StatisticsViewDataColumns <- c("Month", "MonthName")
StatisticsViewDataRows <- "Year"
StatisticsViewHiddenFromAggregators <- c("Month", "Year", "MonthName", "Date")
StatisticsViewHiddenFromDragDrop <- c("Date", "Resting Heart Rate", "Calories (BMR)", "Calories (Total)", "Calories (Activity)", "Steps",
                                      "Distance (Total) (km)", "Floors", "Elevation", "Sedentary Minutes", "Lightly Active Minutes", 
                                      "Fairly Active Minutes", "Very Active Minutes")
StatisticsViewRawDataNumericColumns <- c("Resting Heart Rate", "Calories (BMR)", "Calories (Total)", "Calories (Activity)", "Steps",
                                        "Distance (Total) (km)", "Floors", "Elevation", "Sedentary Minutes", "Lightly Active Minutes", 
                                        "Fairly Active Minutes", "Very Active Minutes")

StatisticsViewSpecificActivityHiddenFromDragDrop <- StatisticsViewHiddenFromDragDrop

getAllStatisticsPivotTable <- function(dailyStatistics){
  
  result <- rpivotTable(aggregatorName="Average",
                        vals = "Very Active Minutes",
                        rendererName = "Line Chart",
                        data = dailyStatistics,
                        cols = StatisticsViewDataColumns,
                        rows = StatisticsViewDataRows,
                        hiddenFromAggregators = StatisticsViewHiddenFromAggregators,
                        hiddenFromDragDrop = StatisticsViewHiddenFromDragDrop)
  return(result)
}

#====================================================================================================

getSpecificStatisticsPivotTable <- function(dailyStatistics, 
                                            statisticType,
                                            aggregatorName,  
                                            rendererName){
  filteredDailyExercises <- dailyStatistics %>% select(c(StatisticsViewDataColumns,
                                                         StatisticsViewDataRows,
                                                         statisticType))
  
  result <- rpivotTable(aggregatorName = aggregatorName,
                        vals = statisticType,
                        rendererName = rendererName,
                        data = filteredDailyExercises, 
                        cols = StatisticsViewDataColumns, 
                        rows = StatisticsViewDataRows, 
                        hiddenFromAggregators = StatisticsViewHiddenFromAggregators,
                        hiddenFromDragDrop = StatisticsViewSpecificActivityHiddenFromDragDrop)
  return(result)
}

getDailyHeartRatePivotTable <- function(dailyStatistics){
  result <- getSpecificStatisticsPivotTable(dailyStatistics = dailyStatistics,
                                            statisticType = "Resting Heart Rate",
                                            aggregatorName = "Average",  
                                            rendererName = "Table")
}

getDailyCaloriesActivityPivotTable <- function(dailyStatistics){
  result <- getSpecificStatisticsPivotTable(dailyStatistics = dailyStatistics,
                                            statisticType = "Calories (Activity)",
                                            aggregatorName = "Average",  
                                            rendererName = "Table")
}

getDailyCaloriesTotalPivotTable <- function(dailyStatistics){
  result <- getSpecificStatisticsPivotTable(dailyStatistics = dailyStatistics,
                                            statisticType = "Calories (Total)",
                                            aggregatorName = "Average",  
                                            rendererName = "Table")
}

getDailyStepsPivotTable <- function(dailyStatistics){
  result <- getSpecificStatisticsPivotTable(dailyStatistics = dailyStatistics,
                                            statisticType = "Steps",
                                            aggregatorName = "Average",  
                                            rendererName = "Table")
}

getDailySedentaryMinutesPivotTable <- function(dailyStatistics){
  result <- getSpecificStatisticsPivotTable(dailyStatistics = dailyStatistics,
                                            statisticType = "Sedentary Minutes",
                                            aggregatorName = "Average",  
                                            rendererName = "Table")
}

getDailyVeryActiveMinutesPivotTable <- function(dailyStatistics){
  result <- getSpecificStatisticsPivotTable(dailyStatistics = dailyStatistics,
                                            statisticType = "Very Active Minutes",
                                            aggregatorName = "Average",  
                                            rendererName = "Table")
}

#====================================================================================================

getDailyStatisticsRawDataTable <- function(dailyStatistics){
  result <- getCopyCsvButtonsTable(inputData = dailyStatistics, pageLength = 7,
                                   numberColumnNames = StatisticsViewRawDataNumericColumns)
  return(result)
}