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
use "/home/inath/Temperature&Mortality/US/DataCleaning/MergedTerciles.dta"

merge m:1 fips using "/home/inath/Temperature&Mortality/US/DataCleaning/RuralUrban.dta"
keep if _merge == 3
drop _merge

save "/home/inath/Temperature&Mortality/US/DataCleaning/MergedTercilesRuralUrban.dta", replace
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

gen smean1_rural = smean1*rural
gen smean1_urban = smean1*urban
gen smean2_rural = smean2*rural
gen smean2_urban = smean2*urban
gen smean3_rural = smean3*rural
gen smean3_urban = smean3*urban
gen smean4_rural = smean4*rural
gen smean4_urban = smean4*urban
gen smean5_rural = smean5*rural
gen smean5_urban = smean5*urban
gen smean6_rural = smean6*rural
gen smean6_urban = smean6*urban
gen smean7_rural = smean7*rural
gen smean7_urban = smean7*urban
gen smean8_rural = smean8*rural
gen smean8_urban = smean8*urban
gen smean9_rural = smean9*rural
gen smean9_urban = smean9*urban
gen smean10_rural = smean10*rural
gen smean10_urban = smean10*urban

reghdfe weighteddeathrate smean1_rural smean1_urban smean2_rural smean2_urban smean3_rural smean3_urban ///
smean4_rural smean4_urban smean5_rural smean5_urban ///
smean7_rural smean7_urban ///
smean8_rural smean8_urban smean9_rural smean9_urban ///
smean10_rural smean10_urban ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599, absorb(i.fips#i.rural i.fips i.fips#i.urban i.year i.year#i.rural i.year#i.urban) vce(cluster fips)

estimates store r1, title(County & Year FE)

reghdfe weighteddeathrate smean1_rural smean1_urban smean2_rural smean2_urban smean3_rural smean3_urban ///
smean4_rural smean4_urban smean5_rural smean5_urban ///
smean7_rural smean7_urban ///
smean8_rural smean8_urban smean9_rural smean9_urban ///
smean10_rural smean10_urban ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599, absorb(i.fips#i.rural i.fips i.fips#i.urban i.statefips#i.year i.statefips#i.year#i.rural i.statefips#i.year#i.urban) vce(cluster fips)

estimates store r2, title(County & State-Year FE)

reghdfe weighteddeathrate smean1_rural smean1_urban smean2_rural smean2_urban ///
smean3 smean4 smean5 smean7 smean8 smean9_rural smean9_urban ///
smean10_rural smean10_urban ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599, absorb(i.fips#i.rural i.fips i.fips#i.urban i.year i.year#i.rural i.year#i.urban) vce(cluster fips)

estimates store r3, title(County & Year FE)

reghdfe weighteddeathrate smean1_rural smean1_urban smean2_rural smean2_urban ///
smean3 smean4 smean5 smean7 smean8 smean9_rural smean9_urban ///
smean10_rural smean10_urban ///
mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599, absorb(i.fips#i.rural i.fips i.fips#i.urban i.statefips#i.year i.statefips#i.year#i.rural i.statefips#i.year#i.urban) vce(cluster fips)

estimates store r4, title(County & State-Year FE)

label variable weighteddeathrate "Death Rate"
label variable smean1_rural "<10F*rural" 
label variable smean1_urban "<10F*urban" 
label variable smean2_rural "10-20F*rural" 
label variable smean2_urban "10-20F*urban" 
label variable smean3_rural "20-30F*rural" 
label variable smean3 "20-30F" 
label variable smean3_urban "20-30F*urban" 
label variable smean4_rural "30-40F*rural" 
label variable smean4 "30-40F" 
label variable smean4_urban "30-40F*urban" 
label variable smean5_rural "40-50F*rural" 
label variable smean5 "40-50F" 
label variable smean5_urban "40-50F*urban" 
label variable smean7_rural "60-70F*rural" 
label variable smean7 "60-70F" 
label variable smean7_urban "60-70F*urban" 
label variable smean8_rural "70-80F*rural" 
label variable smean8 "70-80F" 
label variable smean8_urban "70-80F*urban" 
label variable smean9_rural "80-90F*rural" 
label variable smean9_urban "80-90F*urban" 
label variable smean10_rural ">90F*rural"
label variable smean10_urban ">90F*urban"

esttab r1 r2 r3 r4, replace b(a2) se(a2) r2 ar2 scalars(F) nostar parentheses mtitles label varlabels(_cons Constant)
esttab r1 r2 r3 r4 using "/home/inath/Temperature&Mortality/US/Analysis/UrbanRuralInteractions.tex", replace b(a2) se(a2) r2 ar2 scalars(F) /// 
drop(mprcp2 mprcp3 mprcp4 mprcp5 mprcp6 mprcp7 mprcp8 mprcp9 mprcp10 mprcp11 mprcp12 ///
proportion0000 proportion0144 proportion4564 proportion6599) ///
order(smean1_rural smean1_urban smean2_rural smean2_urban smean3_rural smean3 smean3_urban ///
smean4_rural smean4 smean4_urban smean5_rural smean5 smean5_urban ///
smean7_rural smean7 smean7_urban ///
smean8_rural smean8 smean8_urban smean9_rural smean9_urban ///
smean10_rural smean10_urban) ///
longtable nostar parentheses mtitles label varlabels(_cons Constant)


