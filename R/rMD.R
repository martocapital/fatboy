
rMD <- function(fileName){
	#read csv into data frame
	read.csv(fileName) -> df
	cat(fileName, dim(df),'\n')

	i = 1

	df[i,][-1] -> row

	row$code -> code
	row$code <- NULL

	paste('(',code,',',names(row),',',row,')', sep="", collapse=",") -> w

	w
}
