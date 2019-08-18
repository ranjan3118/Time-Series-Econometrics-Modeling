** GENERATING LOG VARIABLE TO COMPUTE EMPLOYMENT RATE
generate mhr1=log(mhr)
generate guj1=log(mhr)
generate mp1=log(mp)
generate ap1=log(ap)
generate tn1=log(tn)
generate kerala1=log(kerala)
** GENERATING LAG VARIABLE AND TAKING LOG OF THAT
gen mhrlag = l.mhr
gen gujlag = l.guj
gen mplag = l.mp
gen aplag = l.ap
gen tnlag = l.tn
gen keralalag = l.kerala
** COMPUTING THE EMPLOYMENT RATE
gen unempr_mhr = log(mhr) - log(mhrlag)
log using "C:\Users\ayush\OneDrive\Desktop\stata class\24 june assignment log.smcl"
gen unempr_guj = log(guj) - log(gujlag)
gen unempr_mp = log(mp) - log(mplag)
gen unempr_ap = log(ap) - log(aplag)
gen unempr_tn = log(tn) - log(tnlag)
gen unempr_kerala = log(kerala) - log(keralalag)
generate ln_mhr = log(mhr)
generate ln_guj = log(guj)
gen ln_mp = log(mp)
gen ln_ap = log(ap)
gen Ln_tn = log(tn)
gen ln_kerala = log(kerala)
reg ln_mhr t
reg ln_mhr ln_guj ln_mp ln_ap Ln_tn ln_kerala t
** HETTEST FOR CHECKING FOR HETERODASKTICITY
hettest
** ENDOGENISING TIME
tsset t
** COMPUTING REGRESSION WITH IV as D. and L. 
reg ln_mhr D.ln_mhr
reg ln_mhr L.ln_mhr
** ARIMA MODELING
arima ln_mhr, arima( 1 1 1 )
reg D.ln_mhr
** TEST ARCH EFFECT
estat archlm, lags(1)
estat archlm, lags(1)
** YES THERE IS ARCH EFFECT
arch D.ln_mhr, arch(1) garch(1)
** INNOVATION INTRODUCED GARCH IS MORE SIGNIFICANT THAN ARCH
arch D.ln_mhr,ar(1)ma(1 4)
arch D.ln_mhr,ar(1)ma(1 4) arch(1) garch(1)
test[ARCH]L1.arch [ARCH]L1.garch
reg ln_mhr ln_guj ln_mp ln_ap Ln_tn ln_kerala t
mean mhr
mean mhr
vce
reg mhr guj ap mp tn kerala t
vif
**VIF tells the extent to which standard error of the coef of interest, variance the square of the standard error has been inflated upwards, std error = sqrt variance to inflated twice its basic size.
reg mhr guj ap mp tn t
vif
reg mhr guj ap mp t
vif
** DROPPED VARIABLES to lower the VIF below 10
** VIF = 1/ (1- R^2)
arch D.ln_mhr,ar(1)ma(1 4) arch(1) garch(1)
mean mhr
summarize
mean(mhr)
mean mhr
** TO GENERATE MEAN VALUE USING EGEN FUNCTION
egen mmhr = mean(mhr)
egen mguj = mean(guj)
egen mmp = mean(mp)
egen map = mean(ap)
egen mtn = mean(tn)
egen mkerala = mean(kerala)
egen mmhrlag = mean(mhrlag)
egen mgujlag = mean(gujlag)
egen mmplag = mean(mplag)
egen maplag = mean(aplag)
egen mtnlag = mean(tnlag)
egen mkeralalag = mean(keralalag)
** COMPUTED AGGREGATE VALUE OF EMPLOYMENT RATE OF STATES
gen unempr_mguj = log(mguj) - log(mgujlag)
gen unempr_mmp = log(mmp) - log(mmplag)
gen unempr_map = log(map) - log(maplag)
gen unempr_mtn = log(mtn) - log(mtnlag)
gen unempr_mkerala = log(mkerala) - log(mkeralalag)
log close
