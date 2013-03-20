\name{linML}
\alias{linML}

\title{Fitting Linear Models via Maximum Likelihood}

\description{\code{linML} fits linear models by ML (maximum likelihood).
	For complete data, it is based on a object of the class \code{readCatdata}.
	For missing data, it is based on a object of the class \code{satMarML} 
	(under MAR or MCAR).
	Depending on the formulation (freedom equations or constraints), different 
	arguments must be informed.
}

\usage{linML(obj, A, X, U, start, maxit=100, trace=0, epsilon1=1e-6,
			epsilon2=1e-6, zeroN, digits)}

\arguments{
	\item{obj}{object of the class \code{readCatdata} (for complete data) or 
		\code{satMarML} (for missing data).}
	\item{A}{a matrix that specifies the linear functions of the probabilities to be 
		modeled; by default, it is 
		diag(\var{S}) \%x\% cbind(diag(\var{R-1}),rep(\var{0},\var{R-1})), which
		discards the last element of the probability vector associated to each multinomial, where \var{S} 
		represents the number of subpopulations and \var{R}, the number of response categories.}
	\item{X}{a model specification matrix for the freedom equation formulation.}
	\item{U}{a matrix for the constraint formulation.}
	\item{start}{by default, the function uses the proportions of the complete data as starting 
		values in the iterative process, but the current argument allows the user to inform an 
		alternative starting value for the parameters of the model if the 
		freedom equation formulation is considered and the matrix \var{A} is modeling \code{S*(R-1)} 
		linear functions; a vector with these values must be informed.}
	\item{maxit}{the maximum number of iterations (the default is 100).}
	\item{trace}{the alternatives are: \var{0} for no printing (default), \var{1} for showing only 
		the value of the likelihood ratio statistics at each iteration of the iterative process, 
		and \var{2} for including the parameter estimates at each iteraction.}
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
	Linear models may be fit to the functions A\%*\%Theta using a freedom equation formulation
	A\%*\%Theta=X\%*\%Beta, where Beta are the parameters to be estimated, or using a constraint formulation
	U\%*\%A\%*\%Theta=0. Both formulations lead to an equivalent model fit if U\%*\%X=0.

	The generic functions \code{print} and \code{summary} are used to print the results and to obtain a 
	summary thereof.
}

