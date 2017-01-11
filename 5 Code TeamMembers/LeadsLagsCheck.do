clear all
set more off

use "/home/inath/Temperature&Mortality/US/DataCleaning/Merged.dta"

replace rate_0000 = 0 if missing(rate_0000)
replace rate_0144 = 0 if missing(rate_0144)
replace rate_4564 = 0 if missing(rate_4564)
replace rate_6599 = 0 if missing(rate_6599)

gen totalpop = pop_0000+pop_0144+pop_4564+pop_6599
gen sqrtpop = sqrt(totalpop)
egen meanpop = mean(totalpop)
gen sqrtmeanpop = sqrt(meanpop)
gen proportion0000 = pop_0000/totalpop
gen proportion0144 = pop_0144/totalpop
gen proportion4564 = pop_4564/totalpop
gen proportion6599 = pop_6599/totalpop
gen weighteddeathrate = sqrtpop/sqrtmeanpop*(rate_0000*proportion0000+rate_0144*proportion0144+rate_4564*proportion4564+rate_6599*proportion6599)
drop if weighteddeathrate == 0

xtset fips year

reghdfe weighteddeathrate smean1 smean2 smean3 smean4 smean5 smean7 smean8 smean9 smean10 ///
l1.smean1 l1.smean2 l1.smean3 l1.smean4 l1.smean5 l1.smean7 l1.smean8 l1.smean9 l1.smean10 ///
l2.smean1 l2.smean2 l2.smean3 l2.smean4 l2.smean5 l2.smean7 l2.smean8 l2.smean9 l2.smean10 ///
l3.smean1 l3.smean2 l3.smean3 l3.smean4 l3.smean5 l3.smean7 l3.smean8 l3.smean9 l3.smean10 ///
l4.smean1 l4.smean2 l4.smean3 l4.smean4 l4.smean5 l4.smean7 l4.smean8 l4.smean9 l4.smean10 ///
f1.smean1 f1.smean2 f1.smean3 f1.smean4 f1.smean5 f1.smean7 f1.smean8 f1.smean9 f1.smean10 ///
f2.smean1 f2.smean2 f2.smean3 f2.smean4 f2.smean5 f2.smean7 f2.smean8 f2.smean9 f2.smean10 ///
f3.smean1 f3.smean2 f3.smean3 f3.smean4 f3.smean5 f3.smean7 f3.smean8 f3.smean9 f3.smean10 ///
f4.smean1 f4.smean2 f4.smean3 f4.smean4 f4.smean5 f4.smean7 f4.smean8 f4.smean9 f4.smean10 ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599, absorb(i.fips i.year) vce(cluster fips)

*estat ic
estimates store fourlagsandleads, title(Four Leads/Lags, County & Year FE)

gen sample = e(sample)

reghdfe weighteddeathrate smean1 smean2 smean3 smean4 smean5 smean7 smean8 smean9 smean10 ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599 if sample==1, absorb(i.fips i.year) vce(cluster fips)

estimates store nolagsorleads, title(No Lags or Leads, County & Year FE)

reghdfe weighteddeathrate smean1 smean2 smean3 smean4 smean5 smean7 smean8 smean9 smean10 ///
l1.smean1 l1.smean2 l1.smean3 l1.smean4 l1.smean5 l1.smean7 l1.smean8 l1.smean9 l1.smean10 ///
l2.smean1 l2.smean2 l2.smean3 l2.smean4 l2.smean5 l2.smean7 l2.smean8 l2.smean9 l2.smean10 ///
l3.smean1 l3.smean2 l3.smean3 l3.smean4 l3.smean5 l3.smean7 l3.smean8 l3.smean9 l3.smean10 ///
l4.smean1 l4.smean2 l4.smean3 l4.smean4 l4.smean5 l4.smean7 l4.smean8 l4.smean9 l4.smean10 ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599 if sample==1, absorb(i.fips i.year) vce(cluster fips)

*estat ic
estimates store fourlags, title(Four Lags, County & Year FE)

reghdfe weighteddeathrate smean1 smean2 smean3 smean4 smean5 smean7 smean8 smean9 smean10 ///
f1.smean1 f1.smean2 f1.smean3 f1.smean4 f1.smean5 f1.smean7 f1.smean8 f1.smean9 f1.smean10 ///
f2.smean1 f2.smean2 f2.smean3 f2.smean4 f2.smean5 f2.smean7 f2.smean8 f2.smean9 f2.smean10 ///
f3.smean1 f3.smean2 f3.smean3 f3.smean4 f3.smean5 f3.smean7 f3.smean8 f3.smean9 f3.smean10 ///
f4.smean1 f4.smean2 f4.smean3 f4.smean4 f4.smean5 f4.smean7 f4.smean8 f4.smean9 f4.smean10 ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599 if sample==1, absorb(i.fips i.year) vce(cluster fips)

