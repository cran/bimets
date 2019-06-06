\name{ESTIMATE}
\alias{ESTIMATE}


\title{
Estimate a BIMETS model object
}
\description{
\if{html}{(Note: this is the html version of the reference manual. Please consider reading the pdf version of this reference manual, wherein there are figures and the mathematical expressions are better formatted than in html.)\cr\cr}
This function estimates equations that are linear in the coefficients, as specified in the behavioral equations of the input model object. Coefficients can be estimated for single equations or blocks of simultaneous equations. Coefficients restriction procedure derives from the theory of Lagrange Multipliers, while the Cochrane-Orcutt method allows to account for residuals autocorrelation.\cr\cr The estimation function supports:\cr\cr
- \emph{Ordinary Least Squares};\cr
- \emph{Instrumental Variables};\cr
- \emph{Deterministic linear restrictions on the coefficients};\cr
- \emph{Almon Polynomial Distributed Lags};\cr
- \emph{Autocorrelation of the errors};\cr\cr Further details on estimation calculus can be found in \code{\link[=MDL]{MDL}} help page;
}
\usage{
ESTIMATE(model=NULL, 
         eqList=NULL, 
         TSRANGE=NULL,
         estTech='OLS',
         IV=NULL,
         quietly=FALSE,
         showWarnings=FALSE,
         tol=.Machine$double.eps,
         digits=getOption('digits'),
         centerCOV=TRUE,
         ...)

}

\arguments{
  \item{model}{
  The BIMETS model object to be estimated (see also \code{\link[=LOAD_MODEL]{LOAD_MODEL}}).
  }
  \item{eqList}{
  The \code{character} array of behavioral names to be estimated. If it is \code{NULL} then all the behaviorals of the model will be estimated.
  }
  \item{TSRANGE}{
  The time range of the estimation, as a four dimensional numerical array, \cr i.e. \code{TSRANGE=c(start_year, start_period, end_year, end_period)}. The \code{TSRANGE} provided in the behavioral \code{\link[=MDL]{MDL}} definition takes precedence over this function argument.
  }
   \item{estTech}{
   The estimation technique used in the regression. Ordinary Least Squares \code{OLS} and Instrumental Variables estimation \code{IV} are supported.
   }
    \item{IV}{
   The \code{character} array built with the Instrumental Variable expressions, in the case of Instrumental Variables estimation (see examples).
   }
   \item{quietly}{
   If \code{TRUE}, information messages will be suppressed, e.g. results and regression statistics.
   }
  \item{showWarnings}{
  If \code{TRUE} and if a model time series has a missing value then warning message will be shown.
  }
  \item{tol}{
  The tolerance for detecting linear dependencies in the columns of a matrix while an inversion is requested. The default is \code{.Machine$double.eps}.
  }
  \item{digits}{
  Controls the number of digits to print when printing coefficients and statistics of the estimation. Valid values are 1 to 16 with a default of 7.
  }
  \item{centerCOV}{
  If \code{TRUE}, the function subtracts the mean from the residuals before calculating the residual covariance matrix.
  }
   \item{...}{
Backward compatibility.
}
  
  }

