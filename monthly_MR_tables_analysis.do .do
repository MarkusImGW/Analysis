***********************************************************************************

* File: monthly_MR_tables_analysis.do
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

********* 3 bins, different fixed effects ****************

// locals //
local title Impact of Temperature on Mortality in Brazil; Omitted bin is 22-25C
local precip precip0_10 - precip90_100
local five tavg_bin_0C_10C_ tavg_bin_10C_15C_ tavg_bin_15C_20C_ tavg_bin_25C_30C_ tavg_bin_30C_35C_
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local name results_monthly_three_fespecif
local addnote monthly mortality rates are for a population of 100,000. The regressions are population weighted
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster state_fips

reghdfe mrate_tot `three' [aw=pop_tot_weights] , absorb(year#month month#fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, replace tex(frag) ctitle("y-mo mo-mu") auto(2) addtext(Cluster, State) ///
	title("`title'") addnote("`addnote'") ///
	
reghdfe mrate_tot `three' [aw=pop_tot_weights] , absorb(year#fips month#fips) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("y-mu mo-mu") auto(2) addtext(Cluster, State) ///

reghdfe mrate_tot `three' [aw=pop_tot_weights] , absorb(year#fips month#fips year#month) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("y-mu,mo-mu,y-mo") auto(2) addtext(Cluster, State)
	
********* 3 bins, by Gender; all fe poss ****************

// locals //
local title Impact of Temperature on Mortality in Brazil; Omitted bin is 22-25C
local precip precip0_10 - precip90_100
local five tavg_bin_0C_10C_ tavg_bin_10C_15C_ tavg_bin_15C_20C_ tavg_bin_25C_30C_ tavg_bin_30C_35C_
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local name results_monthly_three_fespecif_sex
local addnote All regressions have year-month, year-municipality and month-municipality fixed effects.
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster state_fips

reghdfe mrate_tot `three' [aw=pop_tot_weights] , absorb(year#fips month#fips year#month) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, replace tex(frag) ctitle("total") auto(2) addtext(Cluster, State) ///
	title("`title'") addnote("`addnote'") ///
	
reghdfe mrate_male `three' [aw=pop_male_weights] , absorb(year#fips month#fips year#month) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("male") auto(2) addtext(Cluster, State) ///

reghdfe mrate_female `three' [aw=pop_female_weights] , absorb(year#fips month#fips year#month) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("female") auto(2) addtext(Cluster, State)	
	



********* By Age and 5 bins, clustered at ****************

// locals //
local title Impact of temperature on the monthly monthly mortality rate in Brazil from 1997-2009, , 5-degree bins
local precip precip0_10 - precip90_100
local five tavg_bin_0C_10C_ tavg_bin_10C_15C_ tavg_bin_15C_20C_ tavg_bin_25C_30C_ tavg_bin_30C_35C_
local name results_monthly_five_outreg_age
local depvar mrate_tot_total_
local addnote Monthly mortality rates are for a population of 100,000. The regressions are population weighted
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster state_fips
//

reghdfe mrate_tot `five' [aw=pop_tot_weights] , absorb(year#fips month#fips year#month)) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, replace tex(frag) ctitle("total") auto(2) addtext(Cluster, State) ///
	title("`title'") addnote("`addnote'") ///
	
reghdfe mrate_male `five' [aw=pop_male_weights] , absorb(year#fips month#fips year#month)) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("male") auto(2) addtext(Cluster, State) ///

reghdfe mrate_female `five' [aw=pop_female_weights] , absorb(year#fips month#fips year#month)) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("female") auto(2) addtext(Cluster, State) ///
	

*********** GRAPH ***************
 

// locals //
local title Impact of Temperature on Mortality in Brazil; Omitted bin is 22-25C
local precip precip0_10 - precip90_100
local five tavg_bin_0C_10C_ tavg_bin_10C_15C_ tavg_bin_15C_20C_ tavg_bin_25C_30C_ tavg_bin_30C_35C_
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local name results_monthly_three_fespecif_sex
local addnote All regressions have year-month, year-municipality and month-municipality fixed effects.
local drop "precip0_10 precip10_20 precip20_30 precip30_40 precip40_50 precip50_60 precip60_70 precip70_80 precip80_90 precip90_100"
local cluster state_fips

reghdfe mrate_tot `three' [aw=pop_tot_weights] , absorb(year#fips month#fips year#month) cluster(`cluster')
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.team" ///
	, replace tex(frag) ctitle("total") auto(2) addtext(Cluster, State) ///
	title("`title'") addnote("`addnote'") ///
	  
** SAVE THE REGRESSION OUTPUT. BETAS INTO A MATRIX ``BETAS''; VARIANCES INTO A MATRIX ``VARIANCES''	  
mat betas = e(b)
mat variances = e(V)

*use "YOURFILENAMEHERE.dta", clear
*** ADJUST ME IF YOUR NUMBER OF TEMPERATURE BINS IS NOT 16 (17 INCL OMITTED) AND IF YOU'RE NOT OMITTING THE 12TH BIN
local numbins = 8
local numbinsplusomitted = `numbins' + 1
local omittedbin = 6


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
forvalues i = 1/`numbins'{
  replace se = sqrt(variances[`i',`i']) if _n == `i'
}

gen ci_low = marginal_effect - se*1.96
gen ci_high = marginal_effect + se*1.96

*** THIS JUST ORDERS THINGS CORRECTLY 
gen bins = _n
** THROW THE OMITTED BIN INTO WHERE IT BELONGS (IN THE MIDDLE)
replace bins = bins + 1 if bins >= `omittedbin'
* a little sloppy, but should work
replace bins = `omittedbin' if se == 0

** LABEL THE BINS VARIABLE (set up with 5 degree bins going from {-inf to -40} to {35 to +inf})
cap label drop binlabels
label define binlabels 1 "0C to 10C"
forvalues i = 2/`numbins' {
  local binstart = 10 + 3*(`i'-2)
  local binend = 10 + 3*(`i'-1)
  label define binlabels `i' "`binstart'C to `binend'C", add
}
label define binlabels `numbinsplusomitted' "31C to inf", add
** LABEL BIN VARIABLE
label val bins binlabels

** SORT ON THE BINS VARIABLE
sort bins
** PLOT. THIS SETUP GIVES GRAY SHADED CIS, BLACK POINT ESTIMATES, AND A BLACK DASHED LINE BETWEEN POINT ESTIMATES.
twoway (rarea ci_high ci_low bins, fc(gs12) lc(gs12)) || ///
(scatter marginal_effect bins, lc(black) m(O) mc(black)) || ///
 (line marginal_effect bins, lp(dash) lc(black)), legend(off) xtitle("Temperature bin") ///
 ytitle("mrate_total") title("Temperature response function:mrate_total", color(black)) ///
 graphregion(fcolor(white)) plotregion(ilcolor(white)) graphregion(lcolor(white)) ///
 plotregion(lcolor(white)) graphregion(ilcolor(white)) ylabel(,grid glcolor(gs15)) xlabel(,valuelabel angle(45))
 
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/mortality_monthly.pdf, replace
	
	
