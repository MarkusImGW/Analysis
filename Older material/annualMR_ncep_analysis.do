***********************************************************************************

* File: annualMR_ncep_analysis.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)
/* 
Objective: The objective of this program is to analyze the effect of the ncep degree days on the annual mortality rate


Structure:
*/

***********************************************************************************
***************
** TEMPLATE ***
***************
// preliminaries

// insheet

// data-manipulations

// Analysis

// Export Graphs

***** 

// preliminaries
local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
set matsize 5000

// insheet
use "`path_intermediate'mort-pop_mun_tmf_allage_97_10", clear


keep state_fips tavg_*  fips year mrate_tot_total mrate_tot_total pop_tot_total 
keep fips state_fips year mrate_tot_total mrate_tot_total pop_tot_total *annual_pop
bysort year: egen pop_weights = sum(pop_tot_total_)
replace pop_weights =  pop_tot_total_/pop_weights

order tavg_bin_35C_Inf_annual_pop, last

// 5 degrees
egen tavg_bin_0C_5C_annual_pop = rowtotal(tavg_bin_0C_1C_annual_pop-tavg_bin_4C_5C_annual_pop)
egen tavg_bin_5C_10C_annual_pop = rowtotal(tavg_bin_5C_6C_annual_pop-tavg_bin_9C_10C_annual_pop)
egen tavg_bin_10C_15C_annual_pop = rowtotal(tavg_bin_10C_11C_annual_pop-tavg_bin_14C_15C_annual_pop)
egen tavg_bin_15C_20C_annual_pop = rowtotal(tavg_bin_15C_16C_annual_pop-tavg_bin_19C_20C_annual_pop)
egen tavg_bin_20C_25C_annual_pop = rowtotal(tavg_bin_20C_21C_annual_pop-tavg_bin_24C_25C_annual_pop)
egen tavg_bin_25C_30C_annual_pop = rowtotal(tavg_bin_25C_26C_annual_pop-tavg_bin_29C_30C_annual_pop)
egen tavg_bin_30C_35C_annual_pop = rowtotal(tavg_bin_30C_31C_annual_pop-tavg_bin_35C_Inf_annual_pop)
egen tavg_bin_0C_10C_annual_pop = rowtotal(tavg_bin_0C_1C_annual_pop-tavg_bin_9C_10C_annual_pop)

// 3 degree bins, with 0-12
egen tavg_bin_0C_12C_annual_pop = rowtotal(tavg_bin_0C_1C_annual_pop-tavg_bin_11C_12C_annual_pop)
egen tavg_bin_12C_15C_annual_pop = rowtotal(tavg_bin_12C_13C_annual_pop-tavg_bin_14C_15C_annual_pop)
egen tavg_bin_15C_18C_annual_pop = rowtotal(tavg_bin_15C_16C_annual_pop-tavg_bin_17C_18C_annual_pop)
egen tavg_bin_19C_22C_annual_pop = rowtotal(tavg_bin_19C_20C_annual_pop-tavg_bin_21C_22C_annual_pop)
egen tavg_bin_22C_25C_annual_pop = rowtotal(tavg_bin_22C_23C_annual_pop-tavg_bin_24C_25C_annual_pop)
egen tavg_bin_25C_28C_annual_pop = rowtotal(tavg_bin_25C_26C_annual_pop-tavg_bin_27C_28C_annual_pop)
egen tavg_bin_28C_31C_annual_pop = rowtotal(tavg_bin_28C_29C_annual_pop-tavg_bin_30C_31C_annual_pop)
egen tavg_bin_31C_Inf_annual_pop = rowtotal(tavg_bin_31C_32C_annual_pop-tavg_bin_35C_Inf_annual_pop)

*template
// reghdfe Y X-variables [fw=pop_tot_total] , absorb(year fips) cluster(fips)
// reghdfe mrate_tot_total X-variables [fw=pop_tot_total] , absorb(year fips) cluster(fips)
// reghdfe lmrate_tot_total X-variables [fw=pop_tot_total], absorb(year fips) cluster(fips)

local five tavg_bin_0C_5C_annual_pop tavg_bin_5C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_20C_25C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
reghdfe mrate_tot_total `five' [aw=pop_weights] , absorb(year fips) cluster(fips)


local five tavg_bin_0C_10C_annual_pop tavg_bin_10C_15C_annual_pop tavg_bin_15C_20C_annual_pop tavg_bin_20C_25C_annual_pop tavg_bin_25C_30C_annual_pop tavg_bin_30C_35C_annual_pop
reghdfe mrate_tot_total `five' [aw=pop_weights] , absorb(year fips) cluster(fips)

local three tavg_bin_0C_12C_annual_pop tavg_bin_12C_15C_annual_pop tavg_bin_15C_18C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_22C_25C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_31C_annual_pop tavg_bin_31C_Inf_annual_pop
reghdfe mrate_tot_total `three' [aw=pop_weights] , absorb(year fips) cluster(fips)
mat betas = e(b)
mat variances = e(V)

** CLEAR YOUR WORKSPACE
drop *
** IMPORT THOSE STORED BETA COEFFICIENTS
svmat betas
** ONLY KEEP THE FIRST ROW (SINCE THESE IMPORT HORIZONTALLY)
keep if _n == 1
** TRANSPOSE TO GET THINGS VERTICAL
xpose, clear
rename v1 marginal_effect
** DROP THE CONSTANT - WE DON'T CARE ABOUT IT. ADJUST ME FOR DIFFERENT NUMBERS OF BINS.
drop if _n > `numbins'
** CREATE A BLANK OBSERVATION (FOR OUR OMITTED BIN)
set obs `numbinsplusomitted'
** SET THE EFFECT TO ZERO IN THE OMITTED BIN
replace marginal_effect = 0 if _n == _N
** IMPORT THE STANDARD ERRORS (AGAIN
gen se = 0


***********************************

/* GRAPHS
hist mrate_tot_total
hist lmrate_tot_total
*/

keep *_annual_pop fips year mrate_tot_total
keep tavg_* fips year mrate_tot_total

*reghdfe mrate_tot_total tavg_bin_16C_17C_annual_pop-tavg_bin_34C_35C_annual_pop , absorb(year fips) cluster(fips)
* collinearity remains

