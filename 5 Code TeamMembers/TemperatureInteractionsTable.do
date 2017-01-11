clear all
set more off

use "/home/inath/Temperature&Mortality/US/DataCleaning/Merged.dta"

egen modetempdays = rowmax(smean1 smean2 smean3 smean4 smean5 smean6 smean7 smean8 smean9 smean10)
gen modetempbin = 0
replace modetempbin = 5 if modetempdays == smean1
replace modetempbin = 15 if modetempdays == smean2
replace modetempbin = 25 if modetempdays == smean3
replace modetempbin = 35 if modetempdays == smean4
replace modetempbin = 45 if modetempdays == smean5
replace modetempbin = 55 if modetempdays == smean6
replace modetempbin = 65 if modetempdays == smean7
replace modetempbin = 75 if modetempdays == smean8
replace modetempbin = 85 if modetempdays == smean9
replace modetempbin = 95 if modetempdays == smean10

*summarize modetempbin, detail

gen COLD = 0
replace COLD = 1 if modetempbin < 75
gen MEDIUM = 0
replace MEDIUM = 1 if modetempbin == 75
gen HOT = 0
replace HOT = 1 if modetempbin > 75

save "/home/inath/Temperature&Mortality/US/DataCleaning/MergedModalBinTerciles.dta", replace

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

gen smean1_COLD = smean1*COLD
gen smean1_MEDIUM = smean1*MEDIUM
gen smean1_HOT = smean1*HOT
gen smean2_COLD = smean2*COLD
gen smean2_MEDIUM = smean2*MEDIUM
gen smean2_HOT = smean2*HOT
gen smean3_COLD = smean3*COLD
gen smean3_MEDIUM = smean3*MEDIUM
gen smean3_HOT = smean3*HOT
gen smean4_COLD = smean4*COLD
gen smean4_MEDIUM = smean4*MEDIUM
gen smean4_HOT = smean4*HOT
gen smean5_COLD = smean5*COLD
gen smean5_MEDIUM = smean5*MEDIUM
gen smean5_HOT = smean5*HOT
gen smean7_COLD = smean7*COLD
gen smean7_MEDIUM = smean7*MEDIUM
gen smean7_HOT = smean7*HOT
gen smean8_COLD = smean8*COLD
gen smean8_MEDIUM = smean8*MEDIUM
gen smean8_HOT = smean8*HOT
gen smean9_COLD = smean9*COLD
gen smean9_MEDIUM = smean9*MEDIUM
gen smean9_HOT = smean9*HOT
gen smean10_COLD = smean10*COLD
gen smean10_MEDIUM = smean10*MEDIUM
gen smean10_HOT = smean10*HOT

reghdfe weighteddeathrate smean1_COLD smean1 smean1_HOT smean2_COLD smean2 smean2_HOT ///
smean3_COLD smean3 smean3_HOT smean4_COLD smean4 smean4_HOT ///
smean5_COLD smean5 smean5_HOT ///
smean7_COLD smean7 smean7_HOT smean8_COLD smean8 smean8_HOT ///
smean9_COLD smean9 smean9_HOT smean10_COLD smean10 smean10_HOT ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599, absorb(i.fips#i.COLD i.fips i.fips#i.HOT i.year i.year#i.COLD i.year#i.HOT) vce(cluster fips)

estimates store r1, title(County & Year FE)

reghdfe weighteddeathrate smean1_COLD smean1 smean1_HOT smean2_COLD smean2 smean2_HOT ///
smean3_COLD smean3 smean3_HOT smean4_COLD smean4 smean4_HOT ///
smean5_COLD smean5 smean5_HOT ///
smean7_COLD smean7 smean7_HOT smean8_COLD smean8 smean8_HOT ///
smean9_COLD smean9 smean9_HOT smean10_COLD smean10 smean10_HOT ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599, /// 
absorb(i.fips#i.COLD i.fips i.fips#i.HOT i.statefips#i.year i.statefips#i.year#i.COLD i.statefips#i.year#i.HOT) vce(cluster fips)

estimates store r2, title(County & State-Year FE)

reghdfe weighteddeathrate smean1_COLD smean1 smean1_HOT smean2_COLD smean2 smean2_HOT smean3 smean4 smean5 ///
smean7 smean8 smean9_COLD smean9 smean9_HOT smean10_COLD smean10 smean10_HOT ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599, absorb(i.fips#i.COLD i.fips i.fips#i.HOT i.year i.year#i.COLD i.year#i.HOT) vce(cluster fips)

estimates store r3, title(County & Year FE)

reghdfe weighteddeathrate smean1_COLD smean1 smean1_HOT smean2_COLD smean2 smean2_HOT smean3 smean4 smean5 ///
smean7 smean8 smean9_COLD smean9 smean9_HOT smean10_COLD smean10 smean10_HOT ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599, /// 
absorb(i.fips#i.COLD i.fips i.fips#i.HOT i.statefips#i.year i.statefips#i.year#i.COLD i.statefips#i.year#i.HOT) vce(cluster fips)

estimates store r4, title(County & State-Year FE)


label variable weighteddeathrate "Death Rate"
label variable smean1_COLD "<10F*COLD" 
label variable smean1 "<10F" 
label variable smean1_HOT "<10F*HOT" 
label variable smean2_COLD "10-20F*COLD" 
label variable smean2 "10-20F" 
label variable smean2_HOT "10-20F*HOT" 
label variable smean3_COLD "20-30F*COLD" 
label variable smean3 "20-30F" 
label variable smean3_HOT "20-30F*HOT" 
label variable smean4_COLD "30-40F*COLD" 
label variable smean4 "30-40F" 
label variable smean4_HOT "30-40F*HOT" 
label variable smean5_COLD "40-50F*COLD" 
label variable smean5 "40-50F" 
label variable smean5_HOT "40-50F*HOT" 
label variable smean7_COLD "60-70F*COLD" 
label variable smean7 "60-70F" 
label variable smean7_HOT "60-70F*HOT" 
label variable smean8_COLD "70-80F*COLD" 
label variable smean8 "70-80F" 
label variable smean8_HOT "70-80F*HOT" 
label variable smean9_COLD "80-90F*COLD" 
label variable smean9 "80-90F" 
label variable smean9_HOT "80-90F*HOT" 
label variable smean10_COLD ">90F*COLD"
label variable smean10 ">90F"
label variable smean10_HOT ">90F*HOT"

esttab r1 r2 r3 r4, replace b(a2) se(a2) r2 ar2 scalars(F) nostar parentheses mtitles label varlabels(_cons Constant)
esttab r1 r2 r3 r4 using "/home/inath/Temperature&Mortality/US/Analysis/TemperatureInteractionsTable.tex", replace b(a2) se(a2) r2 ar2 scalars(F) drop(mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599) longtable nostar parentheses mtitles label varlabels(_cons Constant)


