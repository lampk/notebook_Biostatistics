##################################################################################
#  4_Practical_R_preamble                                                    #
#                                                                                #
#  Load functions and packages needed to run code for Practical 4          #
#  
#                                                                                #
#  Margarita Moreno-Betancur                                                     #
#  23 Nov 2019                                                                   #
##################################################################################



library(readstata13)
library(jomo)
library(mice)
library(geepack)
library(micemd)


# 1. Function to combine M estimates and variances from M imputed datasets using Rubin's rules.
# (from my package "survtd" available at https://github.com/moreno-betancur/survtd)
combMI<-function(coefmi,varmi,M)
{est<-mean(coefmi)
varinter<-(1/(M-1))*sum((coefmi-est)^2)
varintra<-mean(varmi)
se<-sqrt(varintra+(1+1/M)*varinter)
r<-(1+1/M)*varinter/varintra
vvv<-(M-1)*(1+1/r)^2
tal<-qt(0.025,df=vvv,lower.tail=F)
pval<-2*(1-pt(q=abs(est/se),df=vvv))
return(c(est=est,se=se,CIlow=est-tal*se,CIupp=est+tal*se,pval=pval))}

# 2. Function to create "past wave" variables for analysis
getpast<-function(x){
  x$bmiprev<-c(NA,c(x[,"bmiz"])[-5])
  x$sleeprev<-c(NA,c(x[,"sleep_prob"])[-5])
  return(x)}


# 3. Function to extract confidence intervals for geese objects 
# (from https://stackoverflow.com/questions/21221280/confidence-interval-of-coefficients-using-generalized-estimating-equation-gee)
confint.geeglm <- function(object, parm, level = 0.95, ...) {
  cc <- coef(summary(object))
  mult <- qnorm((1+level)/2)
  citab <- with(as.data.frame(cc),
                cbind(lwr=Estimate-mult*Std.err,
                      upr=Estimate+mult*Std.err))
  rownames(citab) <- rownames(cc)
  res<-cbind(coef(summary(object)),citab[parm,])
  res<-res[,c("Estimate","Std.err","lwr","upr","Pr(>|W|)")]
  names(res)<-c("est","se", "CIlow", "CIupp", "pval")
  res
}