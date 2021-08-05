#!/usr/bin/env Rscript

# Author: David M. Louis
# Contact: dmlouis@stanford.edui
# Contact: dmlouis87@gmail.com

############################### Arguments ###############################

# expected format of input file is

cmd_args = commandArgs(trailingOnly = TRUE);
# midread_table_file = cmd_args[6] ???????????

input_file=read.csv(cmd_args, header=T)
# tableLength=length(midread_table[,1])
# print(cmd_args) #prints file name
print(paste0("input length: ", length(rownames(input_file))))
#midread_matrix=data.matrix(midread_table)

############################################################################################
# Analysis Functions
############################################################################################

#clean up GLIPH output
GLIPH_cleaner <- function(GLIPH_df) {
  GLIPH_df[GLIPH_df==""] <- NA
  data <- GLIPH_df[rowSums(is.na(GLIPH_df)) != ncol(GLIPH_df), ]
  data <- data[!grepl("single", data$pattern), ]
  if (sum(is.na(data$Sample)) > 0) {
    print("Samples containes NA. Removing all rows. Add missing values if row data is desired in outcome")
    data <- data[!is.na(data$Sample),]
  }
  return(data)
}

#Function ends

############################### Analysis  #################################

clean_input <- GLIPH_cleaner(input_file)

############################### Outputs #################################

write.csv(clean_input, file = paste0("clean_", gsub("^.*/", "", cmd_args)), quote = F, row.names = F)
