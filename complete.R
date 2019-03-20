complete <- function(directory, id = 1:332){
  df_obs <- data.frame(id = integer(), nobs = integer())
  for (i in id){
    file = paste(sprintf("%03i", i), ".csv", sep = "")
    pathfile = paste(normalizePath(getwd()), directory, file, sep = "\\")
    
    # Tengo que calcular el número de casos completos
    df <- read.csv(pathfile)
    ok <- complete.cases(df)
    df_obs <- rbind(df_obs, c(i, sum(ok)))
  }
  colnames(df_obs) <- c("id", "nobs")
  df_obs
}