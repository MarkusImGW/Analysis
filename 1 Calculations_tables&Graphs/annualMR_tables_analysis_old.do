***********************************************************************************

* File: annualMR_tables_analysis.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)
/* 
Objective: The objective of this program is to create tables with fixed effects regressions
Structure:
*/

***********************************************************************************

cd "/Users/arvidviaene/Dropbox/2 Mortality/"
// preliminaries
local path_raw /Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/
local path_intermediate /Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/

set matsize 5000

// insheet
use "`path_intermediate'mort-pop_mun_tmf_allage_97_10", clear

/*
areg mrate_tot_total F1.tavg_bin_26C_27C_annual_pop L(0/1).tavg_bin_26C_27C_annual_pop, absorb (year)
areg mrate_tot_total F(1/4). tavg_bin_26C_27C_annual_pop L(0/4).tavg_bin_26C_27C_annual_pop, absorb (year)
areg mrate_tot_total L(0/4).tavg_bin_26C_27C_annual_pop mrate_tot_total L(0/4).tavg_bin_25C_26C_annual_pop, absorb(year) vce(cluster fips)
*/

// 1. No FE
// 2. Unit & year fixed effects
// 3. Unit & year & month fixed effects
// 4. Unit*month and year FE
// 5. Unit*year and month FE
// 6. Unit*year & unit*month
// 7. unit*month, state*month state-year (extra!)
// 8. (7.) unit*month, state*month*year FE



*******************************************************************
********* Table 1: Varying FE specifications **********************
*******************************************************************
// locals //
local title Impact of temperature on the mortality rate by varying climate
local precip precip0_10 - precip90_100
local three tavg_bin_0C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_31C_annual_pop tavg_bin_31C_Inf_annual_pop
local threeadj tavg_bin_0C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_Inf_annual_pop 
** Adjust the name!!
local name yearly_table1 
local depvar mrate_tot_total_
local addnote Mortality rates are for a population of 100,000. The regressions are population weighted
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster fips

***** No FE // C & Y // C & S*Y

reghdfe mrate_tot_total_ `threeadj' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) ctitle("County and Year") auto(2) label ///
	title("`title'") addnote("`addnote'") ///

reghdfe mrate_tot_total_ `threeadj' [aw=pop_weights] , absorb(year#state fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, append tex(frag) ctitle("County and Year-State") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	

/*

reghdfe mrate_tot_total_ `threeadj' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
estimates store a1

esttab a1 using Results/Tables/table1.tex, booktabs ///
star(* 0.10 ** 0.05 *** 0.01) /// 
replace b(a2) se(a2) r2 ar2 scalars(F) parentheses mtitles label varlabels(_cons Constant)

*/

*******************************************************************
********* Table 2: Lags&Leads Check, County & Year FE *************
*******************************************************************
*******************************************************************
********* Test Lags and Leads ****************
*******************************************************************
d


estimates stats nolead laglead1 laglead2 laglead3 lag4 lead4 laglead4

********************************************************************************
********* Table 3: Average Temperature Interactions// Semi and Full, County & Year FE - C&S-YFE  **********
********************************************************************************

** generation of variables
local bins tavg_bin_0C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_Inf_annual_pop 
local bins 0C_13C 13C_16C 16C_19C 19C_22C 25C_28C 28C_Inf
foreach i of local bins{
	gen bin_`i' = tavg_bin_`i'_annual_pop
}

local bins bin_0C_13C bin_13C_16C bin_16C_19C bin_19C_22C bin_25C_28C bin_28C_Inf
local climate COLD MEDIUM HOT
local climate2 climate_cold climate_medium climate_hot

