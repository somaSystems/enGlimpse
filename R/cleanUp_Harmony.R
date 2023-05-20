# data_path <- ""

clean_up <- function(Harmony_data_path = NULL){
  headers = read.csv(Harmony_data_path, skip = 9, header = F, nrows = 1, as.is = T, sep = "\t")
  # headers
  df = read.csv(Harmony_data_path, skip = 10, header = F, sep = "\t")
  colnames(df) <- headers
  head(df)
  colnames(df) <- gsub(" ","_",colnames(df))
  colnames(df) <- gsub("-","",colnames(df))
  colnames(df) <- gsub("__","_",colnames(df))
  df
}
