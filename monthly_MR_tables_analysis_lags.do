***********************************************************************************

* File: monthly_MR_tables_analysis_lags.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)
/* 
Objective: The objective of this program is to create tables with fixed effects regressions
Structure:
*/

***********************************************************************************

// preliminaries
local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
set matsize 5000

// insheet
use "`path_intermediate'merged_monthly_97_09", clear
destring fips, replace
destring state_fips, replace
*keep mrate_* mort_tot_00_01_ pop_tot_00_01_ pop_weights precip* fips state_fips year mrate_tot_total_ mrate_tot_total_ pop_tot_total_ *
*order precip* state_fips tavg_*  fips year mrate_tot_total mrate_tot_total pop_tot_total 
*order precip* fips state_fips year mrate_tot_total mrate_tot_total pop_tot_total * 

order tavg_bin_35C_Inf, last
order fips year month state_fips mrate_tot lmrate_tot pop_male_weights lmrate_male mrate_male pop_female_weights mrate_female lmrate_female

// 5 degrees
egen tavg_bin_0C_5C_ = rowtotal(tavg_bin_0C_1C_-tavg_bin_4C_5C_)
egen tavg_bin_5C_10C_ = rowtotal(tavg_bin_5C_6C_-tavg_bin_9C_10C_)
egen tavg_bin_10C_15C_ = rowtotal(tavg_bin_10C_11C_-tavg_bin_14C_15C_)
egen tavg_bin_15C_20C_ = rowtotal(tavg_bin_15C_16C_-tavg_bin_19C_20C_)
egen tavg_bin_20C_25C_ = rowtotal(tavg_bin_20C_21C_-tavg_bin_24C_25C_)
egen tavg_bin_25C_30C_ = rowtotal(tavg_bin_25C_26C_-tavg_bin_29C_30C_)
egen tavg_bin_30C_35C_ = rowtotal(tavg_bin_30C_31C_-tavg_bin_35C_Inf_)
egen tavg_bin_0C_10C_ = rowtotal(tavg_bin_0C_1C_-tavg_bin_9C_10C_)

// 3 degree bins, with 0-12
egen tavg_bin_0C_13C_ = rowtotal(tavg_bin_0C_1C_-tavg_bin_12C_13C_)
egen tavg_bin_10C_13C_ = rowtotal(tavg_bin_10C_11C_-tavg_bin_12C_13C_)
egen tavg_bin_13C_16C_ = rowtotal(tavg_bin_13C_14C_-tavg_bin_15C_16C_)
egen tavg_bin_16C_19C_ = rowtotal(tavg_bin_16C_17C_-tavg_bin_18C_19C_)
egen tavg_bin_19C_22C_ = rowtotal(tavg_bin_19C_20C_-tavg_bin_21C_22C_)
egen tavg_bin_22C_25C_ = rowtotal(tavg_bin_22C_23C_-tavg_bin_24C_25C_)
egen tavg_bin_25C_28C_ = rowtotal(tavg_bin_25C_26C_-tavg_bin_27C_28C_)
egen tavg_bin_28C_31C_ = rowtotal(tavg_bin_28C_29C_-tavg_bin_30C_31C_)
egen tavg_bin_31C_Inf_ = rowtotal(tavg_bin_31C_32C_-tavg_bin_35C_Inf_)
egen tavg_bin_28C_Inf_ = rowtotal(tavg_bin_28C_29C_-tavg_bin_35C_Inf_)




************ LAG TABLE ********

local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local threeadj tavg_bin_0C_13C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_Inf_
local l1three
local l2three
foreach var of local three {
local l1three " `l1three' l1_`var'"
local l2three " `l2three' l2_`var'"
}
foreach var of local threeadj {
local l1threeadj " `l1threeadj' l1_`var'"
local l2threeadj " `l2threeadj' l2_`var'"
}

di "`l1three'"
di "`l2three'"


local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local three1 l1_tavg_bin_0C_10C_ l1_tavg_bin_10C_13C_ l1_tavg_bin_13C_16C_ l1_tavg_bin_16C_19C_ l1_tavg_bin_19C_22C_ l1_tavg_bin_25C_28C_ l1_tavg_bin_28C_31C_ l1_tavg_bin_31C_Inf_

