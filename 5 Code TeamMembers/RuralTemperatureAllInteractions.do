clear all
set more off

import excel "/home/inath/Downloads/code93.xls", sheet("code93") firstrow

destring FIPSCode, gen(fips)
rename RuralurbanContinuuumCode199 ruralurbancode

gen rural = 1
replace rural = 0 if ruralurbancode == 1 
replace rural = 0 if ruralurbancode == 2
replace rural = 0 if ruralurbancode == 3

save "/home/inath/Temperature&Mortality/US/DataCleaning/RuralUrban.dta", replace

clear all
use "/home/inath/Temperature&Mortality/US/DataCleaning/MergedModalBinTerciles.dta"

merge m:1 fips using "/home/inath/Temperature&Mortality/US/DataCleaning/RuralUrban.dta"
keep if _merge == 3
drop _merge

save "/home/inath/Temperature&Mortality/US/DataCleaning/MergedModeBinTercilesRuralUrban.dta", replace
gen urban = 0
replace urban = 1 if rural == 0

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

gen smean1_COLD_RURAL = smean1*COLD*rural
gen smean1_HOT_URBAN = smean1*HOT*urban
gen smean1_HOT_RURAL = smean1*HOT*rural
gen smean1_COLD_URBAN = smean1*COLD*urban
gen smean2_COLD_RURAL = smean2*COLD*rural
gen smean2_HOT_URBAN = smean2*HOT*urban
gen smean2_HOT_RURAL = smean2*HOT*rural
gen smean2_COLD_URBAN = smean2*COLD*urban
gen smean3_COLD_RURAL = smean3*COLD*rural
gen smean3_HOT_URBAN = smean3*HOT*urban
gen smean3_HOT_RURAL = smean3*HOT*rural
gen smean3_COLD_URBAN = smean3*COLD*urban
gen smean4_COLD_RURAL = smean4*COLD*rural
gen smean4_HOT_URBAN = smean4*HOT*urban
gen smean4_HOT_RURAL = smean4*HOT*rural
gen smean4_COLD_URBAN = smean4*COLD*urban
gen smean5_COLD_RURAL = smean5*COLD*rural
gen smean5_HOT_URBAN = smean5*HOT*urban
gen smean5_HOT_RURAL = smean5*HOT*rural
gen smean5_COLD_URBAN = smean5*COLD*urban
gen smean7_COLD_RURAL = smean7*COLD*rural
gen smean7_HOT_URBAN = smean7*HOT*urban
gen smean7_HOT_RURAL = smean7*HOT*rural
gen smean7_COLD_URBAN = smean7*COLD*urban
gen smean8_COLD_RURAL = smean8*COLD*rural
gen smean8_HOT_URBAN = smean8*HOT*urban
gen smean8_HOT_RURAL = smean8*HOT*rural
gen smean8_COLD_URBAN = smean8*COLD*urban
gen smean9_COLD_RURAL = smean9*COLD*rural
gen smean9_HOT_URBAN = smean9*HOT*urban
gen smean9_HOT_RURAL = smean9*HOT*rural
gen smean9_COLD_URBAN = smean9*COLD*urban
gen smean10_COLD_RURAL = smean10*COLD*rural
gen smean10_HOT_URBAN = smean10*HOT*urban
gen smean10_HOT_RURAL = smean10*HOT*rural
gen smean10_COLD_URBAN = smean10*COLD*urban


