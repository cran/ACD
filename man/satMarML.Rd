\name{satMarML}
\alias{satMarML}

\title{Fitting Saturated Models for the Marginal Probabilities of Categorization via 
				Maximum Likelihood under MAR and MCAR assumption}

\description{
	\code{satMarML} fits saturated models for the marginal probabilities of 
	categorization as well as missing at random (MAR) or missing completely at random (MCAR) 
	models for the missingness mechanism by maximum likelihood (ML) methodology.
	It is based on input data of a \code{readCatdata} object.
	Linear, log-linear and functional linear models may be subsequently fitted, 
	respectively, using functions \code{linML()}, \code{loglinML()} and 
	\code{funlinWLS()}.
}

\usage{satMarML(catdataobj, missing="MAR", method="EM", start, zero, 
				maxit=100, trace=0, epsilon1=1e-6, epsilon2=1e-6, zeroN, digits) 
}

\arguments{
	\item{catdataobj}{\code{readCatdata} object.}
	\item{missing}{the covariance matrix (based on a Fisher information matrix) of the 
		estimates for the marginal probabilities of categorization may be computed under 
		\code{"MAR"} (default) or under \code{"MCAR"} model.}
	\item{method}{the iterative processes available are: \code{"EM"} (Expectation-Maximization), 
		\code{"FS-MCAR"} (Fisher scoring under MCAR), and \code{"NR/FS-MAR"} 
		(Fisher scoring under MAR or Newton-Raphson under MAR or MCAR); \code{"EM"}
		is the default option, because it is the most stable, although in some cases, the 
		default maximum number of iterations may not be enough due to its slow rate of convergence; 
		as the ML estimates of the marginal probabilities are the same either under MAR or MCAR, 
		one may use the iterative process \code{"FS-MCAR"} even though one is willing to 
		assume MAR; \code{"FS-MCAR"} is generally more stable than \code{"NR/FS-MAR"} 
		when there are sampling zeros, but both iterative processes still may easily jump to a negative 
		estimate and/or generate a singular covariance matrix.}
	\item{start}{by default, the function uses the proportions of the complete data as starting 
		values in the iterative process, but the current argument allows the user to inform an 
		alternative starting value for all marginal probabilities except the one corresponding to the 
		last category of each multinomial, i.e., a vector of dimension \code{S*(R-1)}, where 
		\var{S} represents the number of subpopulations and \var{R}, the number of response categories.}
	\item{zero}{when there are sampling zeros in the complete data, these frequencies are replaced 
		by small values just for the computation of the starting values; this avoids the use of 
		starting values on the boundary of the parameter space and also allows to incorporate 
		information from other missingness patterns in the EM iterative process; by default, the 
		function replaces the values by \code{1/(R*ns1)}, where \var{ns1} is the sample 
		size associated to the subpopulation with completely classified data; the user may indicate an 
		alternative vector with \var{S} values to be used for each subpopulation or an unique value to 
		be used for all subpopulations; the values must be non-negative and less or equal to 0.5.}
	\item{maxit}{the maximum number of iterations (the default is 100).}
	\item{trace}{the alternatives are: \var{0} for no printing (default), \var{1} for showing only 
		the value of the likelihood ratio statistic at each iteration of the iterative process, 
		and \var{2} for including also the parameter estimates at each iteration.}
	\item{epsilon1}{the convergence criterion of the iterative process is attained if the 
		absolute difference of the values of the likelihood ratio statistic of successive iterations 
		is less than the value defined in \code{epsilon1}, \code{1e-6} by default.}
	\item{epsilon2}{the convergence criterion of the iterative process is attained if the 
		absolute differences of the values of estimates for all parameters of the marginal 
		probabilities of categorization in consecutive iterations are less than the value defined 
		in \code{epsilon2}, \code{1e-6} by default.}
	\item{zeroN}{values used to replace null frequencies in the denominator of the Neyman statistic; 
		by default, the function replaces the values by \code{1/(R*nst)}, where \var{nst} 
		is the sample size of the missingness pattern associated to the corresponding subpopulation; 
		the user may indicate alternative values in a matrix with \var{S} rows and an additional column 
		relatively to the number of columns of \var{Rp}; the first column relates to the completely 
		categorized "missingness" patterns, and the remaining columns to the other missingness patterns 
		as they appear in \var{Rp}; the values must be non-negative and less or equal to 0.5.}
	\item{digits}{integer value indicating the number of decimal places to round results when shown
		by \code{print} and \code{summary}; this argument works also when specified 
		directly in both generic functions; default value is 4.}
}

\details{
	The generic functions \code{print} and \code{summary} are used to print the results and to obtain a 
	summary thereof.
}

\value{
	An object of the class \code{satMarML} is a list containing most of the components of the 
	\code{readCatdata} source object informed in the argument \code{catdataobj} as well as
	the following components:
  \item{theta}{vector of ML estimates for all product-multinomial probabilities under the saturated 
  	model for the marginal probabilities of categorization and an assumption of an ignorable missingness 
  	mechanism; this is the same under MAR and under MCAR.}
  \item{Vtheta}{corresponding estimated covariance matrix based on the Fisher information matrix 
  	obtained under the assumed missingness mechanism, leading to different results depending whether the 
  	assumption is MAR or MCAR).}
  \item{QvMCAR}{likelihood ratio statistic for the conditional test of MCAR given a MAR assumption.}
  \item{QpMCAR}{Pearson statistic for the conditional test of MCAR given a MAR assumption.}
  \item{QnMCAR}{Neyman statistic for the conditional test of MCAR given a MAR assumption.}
  \item{glMCAR}{degrees of freedom for the conditional tests of MCAR given a MAR assumption.}
  \item{alphast}{ML estimates for the conditional probabilities of missingness under the assumed 
  	missingness mechanism (MAR or MCAR).}
  \item{yst}{ML estimates for the augmented frequencies under the saturated model for the marginal 
  	probabilities and the assumed missingness mechanism (MAR or MCAR).}
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
				e134.satmcarml<-satMarML(e134.catdata,missing="MCAR")
				e134.satmarml<-satMarML(e134.catdata,method="FS-MCAR")
				e134.satmarml2<-satMarML(e134.catdata,method="NR/FS-MAR")
				e134.satmcarml

				#Compare the estimates of the probabilities, standard errors, 
				#number of iterations and augmented frequencies
				summary(e134.satmcarml)
				summary(e134.satmarml)
				summary(e134.satmarml2)

				#Example 1 of Poleto et al (2012)
				smoking.TF<-rbind(c(167,17,19,10,1,3,52,10,11, 176,24,121, 28,10,12),
				c(120,22,19, 8,5,1,39,12,12, 103, 3, 80, 31, 8,14))

				smoking.Zp <- kronecker(t(rep(1,2)),
																		cbind(kronecker(diag(3),rep(1,3)),
																		kronecker(rep(1,3),diag(3))))

				smoking.Rp<-rbind(c(3,3),c(3,3))
				smoking.catdata<-readCatdata(TF=smoking.TF,Zp=smoking.Zp,Rp=smoking.Rp)
				smoking.catdata

				smoking.satmcarml<-satMarML(smoking.catdata,missing="MCAR")
				smoking.satmarml<-satMarML(smoking.catdata,method="FS-MCAR")
				smoking.satmarml2<-satMarML(smoking.catdata,method="NR/FS-MAR")
				smoking.satmarml
				summary(smoking.satmcarml)
				summary(smoking.satmarml)
				summary(smoking.satmarml2)
}

\keyword{categorical data}