/*
reg tavg_bin_0C_10C_ l1_tavg_bin_0C_10C_ l2_tavg_bin_0C_10C_, robust
reg tavg_bin_10C_13C_ l1_tavg_bin_10C_13C_ l2_tavg_bin_10C_13C_, robust
reg tavg_bin_10C_13C_ l1_tavg_bin_10C_13C_ l2_tavg_bin_10C_13C_, robust
*/

local title Impact of Temperature on Mortality in Brazil; Omitted bin is 22-25C
local precip precip0_10 - precip90_100
local five tavg_bin_0C_10C_ tavg_bin_10C_15C_ tavg_bin_15C_20C_ tavg_bin_25C_30C_ tavg_bin_30C_35C_
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local name results_monthly_three_lags
local addnote monthly mortality rates are for a population of 100,000. The regressions are population weighted
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster state_fips

_rmcoll `three' `l1three' i.year
display r(k omitted)
display r(varlist)


// regression; shows that the collinearity must occurr somewhere in the residual variation
*reg l1_tavg_bin_19C_22C_ l1_tavg_bin_16C_19C_ l1_tavg_bin_13C_16C_ l1_tavg_bin_0C_13C_ `three', robust
*estat vif

// shorthand for locals
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local l1three l1_tavg_bin_0C_10C_ l1_tavg_bin_10C_13C_ l1_tavg_bin_13C_16C_ l1_tavg_bin_16C_19C_ l1_tavg_bin_19C_22C_ l1_tavg_bin_25C_28C_ l1_tavg_bin_28C_31C_ l1_tavg_bin_31C_Inf_ ///

*reg mrate_tot `three' `l1three' i.year [aw=pop_tot_weights] , robust
*xtreg mrate_tot `three' `l1three', fe
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local l1three l1_tavg_bin_0C_10C_ l1_tavg_bin_10C_13C_ l1_tavg_bin_13C_16C_ l1_tavg_bin_16C_19C_ l1_tavg_bin_19C_22C_ l1_tavg_bin_25C_28C_ l1_tavg_bin_28C_31C_ l1_tavg_bin_31C_Inf_ 
local l2three l2_tavg_bin_0C_10C_ l2_tavg_bin_10C_13C_ l2_tavg_bin_13C_16C_ l2_tavg_bin_16C_19C_ l2_tavg_bin_19C_22C_ l2_tavg_bin_25C_28C_ l2_tavg_bin_28C_31C_ l2_tavg_bin_31C_Inf_ 
local cluster state_fips

areg mrate_tot `three' [aw=pop_tot_weights], absorb(date)
areg mrate_tot `three' `l1three' [aw=pop_tot_weights], absorb(date)
areg mrate_tot `three' `l1three' `l2three' [aw=pop_tot_weights], absorb(date)


areg mrate_tot `three' i.state_fips [aw=pop_tot_weights], absorb(date)
areg mrate_tot `three' i.year#i.month [aw=pop_tot_weights], absorb (state_fips)
// Yes, as required, these yield the same coefficients! as absorb just specifies fixed effects


//comparing xtreg with reghdfe, do they give the same coefficients
// saying that each municipality or month has a level effect
reghdfe mrate_tot `three' [aw=pop_tot_weights] , absorb(fips) cluster(`cluster')
xtreg mrate_tot `three' [aw=pop_tot_weights], i(fips) fe
areg mrate_tot `three' [aw=pop_tot_weights], absorb(fips)
// they indeed do the same
*  xtreg will do fixed effects 


reghdfe mrate_tot `three' `l1three' [aw=pop_tot_weights] , absorb(year#month) cluster(`cluster')

reghdfe mrate_tot `three' `l1three' [aw=pop_tot_weights] , absorb(month#fips) cluster(`cluster')


