\name{satMcarWLS}
\alias{satMcarWLS}

\title{Fitting Saturated Models for the Marginal Probabilities of Categorization via 
				Weighted Least Squares under MCAR assumption}

\description{
	\code{satMcarWLS} fits saturated structural models for the marginal probabilities of 
	categorization under a missing completely at random (MCAR) assumption for the 
	missingness mechanism by weighted least squares (WLS) methodology.
	It is based on input data of a \code{readCatdata} object.
	Functional linear models may be subsequently fitted using function \code{funlinWLS()}.
}

\usage{satMcarWLS(catdataobj, zeroN)}

\arguments{
	\item{catdataobj}{\code{readCatdata} object.}
	\item{zeroN}{values used to replace null frequencies in the denominator of the Neyman statistic; 
		by default, the function replaces the values by \code{1/(R*nst)}, where \var{nst} 
		is the sample size of the missingness pattern associated to the corresponding subpopulation; 
		the user may indicate alternative values in a matrix with \var{S} rows and an additional column 
		relatively to the number of columns of \var{Rp}; the first column relates to the completely 
		categorized "missingness" patterns, and the remaining columns to the other missingness patterns 
		as they appear in \var{Rp}; the values must be non-negative and less or equal to 0.5.}
}

\details{
	The generic functions \code{print} and \code{summary} are used to print the results and to obtain a 
	summary thereof.
}

\value{
	An object of the class \code{satMcarWLS} is a list containing most of the components of the 
	\code{readCatdata} source object informed in the argument \code{catdataobj} as well as
	the following components:
  \item{theta}{vector of WLS estimates for all product-multinomial probabilities under the saturated 
  	model for the marginal probabilities of categorization and a MCAR assumption.}
  \item{Vtheta}{corresponding estimated covariance matrix.}
  \item{QnMCAR}{the Neyman statistic for the conditional test of MCAR given a MAR assumption.}
  \item{glMCAR}{degrees of freedom for the conditional test of MCAR given a MAR assumption.}
  \item{yst}{WLS estimates for the augmented frequencies under the saturated model for the marginal 
  	probabilities and the MCAR mechanism.}
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
	#Example 13.4 of Paulino and Singer (2006)
	e134.TF<-c(12,4,5,2, 50,31, 27,12)
	e134.Zp<-cbind(kronecker(diag(2),rep(1,2)),kronecker(rep(1,2),diag(2)))
	e134.Rp<-c(2,2)
	e134.catdata<-readCatdata(TF=e134.TF,Zp=e134.Zp,Rp=e134.Rp)
	e134.satmcarwls<-satMcarWLS(e134.catdata)
	e134.satmcarwls
	
	#Example 1 of Poleto et al (2012)
	smoking.TF<-rbind(c(167,17,19,10,1,3,52,10,11, 176,24,121, 28,10,12),
	c(120,22,19, 8,5,1,39,12,12, 103, 3, 80, 31, 8,14))

	smoking.Zp <- kronecker(t(rep(1,2)),
															cbind(kronecker(diag(3),rep(1,3)),
															kronecker(rep(1,3),diag(3))))

	smoking.Rp<-rbind(c(3,3),c(3,3))

	smoking.catdata<-readCatdata(TF=smoking.TF,Zp=smoking.Zp,Rp=smoking.Rp)
	smoking.satmcarwls<-satMcarWLS(smoking.catdata)
	smoking.satmcarwls
}

\keyword{categorical data}