foreach i of local bins{
	foreach j of local climate{
	di "`i'_`j'"
	gen `i'_`j'=`i'*`j'
	}
}

// locals //
local title Impact of temperature on the mortality rate by varying climate
local precip precip0_10 - precip90_100
local threeadj1 bin_0C_13C_COLD bin_0C_13C_HOT bin_13C_16C_COLD bin_13C_16C_HOT bin_16C_19C ///
bin_19C_22C bin_25C_28C_COLD bin_25C_28C_HOT bin_28C_Inf_COLD bin_28C_Inf_HOT 
local threeadj2 bin_0C_13C_COLD bin_0C_13C_HOT bin_13C_16C_COLD bin_13C_16C_HOT ///
bin_16C_19C_COLD bin_16C_19C_HOT bin_19C_22C_COLD bin_19C_22C_HOT ///
bin_25C_28C_COLD bin_25C_28C_HOT bin_28C_Inf_COLD bin_28C_Inf_HOT 

** Adjust the name!!
local name yearly_table3
local depvar mrate_tot_total_
local addnote Mortality rates are for a population of 100,000. The regressions are population weighted
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster fips

reghdfe mrate_tot_total_ `threeadj2' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
, replace tex(frag) ctitle("County and Year") auto(2) label ///
title("`title'") 
	
reghdfe mrate_tot_total_ `threeadj2' [aw=pop_weights] , absorb(year#state fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
, append tex(frag) ctitle("County and SY") auto(2) label ///
title("`title'") 

reghdfe mrate_tot_total_ `threeadj1' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
, append tex(frag) ctitle("County and Year") auto(2) label ///
title("`title'") 

reghdfe mrate_tot_total_ `threeadj1' [aw=pop_weights] , absorb(year#state fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
, append tex(frag) ctitle("County and SY") auto(2) label ///
title("`title'") 



********************************************************************************
********* Table 4: Rural-Urban Interactions// Semi and Full, County & Year FE - C&S-YFE  **********
********************************************************************************

local bins bin_0C_13C bin_13C_16C bin_16C_19C bin_19C_22C bin_25C_28C bin_28C_Inf
local ruralvar rural urban

foreach i of local bins{
	foreach j of local ruralvar{
	di "`i'_`j'"
	gen `i'_`j'=`i'*`j'
	}
}

// locals //
local title Impact of temperature on the mortality rate by varying climate
local precip precip0_10 - precip90_100
local bin_0C_13C bin_13C_16C bin_16C_19C bin_19C_22C bin_25C_28C bin_28C_Inf

local threeadj1 bin_0C_13C_rural bin_0C_13C_urban bin_13C_16C_rural bin_13C_16C_urban bin_16C_19C ///
bin_19C_22C bin_25C_28C_rural bin_25C_28C_urban bin_28C_Inf_rural bin_28C_Inf_urban 

local threeadj2 bin_0C_13C_rural bin_0C_13C_urban bin_13C_16C_rural bin_13C_16C_urban ///
bin_16C_19C_rural bin_16C_19C_urban bin_19C_22C_rural bin_19C_22C_urban ///
bin_25C_28C_rural bin_25C_28C_urban bin_28C_Inf_rural bin_28C_Inf_urban 


** Adjust the name!!
local name yearly_table4
local depvar mrate_tot_total_
local addnote Mortality rates are for a population of 100,000. The regressions are population weighted
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster fips


reghdfe mrate_tot_total_ `threeadj2' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
, replace tex(frag) ctitle("County and Year") auto(2) label ///
title("`title'") 
	
reghdfe mrate_tot_total_ `threeadj2' [aw=pop_weights] , absorb(year#state fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
, append tex(frag) ctitle("County and SY") auto(2) label ///
title("`title'") 

reghdfe mrate_tot_total_ `threeadj1' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
, append tex(frag) ctitle("County and Year") auto(2) label ///
title("`title'") 

reghdfe mrate_tot_total_ `threeadj1' [aw=pop_weights] , absorb(year#state fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
, append tex(frag) ctitle("County and SY") auto(2) label ///
title("`title'") 

********************************************************************************
********* Table 5: AT & Rural-Urban Interactions// Semi and Full, County & Year FE - C&S-YFE  **********
********************************************************************************

local threeadj1 bin_0C_13C_COLD bin_0C_13C_HOT bin_13C_16C_COLD bin_13C_16C_HOT bin_16C_19C ///
bin_19C_22C bin_25C_28C_COLD bin_25C_28C_HOT bin_28C_Inf_COLD bin_28C_Inf_HOT 
local threeadj2 bin_0C_13C_COLD bin_0C_13C_HOT bin_13C_16C_COLD bin_13C_16C_HOT ///
bin_16C_19C_COLD bin_16C_19C_HOT bin_19C_22C_COLD bin_19C_22C_HOT ///
bin_25C_28C_COLD bin_25C_28C_HOT bin_28C_Inf_COLD bin_28C_Inf_HOT 























*******************************************************************
********* 3 year bins, broken down by hot and cold ****************
*******************************************************************

// locals //
local title Impact of temperature on the mortality rate by varying climate
local precip precip0_10 - precip90_100
local three tavg_bin_0C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_31C_annual_pop tavg_bin_31C_Inf_annual_pop
local threeadj tavg_bin_0C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_Inf_annual_pop 
** Adjust the name!!
local name yearly_temp
local depvar mrate_tot_total_
local addnote Mortality rates are for a population of 100,000. The regressions are population weighted
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster fips

reghdfe mrate_tot_total_ `three' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) ctitle("general") auto(2) label ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X") 

reghdfe mrate_tot_total_ `three' [aw=pop_weights] if COLD==1 , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, append tex(frag) ctitle("cold: <22") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X") 
	
reghdfe mrate_tot_total_ `three' [aw=pop_weights] if MEDIUM==1 , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("medium: 22-25") auto(2)  ///
	addtext(Year, "X", County, "X") 

reghdfe mrate_tot_total_ `three' [aw=pop_weights] if HOT==1 , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("hot: >25") auto(2) ///
	addtext(Year, "X", County, "X") 
	
reghdfe mrate_tot_total_ `threeadj' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, append tex(frag) ctitle("general") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X") 

reghdfe mrate_tot_total_ `threeadj' [aw=pop_weights] if COLD==1 , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, append tex(frag) ctitle("cold: <22") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X") 
	
reghdfe mrate_tot_total_ `threeadj' [aw=pop_weights] if MEDIUM==1 , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("medium: 22-25") auto(2)  ///
	addtext(Year, "X", County, "X") 

reghdfe mrate_tot_total_ `threeadj' [aw=pop_weights] if HOT==1 , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("hot: >25") auto(2) ///
	addtext(Year, "X", County, "X") 	
	
*******************************************************************
********* Interaction effects ****************
*******************************************************************
	
	

*******************************************************************
********* Test Lags and Leads ****************
*******************************************************************
local title Impact of temperature on the mortality rate by varying climate
local precip precip0_10 - precip90_100
local precip_drop precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60
local three tavg_bin_0C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_31C_annual_pop tavg_bin_31C_Inf_annual_pop

local threeadj tavg_bin_0C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_Inf_annual_pop 
local threeadj_lead f1_tavg_bin_0C_13C_annual_pop f1_tavg_bin_13C_16C_annual_pop f1_tavg_bin_16C_19C_annual_pop f1_tavg_bin_19C_22C_annual_pop f1_tavg_bin_25C_28C_annual_pop f1_tavg_bin_28C_Inf_annual_pop 
local threeadj_lead2 f2_tavg_bin_0C_13C_annual_pop f2_tavg_bin_13C_16C_annual_pop f2_tavg_bin_16C_19C_annual_pop f2_tavg_bin_19C_22C_annual_pop f2_tavg_bin_25C_28C_annual_pop f2_tavg_bin_28C_Inf_annual_pop 
local threeadj_lead3 f3_tavg_bin_0C_13C_annual_pop f3_tavg_bin_13C_16C_annual_pop f3_tavg_bin_16C_19C_annual_pop f3_tavg_bin_19C_22C_annual_pop f3_tavg_bin_25C_28C_annual_pop f3_tavg_bin_28C_Inf_annual_pop 
local threeadj_lead4 f4_tavg_bin_0C_13C_annual_pop f4_tavg_bin_13C_16C_annual_pop f4_tavg_bin_16C_19C_annual_pop f4_tavg_bin_19C_22C_annual_pop f4_tavg_bin_25C_28C_annual_pop f4_tavg_bin_28C_Inf_annual_pop 

local threeadj_lag l1_tavg_bin_0C_13C_annual_pop l1_tavg_bin_13C_16C_annual_pop l1_tavg_bin_16C_19C_annual_pop l1_tavg_bin_19C_22C_annual_pop l1_tavg_bin_25C_28C_annual_pop l1_tavg_bin_28C_Inf_annual_pop 
local threeadj_lag2 l2_tavg_bin_0C_13C_annual_pop l2_tavg_bin_13C_16C_annual_pop l2_tavg_bin_16C_19C_annual_pop l2_tavg_bin_19C_22C_annual_pop l2_tavg_bin_25C_28C_annual_pop l2_tavg_bin_28C_Inf_annual_pop 
local threeadj_lag3 l3_tavg_bin_0C_13C_annual_pop l3_tavg_bin_13C_16C_annual_pop l3_tavg_bin_16C_19C_annual_pop l3_tavg_bin_19C_22C_annual_pop l3_tavg_bin_25C_28C_annual_pop l3_tavg_bin_28C_Inf_annual_pop 
local threeadj_lag4 l4_tavg_bin_0C_13C_annual_pop l4_tavg_bin_13C_16C_annual_pop l4_tavg_bin_16C_19C_annual_pop l4_tavg_bin_19C_22C_annual_pop l4_tavg_bin_25C_28C_annual_pop l4_tavg_bin_28C_Inf_annual_pop


local threeadj2 tavg_bin_0C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_Inf_annual_pop 
local threeadj2_lead f1_tavg_bin_0C_16C_annual_pop f1_tavg_bin_16C_19C_annual_pop f1_tavg_bin_19C_22C_annual_pop f1_tavg_bin_25C_28C_annual_pop f1_tavg_bin_28C_Inf_annual_pop 

** Adjust the name!!
local name yearly_lag
local depvar mrate_tot_total_
local addnote Mortality rates are for a population of 100,000. The regressions are population weighted
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster fips

reghdfe mrate_tot_total_ `threeadj' `precip' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) drop(`precip_drop' o.precip*) ctitle("precip 10 bins") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X")
estimates store nolead 


areg mrate_tot_total_ `threeadj' `threeadj_lead' `precip' i.year [aw=pop_weights], absorb(fips) vce(cluster `cluster')
*reghdfe mrate_tot_total_ `threeadj' `threeadj_lead' `precip' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) drop(`precip_drop' o.precip*) ctitle("precip 10 bins") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X")
estimates store lead1

areg mrate_tot_total_ `threeadj' `threeadj_lead' `threeadj_lag' `precip' i.year [aw=pop_weights], absorb(fips) vce(cluster `cluster')
*reghdfe mrate_tot_total_ `threeadj' `threeadj_lead' `precip' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) drop(`precip_drop' o.precip*) ctitle("precip 10 bins") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X")
estimates store laglead1

areg mrate_tot_total_ `threeadj' `threeadj_lead' `threeadj_lag' `threeadj_lead2' `threeadj_lag2' `precip' i.year [aw=pop_weights], absorb(fips) vce(cluster `cluster')
*reghdfe mrate_tot_total_ `threeadj' `threeadj_lead' `precip' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) drop(`precip_drop' o.precip*) ctitle("precip 10 bins") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X")
estimates store laglead2

areg mrate_tot_total_ `threeadj' `threeadj_lead' `threeadj_lag' `threeadj_lead2' `threeadj_lag2' ///
`threeadj_lead3' `threeadj_lag3' `precip' i.year [aw=pop_weights], absorb(fips) vce(cluster `cluster')
*reghdfe mrate_tot_total_ `threeadj' `threeadj_lead' `precip' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) drop(`precip_drop' o.precip*) ctitle("precip 10 bins") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X")
estimates store laglead3

areg mrate_tot_total_ `threeadj' `threeadj_lead' `threeadj_lag' `threeadj_lead2' `threeadj_lag2' ///
`threeadj_lead3' `threeadj_lag3' `threeadj_lead4' `threeadj_lag4' `precip' ///
i.year [aw=pop_weights], absorb(fips) vce(cluster `cluster')
*reghdfe mrate_tot_total_ `threeadj' `threeadj_lead' `precip' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) drop(`precip_drop' o.precip*) ctitle("precip 10 bins") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X")
estimates store laglead4



areg mrate_tot_total_ `threeadj' `threeadj_lead' `threeadj_lead2' `precip' i.year [aw=pop_weights], absorb(fips) vce(cluster `cluster')
*reghdfe mrate_tot_total_ `threeadj' `threeadj_lead' `precip' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) drop(`precip_drop' o.precip*) ctitle("precip 10 bins") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X")
estimates store lead2

areg mrate_tot_total_ `threeadj' `threeadj_lead' `threeadj_lead2' `threeadj_lead3' `precip' i.year [aw=pop_weights], absorb(fips) vce(cluster `cluster')
*reghdfe mrate_tot_total_ `threeadj' `threeadj_lead' `precip' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) drop(`precip_drop' o.precip*) ctitle("precip 10 bins") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X")
estimates store lead3

areg mrate_tot_total_ `threeadj' `threeadj_lead' `threeadj_lead2' `threeadj_lead3' `threeadj_lead4' `precip' i.year [aw=pop_weights], absorb(fips) vce(cluster `cluster')
*reghdfe mrate_tot_total_ `threeadj' `threeadj_lead' `precip' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) drop(`precip_drop' o.precip*) ctitle("precip 10 bins") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X")
estimates store lead4

areg mrate_tot_total_ `threeadj' `threeadj_lag' `threeadj_lag2' `threeadj_lag3' `threeadj_lag4' `precip' i.year [aw=pop_weights], absorb(fips) vce(cluster `cluster')
*reghdfe mrate_tot_total_ `threeadj' `threeadj_lead' `precip' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) drop(`precip_drop' o.precip*) ctitle("precip 10 bins") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X")
estimates store lag4

estimates stats nolead laglead1 laglead2 laglead3 lag4 lead4 laglead4

*******************************************************************
********* Rural and Urban ****************
*******************************************************************


hist shares_rural_ 
*graph save "/Users/arvidviaene/Dropbox/2 Mortality/Results/Figures/shares_rural.pdf", replace

*******************************************************************
********* Main Specification ****************
*******************************************************************

local title Impact of temperature on the mortality rate by varying climate
local precip precip0_10 - precip90_100
local precip_drop precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60
local three tavg_bin_0C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_31C_annual_pop tavg_bin_31C_Inf_annual_pop

local threeadj tavg_bin_0C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_Inf_annual_pop 
local threeadj_lead f1_tavg_bin_0C_13C_annual_pop f1_tavg_bin_13C_16C_annual_pop f1_tavg_bin_16C_19C_annual_pop f1_tavg_bin_19C_22C_annual_pop f1_tavg_bin_25C_28C_annual_pop f1_tavg_bin_28C_Inf_annual_pop 
local threeadj_lead2 f2_tavg_bin_0C_13C_annual_pop f2_tavg_bin_13C_16C_annual_pop f2_tavg_bin_16C_19C_annual_pop f2_tavg_bin_19C_22C_annual_pop f2_tavg_bin_25C_28C_annual_pop f2_tavg_bin_28C_Inf_annual_pop 
local threeadj_lead3 f3_tavg_bin_0C_13C_annual_pop f3_tavg_bin_13C_16C_annual_pop f3_tavg_bin_16C_19C_annual_pop f3_tavg_bin_19C_22C_annual_pop f3_tavg_bin_25C_28C_annual_pop f3_tavg_bin_28C_Inf_annual_pop 
local threeadj_lead4 f4_tavg_bin_0C_13C_annual_pop f4_tavg_bin_13C_16C_annual_pop f4_tavg_bin_16C_19C_annual_pop f4_tavg_bin_19C_22C_annual_pop f4_tavg_bin_25C_28C_annual_pop f4_tavg_bin_28C_Inf_annual_pop 
local threeadj_lag l1_tavg_bin_0C_13C_annual_pop l1_tavg_bin_13C_16C_annual_pop l1_tavg_bin_16C_19C_annual_pop l1_tavg_bin_19C_22C_annual_pop l1_tavg_bin_25C_28C_annual_pop l1_tavg_bin_28C_Inf_annual_pop 
local threeadj_lag2 l2_tavg_bin_0C_13C_annual_pop l2_tavg_bin_13C_16C_annual_pop l2_tavg_bin_16C_19C_annual_pop l2_tavg_bin_19C_22C_annual_pop l2_tavg_bin_25C_28C_annual_pop l2_tavg_bin_28C_Inf_annual_pop 
local threeadj_lag3 l3_tavg_bin_0C_13C_annual_pop l3_tavg_bin_13C_16C_annual_pop l3_tavg_bin_16C_19C_annual_pop l3_tavg_bin_19C_22C_annual_pop l3_tavg_bin_25C_28C_annual_pop l3_tavg_bin_28C_Inf_annual_pop 
local threeadj_lag4 l4_tavg_bin_0C_13C_annual_pop l4_tavg_bin_13C_16C_annual_pop l4_tavg_bin_16C_19C_annual_pop l4_tavg_bin_19C_22C_annual_pop l4_tavg_bin_25C_28C_annual_pop l4_tavg_bin_28C_Inf_annual_pop

local threeadj2 tavg_bin_0C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_Inf_annual_pop 
local threeadj2_lead f1_tavg_bin_0C_16C_annual_pop f1_tavg_bin_16C_19C_annual_pop f1_tavg_bin_19C_22C_annual_pop f1_tavg_bin_25C_28C_annual_pop f1_tavg_bin_28C_Inf_annual_pop 

** Adjust the name!!
local name yearly_mainspecif
local depvar mrate_tot_total_
local addnote Mortality rates are for a population of 100,000. The regressions are population weighted
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster fips


areg mrate_tot_total_ `threeadj' `threeadj_lead' `precip' i.year [aw=pop_weights], absorb(fips) vce(cluster `cluster')
*reghdfe mrate_tot_total_ `threeadj' `threeadj_lead' `precip' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) drop(`precip_drop' o.precip*) ctitle("precip 10 bins") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X")
estimates store lead1





*******************************************************************
********* Effects of precipitation ****************
*******************************************************************


local title Impact of temperature on the mortality rate by varying climate
local precip precip0_10 - precip90_100
local precip_drop precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60
local three tavg_bin_0C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_31C_annual_pop tavg_bin_31C_Inf_annual_pop
local threeadj tavg_bin_0C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_Inf_annual_pop 
local threeadj2 tavg_bin_0C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_Inf_annual_pop 
** Adjust the name!!
local name yearly_precip
local depvar mrate_tot_total_
local addnote Mortality rates are for a population of 100,000. The regressions are population weighted
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster fips

reghdfe mrate_tot_total_ `threeadj' `precip' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) drop(`precip_drop' o.precip*) ctitle("precip 10 bins") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X") 

reghdfe mrate_tot_total_ `threeadj'  [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, append tex(frag) ctitle(" no precip") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X") 

reghdfe mrate_tot_total_ `threeadj2' `precip' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, append tex(frag) drop(precip* o.precip*) ctitle("precip 10 bins") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X") 

reghdfe mrate_tot_total_ `threeadj2'  [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, append tex(frag) drop(`precip') ctitle(" no precip") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	addtext(Year, "X", County, "X") 

****************************************************************
********* By Age and 5 bins, clustered at **********************
****************************************************************

// locals //
local title Impact of temperature on the mortality rate in Brazil from 1997-2009, , 5¡ bins
local precip precip0_10 - precip90_100
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
local name results_five_outreg_age
local depvar mrate_tot_total_
local addnote Mortality rates are for a population of 100,000. The regressions are population weighted
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster state_fips

reghdfe mrate_tot_total_ `five' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) ctitle("total") auto(2) addtext(State-Year, NO, Cluster, State) ///
	title("`title'") addnote("`addnote'") ///
	
reghdfe mrate_tot_00_01_ `five' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("0_1") auto(2) addtext(State-Year, NO, Cluster, State) ///

reghdfe mrate_tot_01_19_ `five' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("01_19") auto(2) addtext(State-Year, NO, Cluster, State) ///

reghdfe mrate_tot_20_39_ `five' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("20_39") auto(2) addtext(State-Year, NO, Cluster, State) ///

reghdfe mrate_tot_40_59_ `five' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("40_59") auto(2) addtext(State-Year, NO, Cluster, State) ///

reghdfe mrate_tot_60_79_ `five' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("60_79") auto(2) addtext(State-Year, NO, Cluster, State) ///

reghdfe mrate_tot_80_110_ `five' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("80+") auto(2) addtext(State-Year, NO, Cluster, State) ///





********* By Age and 3 year bins, clustered at ****************

// locals //
local title Impact of temperature on the mortality rate in Brazil from 1997-2009, 3¡ bins
local precip precip0_10 - precip90_100
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
local three tavg_bin_0C_10C_annual_pop tavg_bin_10C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_31C_annual_pop tavg_bin_31C_Inf_annual_pop
** Adjust the name!!
local name results_three_outreg_age
local depvar mrate_tot_total_
local addnote Mortality rates are for a population of 100,000. The regressions are population weighted
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster state_fips

reghdfe mrate_tot_total_ `three' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) ctitle("total") auto(2) addtext(State-Year, NO, Cluster, State) ///
	title("`title'") addnote("`addnote'") ///
	
reghdfe mrate_tot_00_01_ `three' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("0_1") auto(2) addtext(State-Year, NO, Cluster, State) ///

reghdfe mrate_tot_01_19_ `three' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("01_19") auto(2) addtext(State-Year, NO, Cluster, State) ///

reghdfe mrate_tot_20_39_ `three' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("20_39") auto(2) addtext(State-Year, NO, Cluster, State) ///

reghdfe mrate_tot_40_59_ `three' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("40_59") auto(2) addtext(State-Year, NO, Cluster, State) ///

reghdfe mrate_tot_60_79_ `three' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("60_79") auto(2) addtext(State-Year, NO, Cluster, State) ///

reghdfe mrate_tot_80_110_ `three' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("80+") auto(2) addtext(State-Year, NO, Cluster, State) ///


********* By Age and 3 year bins, adjusted; 0-13 and 28-Inf ****************

// locals //
local title Impact of temperature on the mortality rate in Brazil from 1997-2009, wider end-bins
local precip precip0_10 - precip90_100
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
local threeadj tavg_bin_0C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_Inf_annual_pop 
** Adjust the name!!
local name results_threeadj_outreg_age
local depvar mrate_tot_total_
local addnote Mortality rates are for a population of 100,000. The regressions are population weighted
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster state_fips

reghdfe mrate_tot_total_ `threeadj' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) ctitle("total") auto(2) addtext(State-Year, NO, Cluster, State) ///
	title("`title'") addnote("`addnote'") ///
	
reghdfe mrate_tot_00_01_ `threeadj' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("0_1") auto(2) addtext(State-Year, NO, Cluster, State) ///

reghdfe mrate_tot_01_19_ `threeadj' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("01_19") auto(2) addtext(State-Year, NO, Cluster, State) ///

reghdfe mrate_tot_20_39_ `threeadj' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("20_39") auto(2) addtext(State-Year, NO, Cluster, State) ///

reghdfe mrate_tot_40_59_ `threeadj' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("40_59") auto(2) addtext(State-Year, NO, Cluster, State) ///

reghdfe mrate_tot_60_79_ `threeadj' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("60_79") auto(2) addtext(State-Year, NO, Cluster, State) ///

reghdfe mrate_tot_80_110_ `threeadj' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("80+") auto(2) addtext(State-Year, NO, Cluster, State) ///

********* By Age and 3 year bins, adjusted; 0-13 and 28-Inf ****************

// locals //
local title Impact of temperature on the mortality rate in Brazil from 1997-2009, wider end-bins, state-year fixed effects and state-cluster
local precip precip0_10 - precip90_100
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
local threeadj tavg_bin_0C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_Inf_annual_pop 
** Adjust the name!!
local name results_threeadj_outreg_age_ystate_state
local depvar mrate_tot_total_
local addnote Mortality rates are for a population of 100,000. The regressions are population weighted
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster state_fips

reghdfe mrate_tot_total_ `threeadj' [aw=pop_weights] , absorb(year#state_fips fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) ctitle("total") auto(2) addtext(State-Year, Yes, Cluster, State) ///
	title("`title'") addnote("`addnote'") ///
	
reghdfe mrate_tot_00_01_ `threeadj' [aw=pop_weights] , absorb(year#state_fips fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("0_1") auto(2) addtext(State-Year, Yes, Cluster, State) ///

reghdfe mrate_tot_01_19_ `threeadj' [aw=pop_weights] , absorb(year#state_fips fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("01_19") auto(2) addtext(State-Year, Yes, Cluster, State) ///

reghdfe mrate_tot_20_39_ `threeadj' [aw=pop_weights] , absorb(year#state_fips fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("20_39") auto(2) addtext(State-Year, Yes, Cluster, State) ///

reghdfe mrate_tot_40_59_ `threeadj' [aw=pop_weights] , absorb(year#state_fips fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("40_59") auto(2) addtext(State-Year, Yes, Cluster, State) ///

reghdfe mrate_tot_60_79_ `threeadj' [aw=pop_weights] , absorb(year#state_fips fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("60_79") auto(2) addtext(State-Year, Yes, Cluster, State) ///

reghdfe mrate_tot_80_110_ `threeadj' [aw=pop_weights] , absorb(year#state_fips fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("80+") auto(2) addtext(State-Year, Yes, Cluster, State) ///


********* By Age and 3 year bins, adjusted; 0-13 and 28-Inf ****************

// locals //
local title Impact of temperature on the mortality rate in Brazil from 1997-2009, wider end-bins, state-year fixed effects and muni-cluster
local precip precip0_10 - precip90_100
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
local threeadj tavg_bin_0C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_Inf_annual_pop 
** Adjust the name!!
local name results_threeadj_outreg_age_ystate_fips
local depvar mrate_tot_total_
local addnote Mortality rates are for a population of 100,000. The regressions are population weighted
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster fips

reghdfe mrate_tot_total_ `threeadj' [aw=pop_weights] , absorb(year#state_fips fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) ctitle("total") auto(2) addtext(State-Year, Yes, Cluster, municpality) ///
	title("`title'") addnote("`addnote'") ///
	
reghdfe mrate_tot_00_01_ `threeadj' [aw=pop_weights] , absorb(year#state_fips fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("0_1") auto(2) addtext(State-Year, Yes, Cluster, municpality) ///

reghdfe mrate_tot_01_19_ `threeadj' [aw=pop_weights] , absorb(year#state_fips fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("01_19") auto(2) addtext(State-Year, Yes, Cluster, municpality) ///

reghdfe mrate_tot_20_39_ `threeadj' [aw=pop_weights] , absorb(year#state_fips fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("20_39") auto(2) addtext(State-Year, Yes, Cluster, municpality) ///

reghdfe mrate_tot_40_59_ `threeadj' [aw=pop_weights] , absorb(year#state_fips fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("40_59") auto(2) addtext(State-Year, Yes, Cluster, municpality) ///

reghdfe mrate_tot_60_79_ `threeadj' [aw=pop_weights] , absorb(year#state_fips fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("60_79") auto(2) addtext(State-Year, Yes, Cluster, municpality) ///

reghdfe mrate_tot_80_110_ `threeadj' [aw=pop_weights] , absorb(year#state_fips fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("80+") auto(2) addtext(State-Year, Yes, Cluster, municpality) ///
	

****** SAME TABLE WITH PRECIP *****
cap erase /Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_five_outreg_precip.txt
cap erase /Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_five_outreg_precip.text
cap erase /Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_five_outreg_precip.tex
local precip precip0_10 - precip90_100
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop

reghdfe mrate_tot_total_ `five' [aw=pop_weights] , absorb(year fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_five_outreg_precip.tex" ///
	, append tex(frag)drop(`precip') auto(2) addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, NO, Precip, NO)
*

reghdfe mrate_tot_total_ `five' [aw=pop_weights] , absorb(year fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_five_outreg_precip.text" ///
	, append tex(frag) auto(2) drop(`precip') title("Mortality rate in Brazil") addnote("Population-weighted regressions using 5 degree bins. Mortality rate is measured as the deaths per 100,000.") ///
	  addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, NO, Precip, NO)
/*	
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
reghdfe mrate_tot_total_ `five' [aw=pop_weights] , absorb(year state_fips fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_five_outreg_precip.text" ///
	, tex(frag) append auto(2) drop(`precip') addtext(Municipality FE, YES, Year FE, YES, State-YEAR, YES, Precip, NO)
** this just overwrites the earlier one, maybe because I manually have to specify
*/
/*
reghdfe mrate_tot_total_ `five' [aw=pop_weights] , absorb(year#state_fips fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_five_outreg_precip.text" ///
	, append tex(frag) auto(2) drop(`precip') addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, YES, Precip, NO)
*/
reghdfe mrate_tot_total_ `five' [aw=pop_weights] , absorb(year#state_fips fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_five_outreg_precip.tex" ///
	, append tex(frag) auto(2) drop(`precip')  addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, YES, Precip, NO)

reghdfe mrate_tot_total_ `five' `precip' [aw=pop_weights] , absorb(year fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_five_outreg_precip.tex" ///
	, append tex(frag) auto(2) drop(`precip')  addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, NO, Precip, YES)

reghdfe mrate_tot_total_ `five' `precip' [aw=pop_weights] , absorb(year#state_fips fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_five_outreg_precip.tex" ///
	, append tex(frag) auto(2) drop(`precip')  addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, YES, Precip, YES)

****** SAME TABLE WITH PRECIP AND CLUSTERING AT STATE LEVEL *****

************************ 3 degree bins ************
cap erase /Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_three_outreg_precip.txt
cap erase /Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_three_outreg_precip.text
cap erase /Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_three_outreg_precip.tex
local precip precip0_10 - precip90_100
local three tavg_bin_0C_12C_annual_pop tavg_bin_12C_15C_annual_pop tavg_bin_15C_18C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_31C_annual_pop tavg_bin_31C_Inf_annual_pop


reghdfe mrate_tot_total_ `three' [aw=pop_weights] , absorb(year fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_three_outreg_precip.tex" ///
	, append tex(frag)drop(`precip') auto(2) addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, NO, Precip, NO)
	
reghdfe mrate_tot_total_ `three' [aw=pop_weights] , absorb(year#state_fips fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_three_outreg_precip.tex" ///
	, append tex(frag) auto(2) drop(`precip')  addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, YES, Precip, NO)

reghdfe mrate_tot_total_ `three' `precip' [aw=pop_weights] , absorb(year fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_three_outreg_precip.tex" ///
	, append tex(frag) auto(2) drop(`precip')  addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, NO, Precip, YES)

reghdfe mrate_tot_total_ `three' `precip' [aw=pop_weights] , absorb(year#state_fips fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_three_outreg_precip.tex" ///
	, append tex(frag) auto(2) drop(`precip')  addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, YES, Precip, YES)


************************ 0-1 years ************
// locals //
local precip precip0_10 - precip90_100
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
local name results_five_outreg_precip_0_1
local depvar mrate_tot_00_01

// erase file  //
cap erase /Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.txt
cap erase /Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text
cap erase /Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.tex


reghdfe `depvar' `five' [aw=pop_weights] , absorb(year fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.tex" ///
	, append tex(frag)drop(`precip') auto(2) addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, NO, Precip, NO) ///
	title("Mortality rate in Brazil") addnote("Population-weighted regressions using 5 degree bins. Mortality rate is measured as the deaths per 100,000.") ///

/*
reghdfe `depvar' `five' [aw=pop_weights] , absorb(year fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, append tex(frag) auto(2) drop(`precip') title("Mortality rate in Brazil") addnote("Population-weighted regressions using 5 degree bins. Mortality rate is measured as the deaths per 100,000.") ///
	  addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, NO, Precip, NO)
	  */
	  
reghdfe `depvar' `five' [aw=pop_weights] , absorb(year#state_fips fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.tex" ///
	, append tex(frag) auto(2) drop(`precip')  addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, YES, Precip, NO)

reghdfe `depvar' `five' `precip' [aw=pop_weights] , absorb(year fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.tex" ///
	, append tex(frag) auto(2) drop(`precip')  addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, NO, Precip, YES)

reghdfe `depvar' `five' `precip' [aw=pop_weights] , absorb(year#state_fips fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.tex" ///
	, append tex(frag) auto(2) drop(`precip')  addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, YES, Precip, YES)


************************ YEAR-ALLAGE - clustered at state************

/// CREATING PANEL DATA
local cluster state_fips
tsset fips year
foreach i of numlist 1(1)3 {
	foreach var of varlist tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop {
	cap gen l`i'= l`i'.`var'
	cap rename l`i' l`i'_`var'
	cap gen f`i'= f`i'.`var'
	cap rename f`i' f`i'_`var'
	}
}

// locals //
local precip precip0_10 - precip90_100
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
local name results_five_outreg_precip_0_1_statecluster
local depvar mrate_tot_total_
local title Impact of temperature on the mortality rate in Brazil from 1997-2009"
local addnote 
local cluster fips

// erase file  //
cap erase /Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.txt
cap erase /Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text
cap erase /Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.tex


reghdfe `depvar' `five' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, append tex(frag) drop("`precip'") auto(2) addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, NO, Precip, NO)
*

reghdfe `depvar' `five' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, append tex(frag) auto(2) drop("`precip'") title("Mortality rate in Brazil, clustered at state level") addnote("Population-weighted regressions using 5 degree bins. Mortality rate is measured as the deaths per 100,000.") ///
	  addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, NO, Precip, NO)

reghdfe `depvar' `five' [aw=pop_weights] , absorb(year#state_fips fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, append tex(frag) auto(2) drop("`precip'")  addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, YES, Precip, NO)

reghdfe `depvar' `five' `precip' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, append tex(frag) auto(2) drop("`precip'")  addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, NO, Precip, YES)

reghdfe `depvar' `five' `precip' [aw=pop_weights] , absorb(year#state_fips fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, append tex(frag) auto(2) drop("`precip'")  addtext(Municipality FE, YES, Year FE, YES, State-YEAR FE, YES, Precip, YES)














****************************************	
/// REST CODE REMAINING CODE************
****************************************

/*

// bins of 5 degrees, going from 10 onwards
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
local precip precip0_10 - precip90_100
di `precip'
reghdfe mrate_tot_total_ `five' `precip' [aw=pop_weights] , absorb(year fips) cluster(fips)
eststo F2

// State fixed effects
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
reghdfe mrate_tot_total_ `five' `precip' [aw=pop_weights] , absorb(year state_fips fips) cluster(fips)
eststo F3

// Going for broke with state*year fixed effects
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
reghdfe mrate_tot_total_ `five' `precip' [aw=pop_weights] , absorb(year state_fips fips) cluster(fips)
eststo F4

// Going for broke with state*year fixed effects
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
reghdfe mrate_tot_total_ `five' `precip' [aw=pop_weights] , absorb(year#state_fips fips) cluster(fips)
eststo F5
** does make them insignificant

esttab F2 F3 F4 F5 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_five_precip.tex" ///
	, cells( b(star fmt(4)) se(par fmt(4))) ///
	legend label collabels(none) order() replace ///
 	note(Population-weighted regressions using 5 degree bins. Mortality rate is measured as the deaths per 100,000.) ///
	addnote("The unit of observation is municipality-year. ") ///
	r2

esttab F2 F3 F4 F5 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_five_precip.tex" ///
	, keep (`five') cells( b(star fmt(3)) se(par fmt(3))) ///
	title ("Impact of temperature on Mortality rates, including precipicipation") legend label collabels(none) order() replace ///
 	note("Population-weighted regressions using 5 degree bins.") ///
	r2
* keep (`five')


//// 
// bins of 5 degrees, going from 10 onwards
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_20C_25C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
reghdfe mrate_tot_total_ `five' [aw=pop_weights] , absorb(year fips) cluster(fips)
eststo F2, 

// State fixed effects
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_20C_25C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
reghdfe mrate_tot_total_ `five' [aw=pop_weights] , absorb(year state_fips fips) cluster(fips)
eststo F3

// Going for broke with state*year fixed effects
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
reghdfe mrate_tot_total_ `five' [aw=pop_weights] , absorb(year state_fips fips) cluster(fips)
eststo F4

// Going for broke with state*year fixed effects
local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_20C_25C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
reghdfe mrate_tot_total_ `five' [aw=pop_weights] , absorb(year#state_fips fips) cluster(fips)
eststo F5

esttab F2 F3 F4 F5 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/results_five.tex" ///
	, cells( b(star fmt(4)) se(par fmt(4))) ///
	legend label collabels(none) order() replace ///
 	note(Population-weighted regressions using 5 degree bins. Mortality rate is measured as the deaths per 100,000.) ///
	addnote("The unit of observation is municipality-year. ") ///
	r2

