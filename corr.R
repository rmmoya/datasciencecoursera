corr <- function(directory, threshold = 0){
  
  df <- data.frame(Date = character(), sulfate = double(), 
                   nitrate = double(), ID = integer())
  c <- double()
  
  for (i in 1:332){
    file = paste(sprintf("%03i", i), ".csv", sep = "")
    pathfile = paste(normalizePath(getwd()), directory, file, sep = "\\")
    df <- read.csv(pathfile)
    ok <- complete.cases(df$sulfate, df$nitrate)
    # print(paste(i, length(df$sulfate[ok])))
    if (threshold < length(df$sulfate[ok])){
      c <- c(c, cor(df$sulfate[ok], df$nitrate[ok]))
    }
    
  }
  
  
  # ok <- sample(ok, threshold)
  c
}