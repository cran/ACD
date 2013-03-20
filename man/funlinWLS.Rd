\name{funlinWLS}
\alias{funlinWLS}

\title{Fitting Functional Linear Models via Weighted Least Squares}

\description{
	\code{funlinWLS} fits functional linear models by WLS (weighted least squares).
	For complete data, it is based on a object of the class \code{readCatdata}.
	For missing data, it is based on a object of the class \code{satMarML} 
	(under MAR or MCAR) or \code{satMcarWLS} (under MCAR).
	For both complete and missing data, another alternative is to use as inputs the 
	maximum likelihood (ML) or any other best asymptotically normal (BAN) estimate 
	for the product-multinomial probabilities under a fitted model (which may encompass 
	MAR, MCAR or MNAR assumption) and a consistent estimate of its asymptotic covariance 
	matrix.
	Depending on the formulation (freedom equations or constraints) and on the model 
	specification, different arguments must be informed.
}

\usage{funlinWLS(model, obj, theta, Vtheta, A1, A2, A3, A4, A5, A6, A7, A8, A9, 
	X, U, XL, UL, zeroN, PI1, PI2, PI3, PI4, PI5, PI6, PI7, PI8, PI9)
}

\arguments{
	\item{model}{vector of functions to be modeled linearly; they need to be specified 
		in the order with which they are applied to the vector of proportions; the supported functions are: 
		linear (\code{"lin"}), logarithmic (\code{"log"}), exponential (\code{"exp"}), and addition
		of constants (\code{"add"}).}
	\item{obj}{an object of class \code{readCatdata}, \code{satMarML} or \code{satMcarWLS}.}
	\item{theta}{BAN estimate of the product-multinomial probabilities.}
	\item{Vtheta}{consistent estimate of asymptotic covariance matrix of the estimators of theta.}
	\item{A1}{a matrix for the 1st linear function; for linear model 
		(\code{model="lin"}) the default is a matrix 
		diag(\var{S}) \%x\% cbind(diag(\var{R-1}),rep(\var{0},\var{R-1})) which
		discards the last element of the vector of probabilies of each multinomial; for log-linear model 
		(\code{model=c("lin","log")}) the default is a matrix 
		diag(\var{S}) \%x\% cbind(diag(\var{R-1}),rep(\var{-1},\var{R-1})) which
		generates logits with the last category as the baseline.}
	\item{A2}{a matrix for the 2nd linear function.}
	\item{A3}{a matrix for the 3rd linear function.}
	\item{A4}{a matrix for the 4th linear function.}
	\item{A5}{a matrix for the 5th linear function.}
	\item{A6}{a matrix for the 6th linear function.}
	\item{A7}{a matrix for the 7th linear function.}
	\item{A8}{a matrix for the 8th linear function.}
	\item{A9}{a matrix for the 9th linear function.}
	\item{X}{a model specification matrix for freedom equation formulation for all 
		functional linear models; for log-linear model 
		(\code{model=c("lin","log")}), this is used for the ordinary 
		log-linear specification.}
	\item{U}{a matrix for constraint formulation for all functional linear models; 
		for log-linear model (\code{model=c("lin","log")}), this is used 
		for the ordinary log-linear specification.}
	\item{XL}{a model specification matrix for freedom equation formulation of 
		generalized log-linear models (\code{model=c("lin","log")}).}
	\item{UL}{a matrix for constraint formulation of generalized log-linear 
		models (\code{model=c("lin","log")}).}
	\item{zeroN}{for complete data, the vector has \var{S} values that are used to replace null 
		frequencies in each subpopulation in order to compute the proportions used in the estimate 
		for the covariance matrix; the default value is \code{1/(R*ns)}, where \var{ns} is 
		the sample size associated to the corresponding subpopulation; for missing data, this is not 
		required as the possible replacements occur either at \code{satMarML} or at 
		\code{satMcarWLS}.}
	\item{PI1}{the 1st vector of constants to be added.}
	\item{PI2}{the 2nd vector of constants to be added.}
	\item{PI3}{the 3rd vector of constants to be added.}
	\item{PI4}{the 4th vector of constants to be added.}
	\item{PI5}{the 5th vector of constants to be added.}
	\item{PI6}{the 6th vector of constants to be added.}
	\item{PI7}{the 7th vector of constants to be added.}
	\item{PI8}{the 8th vector of constants to be added.}
	\item{PI9}{the 9th vector of constants to be added.}
}