\value{
If \code{outputText=TRUE}, for each behavioral in the \code{eqList} this function will print out:\cr\cr
- the name of the estimated behavioral;\cr
- the estimation technique used;\cr
- the autocorrelation order of the error, if any, and the iterations count required to achieve the convergence;\cr
- the estimated equation with calculated coefficients and regressor expression; for each coefficient the T-statistic and the significance will be printed out;\cr
- the restriction equations imposed on the coefficients, if any;\cr
- the F-test for the restrictions, including the PDL restrictions, if any;\cr
- the final autocorrelation parameters for the error, along with their standard error, the T-statistic and the significance;\cr
- the \emph{R-Squared} and the \emph{Adjusted R-Squared};\cr
- the \emph{Durbin-Watson Statistic};\cr
- the \emph{Sum of squares of residuals};\cr
- the \emph{Standard Error of Regression};\cr
- the \emph{Log of the Likelihood Function};\cr
- the \emph{F-statistic} and the \emph{F-probability};\cr
- the \emph{AIC} and the \emph{BIC};\cr
- the \emph{Mean of the Dependent Variable};\cr
- the \emph{Number of Observations};\cr
- the \emph{Number of Degrees of Freedom};\cr
- the \emph{Current Sample}, i.e. the \code{TSRANGE} of estimation;\cr

For each behavioral in the \code{eqList} this function will add 4 new named elements into the related behavioral of the output model object:\cr\cr
1) \code{coefficients}: a numerical array built with the estimated coefficients;\cr
2) \code{errorCoefficients}: a numerical array built with the estimated coefficient for the error autoregression, if the \code{ERROR>} structure has been provided in the model \code{\link[=MDL]{MDL}} definition;\cr
3) \code{residuals}: the time series of the regression residuals. If an \code{ERROR>} structure has been provided in the behavioral definition, the related residuals will be calculated as described in the Cochrane-Orcutt procedure (see \code{\link[=MDL]{MDL}}).\cr
4) \code{statistics}: a list built with the parameters and the statistics of the estimation, e.g.:\cr
- \code{TSRANGE}: TSRANGE requested in the latest estimation of the behavioral;\cr
- \code{estimationTechinque}: estimation technique requested in the latest estimation of the behavioral;\cr
- \code{CoeffCovariance}: coefficients covariance;\cr
- \code{StandardErrorRegression} and \code{StandardErrorRegressionNotCentered}: standard error of the regression (centered and not-centered);\cr
- \code{CoeffTstatistic}: T-statistic of the coefficients;\cr
- \code{RSquared}: R-Squared;\cr
- \code{AdjustedRSquared}: adjusted R-Squared;\cr
- \code{DegreesOfFreedom}: degrees of freedom of the regression;\cr
- \code{CoeffPvalues}: coefficients p-values;\cr
- \code{LogLikelihood}:  Log of the Likelihood Function;\cr
- \code{Fstatistics}: F-statistics;\cr
- \code{RhosTstatistics}: rhos T-statistic (if any);\cr
- \code{FtestRestrValue}: F-test value for the restrictions;\cr
- \code{FtestRestrProbability}: F-test probability for the restrictions;\cr
- \code{AIC}: Akaike's Information Criterion;\cr
- \code{BIC}: Schwarz's Information Criterion;\cr
- etc.
\cr\cr


}

\seealso{
\code{\link[=MDL]{MDL}}\cr
\code{\link[=LOAD_MODEL]{LOAD_MODEL}}\cr
\code{\link[=SIMULATE]{SIMULATE}}\cr
\code{\link[=MULTMATRIX]{MULTMATRIX}}\cr
\code{\link[=RENORM]{RENORM}}\cr
\code{\link[=TSERIES]{TIMESERIES}}\cr
\code{\link[=idxOver]{BIMETS indexing}}\cr
\code{\link[=bimetsConf]{BIMETS configuration}}\cr
\code{\link[=summary.BIMETS_MODEL]{summary}}\cr
}

