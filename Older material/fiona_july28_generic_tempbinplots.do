************************************************
**** DO FILE TO PLOT MARGINAL TEMPERATURE EFFECTS
**** WRITTEN BY FIONA WILKES (fiona.wilkes@berkeley.edu)
**** CREATED: July 28, 2015
**** LAST EDITED: July 28, 2015

**** DESCRIPTION: This do-file outlines plotting temperature regressions.
			
**** NOTES: You will have to adjust this for different bins, cluster units, etc.

**** IMPORTANT DATA DECISIONS:

**** PROGRAMS: 

************************************************
version 12

 

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
 
*graph export "YOURFIGUREFILEPATHHERE.pdf", replace

