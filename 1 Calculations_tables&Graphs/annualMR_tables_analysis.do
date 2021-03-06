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


*** LOCALS THROUGHOUT THE REGRESSIONS
local depvar mrate_tot_total_
local precip precip0_10 - precip90_100
local cluster fips
local age_fe "age_pro_pop_0000_ age_pro_pop_4070_ age_pro_pop_70Inf_"

*******************************************************************
********* Table 1: Varying FE specifications **********************
*******************************************************************

** Name of the File
local name yearly_table1

// RHS
local omitted_bin bin_22C_25C
local bins bin_0C_13C bin_13C_16C bin_16C_19C bin_19C_22C bin_22C_25C bin_25C_28C bin_28C_Inf

foreach i of local bins{
			if "`i'" != "`omitted_bin'" {
			di "`i'"
			local rhs `rhs' `i'
			  }
			else {
			di "omitted bin `i'"
			}

}
reghdfe `depvar' `rhs' `age_fe' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, replace tex(frag) drop(`age_fe') ctitle("County and Year") auto(2) label ///
	title("`title'") addnote("`addnote'") ///

reghdfe `depvar' `rhs' `age_fe' [aw=pop_weights] , absorb(year#state fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, append tex(frag) drop(`age_fe') ctitle("County and Year-State") auto(2) ///
	title("`title'") addnote("`addnote'") ///
	
********************************************************************************
********* Table 3: Average Temperature Interactions// Semi and Full, County & Year FE - C&S-YFE  **********
********************************************************************************

// Name of the file
local name yearly_table3

// RHS
local rhs // reset of the variable
di "`rhs'"

local omitted_bin bin_22C_25C_MEDIUM
local bins bin_0C_13C bin_13C_16C bin_16C_19C bin_19C_22C bin_22C_25C bin_25C_28C bin_28C_Inf
* local ruralvar rural urban
local climate COLD MEDIUM HOT
foreach i of local bins{
	foreach j of local climate{
			if "`i'_`j'" != "`omitted_bin'" {
			di "`i'_`j'"
			local rhs `rhs' `i'_`j'
			  }
			else {
			di "omitted bin `i'_`j'
			}
	}	
}

reghdfe `depvar' `rhs' `age_fe' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
, replace tex(frag) drop(`age_fe') ctitle("County and Year") auto(2) label ///
title("`title'") 
	
reghdfe `depvar' `rhs' `age_fe' [aw=pop_weights] , absorb(year#state fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
, append tex(frag) drop(`age_fe') ctitle("County and SY") auto(2) label ///
title("`title'") 



********************************************************************************
********* Table 4: Rural-Urban Interactions// Semi and Full, County & Year FE - C&S-YFE  **********
********************************************************************************

// Name of the file
local name yearly_table4b

// RHS
local rhs // reset of the variable
local omitted_bin bin_22C_25C_urban
local bins bin_0C_13C bin_13C_16C bin_16C_19C bin_19C_22C bin_22C_25C bin_25C_28C bin_28C_Inf
local ruralvar rural urban
*local climate COLD MEDIUM HOT
foreach i of local bins{
	foreach j of local ruralvar{
			if "`i'_`j'" != "`omitted_bin'" {
			di "`i'_`j'"
			local rhs `rhs' `i'_`j'
			  }
			else {
			di "omitted bin `i'_`j'
			}
	}	
}
// 
reghdfe `depvar' `rhs' `age_fe' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
, replace tex(frag) drop(`age_fe') ctitle("County and Year") auto(2) label ///
title("`title'") 
	
reghdfe `depvar' `rhs' `age_fe'  [aw=pop_weights] , absorb(year#state fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
, append tex(frag) drop(`age_fe') ctitle("County and SY") auto(2) label ///
title("`title'") 
  

********************************************************************************
********* Table 5: AT & Rural-Urban Interactions// Semi and Full, County & Year FE - C&S-YFE  **********
********************************************************************************

// Name of the file
local name yearly_table5b

// RHS
local rhs // reset of the variable
local omitted_bin bin_22C_25C_urban_MEDIUM
local bins bin_0C_13C bin_13C_16C bin_16C_19C bin_19C_22C bin_22C_25C bin_25C_28C bin_28C_Inf
local ruralvar rural urban
local climate COLD MEDIUM HOT
foreach i of local bins{
	foreach j of local ruralvar{
		foreach k of local climate {
			if "`i'_`j'_`k'" != "`omitted_bin'" {
			di "`i'_`j'_`k'"
			local rhs `rhs' `i'_`j'_`k'
			  }
			else {
			di "omitted bin `i'_`j'_`k'"
			}
		}
	}	
}

reghdfe `depvar' `rhs' `age_fe' [aw=pop_weights] , absorb(year fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
, replace tex(frag) drop(`age_fe') ctitle("County and Year") auto(2) label ///
title("`title'") 
	
reghdfe `depvar' `rhs' `age_fe'  [aw=pop_weights] , absorb(year#state fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
, append tex(frag) drop(`age_fe') ctitle("County and SY") auto(2) label ///
title("`title'") 



*********************************************
****** END Main File ************************
*********************************************

	
	
/*	

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
********* Checking the effects of precipitation ****************
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



*******************************************************************
********* Table X: Lags&Leads Check, County & Year FE *************
*******************************************************************
*******************************************************************
********* Test Lags and Leads ****************
*******************************************************************

// estimates stats nolead laglead1 laglead2 laglead3 lag4 lead4 laglead4

