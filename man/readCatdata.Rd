\name{readCatdata}
\alias{readCatdata}

\title{Reads Categorical Data}                                                      

\description{
				\code{readCatdata} inputs the categorical data, accommodating complete or 
				missing observations.
				This corresponds to objects of the classes \code{vector} or \code{matrix} which 
				represent a table of frequencies assumed to follow a product-multinomial 
				distribution.
				For complete data, only the argument \code{TF} is required. Linear, 
				log-linear and functional linear models may be subsequently fitted, 
				respectively, using the functions \code{linML()}, \code{loglinML()} and 
				\code{funlinWLS()}.
				For missing data, all arguments \code{TF}, \code{Zp} and 
				\code{Rp} are required. Before proceeding to model fitting, inferences 
				for the saturated product-multinomial parameters are conducted using 
				either the function \code{satMarML()} or \code{satMcarWLS()}.
}

\usage{readCatdata(TF, Zp, Rp)}

\arguments{
				\item{TF}{a matrix including the table of frequencies (see details).}
				\item{Zp}{a matrix with indicators of the partially classified data (see 
								details).}
				\item{Rp}{a matrix with the number of response classes corresponding to the missingness 
								patterns (see details).}
}

\details{
				Whenever \code{TF} is a vector it represents one population assumed 
				to follow a multinomial distribution. Whenever \code{TF} is a matrix, 
				each row represents a subpopulation, the set of which is assumed to follow a 
				product-multinomial distribution. 
				For complete data, \code{TF} is usually a simple matrix (table of 
				frequencies) with \var{S} rows (subpopulations) and \var{R} columns  (response 
				categories).
				For missing categorical data, each row of \code{TF} is assumed to have 
				first the \var{R} frequencies associated to the response categories of the 
				fully classified data, and thereafter the frequencies associated to the 
				response classes of the partially classified data. 
				The term response class is used to indicate that the corresponding observed data 
				may only be classified into a set of response categories and not to the individual 
				categories within this set. This is informed via indicator vectors with \var{R} rows, 
				the elements of which are equal to 1 for the positions corresponding to the 
				response categories in the response class and to 0 otherwise. 
				For computational simplicity, it is assumed that the response classes corresponding to 
				each missingness pattern belong to a partition of the response categories.
				\code{Zp} contains all the indicator vectors, which were first combined 
				columnwise within subpopulations (without mixing different missingness 
				patterns) and then between subpopulations.
				As \code{Rp} is a matrix that contains the number of response classes of 
				each missingness pattern (column) of each subpopulation (row), \code{Zp} 
				is a matrix with \var{R} rows and \code{sum(Rp)} columns.
				If the subpopulations do not have the same number of missingness patterns and/or 
				response classes, the matrices \code{TF} and \code{Rp} shall be 
				completed with "0".
				The generic functions \code{print} and \code{summary} are used to print the results and to obtain a 
				summary thereof. The latter is particularly useful for checking whether the missing categorical 
				data input was conducted in the right way.
}

\value{
				An object of the class \code{readCatdata} is a list containing at least the following components:
				\item{R}{number of response categories.}
				\item{S}{number of subpopulations.}
				\item{Tt}{number of missingness patterns of each subpopulation.}
				\item{Nst}{frequencies under each missingness pattern of each subpopulation.}
				\item{nstm}{sample size of each missingness pattern of each subpopulation.}
				\item{nsmm}{sample size of each subpopulation.}
				\item{pst}{vectors of proportions computed under each missingness pattern of each subpopulation.}
				\item{Vpst}{covariance matrices of the proportions.}
				\item{theta}{vector of estimates for all product-multinomial probabilities under 
								the saturated model (for complete data only).}
				\item{Vtheta}{corresponding covariance matrix (only for complete data).}
}