\value{
	An object of the class \code{linML} is a list containing most of the components of the 
	argument \code{obj} as well as the following components:
	\item{thetaH}{vector of ML estimates for all product-multinomial probabilities under the linear 
		model for the marginal probabilities of categorization and, in the case of missing data, under an 
		assumption of an ignorable missingness mechanism.}
	\item{VthetaH}{corresponding estimated covariance matrix.}
	\item{beta}{vector of ML estimates for the parameters of the linear model (only for freedom 
		equation formulation).}
	\item{Vbeta}{corresponding estimated covariance matrix (only for freedom equation formulation).}
	\item{Fu}{observed linear functions, without model constraints.}
	\item{VFu}{corresponding estimated covariance matrix.}
	\item{FH}{ML estimates for the linear functions under the fitted model.}
	\item{VFH}{corresponding estimated covariance matrix.}
	\item{QvH}{likelihood ratio statistic for testing the goodness of fit of the linear model 
		(for missing data, conditional on the assumed missingness mechanism).}
	\item{QpH}{Pearson statistic for testing the goodness of fit of the linear model 
		(for missing data, conditional on the assumed missingness mechanism).}
	\item{QnH}{Neyman statistic for testing the goodness of fit of the linear model 
		(for missing data, conditional on the assumed missingness mechanism).}
	\item{QwH}{Wald statistic for testing the goodness of fit of the linear model 
		(for missing data, conditional on the assumed missingness mechanism).}
	\item{glH}{degrees of freedom for testing the goodness of fit of the linear model 
		(for missing data, conditional on the assumed missingness mechanism).}
	\item{QvHMCAR}{likelihood ratio statistic for the conditional test of both the linear model 
		and MCAR given a MAR assumption (for missing data only).}
	\item{QpHMCAR}{Pearson statistic for the conditional test of both the linear model 
		and MCAR given a MAR assumption (for missing data only).}
	\item{QnHMCAR}{Neyman statistic for the conditional test of both the linear model 
		and MCAR given a MAR assumption (for missing data only).}
	\item{glHMCAR}{degrees of freedom for the conditional test of both the linear model 
		and MCAR given a MAR assumption (for missing data only).}
	\item{ystH}{for complete data, it contains the ML estimates for the frequencies under the linear 
		model; for missing data, it contains the ML estimates for the augmented frequencies under both 
		the linear model and the assumed missingness mechanism.}
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
#Example 8.1 of Paulino and Singer (2006)

e81.TF<-c(192,1,5,2,146,5,11,12,71)
e81.catdata<-readCatdata(TF=e81.TF)

e81.U<-rbind(c(0,-1, 0,1,0, 0,0,0),
			 c(0, 0,-1,0,0, 0,1,0),
			 c(0, 0, 0,0,0,-1,0,1))

e81.X<-rbind(c(1,0,0,0,0),
			 c(0,1,0,0,0),
			 c(0,0,1,0,0),
			 c(0,1,0,0,0),
			 c(0,0,0,1,0),
			 c(0,0,0,0,1),
			 c(0,0,1,0,0),
			 c(0,0,0,0,1))

#Two equivalent ways of fitting the same symmetry model

e81.linml1<-linML(e81.catdata,U=e81.U)
e81.linml2<-linML(e81.catdata,X=e81.X)
e81.linml1 #constraint formulation
e81.linml2 #freedom equation formulation
summary(e81.linml1)

#Example 8.2 of Paulino and Singer (2006)
e82.TF<-c(11,5,0,14,34,7,2,13,11)

e82.catdata<-readCatdata(TF=e82.TF)

e82.U<-rbind(c(0, 1,1,-1,0,0,-1, 0),
			 c(0,-1,0, 1,0,1, 0,-1))
e82.X<-rbind(c(1, 0, 0,0,0,0),
			 c(0, 1, 0,0,0,0),
			 c(0,-1, 1,0,1,0),
			 c(0, 0, 1,0,0,0),
			 c(0, 0, 0,1,0,0),
			 c(0, 1,-1,0,0,1),
			 c(0, 0, 0,0,1,0),
			 c(0, 0, 0,0,0,1))

e82.linml1<-linML(e82.catdata,U=e82.U)

e82.linml2<-linML(e82.catdata,X=e82.X)

e82.A<-rbind(c(1,1,1,0,0,0,0,0,0),
			 c(0,0,0,1,1,1,0,0,0),
			 c(1,0,0,1,0,0,1,0,0),
			 c(0,1,0,0,1,0,0,1,0))

e82.U2<-rbind(c(1,0,-1, 0),
			  c(0,1, 0,-1))

e82.X2<-rbind(c(1,0),
			  c(0,1),
			  c(1,0),
			  c(0,1))

e82.linml3<-linML(e82.catdata,A=e82.A,U=e82.U2)
e82.linml4<-linML(e82.catdata,A=e82.A,X=e82.X2)

#Four equivalent ways of fitting the same marginal homogeneity model
e82.linml1;e82.linml2;e82.linml3;e82.linml4

#Example 13.2 of Paulino and Singer (2006)

e132.TF2<-c(7,11,2,3,9,5,1e-5,10,4, 8,7,3,0, 0,7,14,7) #replace zero by small value
e132.Zp<-cbind(rbind(cbind(
			   kronecker(rep(1,2),diag(3)),rep(0,6)),
 			   cbind(matrix(0,3,3),rep(1,3)) ),
			   rbind(cbind(rep(1,3),matrix(0,3,3)),
			   cbind(rep(0,6),kronecker(rep(1,2),diag(3)))))
e132.Rp<-c(4,4)
e132.catdata2<-readCatdata(TF=e132.TF2,Zp=e132.Zp,Rp=e132.Rp) 

e132.satmarml2<-satMarML(e132.catdata2)

e132.U<-rbind(c(0, 1,1,-1,0,0,-1, 0),
			  c(0,-1,0, 1,0,1, 0,-1) )

e132.linml<-linML(e132.satmarml2,U=e132.U)

#Example 2 of Poleto et al (2012)
obes.TF<-rbind(
	   c( 90, 9, 3, 7, 0,1, 1, 8,16, 5,0, 0, 9,3,0,0,129,18,6,13,32, 5,33,11,70,24),
	   c(150,15, 8, 8, 8,9, 7,20,38, 3,1,11,16,6,1,3, 42, 2,3,13,45, 7,33, 4,55,14),
	   c(152,11, 8,10, 7,7, 9,25,48, 6,2,14,13,5,0,3, 36, 5,4, 3,59,17,31, 9,40, 9),
	   c(119, 7, 8, 3,13,4,11,16,42, 4,4,13,14,2,1,4, 18, 3,3, 1,82,24,23, 6,37,14),
	   c(101, 4, 2, 7, 8,0, 6,15,82, 9,8,12, 6,1,0,1, 13, 1,2, 2,95,23,34,12,15, 3),
	   c( 75, 8, 2, 4, 2,2, 1, 8,20, 0,0, 4, 7,2,0,1,109,22,7,24,23, 5,27, 5,65,19),
	   c(154,14,13,19, 2,6, 6,21,25, 3,1,11,16,3,0,4, 47, 4,1, 8,47, 7,23, 5,39,13),
	   c(148, 6,10, 8,12,0, 8,27,36, 0,7,17, 8,1,1,4, 39, 6,7,13,53,16,25, 9,23, 8),
	   c(129, 8, 7, 9, 6,2, 7,14,36, 9,4,13,31,4,2,6, 19, 1,2, 2,58,37,21, 1,23,10),
	   c( 91, 9, 5, 3, 6,0, 6,15,83,15,6,23, 5,0,0,1, 11, 1,2, 3,89,32,43,15,14, 5))


obes.Zp<-kronecker(t(rep(1,10)),
				   cbind(kronecker(diag(4),rep(1,2)),
						 kronecker(diag(2),kronecker(rep(1,2),diag(2))),
						 kronecker(rep(1,2),diag(4)),
						 kronecker(diag(2),rep(1,4)),
						 kronecker(rep(1,2),kronecker(diag(2),rep(1,2))),
						 kronecker(rep(1,4),diag(2))))

obes.Rp<-kronecker(rep(1,10),t(c(4,4,4,2,2,2)))
obes.catdata<-readCatdata(TF=obes.TF,Zp=obes.Zp,Rp=obes.Rp)
obes.mar<-satMarML(obes.catdata)

obes.A.marg <- kronecker(diag(10),t(cbind(
   			   kronecker(diag(2),rep(1,4)),
			   kronecker(rep(1,2),kronecker(diag(2),rep(1,2))),
			   kronecker(rep(1,4),diag(2))))[c(2,4,6),])

obes.age<-c(6,8,10,8,10,12,10,12,14,12,14,16,14,16,18)
obes.X2<-kronecker(diag(2),cbind(rep(1,15),obes.age,obes.age^2))

# Not run
# obes.lin2.ml<-linML(obes.mar,A=obes.A.marg,X=obes.X2)

obesR.TF<-obes.TF

obesR.TF[obesR.TF==0]<-1e-6 #Replacing null frequencies by 10^{-6}

obesR.catdata<-readCatdata(TF=obesR.TF,Zp=obes.Zp,Rp=obes.Rp)
obesR.mar<-satMarML(obesR.catdata)
obesR.lin2.ml<-linML(obesR.mar,A=obes.A.marg,X=obes.X2)

obesR.lin2.ml
}

\keyword{package}
\keyword{categorical data}