*reghdfe weighteddeathrate c.smean1_COLD#i.rural c.smean1#i.rural c.smean1_HOT#i.rural c.smean2_COLD#i.rural c.smean2#i.rural c.smean2_HOT#i.rural c.smean3#i.rural c.smean4#i.rural c.smean5#i.rural ///
*c.smean7#i.rural c.smean8#i.rural c.smean9_COLD#i.rural c.smean9#i.rural c.smean9_HOT#i.rural c.smean10_COLD#i.rural c.smean10#i.rural c.smean10_HOT#i.rural ///
*mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
*proportion0000 proportion0144 proportion4564 proportion6599 if rural==0, absorb(i.fips#i.COLD i.fips i.fips#i.HOT i.year i.year#i.COLD i.year#i.HOT) vce(cluster fips)

reghdfe weighteddeathrate smean1_COLD_URBAN smean1_COLD_RURAL smean1 smean1_HOT_URBAN smean1_HOT_RURAL ///
smean2_COLD_URBAN smean2_COLD_RURAL smean2 smean2_HOT_URBAN smean2_HOT_RURAL ///
smean3_COLD_URBAN smean3_COLD_RURAL smean3 smean3_HOT_URBAN smean3_HOT_RURAL ///
smean4_COLD_URBAN smean4_COLD_RURAL smean4 smean4_HOT_URBAN smean4_HOT_RURAL ///
smean5_COLD_URBAN smean5_COLD_RURAL smean5 smean5_HOT_URBAN smean5_HOT_RURAL ///
smean7_COLD_URBAN smean7_COLD_RURAL smean7 smean7_HOT_URBAN smean7_HOT_RURAL ///
smean8_COLD_URBAN smean8_COLD_RURAL smean8 smean8_HOT_URBAN smean8_HOT_RURAL ///
smean9_COLD_URBAN smean9_COLD_RURAL smean9 smean9_HOT_URBAN smean9_HOT_RURAL ///
smean10_COLD_URBAN smean10_COLD_RURAL smean10 smean10_HOT_URBAN smean10_HOT_RURAL ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599, absorb(i.fips#i.COLD i.fips i.fips#i.HOT i.year i.year#i.COLD i.year#i.HOT) vce(cluster fips)

estimates store r1, title(County & Year FE)

reghdfe weighteddeathrate smean1_COLD_URBAN smean1_COLD_RURAL smean1 smean1_HOT_URBAN smean1_HOT_RURAL ///
smean2_COLD_URBAN smean2_COLD_RURAL smean2 smean2_HOT_URBAN smean2_HOT_RURAL ///
smean3_COLD_URBAN smean3_COLD_RURAL smean3 smean3_HOT_URBAN smean3_HOT_RURAL ///
smean4_COLD_URBAN smean4_COLD_RURAL smean4 smean4_HOT_URBAN smean4_HOT_RURAL ///
smean5_COLD_URBAN smean5_COLD_RURAL smean5 smean5_HOT_URBAN smean5_HOT_RURAL ///
smean7_COLD_URBAN smean7_COLD_RURAL smean7 smean7_HOT_URBAN smean7_HOT_RURAL ///
smean8_COLD_URBAN smean8_COLD_RURAL smean8 smean8_HOT_URBAN smean8_HOT_RURAL ///
smean9_COLD_URBAN smean9_COLD_RURAL smean9 smean9_HOT_URBAN smean9_HOT_RURAL ///
smean10_COLD_URBAN smean10_COLD_RURAL smean10 smean10_HOT_URBAN smean10_HOT_RURAL ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599, /// 
absorb(i.fips#i.COLD i.fips i.fips#i.HOT i.statefips#i.year i.statefips#i.year#i.COLD i.statefips#i.year#i.HOT) vce(cluster fips)

estimates store r2, title(County & State-Year FE)

reghdfe weighteddeathrate smean1_COLD_URBAN smean1_COLD_RURAL smean1 smean1_HOT_URBAN smean1_HOT_RURAL ///
smean2_COLD_URBAN smean2_COLD_RURAL smean2 smean2_HOT_URBAN smean2_HOT_RURAL ///
smean3 smean4 smean5 smean7 smean8 ///
smean9_COLD_URBAN smean9_COLD_RURAL smean9 smean9_HOT_URBAN smean9_HOT_RURAL ///
smean10_COLD_URBAN smean10_COLD_RURAL smean10 smean10_HOT_URBAN smean10_HOT_RURAL ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599, absorb(i.fips#i.COLD i.fips i.fips#i.HOT i.year i.year#i.COLD i.year#i.HOT) vce(cluster fips)

estimates store r3, title(County & Year FE)

reghdfe weighteddeathrate smean1_COLD_URBAN smean1_COLD_RURAL smean1 smean1_HOT_URBAN smean1_HOT_RURAL ///
smean2_COLD_URBAN smean2_COLD_RURAL smean2 smean2_HOT_URBAN smean2_HOT_RURAL ///
smean3 smean4 smean5 smean7 smean8 ///
smean9_COLD_URBAN smean9_COLD_RURAL smean9 smean9_HOT_URBAN smean9_HOT_RURAL ///
smean10_COLD_URBAN smean10_COLD_RURAL smean10 smean10_HOT_URBAN smean10_HOT_RURAL ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599, /// 
absorb(i.fips#i.COLD i.fips i.fips#i.HOT i.statefips#i.year i.statefips#i.year#i.COLD i.statefips#i.year#i.HOT) vce(cluster fips)

estimates store r4, title(County & State-Year FE)

label variable weighteddeathrate "Death Rate"
label variable smean1_COLD_RURAL "<10F*COLD*RURAL"
label variable smean1_COLD_URBAN "<10F*COLD*URBAN"
label variable smean1 "<10F"
label variable smean1_HOT_RURAL "<10F*HOT*RURAL"
label variable smean1_HOT_URBAN "<10F*HOT*URBAN"
label variable smean2_COLD_RURAL "10-20F*COLD*RURAL"
label variable smean2_COLD_URBAN "10-20F*COLD*URBAN"
label variable smean2 "10-20F"
label variable smean2_HOT_RURAL "10-20F*HOT*RURAL"
label variable smean2_HOT_URBAN "10-20F*HOT*URBAN"
label variable smean3_COLD_RURAL "20-30F*COLD*RURAL"
label variable smean3_COLD_URBAN "20-30F*COLD*URBAN"
label variable smean3 "20-30F"
label variable smean3_HOT_RURAL "20-30F*HOT*RURAL"
label variable smean3_HOT_URBAN "20-30F*HOT*URBAN"
label variable smean4_COLD_RURAL "30-40F*COLD*RURAL"
label variable smean4_COLD_URBAN "30-40F*COLD*URBAN"
label variable smean4 "30-40F"
label variable smean4_HOT_RURAL "30-40F*HOT*RURAL"
label variable smean4_HOT_URBAN "30-40F*HOT*URBAN"
label variable smean5_COLD_RURAL "40-50F*COLD*RURAL"
label variable smean5_COLD_URBAN "40-50F*COLD*URBAN"
label variable smean5 "40-50F"
label variable smean5_HOT_RURAL "40-50F*HOT*RURAL"
label variable smean5_HOT_URBAN "40-50F*HOT*URBAN"
label variable smean7_COLD_RURAL "60-70F*COLD*RURAL"
label variable smean7_COLD_URBAN "60-70F*COLD*URBAN"
label variable smean7 "60-70F"
label variable smean7_HOT_RURAL "60-70F*HOT*RURAL"
label variable smean7_HOT_URBAN "60-70F*HOT*URBAN"
label variable smean8_COLD_RURAL "70-80F*COLD*RURAL"
label variable smean8_COLD_URBAN "70-80F*COLD*URBAN"
label variable smean8 "70-80F"
label variable smean8_HOT_RURAL "70-80F*HOT*RURAL"
label variable smean8_HOT_URBAN "70-80F*HOT*URBAN"
label variable smean9_COLD_RURAL "80-90F*COLD*RURAL"
label variable smean9_COLD_URBAN "80-90F*COLD*URBAN"
label variable smean9 "80-90F"
label variable smean9_HOT_RURAL "80-90F*HOT*RURAL"
label variable smean9_HOT_URBAN "80-90F*HOT*URBAN"
label variable smean10_COLD_RURAL ">90F*COLD*RURAL"
label variable smean10_COLD_URBAN ">90F*COLD*URBAN"
label variable smean10 ">90F"
label variable smean10_HOT_RURAL ">90F*HOT*RURAL"
label variable smean10_HOT_URBAN ">90F*HOT*URBAN"

esttab r1 r2 r3 r4, replace b(a2) se(a2) r2 ar2 scalars(F) nostar parentheses mtitles label varlabels(_cons Constant)
esttab r1 r2 r3 r4 using "/home/inath/Temperature&Mortality/US/Analysis/RuralUrbanandTempInteractions.tex", replace b(a2) se(a2) r2 ar2 scalars(F) drop(mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599) longtable nostar parentheses mtitles label varlabels(_cons Constant)


