pollutantmean <- function(directory, pollutant, id = 1:332){
  df <- data.frame(Date = character(), sulfate = double(), nitrate = double(), ID = integer())
  
  for (i in id){
    file = paste(sprintf("%03i", i), ".csv", sep = "")
    pathfile = paste(normalizePath(getwd()), directory, file, sep = "\\")
    df <- rbind(df, read.csv(pathfile))
  }
  
  values = df[[pollutant]] 
  mean(values[!is.na(values)])
}