\examples{

#define model
myModelDefinition=
"MODEL

COMMENT> Modified Klein Model 1 of the U.S. Economy with PDL,
COMMENT> autocorrelation on errors, restrictions and conditional evaluations

COMMENT> Consumption
BEHAVIORAL> cn
TSRANGE 1925 1 1941 1
EQ> cn = a1 + a2*p + a3*TSLAG(p,1) + a4*(w1+w2)
COEFF> a1 a2 a3 a4
ERROR> AUTO(2)

COMMENT> Investment
BEHAVIORAL> i
TSRANGE 1923 1 1941 1
EQ> i = b1 + b2*p + b3*TSLAG(p,1) + b4*TSLAG(k,1)
COEFF> b1 b2 b3 b4
RESTRICT> b2 + b3 = 1

COMMENT> Demand for Labor
BEHAVIORAL> w1
TSRANGE 1925 1 1941 1
EQ> w1 = c1 + c2*(y+t-w2) + c3*TSLAG(y+t-w2,1)+c4*time
COEFF> c1 c2 c3 c4
PDL> c3 1 3

COMMENT> Gross National Product
IDENTITY> y
EQ> y = cn + i + g - t

COMMENT> Profits
IDENTITY> p
EQ> p = y - (w1+w2)

COMMENT> Capital Stock with switches
IDENTITY> k
EQ> k = TSLAG(k,1) + i
IF> i > 0
IDENTITY> k
EQ> k = TSLAG(k,1)
IF> i <= 0
END";

#define model data
myModelData=list(
  cn
  =TIMESERIES(39.8,41.9,45,49.2,50.6,52.6,55.1,56.2,57.3,57.8,55,50.9,
              45.6,46.5,48.7,51.3,57.7,58.7,57.5,61.6,65,69.7,
              START=c(1920,1),FREQ=1),
  g
  =TIMESERIES(4.6,6.6,6.1,5.7,6.6,6.5,6.6,7.6,7.9,8.1,9.4,10.7,10.2,9.3,10,
              10.5,10.3,11,13,14.4,15.4,22.3,
              START=c(1920,1),FREQ=1),
  i
  =TIMESERIES(2.7,-.2,1.9,5.2,3,5.1,5.6,4.2,3,5.1,1,-3.4,-6.2,-5.1,-3,-1.3,
              2.1,2,-1.9,1.3,3.3,4.9,
              START=c(1920,1),FREQ=1),
  k
  =TIMESERIES(182.8,182.6,184.5,189.7,192.7,197.8,203.4,207.6,210.6,215.7,
              216.7,213.3,207.1,202,199,197.7,199.8,201.8,199.9,
              201.2,204.5,209.4,
              START=c(1920,1),FREQ=1),
  p
  =TIMESERIES(12.7,12.4,16.9,18.4,19.4,20.1,19.6,19.8,21.1,21.7,15.6,11.4,
              7,11.2,12.3,14,17.6,17.3,15.3,19,21.1,23.5,
              START=c(1920,1),FREQ=1),
  w1
  =TIMESERIES(28.8,25.5,29.3,34.1,33.9,35.4,37.4,37.9,39.2,41.3,37.9,34.5,
              29,28.5,30.6,33.2,36.8,41,38.2,41.6,45,53.3,
              START=c(1920,1),FREQ=1),
  y
  =TIMESERIES(43.7,40.6,49.1,55.4,56.4,58.7,60.3,61.3,64,67,57.7,50.7,41.3,
              45.3,48.9,53.3,61.8,65,61.2,68.4,74.1,85.3,
              START=c(1920,1),FREQ=1),
  t
  =TIMESERIES(3.4,7.7,3.9,4.7,3.8,5.5,7,6.7,4.2,4,7.7,7.5,8.3,5.4,6.8,7.2,
              8.3,6.7,7.4,8.9,9.6,11.6,
              START=c(1920,1),FREQ=1),
  time 
  =TIMESERIES(NA,-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,
              START=c(1920,1),FREQ=1),
  w2
  =TIMESERIES(2.2,2.7,2.9,2.9,3.1,3.2,3.3,3.6,3.7,4,4.2,4.8,5.3,5.6,6,6.1,
              7.4,6.7,7.7,7.8,8,8.5,
              START=c(1920,1),FREQ=1)
);


#load model 
myModel=LOAD_MODEL(modelText=myModelDefinition);

#load data into the model
myModel=LOAD_MODEL_DATA(myModel,myModelData,showWarnings = TRUE);

#################################################
#OLS case

#estimate the model
myModel=ESTIMATE(myModel);

#HERE BELOW THE OUTPUT OF THE ESTIMATION (COMMENTED OUT):
#.CHECK_MODEL_DATA(): warning, there are undefined values in time series "time".
#
#Estimate the Model myModelDefinition:
#the number of behavioral equations to be estimated is 3.
#The total number of coefficients is 14.
#
#_________________________________________
#
#BEHAVIORAL EQUATION: cn
#Estimation Technique: OLS
#Autoregression of Order  2  (Cochrane-Orcutt procedure)
#
#Convergence was reached in  9  /  20  iterations.
#
#
#cn                  =   19.01352    
#                        T-stat. 13.1876     ***
#
#                    +   0.3442816   p
#                        T-stat. 3.841051    **
#
#                    +   0.03443117  TSLAG(p,1)
#                        T-stat. 0.4280928   
#
#                    +   0.6993905   (w1+w2)
#                        T-stat. 15.30744    ***
#
#ERROR:  AUTO(2) 
#
#AUTOREGRESSIVE PARAMETERS:
#Rho             Std. Error      T-stat.         
# 0.05743131      0.3324101       0.1727725       
# 0.007785936     0.2647013       0.02941404      
#
#
#STATs:
#R-Squared                      : 0.985263    
#Adjusted R-Squared             : 0.979595    
#Durbin-Watson Statistic        : 1.966609    
#Sum of squares of residuals    : 9.273455    
#Standard Error of Regression   : 0.8445961   
#Log of the Likelihood Function : -20.14564   
#F-statistic                    : 173.8271    
#F-probability                  : 1.977107e-11
#Akaike's IC                    : 54.29129    
#Schwarz's IC                   : 60.90236    
#Mean of Dependent Variable     : 55.71765    
#Number of Observations         : 19
#Number of Degrees of Freedom   : 13
#Current Sample (year-period)   : 1925-1 / 1941-1
#
#
#Signif. codes:   *** 0.001  ** 0.01  * 0.05  
#
#
#
#_________________________________________
#
#BEHAVIORAL EQUATION: i
#Estimation Technique: OLS
#
#i                   =   2.868104    
#                        T-stat. 0.3265098   
#
#                    +   0.5787626   p
#                        T-stat. 4.456542    ***
#
#                    +   0.4212374   TSLAG(p,1)
#                        T-stat. 3.243579    **
#
#                    -   0.09160307  TSLAG(k,1)
#                        T-stat. -2.11748    
#
#RESTRICTIONS:
#b2+b3=1
#
#RESTRICTIONS F-TEST:
#F-value            : 8.194478       
#F-prob(1,15)       : 0.0118602      
#
#
#STATs:
#R-Squared                      : 0.8928283   
#Adjusted R-Squared             : 0.8794319   
#Durbin-Watson Statistic        : 1.173106    
#Sum of squares of residuals    : 26.76483    
#Standard Error of Regression   : 1.293368    
#Log of the Likelihood Function : -30.215     
#F-statistic                    : 66.64659    
#F-probability                  : 1.740364e-08
#Akaike's IC                    : 68.43001    
#Schwarz's IC                   : 72.20776    
#Mean of Dependent Variable     : 1.310526    
#Number of Observations         : 19
#Number of Degrees of Freedom   : 16
#Current Sample (year-period)   : 1923-1 / 1941-1
#
#
#Signif. codes:   *** 0.001  ** 0.01  * 0.05  
#
#
#
#_________________________________________
#
#BEHAVIORAL EQUATION: w1
#Estimation Technique: OLS
#
#w1                  =   1.12869     
#                        T-stat. 0.6479266   
#
#                    +   0.4398767   (y+t-w2)
#                        T-stat. 12.01268    ***
#
#                    +   c3          TSLAG(y+t-w2,1)
#                        PDL
#
#                    +   0.1368206   time
#                        T-stat. 3.373905    **
#
#PDL:
#c3 1 3
#
#Distributed Lag Coefficient: c3
#Lag     Coeff.         Std. Error     T-stat.        
#0        0.1076812      0.04283967     2.513586      *
#1        0.05074557     0.01291231     3.930015      **
#2       -0.00619005     0.03110492    -0.1990055     
#SUM      0.1522367      0.03873693    
#
#RESTRICTIONS F-TEST:
#F-value            : 0.06920179     
#F-prob(1,11)       : 0.7973647      
#
#
#STATs:
#R-Squared                      : 0.9890855   
#Adjusted R-Squared             : 0.9854474   
#Durbin-Watson Statistic        : 2.174168    
#Sum of squares of residuals    : 6.392707    
#Standard Error of Regression   : 0.7298805   
#Log of the Likelihood Function : -15.80848   
#F-statistic                    : 271.8645    
#F-probability                  : 1.172284e-11
#Akaike's IC                    : 43.61697    
#Schwarz's IC                   : 48.61625    
#Mean of Dependent Variable     : 37.69412    
#Number of Observations         : 17
#Number of Degrees of Freedom   : 12
#Current Sample (year-period)   : 1925-1 / 1941-1
#
#
#Signif. codes:   *** 0.001  ** 0.01  * 0.05  
#
#
#...ESTIMATE OK


#get residuals of 'cn'
myModel$behaviorals$cn$residuals
#Time Series:
#Start = 1925 
#End = 1941 
#Frequency = 1 
# [1] -0.88562504  0.25109884  0.66750111  ...
#[17] -1.41795908

#get residuals of 'i'
myModel$behaviorals$i$residuals
#Time Series:
#Start = 1923 
#End = 1941 
#Frequency = 1 
# [1]  1.464518775 -1.469763968  0.078674017  ...
#[16] -2.425079127 -0.698071507 -1.352967430 -1.724306054

#get estimation coefficients of 'cn' and 'w1'
myModel$behaviorals$cn$coefficients
#          [,1]
#a1 19.01352476
#a2  0.34428157
#a3  0.03443117
#a4  0.69939052

myModel$behaviorals$cn$errorCoefficients
#             [,1]
#RHO_1 0.057431312
#RHO_2 0.007785936

myModel$behaviorals$w1$coefficients
#                [,1]
#c1        1.12869024
#c2        0.43987666
#c3        0.10768118
#c3_PDL_1  0.05074557
#c3_PDL_2 -0.00619005
#c4        0.13682057

#get latest estimation parameters
myModel$estimate_parameters
#$estTech
#[1] "OLS"
#
#$eqList
#[1] "cn" "i"  "w1"

#################################################
#IV case

#estimation of Consumption "cn" with arbitrary IVs
#and error autocorrelation
myModel=ESTIMATE(myModel,
                 eqList = 'cn',
                 estTech = 'IV', 
                 IV=c('1',
                      'TSLAG(y)',
                      'TSLAG(w1)*pi+0.5',
                      'exp(w2)'));
#.CHECK_MODEL_DATA(): warning, there are undefined values in time series "time".
#
#Estimate the Model myModelDefinition:
#the number of behavioral equations to be estimated is 1.
#The total number of coefficients is 4.
#
#_________________________________________
#
#BEHAVIORAL EQUATION: cn
#Estimation Technique: IV
#Autoregression of Order  2  (Cochrane-Orcutt procedure)
#
#Convergence was reached in  7  /  20  iterations.
#
#
#cn                  =   17.93884143014611    
#                        T-stat. 11.35605608264105    ***
#
#                    +   0.1594074567906318   p
#                        T-stat. 0.7524421962971953   
#
#                    +   0.1277506382165825   TSLAG(p,1)
#                        T-stat. 0.9491296499358723   
#
#                    +   0.7596945016016718   (w1+w2)
#                        T-stat. 13.00631014447263    ***
#
#ERROR:  AUTO(2) 
#
#AUTOREGRESSIVE PARAMETERS:
#Rho                      Std. Error               T-stat.                  
# 0.1195212459504091       0.3378062168740853       0.3538160045022491       
#-0.2124449434554128       0.3005397305932941      -0.7068780657919213       
#
#
#STATs:
#R-Squared                      : 0.981280540184345    
#Adjusted R-Squared             : 0.9740807479475546   
#Durbin-Watson Statistic        : 1.852330110333749    
#Sum of squares of residuals    : 11.77949537517467    
#Standard Error of Regression   : 0.9519007452773581   
#Log of the Likelihood Function : -22.41808505770927   
#F-statistic                    : 136.2928967825036    
#F-probability                  : 9.311151849544785e-11
#Akaike's IC                    : 58.83617011541855    
#Schwarz's IC                   : 65.44724296958363    
#Mean of Dependent Variable     : 55.71764705882353    
#Number of Observations         : 19
#Number of Degrees of Freedom   : 13
#Current Sample (year-period)   : 1925-1 / 1941-1
#
#
#Signif. codes:   *** 0.001  ** 0.01  * 0.05  
#
#
#...ESTIMATE OK




#estimation of Investment "i" with arbitrary IVs
#and coefficient restrictions
myModel=ESTIMATE(myModel,
                 eqList = 'i',
                 estTech = 'IV', 
                 IV=c('1',
                      'TSLAG(w2)',
                      'TSLAG(w1)*pi+0.5',
                      'exp(w2)'));

#.CHECK_MODEL_DATA(): warning, there are undefined values in time series "time".
#
#Estimate the Model myModelDefinition:
#the number of behavioral equations to be estimated is 1.
#The total number of coefficients is 4.
#
#_________________________________________
#
#BEHAVIORAL EQUATION: i
#Estimation Technique: IV
#
#i                   =   34.51754474586971    
#                        T-stat. 1.264388701353744    
#
#                    +   0.3216327065477544   p
#                        T-stat. 0.8648297095197013   
#
#                    +   0.6783672934522457   TSLAG(p,1)
#                        T-stat. 1.824043940185745    
#
#                    -   0.2475568598269819   TSLAG(k,1)
#                        T-stat. -1.842520302814061   
#
#RESTRICTIONS:
#b2+b3=1
#
#RESTRICTIONS F-TEST:
#F-value            : 2.465920754930322       
#F-prob(1,15)       : 0.1371905708637959      
#
#
#STATs:
#R-Squared                      : 0.8057731392963399   
#Adjusted R-Squared             : 0.7814947817083824   
#Durbin-Watson Statistic        : 0.9405346241683215   
#Sum of squares of residuals    : 48.50580729347795    
#Standard Error of Regression   : 1.741152766371283    
#Log of the Likelihood Function : -35.86365535226765   
#F-statistic                    : 33.18894766160036    
#F-probability                  : 2.025229876911894e-06
#Akaike's IC                    : 79.7273107045353     
#Schwarz's IC                   : 83.50506662120105    
#Mean of Dependent Variable     : 1.310526315789474    
#Number of Observations         : 19
#Number of Degrees of Freedom   : 16
#Current Sample (year-period)   : 1923-1 / 1941-1
#
#
#Signif. codes:   *** 0.001  ** 0.01  * 0.05  
#
#
#...ESTIMATE OK


}