reghdfe mrate_tot tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_ ///
l1_tavg_bin_0C_10C_ l1_tavg_bin_10C_13C_ l1_tavg_bin_13C_16C_ l1_tavg_bin_16C_19C_ l1_tavg_bin_19C_22C_ l1_tavg_bin_25C_28C_ l1_tavg_bin_28C_31C_ l1_tavg_bin_31C_Inf_ ///
 [aw=pop_tot_weights] , absorb(year) cluster(`cluster')
// still omitted

reghdfe mrate_tot tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_ ///
l1_tavg_bin_0C_10C_ l1_tavg_bin_10C_13C_ l1_tavg_bin_13C_16C_ l1_tavg_bin_16C_19C_ l1_tavg_bin_19C_22C_ l1_tavg_bin_25C_28C_ l1_tavg_bin_28C_31C_ l1_tavg_bin_31C_Inf_ ///
 [aw=pop_tot_weights] , absorb(fips) cluster(`cluster')
// still omitted

reghdfe mrate_tot tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_ ///
l1_tavg_bin_0C_10C_ l1_tavg_bin_10C_13C_ l1_tavg_bin_13C_16C_ l1_tavg_bin_16C_19C_ l1_tavg_bin_19C_22C_ l1_tavg_bin_25C_28C_ l1_tavg_bin_28C_31C_ l1_tavg_bin_31C_Inf_ ///
 [aw=pop_tot_weights] , absorb() cluster(`cluster')



reghdfe mrate_tot `three' `l1three' [aw=pop_tot_weights] , absorb(month#fips) cluster(`cluster')

reghdfe mrate_tot `three' `l1three' [aw=pop_tot_weights] , absorb(year month fips) cluster(`cluster')

reghdfe mrate_tot `l1three' [aw=pop_tot_weights] , absorb(year#fips month#fips year#month) cluster(`cluster')


reghdfe mrate_tot `three' [aw=pop_tot_weights] , absorb(year#fips month#fips year#month) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) replace ctitle("no lag") auto(2) addtext(Cluster, State)

reghdfe mrate_tot `three' `l1three' [aw=pop_tot_weights] , absorb(year#fips month#fips year#month) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("1 lag") auto(2) addtext(Cluster, State)


/*	
reghdfe mrate_tot `threeadj' `l1threeadj' [aw=pop_tot_weights] , absorb(year#fips month#fips year#month) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("1 lag") auto(2) addtext(Cluster, State)
*/	

reghdfe mrate_tot `three' `l1three' `l2three' [aw=pop_tot_weights] , absorb(year#fips month#fips year#month) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("2 lags") auto(2) addtext(Cluster, State)
	
***

************ LAG TABLE adj ********

local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local threeadj tavg_bin_0C_13C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_Inf_
local l1three
local l2three
foreach var of local three {
local l1three " `l1three' l1_`var'"
local l2three " `l2three' l2_`var'"
}
foreach var of local threeadj {
local l1threeadj " `l1threeadj' l1_`var'"
local l2threeadj " `l2threeadj' l2_`var'"
}

di "`l1threeadj'"
di "`l2threeadj'"

local title Impact of Temperature on Mortality in Brazil; Omitted bin is 22-25C
local precip precip0_10 - precip90_100
local five tavg_bin_0C_10C_ tavg_bin_10C_15C_ tavg_bin_15C_20C_ tavg_bin_25C_30C_ tavg_bin_30C_35C_
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local name results_monthly_three_lags
local addnote monthly mortality rates are for a population of 100,000. The regressions are population weighted
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster state_fips

*reghdfe mrate_tot `three' [aw=pop_tot_weights] , absorb(year#fips month#fips year#month) cluster(`cluster')

reghdfe mrate_tot `three' `l1three' [aw=pop_tot_weights] , absorb(year#fips month#fips year#month) cluster(`cluster')
	
reghdfe mrate_tot `threeadj' `l1threeadj' [aw=pop_tot_weights] , absorb(year#fips month#fips year#month) cluster(`cluster')
	
reghdfe mrate_tot `three' `l1three' `l2three' [aw=pop_tot_weights] , absorb(year#fips month#fips year#month) cluster(`cluster')
	
***







