\name{loglinML}
\alias{loglinML}

\title{Fitting Log-Linear Models via Maximum Likelihood}

\description{
	\code{loglinML} fits log-linear models by ML (maximum likelihood).
	For complete data, it is based on a object of the class \code{readCatdata}.
	For missing data, it is based on a object of the class \code{satMarML} 
	(under MAR or MCAR).
	Depending on the formulation (freedom equations or constraints) and on the model 
	type (ordinary or generalized log-linear model), different arguments must be informed.
}

\usage{loglinML(obj, A, X, U, XL, UL, start, maxit=100, trace=0, epsilon1=1e-6, 
	epsilon2=1e-6, zeroN, digits)}

\arguments{
	\item{obj}{object of the class \code{readCatdata} (for complete data) or 
		\code{satMarML} (for missing data).}
	\item{A}{a matrix that specifies the log-linear functions of the probabilities to be 
		modeled; by default, it is 
		diag(\var{S}) \%x\% cbind(diag(\var{R-1}),rep(\var{-1},\var{R-1})), which
		generates logits with the last (R) category as baseline.}
	\item{X}{a model specification matrix for the freedom equation formulation of 
		the ordinary log-linear model.}
	\item{U}{a matrix for the constraint formulation of the ordinary log-linear specification.}
	\item{XL}{a model specification matrix for the freedom equation formulation of 
		the generalized log-linear model.}
	\item{UL}{a matrix for the constraint formulation of the generalized log-linear 
		model.}
	\item{start}{by default, the function uses the proportions of the complete data as starting 
		values in the iterative process, but the current argument allows the user to inform an 
		alternative starting value for the parameters of the model if the freedom equation formulation 
		is considered and the matrix \var{A} is modeling \code{S*(R-1)} log-linear functions; 
		a vector with these values must be informed.}
	\item{maxit}{the maximum number of iterations (the default is 100).}
	\item{trace}{the alternatives are: \var{0} for no printing (default), \var{1} for showing only 
		the value of the likelihood ratio statistics at each iteration of the iterative process, 
		and \var{2} for including also the parameter estimates at each iteraction.}
	\item{epsilon1}{the convergence criterion of the iterative process is attained if the 
		absolute difference of the values of the likelihood ratio statistic in successive iterations 
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
	\code{loglinML} handles both ordinary and generalized log-linear model types either under
	a freedom equation formulation or under a constraint formulation.
	X and U are used for ordinary log-linear models, and XL and UL are used for generalized 
	log-linear models.
	X and XL are used for the freedom equation formulation, and U and UL are used for the constraint 
	formulation.
	Namely, the 4 ways with which the function allows to specify the model are: 
	log(Theta)=nu+X\%*\%Beta, U\%*\%log(Theta)=0, A\%*\%log(Theta)=XL\%*\%Beta, 
	UL\%*\%A\%*\%log(Theta)=0, where nu are non-estimated parameters included only to satisfy the 
	natural constraints of the product-multinomial distribution and Beta are the parameters to be 
	estimated.

	The generic functions \code{print} and \code{summary} are used to print the results and to obtain a 
	summary thereof.
}

\value{
	An object of the class \code{loglinML} is a list containing most of the components of the 
	argument \code{obj} as well as the following components:
  \item{thetaH}{vector of ML estimates for all product-multinomial probabilities under the log-linear 
  	model for the marginal probabilities of categorization and, in the case of missing data, under an 
  	assumption of an ignorable missingness mechanism.}
  \item{VthetaH}{corresponding estimated covariance matrix.}
  \item{beta}{vector of ML estimates for the parameters of the log-linear model (only for freedom 
  	equation formulation).}
  \item{Vbeta}{corresponding estimated covariance matrix (only for the freedom equation formulation).}
  \item{Fu}{observed log-linear functions, without model constraints.}
  \item{VFu}{corresponding estimated covariance matrix.}
  \item{FH}{ML estimates for the log-linear functions under the fitted model.}
  \item{VFH}{corresponding estimated covariance matrix.}
  \item{QvH}{likelihood ratio statistic for testing the goodness of fit of the log-linear model 
  	(for missing data, conditional on the assumed missingness mechanism).}
  \item{QpH}{Pearson statistic for testing the goodness of fit of the log-linear model 
  	(for missing data, conditional on the assumed missingness mechanism).}
  \item{QnH}{Neyman statistic for testing the goodness of fit of the log-linear model 
  	(for missing data, conditional on the assumed missingness mechanism).}
  \item{QwH}{Wald statistic for testing the goodness of fit of the log-linear model 
  	(for missing data, conditional on the assumed missingness mechanism).}
  \item{glH}{degrees of freedom for testing the goodness of fit of the log-linear model 
  	(for missing data, conditional on the assumed missingness mechanism).}
  \item{QvHMCAR}{likelihood ratio statistic for the conditional test of both the log-linear model 
  	and MCAR given a MAR assumption (for missing data only).}
  \item{QpHMCAR}{Pearson statistic for the conditional test of both the log-linear model 
  	and MCAR given a MAR assumption (for missing data only).}
  \item{QnHMCAR}{Neyman statistic for the conditional test of both the log-linear model 
  	and MCAR given a MAR assumption (for missing data only).}
  \item{glHMCAR}{degrees of freedom for the conditional test of both the log-linear model 
  	and MCAR given a MAR assumption (for missing data only).}
  \item{ystH}{for complete data, it has the ML estimates for the frequencies under the log-linear 
  	model; for missing data, it has the ML estimates for the augmented frequencies under both 
  	the log-linear model and the assumed missingness mechanism.}
}

\author{
	Frederico Zanqueta Poleto(\email{frederico@poleto.com})\cr
	Julio da Motta Singer (\email{jmsinger@ime.usp.br})\cr
	Carlos Daniel Paulino (\email{daniel.paulino@math.ist.utl.pt})\cr
 with the collaboration of \cr
	Fabio Mathias Correa (\email{fmcorrea@uesc.br})\cr
	Enio Galinkin Jelihovschi (\email{eniojelihovs@gmail.com})\cr
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
	#Example 9.1 of Paulino and Singer (2006)
	e91.TF<-c(3,25,32,68)
	e91.catdata<-readCatdata(TF=e91.TF)
	e91.U<-c(1,-1,-1,1)
	
	e91.X<-rbind(c(0,0), c(0,1),
	             c(1,0), c(1,1))

	e91.X2<-rbind(c(0,0,0),
    	          c(0,1,0),
        	      c(1,0,0),
	              c(1,1,1))
	
	e91.loglinml1<-loglinML(e91.catdata,U=e91.U)
	e91.loglinml2<-loglinML(e91.catdata,X=e91.X)
	e91.loglinml3<-loglinML(e91.catdata,X=e91.X2)
	e91.loglinml4<-loglinML(e91.catdata,A=c(1,-1,-1,1),XL=1)

	# Independence ordinary log-linear model, constraint formulation
	e91.loglinml1 
	# Independence ordinary log-linear model, freedom equation formulation
	e91.loglinml2 
	#Saturated ordinary log-linear model, freedom equation formulation
	e91.loglinml3 

	#Saturated generalized log-linear model, freedom equation formulation
	e91.loglinml4 
	
	#95\% confidence interval for log-odds ratio and for odds ratio
	round(e91.loglinml4$beta+c(-1,1)*qnorm(0.975)*sqrt(e91.loglinml4$Vbeta),3)
	round(exp(e91.loglinml4$beta),3)
	round(exp(e91.loglinml4$beta+c(-1,1)*qnorm(0.975)*sqrt(e91.loglinml4$Vbeta)),3)

	#Example 1 of Poleto et al (2012)
	smoking.TF<-rbind(c(167,17,19,10,1,3,52,10,11, 176,24,121, 28,10,12),
	                  c(120,22,19, 8,5,1,39,12,12, 103, 3, 80, 31, 8,14))
	
	smoking.Zp<-t(rep(1,2))\%x\%cbind(diag(3)\%x\%rep(1,3), rep(1,3)\%x\%diag(3))
	
	smoking.Rp<-rbind(c(3,3),c(3,3))
	
	smoking.catdata<-readCatdata(TF=smoking.TF,Zp=smoking.Zp,Rp=smoking.Rp)
	smoking.catdata #Proportions of the complete data
	
	smoking.satmarml<-satMarML(smoking.catdata)
	smoking.satmcarml<-satMarML(smoking.catdata,missing="MCAR")
	
	smoking.E<-rbind(c(1,-1,0),c(0,1,-1))
	
	smoking.A<-diag(2)\%x\%smoking.E\%x\%smoking.E
	smoking.loglin2.marml<-loglinML(smoking.satmarml,A=smoking.A,XL=rep(1,8))
	smoking.loglin2.mcarml<-loglinML(smoking.satmcarml,A=smoking.A,XL=rep(1,8))
}

\keyword{package}
\keyword{categorical data}
