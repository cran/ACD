\name{waldTest}
\alias{waldTest}

\title{Wald Test}                                                      

\description{
	\code{waldTest} allows to perform a Wald test of certain hypotheses on the parameters of models fitted 
	under a freedom equation formulation for both complete and missing data.
}

\usage{waldTest(obj, C, C0)}

\arguments{
	\item{obj}{object of the class \code{linML}, \code{loglinML} or \code{funlinWLS}.}
	\item{C}{full rank matrix with number of columns equal to the number of parameters of 
  	\code{obj}.}
  	\item{C0}{a vector of constants with dimension equal to the number of rows of \code{C}; 
  	by default, it is a vector of zeros.}
}

\details{
	\code{waldTest} performs a test for hypotheses of the type H:C\%*\%Beta=C0, where 
	Beta are the parameters of the model in \code{obj}.
	The generic function \code{print} is used to print the results.
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
#Example 11.7 of Paulino and Singer (2006)
e117.TF<-rbind(c(28,40,68),
               c( 5,21,49),
   	           c( 1, 4,15))

e117.catdata<-readCatdata(TF=e117.TF)
e117.A<-kronecker(diag(3),cbind(diag(2),rep(-1,2)))
e117.X1<-rbind(c(1,0,0,0),
               c(0,1,0,0),
   	           c(1,0,2,0),
       	       c(0,1,1,0),
           	   c(1,0,0,2),
               c(0,1,0,1))

e117.loglinwls1<-funlinWLS(model=c("lin","log"), obj=e117.catdata, 
	A1=e117.A,XL=e117.X1)
waldTest(obj=e117.loglinwls1,C=cbind(0*diag(2),diag(2)))
}

\keyword{package}
\keyword{categorical data}
