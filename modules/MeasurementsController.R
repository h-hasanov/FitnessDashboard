MeasurementsViewDataColumns <- c("Year", "Month", "MonthName")
MeasurementsViewDataRows <- character(0)
MeasurementsViewHiddenFromAggregators <- c("Month", "Year", "MonthName", "Date")
MeasurementsViewHiddenFromDragDrop <- c("Date", "Waist (cm)", "Weight (kg)", "Body Fat %", "Body Muscle %",
                                        "Chest (cm)", "Left Arm (cm)", "Right Arm (cm)", "Left Forearm (cm)",
                                        "Right Forearm (cm)")

MeasurementsViewRawDataNumericColumns <- c("Waist (cm)", "Weight (kg)", "Body Fat %", "Body Muscle %",
                                           "Chest (cm)", "Left Arm (cm)", "Right Arm (cm)", "Left Forearm (cm)",
                                           "Right Forearm (cm)")
MeasurementsViewSpecificMeasurementHiddenFromDragDrop <- MeasurementsViewHiddenFromDragDrop

getMeasurementsPivotTable <- function(measurements){

  result <- rpivotTable(aggregatorName = "Average",
                        vals = "Weight (kg)",
                        rendererName = "Line Chart",
                        data = measurements,
                        cols = MeasurementsViewDataColumns,
                        rows = MeasurementsViewDataRows,
                        hiddenFromAggregators = MeasurementsViewHiddenFromAggregators,
                        hiddenFromDragDrop = MeasurementsViewHiddenFromDragDrop)
  return(result)
}

#====================================================================================================

getSpecificMeasurementPivotTable <- function(measurements,
                                             measurementType,
                                             aggregatorName,
                                             rendererName){
  filteredMeasurement <- measurements %>% select(c(MeasurementsViewDataColumns,
                                                   MeasurementsViewDataRows,
                                                   measurementType))

  result <- rpivotTable(aggregatorName = aggregatorName,
                        vals = measurementType,
                        rendererName = rendererName,
                        data = filteredMeasurement,
                        cols = MeasurementsViewDataColumns,
                        rows = MeasurementsViewDataRows,
                        hiddenFromAggregators = MeasurementsViewHiddenFromAggregators,
                        hiddenFromDragDrop = MeasurementsViewSpecificMeasurementHiddenFromDragDrop)
  return(result)
}

getStandardSpecificMeasurementPivotTable <- function(measurements,
                                                     measurementType){

  result <- getSpecificMeasurementPivotTable(measurements = measurements,
                                             measurementType = measurementType,
                                             aggregatorName = "Average",
                                             rendererName = "Line Chart")
  return(result)
}

getBodyWeightPivotTable <- function(measurements){
  result <- getStandardSpecificMeasurementPivotTable(measurements = measurements, measurementType = "Weight (kg)")
  return(result)
}

getWaistPivotTable <- function(measurements){
  result <- getStandardSpecificMeasurementPivotTable(measurements = measurements, measurementType = "Waist (cm)")
  return(result)
}


getBodyFatPivotTable <- function(measurements){
  result <- getStandardSpecificMeasurementPivotTable(measurements = measurements, measurementType = "Body Fat %")
  return(result)
}

getBodyMusclePivotTable <- function(measurements){
  result <- getStandardSpecificMeasurementPivotTable(measurements = measurements, measurementType = "Body Muscle %")
  return(result)
}

#====================================================================================================

getMeasurementsRawDataTable <- function(measurements){
  result <- getCopyCsvButtonsTable(inputData = measurements, pageLength = 7,
                                   numberColumnNames = MeasurementsViewRawDataNumericColumns)
  return(result)
}