\details{
	Every linear function demands the specification of a matrix in \var{A}\emph{i}, where 
	\emph{i} may vary from \var{1} to \var{9}; such matrices must be numbered from right to left, 
	in the order of which the operations are applied. Similarly, the user needs to specify a vector 
	\var{PI}\emph{i} for every addition of constants.
	
	Examples of functions (for simplicity, consider "*" as a matrix multiplication in the following functions)
	\tabular{lll}{
		Function F(Theta) \tab \var{model} \cr
		A1*Theta \tab \var{"lin"}\cr
		log(Theta) \tab \var{"log"} \cr
		exp(Theta) \tab \var{"exp"} \cr
		PI1+Theta \tab \var{"add"} \cr
		A1*log(Theta) \tab \var{c("lin","log")} \cr
		exp[A1*log(Theta)] \tab \var{c("exp","lin","log")}\cr
		PI3+exp[PI2+A1*log(PI1+Theta)] \tab \var{c("add","exp","add","lin","log","add")} \cr
		PI1+exp(A4*log{A3*exp[A2*log(A1*Theta)]}) \tab \var{c("add","exp","lin","log","lin","exp","lin","log","lin")} \cr
	}
	\tabular{lll}{
		Function F(Theta) \tab Arguments that must be supplied \cr
		A1*Theta \tab A1 \cr
		log(Theta) \tab (none) \cr
		exp(Theta) \tab (none) \cr
		PI1+Theta \tab PI1 \cr
		A1*log(Theta) \tab A1 \cr
		exp[A1*log(Theta)] \tab A1 \cr
		PI3+exp[PI2+A1*log(PI1+Theta)] \tab A1, PI1, PI2, PI3 \cr
		PI1+exp(A4*log{A3*exp[A2*log(A1*Theta)]}) \tab A1, A2, A3, A4, PI1 \cr
	}

	
	Functional linear models may be fitted to the functions F(Theta) using a freedom equation 
	formulation F(Theta)=X\%*\%Beta, where the elements of Beta are the parameters to be estimated, 
	or using a constraint formulation U\%*\%F(Theta)=0. Both formulations lead to an equivalent 
	model fit if U\%*\%X=0.
	
	Specifically for log-linear models (\code{model=c("lin","log")}), X and U are used 
	for ordinary log-linear models, and XL and UL are used for generalized log-linear models, 
	namely log(Theta)=nu+X\%*\%Beta, U\%*\%log(Theta)=0, A1\%*\%log(Theta)=XL\%*\%Beta, 
	UL\%*\%A1\%*\%log(Theta)=0, where nu are non-estimated parameters included only to satisfy 
	the natural constraints of the product-multinomial distribution.
	
	The generic functions \code{print} and \code{summary} are used to print the results and to obtain a
	summary thereof.
}

