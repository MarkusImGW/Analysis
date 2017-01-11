***********************************************************************************

* File: BEST_generatemonthly.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)
/* 
Objective: The objective of this program is to create the standardized BEST date on monthly level by year
for all municipalities


Structure:
- Insheet
- keep all best data, drop the others
- get month on the outside
- reshape the month
- save

*/

***********************************************************************************

********* Preliminaries *********
local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/

// Insheet
use "`path_intermediate'merged_climate_dataset_fips", clear

// keep all best data and precip, drop the others
drop m_precip* m_tavg* m_temp* temp* DD* *annual_pop *SON_pop *WT_pop *NH_SR_pop *MAM_pop *JJA_pop *DJF_pop

order fips year id state state_municipality

// get month on the outside //
/*
2 tasks
1) get rid of pop
2) rename to number for months
*/

// generate locals
local degrees 
foreach i of numlist 0(1)34{
local degrees "`degrees' `i'"
}
local monthloop 1 2 3 4 5 6 7 8 9 10 11 12

foreach Month of local monthloop{
foreach i of local degrees{
local j = `i' + 1
rename tavg_bin_`i'C_`j'C_m`Month'_pop tavg_bin_`i'C_`j'C_`Month'
}
// extra for the 35 to Inf bin and precip
rename tavg_bin_35C_Inf_m`Month'_pop tavg_bin_35C_Inf_`Month'
rename precip_m`Month'_pop precip_`Month'
}

// check reshape

*local
// add precip
local bins tavg_bin_35C_Inf_
foreach i of local degrees {
local j = `i' + 1
local bins "`bins' tavg_bin_`i'C_`j'C_"
}
local bins "`bins' precip_"
di "`bins'"


// Reshape to year and month
reshape long `bins' , i(fips year) j(month)
//save
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
save "`path_intermediate'best_monthly", replace
