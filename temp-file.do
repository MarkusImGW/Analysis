
***********************************************************************************

* File: merge_monthly.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)
/* 
Objective: The objective of this program is to create a dataset for municipalities and brazil for the year 2009
for all categories

Structure:
1. Insheet all data and get ready for merge
2. Merge
3. Rename and change characters
4. Save
*/
***********************************************************************************

********* Preliminaries *********
global mypath  /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/

//population
use "`path_intermediate'pop_tmf_total_97_09_monthly'", clear

merge 1:1 fips year month using "`path_intermediate'mort_tmf_total_97_10_monthly"
drop if _merge == 1 | _merge == 2
drop _merge
merge 1:1 fips year month using "`path_intermediate'best_monthly"
drop if _merge == 1 | _merge == 2
drop _merge
drop if year>2009

destring fips, replace
destring state_fips, replace


local sex "tot male female"
foreach var of local sex{
* generate population weights and mortality rate
bysort year month: egen pop_`var'_weights = total(pop_`var'_)
replace pop_`var'_weights =  pop_`var'_/pop_`var'_weights
**** generate (log-)mortality rates ********
gen mrate_`var' = 100000*mort_`var'_/pop_`var'_
gen lmrate_`var' = log(mrate_`var')
}

local bin_ordering
foreach i of numlist 0(1)34{
local j = `i' + 1
local bin_ordering "`bin_ordering' tavg_bin_`i'C_`j'C_"
}
local bin_ordering "`bin_ordering' tavg_bin_35C_Inf_"
*di "`bin_ordering'"
order `bin_ordering'

// 5 degrees
egen tavg_bin_0C_5C_ = rowtotal(tavg_bin_0C_1C_-tavg_bin_4C_5C_)
egen tavg_bin_5C_10C_ = rowtotal(tavg_bin_5C_6C_-tavg_bin_9C_10C_)
egen tavg_bin_10C_15C_ = rowtotal(tavg_bin_10C_11C_-tavg_bin_14C_15C_)
egen tavg_bin_15C_20C_ = rowtotal(tavg_bin_15C_16C_-tavg_bin_19C_20C_)
egen tavg_bin_20C_25C_ = rowtotal(tavg_bin_20C_21C_-tavg_bin_24C_25C_)
egen tavg_bin_25C_30C_ = rowtotal(tavg_bin_25C_26C_-tavg_bin_29C_30C_)
egen tavg_bin_30C_35C_ = rowtotal(tavg_bin_30C_31C_-tavg_bin_35C_Inf_)
* with special 0_10C
egen tavg_bin_0C_10C_ = rowtotal(tavg_bin_0C_1C_-tavg_bin_9C_10C_)

// 3 degree bins, with 0-13 bin (but use 
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

// 2 degree bins, 

**********************************
***** Creating lags and leads **** 
**********************************

// create the month-year variables
//creating time variable  "date" that signals year month, to then convert it to stata format
gen time = "-"
order time

local years
foreach i of numlist 1997(1)2009{
local years "`years' `i'"
}
local months
foreach i of numlist 1(1)12{
local months "`months' `i'"
}

foreach t of local years{
foreach m of local months{
replace time = "`t'm`m'" if year == `t' & month == `m'
}
}
gen date = monthly(time,"ym")
order date
xtset fips date

// creating the lag variables
local bins tavg_bin_0C_13C_ tavg_bin_28C_Inf_ tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_

foreach i of numlist 1(1)4{
foreach var of local bins {
gen l`i'_`var' = l`i'.`var'
gen f`i'_`var' = f`i'.`var'
}
}
// looking good

*******************************************
***** Creating Municipality-month unit **** 
*******************************************



**** save ****
save "`path_intermediate'merged_monthly_97_09", replace