*estat ic
estimates store fourleads, title(Four Leads, County & Year FE)

reghdfe weighteddeathrate smean1 smean2 smean3 smean4 smean5 smean7 smean8 smean9 smean10 ///
l1.smean1 l1.smean2 l1.smean3 l1.smean4 l1.smean5 l1.smean7 l1.smean8 l1.smean9 l1.smean10 ///
f1.smean1 f1.smean2 f1.smean3 f1.smean4 f1.smean5 f1.smean7 f1.smean8 f1.smean9 f1.smean10 ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599 if sample==1, absorb(i.fips i.year) vce(cluster fips)

*estat ic
estimates store onelagandlead, title(One Lead/Lag, County & Year FE)

reghdfe weighteddeathrate smean1 smean2 smean3 smean4 smean5 smean7 smean8 smean9 smean10 ///
l1.smean1 l1.smean2 l1.smean3 l1.smean4 l1.smean5 l1.smean7 l1.smean8 l1.smean9 l1.smean10 ///
l2.smean1 l2.smean2 l2.smean3 l2.smean4 l2.smean5 l2.smean7 l2.smean8 l2.smean9 l2.smean10 ///
f1.smean1 f1.smean2 f1.smean3 f1.smean4 f1.smean5 f1.smean7 f1.smean8 f1.smean9 f1.smean10 ///
f2.smean1 f2.smean2 f2.smean3 f2.smean4 f2.smean5 f2.smean7 f2.smean8 f2.smean9 f2.smean10 ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599 if sample==1, absorb(i.fips i.year) vce(cluster fips)

*estat ic
estimates store twolagsandleads, title(Two Leads/Lags, County & Year FE)

reghdfe weighteddeathrate smean1 smean2 smean3 smean4 smean5 smean7 smean8 smean9 smean10 ///
l1.smean1 l1.smean2 l1.smean3 l1.smean4 l1.smean5 l1.smean7 l1.smean8 l1.smean9 l1.smean10 ///
l2.smean1 l2.smean2 l2.smean3 l2.smean4 l2.smean5 l2.smean7 l2.smean8 l2.smean9 l2.smean10 ///
l3.smean1 l3.smean2 l3.smean3 l3.smean4 l3.smean5 l3.smean7 l3.smean8 l3.smean9 l3.smean10 ///
f1.smean1 f1.smean2 f1.smean3 f1.smean4 f1.smean5 f1.smean7 f1.smean8 f1.smean9 f1.smean10 ///
f2.smean1 f2.smean2 f2.smean3 f2.smean4 f2.smean5 f2.smean7 f2.smean8 f2.smean9 f2.smean10 ///
f3.smean1 f3.smean2 f3.smean3 f3.smean4 f3.smean5 f3.smean7 f3.smean8 f3.smean9 f3.smean10 ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599 if sample==1, absorb(i.fips i.year) vce(cluster fips)

*estat ic
estimates store threelagsandleads, title(Three Leads/Lags, County & Year FE)



label variable weighteddeathrate "Death Rate"
label variable smean1 "<10F" 
label variable smean2 "10-20F" 
label variable smean3 "20-30F"
label variable smean4 "30-40F"
label variable smean5 "40-50F"
label variable smean7 "60-70F"
label variable smean8 "70-80F"
label variable smean9 "80-90F" 
label variable smean10 ">90F"

estimates stats nolagsorleads fourlags fourleads onelagandlead twolagsandleads threelagsandleads fourlagsandleads

esttab nolagsorleads fourlags fourleads onelagandlead twolagsandleads threelagsandleads fourlagsandleads, replace b(a2) se(a2) r2 ar2 scalars(F) aic bic drop(mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599) nostar parentheses mtitles label varlabels(_cons Constant)
esttab nolagsorleads fourlags fourleads onelagandlead twolagsandleads threelagsandleads fourlagsandleads using "/home/inath/Temperature&Mortality/US/Analysis/LagsandLeads.tex", replace b(a2) se(a2) r2 ar2 scalars(F) aic bic drop(mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599) longtable nostar parentheses mtitles label varlabels(_cons Constant)


