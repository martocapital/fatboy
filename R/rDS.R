#' A read Data Series
#'
#' This function allows you to express your love of cats.
#' @param love Do you love cats? Defaults to TRUE.
#' @keywords cats
#' @export
#' @import foreach doMC
#' @examples
#' rDS()


#mydb = dbConnect(MySQL(), user='manoj', password='password', host='localhost',dbName='martocapital')
#try1 = fetch(dbSendQuery(mydb, "SELECT book_id, title, description ... ;") ==> remember about ';'

rDS <- function(fileNameList){

	query <- 'INSERT INTO numDataSeries (vendorId, dataSeriesCode, observationDate, observationValue) values' 
	# should have this: values(i,j,k), (a,b,c)

	for( fileName in fileNameList) {
		#read file
		df <- read.csv(fileName)
		cat(fileName, ':', dim(df),'\n')

		#read date list (first is empty - see CSV format)
		dl <- colnames(df)[-1]
		dl <- as.Date(substr(dl,2,nchar(dl)), format="%Y.%m.%d")

		#print(dl)

		vId = 1

		l <- foreach( i=1:nrow(df)) %dopar% {
			dsc <- df[i,1]
			dv <- df[i,2:ncol(df)]
			dv <- gsub('NA','NULL',dv)
			v <- paste('(',"'",vId,"'",',',dcs,',',"'", dl, "'",',',dv,')',sep="", collapse=",")
		}

		q <- paste(query, l, ';' ,sep="",collapse=",")
		#dbSendQuery(mydb,q)
	}
}

