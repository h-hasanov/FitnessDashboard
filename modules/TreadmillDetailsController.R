TreadmillDetailsViewDataColumns <- c("Month", "MonthName")
TreadmillDetailsViewDataRows <- c("Year")
TreadmillDetailsViewHiddenFromAggregators <- c("Month", "Year", "MonthName", "Date")
TreadmillDetailsViewHiddenFromDragDrop <- c("Date", "Distance (km)", "Duration (minutes)", "Speed (km/h)", "Calories", "Calories (cal/min)")

TreadmillDetailsViewRawDataNumericColumns <- c("Distance (km)", "Duration (minutes)", "Speed (km/h)", "Calories", "Calories (cal/min)")
TreadmillDetailsViewSpecificTreadmillDetailHiddenFromDragDrop <- TreadmillDetailsViewHiddenFromDragDrop

getTreadmillDetailsPivotTable <- function(treadmillDetails){
  
  result <- rpivotTable(aggregatorName = "Sum",
                        vals = "Distance (km)",
                        rendererName = "Line Chart",
                        data = treadmillDetails,
                        cols = TreadmillDetailsViewDataColumns,
                        rows = TreadmillDetailsViewDataRows,
                        hiddenFromAggregators = TreadmillDetailsViewHiddenFromAggregators,
                        hiddenFromDragDrop = TreadmillDetailsViewHiddenFromDragDrop)
  return(result)
}

#====================================================================================================

getSpecificTreadmillDetailPivotTable <- function(treadmillDetails,
                                                 treadmillDetailType,
                                                 aggregatorName,
                                                 rendererName){
  filteredTreadmillDetail <- treadmillDetails %>% select(c(TreadmillDetailsViewDataColumns,
                                                           TreadmillDetailsViewDataRows,
                                                           treadmillDetailType))
  
  result <- rpivotTable(aggregatorName = aggregatorName,
                        vals = treadmillDetailType,
                        rendererName = rendererName,
                        data = filteredTreadmillDetail,
                        cols = TreadmillDetailsViewDataColumns,
                        rows = TreadmillDetailsViewDataRows,
                        hiddenFromAggregators = TreadmillDetailsViewHiddenFromAggregators,
                        hiddenFromDragDrop = TreadmillDetailsViewSpecificTreadmillDetailHiddenFromDragDrop)
  return(result)
}

getStandardSpecificTreadmillDetailPivotTable <- function(treadmillDetails,
                                                         treadmillDetailType,
                                                         aggregatorName = "Average"){
  
  result <- getSpecificTreadmillDetailPivotTable(treadmillDetails = treadmillDetails,
                                                 treadmillDetailType = treadmillDetailType,
                                                 aggregatorName = aggregatorName,
                                                 rendererName = "Line Chart")
  return(result)
}

getTreadmillDistancePivotTable <- function(treadmillDetails){
  result <- getStandardSpecificTreadmillDetailPivotTable(treadmillDetails = treadmillDetails, 
                                                         treadmillDetailType = "Distance (km)",
                                                         aggregatorName = "Sum")
  return(result)
}

getTreadmillSpeedPivotTable <- function(treadmillDetails){
  result <- getStandardSpecificTreadmillDetailPivotTable(treadmillDetails = treadmillDetails, 
                                                         treadmillDetailType = "Speed (km/h)")
  return(result)
}


getTreadmillDurationPivotTable <- function(treadmillDetails){
  result <- getStandardSpecificTreadmillDetailPivotTable(treadmillDetails = treadmillDetails, 
                                                         treadmillDetailType = "Duration (minutes)",
                                                         aggregatorName = "Sum")
  return(result)
}

getTreadmillCaloriesPivotTable <- function(treadmillDetails){
  result <- getStandardSpecificTreadmillDetailPivotTable(treadmillDetails = treadmillDetails, 
                                                         treadmillDetailType = "Calories",
                                                         aggregatorName = "Sum")
  return(result)
}

getTreadmillCaloriesPerMinutePivotTable <- function(treadmillDetails){
  result <- getStandardSpecificTreadmillDetailPivotTable(treadmillDetails = treadmillDetails, 
                                                         treadmillDetailType = "Calories (cal/min)")
  return(result)
}

#====================================================================================================

getTreadmillDetailsRawDataTable <- function(treadmillDetails){
  result <- getCopyCsvButtonsTable(inputData = treadmillDetails, pageLength = 7,
                                   decimalColumnNames = TreadmillDetailsViewRawDataNumericColumns)
  return(result)
}