\value{
	An object of the class \code{funlinWLS} is a list containing most of the components of the 
	argument \code{obj} as well as the following components:
  \item{thetaH}{vector of WLS estimates for all product-multinomial probabilities under the 
  	functional linear model (in the case of missing data, conditional on the previously assumed 
  	model for the missingness mechanism.}
  \item{VthetaH}{corresponding estimated covariance matrix.}
  \item{beta}{vector of WLS estimates for parameters of the functional linear model (only for the freedom 
  	equation formulation).}
  \item{Vbeta}{corresponding estimated covariance matrix (only for the freedom equation formulation).}
  \item{Fu}{observed functions, without model constraints.}
  \item{VFu}{corresponding estimated covariance matrix.}
  \item{FH}{WLS estimates for the functions under the fitted model.}
  \item{VFH}{corresponding estimated covariance matrix.}
  \item{QwH}{Wald statistic for testing the goodness of fit of the functional linear model 
  	(for missing data, conditional on the assumed missingness mechanism).}
  \item{glH}{degrees of freedom for testing the goodness of fit of the functional linear model 
  	(for missing data, conditional on the assumed missingness mechanism).}
  \item{ystH}{for complete data, it contains the WLS estimates for the frequencies under the 
  	functional linear model; for missing data, it contains the WLS estimates for the augmented 
  	frequencies under both the linear model and the assumed missingness mechanism; for both 
  	missing and complete data, this is computed only for linear and certain log-linear models 
  	wherein it is possible to estimate the marginal probabilities of categorization.}
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
	#Example 11.2 of Paulino and Singer (2006)
	e112.TF<-c(192,1,5,2,146,5,11,12,71)

	e112.catdata<-readCatdata(TF=e112.TF)
	
	e112.U<-rbind(c(0,-1, 0,1,0, 0,0,0),
    	          c(0, 0,-1,0,0, 0,1,0),
        	      c(0, 0, 0,0,0,-1,0,1))
	
	e112.X<-rbind(c(1,0,0,0,0),
    	          c(0,1,0,0,0),
        	      c(0,0,1,0,0),
            	  c(0,1,0,0,0),
	              c(0,0,0,1,0),
    	          c(0,0,0,0,1),
        	      c(0,0,1,0,0),
            	  c(0,0,0,0,1))

	#Two equivalent ways of fitting the same symmetry model
	e112.linwls1<-funlinWLS(model="lin",obj=e112.catdata,U=e112.U)
	e112.linwls2<-funlinWLS(model="lin",obj=e112.catdata,X=e112.X)
	e112.linwls1 #constraint formulation
	e112.linwls2 #freedom equation formulation
	summary(e112.linwls1)
	
	#Example 11.5 of Paulino and Singer (2006)
	e115.TF<-c(3,25,32,68)
	e115.catdata<-readCatdata(TF=e115.TF)
	e115.U<-c(1,-1,-1,1)

	e115.X<-rbind(c(0,0),c(0,1),c(1,0),c(1,1))

	e115.X2<-rbind(c(0,0,0),c(0,1,0),c(1,0,0),c(1,1,1))

	e115.loglinwls1<-funlinWLS(model=c("lin","log"),obj=e115.catdata,U=e115.U)
	e115.loglinwls2<-funlinWLS(model=c("lin","log"),obj=e115.catdata,X=e115.X)
	e115.loglinwls3<-funlinWLS(model=c("lin","log"),obj=e115.catdata,X=e115.X2)
	e115.loglinwls4<-funlinWLS(model=c("lin","log"),obj=e115.catdata,A1=c(1,-1,-1,1), XL=1) 

	e115.loglinwls1 #Independence ordinary log-linear model, constraint formulation
	e115.loglinwls2 #Independence ordinary log-linear model, freedom equation formulation
	e115.loglinwls3 #Saturated ordinary log-linear model, freedom equation formulation
	e115.loglinwls4 #Saturated generalized log-linear model, freedom equation formulation

	#95% confidence interval for log-odds ratio and for odds ratio

	round(e115.loglinwls4$beta+c(-1,1)*qnorm(0.975)*sqrt(e115.loglinwls4$Vbeta),3) 
	round(exp(e115.loglinwls4$beta),3)
	round(exp(e115.loglinwls4$beta+c(-1,1)*qnorm(0.975)*sqrt(e115.loglinwls4$Vbeta)),3)
	
	#Example 11.3 of Paulino and Singer (2006)
	e113.TF<-c(11,5,0,14,34,7,2,13,11)
	e113.catdata<-readCatdata(TF=e113.TF)

	e113.U<-rbind(c(0, 1,1,-1,0,0,-1, 0),
	              c(0,-1,0, 1,0,1, 0,-1))

	e113.X<-rbind(c(1, 0, 0,0,0,0),
    	          c(0, 1, 0,0,0,0),
        	      c(0,-1, 1,0,1,0),
            	  c(0, 0, 1,0,0,0),
	              c(0, 0, 0,1,0,0),
    	          c(0, 1,-1,0,0,1),
        	      c(0, 0, 0,0,1,0),
            	  c(0, 0, 0,0,0,1))

	e113.linwls1<-funlinWLS(model="lin",obj=e113.catdata,U=e113.U)
	e113.linwls2<-funlinWLS(model="lin",obj=e113.catdata,X=e113.X)

	e113.A<-rbind(c(1,1,1,0,0,0,0,0,0),
    	          c(0,0,0,1,1,1,0,0,0),
        	      c(1,0,0,1,0,0,1,0,0),
            	  c(0,1,0,0,1,0,0,1,0))

	e113.U2<-rbind(c(1,0,-1, 0),c(0,1, 0,-1))
	e113.X2<-rbind(c(1,0),c(0,1),c(1,0),c(0,1))

	e113.linwls3<-funlinWLS(model="lin",obj=e113.catdata,A1=e113.A,U=e113.U2)
	e113.linwls4<-funlinWLS(model="lin",obj=e113.catdata,A1=e113.A,X=e113.X2)

	#Four equivalent ways of fitting the same marginal homogeneity model
	e113.linwls1
	e113.linwls2
	e113.linwls3
	e113.linwls4

	#Example 11.12 of Paulino and Singer (2006)
	e1112.TF<-c(11,5,0,14,34,7,2,13,11)
	e1112.catdata<-readCatdata(TF=e1112.TF)

	e1112.A1<-rbind(c(rep(c(1,0,0,0),2),1),rep(1,9),
			  kronecker(diag(3),t(rep(1,3))),kronecker(t(rep(1,3)),diag(3)))

	e1112.A2<-rbind(cbind(diag(2),matrix(0,2,6)),
					cbind(matrix(0,3,2),kronecker(t(rep(1,2)),diag(3))))

	e1112.A3<-cbind(c(1,0),c(1,1),
					tcrossprod(-c(2,1),(rep(1,3))))

	e1112.A4<-t(c(1,-1))
	
	e1112.kappa<-funlinWLS(model=c("add","exp","lin","log","lin","exp","lin","log","lin"),
						   obj=e1112.catdata,A1=e1112.A1,A2=e1112.A2,A3=e1112.A3,A4=e1112.A4,PI1=-1,X=1)
	# confidence interval
	round(e1112.kappa$beta+c(-1,1)*qnorm(0.975)*sqrt(e1112.kappa$Vbeta),3)

	#weighted kappa (Spitzer, Cohen, Fleiss e Endicott, 1967)

	W1<-c(1,0.75,0,0.75,1,0.75,0,0.75,1) #squared weights (Fleiss e Cohen, 1973) 
	W2<-c(1,0.5,0,0.5,1,0.5,0,0.5,1) #absolute weights (Cicchetti e Allison, 1971) 

	e1112.w1A1<-rbind(t(W1),rep(1,9),kronecker(diag(3),t(rep(1,3))),
					  kronecker(t(rep(1,3)),diag(3)))

	e1112.w2A1<-rbind(t(W2),rep(1,9),kronecker(diag(3),t(rep(1,3))),
					  kronecker(t(rep(1,3)),diag(3)))

	e1112.wA2<-rbind(cbind(diag(2),matrix(0,2,6)),cbind(matrix(0,9,2),
					 cbind(kronecker(diag(3),rep(1,3)),kronecker(rep(1,3),diag(3)))))

	e1112.w1A3<-cbind(c(1,0),c(1,1),kronecker(-c(2,1),t(W1)))

	e1112.w2A3<-cbind(c(1,0),c(1,1),kronecker(-c(2,1),t(W2)))

	e1112.kappaw1<-funlinWLS(model=c("add","exp","lin","log","lin","exp","lin","log","lin"),
	 obj=e1112.catdata,A1=e1112.w1A1,A2=e1112.wA2,A3=e1112.w1A3,A4=e1112.A4,PI1=-1,X=1)

	e1112.kappaw2<-funlinWLS(model=c("add","exp","lin","log","lin","exp","lin","log","lin"),
	 obj=e1112.catdata,A1=e1112.w2A1,A2=e1112.wA2,A3=e1112.w2A3,A4=e1112.A4,PI1=-1,X=1)

	#Example 1 of Poleto et al (2012)
	smoking.TF<-rbind(c(167,17,19,10,1,3,52,10,11, 176,24,121, 28,10,12),
	                  c(120,22,19, 8,5,1,39,12,12, 103, 3, 80, 31, 8,14))

	smoking.Zp<-kronecker(t(rep(1,2)),cbind(kronecker(diag(3),rep(1,3)),
											kronecker(rep(1,3),diag(3))))

	smoking.Rp<-rbind(c(3,3),c(3,3))

	smoking.catdata<-readCatdata(TF=smoking.TF,Zp=smoking.Zp,Rp=smoking.Rp)

	smoking.catdata #Proportions of the complete data
	smoking.satmarml<-satMarML(smoking.catdata)
	smoking.satmcarml<-satMarML(smoking.catdata,missing="MCAR")
	smoking.satmcarwls<-satMcarWLS(smoking.catdata)

	smoking.E<-rbind(c(1,-1,0),c(0,1,-1))
	smoking.A<-kronecker(kronecker(diag(2),smoking.E),smoking.E)

	smoking.loglin2.marhybrid<-funlinWLS(model=c("lin","log"),
								obj=smoking.satmarml,A1=smoking.A,XL=rep(1,8))
	smoking.loglin2.mcarhybrid<-funlinWLS(model=c("lin","log"),
								obj=smoking.satmcarml,A1=smoking.A,XL=rep(1,8))
	smoking.loglin2.mcarwls<-funlinWLS(model=c("lin","log"),
								obj=smoking.satmcarwls,A1=smoking.A,XL=rep(1,8))

	#MNAR example
	#Minus log-likelihood of the MNAR described in the last paragraph of Section 3
	mnar.mll<-function(p,fr){
	 # p=(pi11(1),...,pi33(2),a2(11),a2(21),a2(31),a3(11),
	 #                        a3(21),a3(31),a2(12),a2(22),
	 #                        a2(32),a3(12),a3(22),a3(32))
		
	 pi11.1<-p[1]; pi12.1<-p[2]; pi13.1<-p[3]
	 pi21.1<-p[4]; pi22.1<-p[5]; pi23.1<-p[6]
	 pi31.1<-p[7]; pi32.1<-p[8]
	 pi33.1=1-pi11.1-pi12.1-pi13.1-pi21.1-pi22.1-pi23.1-pi31.1-pi32.1

	 pi11.2<-p[9]; pi12.2<-p[10];pi13.2<-p[11]
	 pi21.2<-p[12];pi22.2<-p[13];pi23.2<-p[14]
	 pi31.2<-p[15];pi32.2<-p[16]
	 pi33.2=1-pi11.2-pi12.2-pi13.2-pi21.2-pi22.2-pi23.2-pi31.2-pi32.2

	 a2.1.1<-p[17];a2.2.1<-p[18];a2.3.1<-p[19]
	 a3.1.1<-p[20];a3.2.1<-p[21];a3.3.1<-p[22]

	 a2.1.2<-p[23];a2.2.2<-p[24];a2.3.2<-p[25]
	 a3.1.2<-p[26];a3.2.2<-p[27];a3.3.2<-p[28]

	 value<- -(
	  fr[1,1]*log(pi11.1*(1-a2.1.1-a3.1.1))+fr[1,2]*log(pi12.1*(1-a2.2.1-a3.1.1))+
	  fr[1,3]*log(pi13.1*(1-a2.3.1-a3.1.1))+
	  fr[1,4]*log(pi21.1*(1-a2.1.1-a3.2.1))+fr[1,5]*log(pi22.1*(1-a2.2.1-a3.2.1))+
	  fr[1,6]*log(pi23.1*(1-a2.3.1-a3.2.1))+
	  fr[1,7]*log(pi31.1*(1-a2.1.1-a3.3.1))+fr[1,8]*log(pi32.1*(1-a2.2.1-a3.3.1))+
	  fr[1,9]*log(pi33.1*(1-a2.3.1-a3.3.1))+

	  fr[1,10]*log(pi11.1*a2.1.1 + pi12.1*a2.2.1 + pi13.1*a2.3.1)+
	  fr[1,11]*log(pi21.1*a2.1.1 + pi22.1*a2.2.1 + pi23.1*a2.3.1)+
	  fr[1,12]*log(pi31.1*a2.1.1 + pi32.1*a2.2.1 + pi33.1*a2.3.1)+

	  fr[1,13]*log(pi11.1*a3.1.1 + pi21.1*a3.2.1 + pi31.1*a3.3.1)+
	  fr[1,14]*log(pi12.1*a3.1.1 + pi22.1*a3.2.1 + pi32.1*a3.3.1)+
	  fr[1,15]*log(pi13.1*a3.1.1 + pi23.1*a3.2.1 + pi33.1*a3.3.1)+

	  fr[2,1]*log(pi11.2*(1-a2.1.2-a3.1.2))+fr[2,2]*log(pi12.2*(1-a2.2.2-a3.1.2))+
	  fr[2,3]*log(pi13.2*(1-a2.3.2-a3.1.2))+
	  fr[2,4]*log(pi21.2*(1-a2.1.2-a3.2.2))+fr[2,5]*log(pi22.2*(1-a2.2.2-a3.2.2))+
	  fr[2,6]*log(pi23.2*(1-a2.3.2-a3.2.2))+
	  fr[2,7]*log(pi31.2*(1-a2.1.2-a3.3.2))+fr[2,8]*log(pi32.2*(1-a2.2.2-a3.3.2))+
	  fr[2,9]*log(pi33.2*(1-a2.3.2-a3.3.2))+

	  fr[2,10]*log(pi11.2*a2.1.2 + pi12.2*a2.2.2 + pi13.2*a2.3.2)+
	  fr[2,11]*log(pi21.2*a2.1.2 + pi22.2*a2.2.2 + pi23.2*a2.3.2)+
	  fr[2,12]*log(pi31.2*a2.1.2 + pi32.2*a2.2.2 + pi33.2*a2.3.2)+

	  fr[2,13]*log(pi11.2*a3.1.2 + pi21.2*a3.2.2 + pi31.2*a3.3.2)+
	  fr[2,14]*log(pi12.2*a3.1.2 + pi22.2*a3.2.2 + pi32.2*a3.3.2)+
	  fr[2,15]*log(pi13.2*a3.1.2 + pi23.2*a3.2.2 + pi33.2*a3.3.2)

	 )
	value
	}

	mnar.fit<-constrOptim(theta=c(rep(1/9,16),rep(1/3,12)),f=mnar.mll,
				method="Nelder-Mead",ui=diag(28),ci=rep(0,28),
				control=list(maxit=10000),outer.iterations=1000,fr=smoking.TF)

	#hessian matrix
	mnar.der<-deriv3(~-(
	 o1.1*log(pi11.1*(1-a2.1.1-a3.1.1))+o1.2*log(pi12.1*(1-a2.2.1-a3.1.1))+
	 o1.3*log(pi13.1*(1-a2.3.1-a3.1.1))+
	 o1.4*log(pi21.1*(1-a2.1.1-a3.2.1))+o1.5*log(pi22.1*(1-a2.2.1-a3.2.1))+
	 o1.6*log(pi23.1*(1-a2.3.1-a3.2.1))+
	 o1.7*log(pi31.1*(1-a2.1.1-a3.3.1))+o1.8*log(pi32.1*(1-a2.2.1-a3.3.1))+
  	 o1.9*log((1-pi11.1-pi12.1-pi13.1-pi21.1-
				 pi22.1-pi23.1-pi31.1-pi32.1)*(1-a2.3.1-a3.3.1))+
	 o1.10*log(pi11.1*a2.1.1 + pi12.1*a2.2.1 + pi13.1*a2.3.1)+
	 o1.11*log(pi21.1*a2.1.1 + pi22.1*a2.2.1 + pi23.1*a2.3.1)+
	 o1.12*log(pi31.1*a2.1.1 + pi32.1*a2.2.1 + 
     	(1-pi11.1-pi12.1-pi13.1-pi21.1-pi22.1-pi23.1-pi31.1-pi32.1)*a2.3.1)+
	 o1.13*log(pi11.1*a3.1.1 + pi21.1*a3.2.1 + pi31.1*a3.3.1)+
	 o1.14*log(pi12.1*a3.1.1 + pi22.1*a3.2.1 + pi32.1*a3.3.1)+
	 o1.15*log(pi13.1*a3.1.1 + pi23.1*a3.2.1 + 
		(1-pi11.1-pi12.1-pi13.1-pi21.1-pi22.1-pi23.1-pi31.1-pi32.1)*a3.3.1)+
	 o2.1*log(pi11.2*(1-a2.1.2-a3.1.2))+o2.2*log(pi12.2*(1-a2.2.2-a3.1.2))+
	 o2.3*log(pi13.2*(1-a2.3.2-a3.1.2))+
	 o2.4*log(pi21.2*(1-a2.1.2-a3.2.2))+o2.5*log(pi22.2*(1-a2.2.2-a3.2.2))+
	 o2.6*log(pi23.2*(1-a2.3.2-a3.2.2))+
	 o2.7*log(pi31.2*(1-a2.1.2-a3.3.2))+o2.8*log(pi32.2*(1-a2.2.2-a3.3.2)) +
		o2.9*log((1-pi11.2-pi12.2-pi13.2-pi21.2-
				  pi22.2-pi23.2-pi31.2-pi32.2)*(1-a2.3.2-a3.3.2))+
	 o2.10*log(pi11.2*a2.1.2 + pi12.2*a2.2.2 + pi13.2*a2.3.2)+
	 o2.11*log(pi21.2*a2.1.2 + pi22.2*a2.2.2 + pi23.2*a2.3.2)+
	 o2.12*log(pi31.2*a2.1.2 + pi32.2*a2.2.2 + 
		(1-pi11.2-pi12.2-pi13.2-pi21.2-pi22.2-pi23.2-pi31.2-pi32.2)*a2.3.2)+
	 o2.13*log(pi11.2*a3.1.2 + pi21.2*a3.2.2 + pi31.2*a3.3.2)+
	 o2.14*log(pi12.2*a3.1.2 + pi22.2*a3.2.2 + pi32.2*a3.3.2)+
	 o2.15*log(pi13.2*a3.1.2 + pi23.2*a3.2.2 + 
		(1-pi11.2-pi12.2-pi13.2-pi21.2-pi22.2-pi23.2-pi31.2-pi32.2)*a3.3.2)

	),c("pi11.1","pi12.1","pi13.1","pi21.1","pi22.1","pi23.1","pi31.1","pi32.1",
	 "pi11.2","pi12.2","pi13.2","pi21.2","pi22.2","pi23.2","pi31.2","pi32.2",
	 "a2.1.1","a2.2.1","a2.3.1","a3.1.1","a3.2.1","a3.3.1","a2.1.2","a2.2.2",
	 "a2.3.2","a3.1.2","a3.2.2","a3.3.2"),
	c("pi11.1","pi12.1","pi13.1","pi21.1","pi22.1","pi23.1","pi31.1","pi32.1",
	 "pi11.2","pi12.2","pi13.2","pi21.2","pi22.2","pi23.2","pi31.2","pi32.2",
	 "a2.1.1","a2.2.1","a2.3.1","a3.1.1","a3.2.1","a3.3.1","a2.1.2","a2.2.2",
	 "a2.3.2","a3.1.2","a3.2.2","a3.3.2",
	 "o1.1","o1.2","o1.3","o1.4","o1.5","o1.6","o1.7","o1.8","o1.9","o1.10",
	 "o1.11","o1.12","o1.13","o1.14","o1.15",
	 "o2.1","o2.2","o2.3","o2.4","o2.5","o2.6","o2.7","o2.8","o2.9","o2.10",
	 "o2.11","o2.12","o2.13","o2.14","o2.15")
	)
	
	p<-mnar.fit$par;TF<-smoking.TF
	mnar.InfObs<-mnar.der(p[1],p[2],p[3],p[4],p[5],p[6],p[7],p[8],p[9],p[10],
		p[11],p[12],p[13],p[14], p[15],p[16],p[17],p[18],p[19],p[20],p[21],
		p[22],p[23],p[24],p[25],p[26],p[27],p[28], TF[1,1],TF[1,2],TF[1,3],
		TF[1,4],TF[1,5],TF[1,6],TF[1,7],TF[1,8],TF[1,9],TF[1,10], 
		TF[1,11],TF[1,12],TF[1,13],TF[1,14],TF[1,15], 
		TF[2,1],TF[2,2],TF[2,3],TF[2,4],TF[2,5],TF[2,6],TF[2,7],TF[2,8],TF[2,9],TF[2,10], 
		TF[2,11],TF[2,12],TF[2,13],TF[2,14],TF[2,15])
	b<-smoking.catdata$b #b in (8), i.e., rep(1,2)%x%c(rep(0,8),1)
	B<-smoking.catdata$B #B in (8), i.e., diag(2)%x%rbind(diag(8),rep(-1,8))

	smoking.loglin2mnar.hybrid<-funlinWLS(model=c("lin","log"), 
		theta=as.vector(b+c(B\%*\%mnar.fit$par[1:16])), 
		Vtheta=B\%*\%solve(attr(mnar.InfObs,"hessian")[1,,])[1:16,1:16]\%*\%t(B),
		A1=smoking.A,X=rep(1,8))
}
\keyword{package}
\keyword{categorical data}
