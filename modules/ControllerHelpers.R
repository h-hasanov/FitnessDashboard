getEmptyCopyCsvButtonsTable <- function(){
  emptyDataFrame <-  data.frame(Comment = "Empty Table")
  return(getCopyCsvButtonsTable(inputData = emptyDataFrame))
}

getCopyCsvButtonsTable <- function(inputData, invisibleColumnIndeces = NULL, scrollY = NULL, 
                                   pageLength = NULL,
                                   lengthMenu = list(c(7, 14, 21, 28, -1), c("7", "14", "21", "28", "All")),
                                   numberColumnNames = NULL,
                                   decimalColumnNames = NULL){
  columnDefs <- NULL
  if(!is.null(invisibleColumnIndeces)){
    columnDefs = list(list(visible = FALSE, targets = invisibleColumnIndeces))
  }
  
  options <- list(dom = 'Blfrtip',
                  scroller = FALSE, 
                  scrollX = FALSE, 
                  info = TRUE, 
                  fixedHeader = TRUE,
                  pageLength = pageLength, lengthMenu = lengthMenu,
                  buttons = c('copy', 'csv'), columnDefs = columnDefs)
  
  if(!is.null(scrollY)){
    options$scrollY = scrollY
  }
  
  result <- datatable(inputData, colnames = names(inputData), 
                      extensions = 'Buttons', 
                      selection = 'none',
                      class = 'cell-border stripe',
                      filter = 'top',
                      rownames = FALSE,
                      options = options)
  
  if(!is.null(numberColumnNames)){
    result <- result %>% formatRound(columns = numberColumnNames, digits = 0)
  }
  
  if(!is.null(decimalColumnNames)){
    result <- result %>% formatRound(columns = decimalColumnNames, digits = 2)
  }
  
  return(renderDataTable({result}))
}