\references{
				Paulino, C.D. e Singer, J.M. (2006). \emph{Analise de dados categorizados} 
				(in Portuguese). Sao Paulo: Edgard Blucher.

				Poleto, F.Z. (2006). \emph{Analise de dados categorizados com omissao} (in 
				Portuguese). Dissertacao de mestrado. IME-USP. 
				\url{http://www.poleto.com/missing.html}.

				Poleto, F.Z., Singer, J.M. e Paulino, C.D. (2007). \emph{Analyzing categorical 
								data with complete or missing responses using the Catdata package}. Unpublished 
				vignette. \url{http://www.poleto.com/missing.html}.

				Poleto, F.Z., Singer, J.M. e Paulino, C.D. (2012). A product-multinomial 
				framework for categorical data analysis with missing responses. 
				To appear in \emph{Brazilian Journal of Probability and Statistics}. 
				\url{http://imstat.org/bjps/papers/BJPS198.pdf}.

				Singer, J. M., Poleto, F. Z. and Paulino, C. D. (2007). Catdata: software for 
				analysis of categorical data with complete or missing responses. \emph{Actas 
								de la XII Reunion Cientifica del Grupo Argentino de Biometria y I Encuentro 
								Argentino-Chileno de Biometria}. 
				\url{http://www.poleto.com/SingerPoletoPaulino2007GAB.pdf}.
}

\examples{
				#Example 1.5 of Paulino and Singer (2006)
				#S=4 subpopulations, R=4 response categories, with complete data
				e15.TF<-rbind(c(19, 5, 4, 2),
								c( 5, 8, 0,17),
								c(11, 6, 7, 6),
								c( 2, 5, 1,22))
				e15.catdata<-readCatdata(TF=e15.TF)
				e15.catdata #shows proportions and standard errors

				#Example 13.4 of Paulino and Singer (2006)
				#S=1 subpopulation, R=4 response categories, with missing data
				#2 missingness patterns with 2 response classes each

				e134.TF<-c(12,4,5,2, 50,31, 27,12)
				e134.Zp<-cbind(kronecker(diag(2),rep(1,2)),kronecker(rep(1,2),diag(2)))
				e134.Rp<-c(2,2)

				e134.catdata<-readCatdata(TF=e134.TF,Zp=e134.Zp,Rp=e134.Rp)
				e134.catdata #Proportions of the complete data
				summary(e134.catdata) #A more detailed analysis of the missing data input

				#Example 13.2 of Paulino and Singer (2006)
				#S=1 subpopulation, R=9 response categories, with missing data
				#2 missingness patterns with 4 response classes each

				e132.TF<-c(7,11,2,3,9,5,0,10,4, 8,7,3,0, 0,7,14,7)
				e132.Zp<-cbind(rbind( cbind(kronecker(rep(1,2),diag(3)),rep(0,6)),
				cbind(matrix(0,3,3),rep(1,3)) ),
				rbind( cbind(rep(1,3),matrix(0,3,3)),
				cbind(rep(0,6),kronecker(rep(1,2),diag(3))) ) )
				e132.Rp<-c(4,4)
				
				e132.catdata<-readCatdata(TF=e132.TF,Zp=e132.Zp,Rp=e132.Rp)
				summary(e132.catdata)

				#Example 1 of Poleto et al (2012)
				#S=2 subpopulation, R=9 response categories, with missing data
				#in each subpopulation: 2 missingness patterns with 3 response classes each

				smoking.TF<-rbind(c(167,17,19,10,1,3,52,10,11, 176,24,121, 28,10,12),
				c(120,22,19, 8,5,1,39,12,12, 103, 3, 80, 31, 8,14))

				smoking.Zp <- kronecker(t(rep(1,2)),
															cbind(kronecker(diag(3),rep(1,3)),
															kronecker(rep(1,3),diag(3))))

				smoking.Rp<-rbind(c(3,3),c(3,3))
				smoking.catdata<-readCatdata(TF=smoking.TF,Zp=smoking.Zp,Rp=smoking.Rp)
				smoking.catdata

				#Example 2 of Poleto et al (2012)
				#S=10 subpopulation, R=8 response categories, with missing data
				#in each subpopulation: 6 missingness patterns, 3 patterns with 4 response classes each,
				# and other 3 patterns with 2 response classes
				obes.TF<-rbind(
				c( 90, 9, 3, 7, 0,1, 1, 8,16, 5,0, 0, 9,3,0,0,129,18,6,13,32, 5,33,11,70,24) ,
				c(150,15, 8, 8, 8,9, 7,20,38, 3,1,11,16,6,1,3, 42, 2,3,13,45, 7,33, 4,55,14) ,
				c(152,11, 8,10, 7,7, 9,25,48, 6,2,14,13,5,0,3, 36, 5,4, 3,59,17,31, 9,40, 9) ,
				c(119, 7, 8, 3,13,4,11,16,42, 4,4,13,14,2,1,4, 18, 3,3, 1,82,24,23, 6,37,14) ,
				c(101, 4, 2, 7, 8,0, 6,15,82, 9,8,12, 6,1,0,1, 13, 1,2, 2,95,23,34,12,15, 3) ,
				c( 75, 8, 2, 4, 2,2, 1, 8,20, 0,0, 4, 7,2,0,1,109,22,7,24,23, 5,27, 5,65,19) ,
				c(154,14,13,19, 2,6, 6,21,25, 3,1,11,16,3,0,4, 47, 4,1, 8,47, 7,23, 5,39,13) ,
				c(148, 6,10, 8,12,0, 8,27,36, 0,7,17, 8,1,1,4, 39, 6,7,13,53,16,25, 9,23, 8) ,
				c(129, 8, 7, 9, 6,2, 7,14,36, 9,4,13,31,4,2,6, 19, 1,2, 2,58,37,21, 1,23,10) ,
				c( 91, 9, 5, 3, 6,0, 6,15,83,15,6,23, 5,0,0,1, 11, 1,2, 3,89,32,43,15,14, 5) )

				obes.Zp<-kronecker(t(rep(1,10)),
				cbind(kronecker(diag(4),rep(1,2)),
				kronecker(diag(2),kronecker(rep(1,2),diag(2))),
				kronecker(rep(1,2),diag(4)),
				kronecker(diag(2),rep(1,4)),
				kronecker(rep(1,2),kronecker(diag(2),rep(1,2))),
				kronecker(rep(1,4),diag(2))))

				obes.Rp<-kronecker(rep(1,10),t(c(4,4,4,2,2,2)))
				obes.catdata<-readCatdata(TF=obes.TF,Zp=obes.Zp,Rp=obes.Rp)

}

\keyword{categorical data}
