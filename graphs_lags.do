
***
/* 
Objective: The objective of this program is to create figures for the effects with lags

*/
***********************************************************************************
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
local path_figures /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/
use "`path_intermediate'figures_lags.dta", clear
drop if _n >9
merge 1:m x1 using "`path_intermediate'figures_lags_male.dta", nogen
drop if _n >9
merge 1:m x1 using "`path_intermediate'figures_lags_female.dta", nogen
drop if _n >9


****************************************************
**** GRAPH total lags: 0-3 lags, with se of 2 month lags ****
****************************************************
label variable b1 "Contemporaneous " 
label variable  b5 "1 lag"
label variable  b9 "2 lags"
label variable  b13 "3 lags"

local bins3lab `"1 "0-10" 2 "10_13" 3 "13_16" 4 "16_19" 5 "19_22" 6 "22_25" 7 "25_28" 8 "28_31" 9 "31+_""'
twoway (rarea b12 b11 x1, fc(gs12) lc(gs12)) || ///
(scatter b9 x1, lc(black) m(O) mc(black)) || ///
(line b9 x1, lp(dash) lc(black)) || ///
(scatter b1 x1, lc(black) m(O) mc(blue)) || ///
 (line b1 x1, lp(dash) lc(blue)) || ///
 (scatter b5 x1, lc(black) m(O) mc(green)) || ///
 (line b5 x1, lp(dash) lc(green)) || /// 
 (scatter b13 x1, lc(black) m(O) mc(red)) || ///
 (line b13 x1, lp(dash) lc(red)) || /// 
 , legend(off) xtitle("Temperature bin") ///
 ytitle("mortality rate") title("Temperature response function", color(black)) ///
 graphregion(fcolor(white)) plotregion(ilcolor(white)) graphregion(lcolor(white)) ///
 plotregion(lcolor(white)) graphregion(ilcolor(white)) ylabel(,grid glcolor(gs15)) xlabel(,valuelabel angle(45)) ///
 xlabel(`bins3lab') legend(on) legend(order(3 5 7 9)) 

graph export `path_figures'lags2.png, replace

****************************************************
**** GRAPH: Total, male and female with 2 month lags ****
****************************************************
label variable  b9 "Total"
label variable  m9 "Male"
label variable  f9 "Female"


local bins3lab `"1 "0-10" 2 "10_13" 3 "13_16" 4 "16_19" 5 "19_22" 6 "22_25" 7 "25_28" 8 "28_31" 9 "31+_""'
twoway (rarea b12 b11 x1, fc(gs12) lc(gs12)) || ///
(scatter b9 x1, lc(black) m(O) mc(black)) || ///
(line b9 x1, lp(dash) lc(black)) || ///
(scatter m9 x1, lc(black) m(O) mc(blue)) || ///
 (line m9 x1, lp(dash) lc(blue)) || ///
 (scatter f9 x1, lp(dash) lc(green)) || ///
 (line f9 x1, lp(dash) lc(green)) || /// 
 ,  xtitle("Temperature bin") ///
 ytitle("mortality rate") title("Temperature response function", color(black)) ///
 graphregion(fcolor(white)) plotregion(ilcolor(white)) graphregion(lcolor(white)) ///
 plotregion(lcolor(white)) graphregion(ilcolor(white)) ylabel(,grid glcolor(gs15)) xlabel(,valuelabel angle(45)) ///
 xlabel(`bins3lab') legend(on) legend(order(3 5 7)) 

/*
local bins3lab `"1 "0-10" 2 "10_13" 3 "13_16" 4 "16_19" 5 "19_22" 6 "22_25" 7 "25_28" 8 "28_31" 9 "31+_""'
twoway (scatter m9 x1, lc(black) m(O) mc(blue)) || ///
 (line m9 x1, lp(dash) lc(blue)) || ///
 (scatter f9 x1, lp(dash) lc(green)) || ///
 (line f9 x1, lp(dash) lc(green)) || /// 
 ,  xtitle("Temperature bin") ///
 ytitle("mortality rate") title("Temperature response function", color(black)) ///
 graphregion(fcolor(white)) plotregion(ilcolor(white)) graphregion(lcolor(white)) ///
 plotregion(lcolor(white)) graphregion(ilcolor(white)) ylabel(,grid glcolor(gs15)) xlabel(,valuelabel angle(45)) ///
 xlabel(`bins3lab') legend(on) legend(order(2 4)) 
 */

graph export `path_figures'lags_tmf.png, replace

****************************************************
**** GRAPH male lags: 0-3 lags, with se of 2 month lags ****
****************************************************
label variable m1 "Contemporaneous "
label variable  m5 "1 lag"
label variable  m9 "2 lags"
label variable  m13 "3 lags"

local bins3lab `"1 "0-10" 2 "10_13" 3 "13_16" 4 "16_19" 5 "19_22" 6 "22_25" 7 "25_28" 8 "28_31" 9 "31+_""'
twoway (rarea b12 b11 x1, fc(gs12) lc(gs12)) || ///
(scatter m9 x1, lc(black) m(O) mc(black)) || ///
(line m9 x1, lp(dash) lc(black)) || ///
(scatter m1 x1, lc(black) m(O) mc(blue)) || ///
 (line m1 x1, lp(dash) lc(blue)) || ///
 (scatter m5 x1, lc(black) m(O) mc(green)) || ///
 (line m5 x1, lp(dash) lc(green)) || /// 
 (scatter m13 x1, lc(black) m(O) mc(red)) || ///
 (line m13 x1, lp(dash) lc(red)) || /// 
 , legend(off) xtitle("Temperature bin") ///
 ytitle("mortality rate") title("Male Temperature response function", color(black)) ///
 graphregion(fcolor(white)) plotregion(ilcolor(white)) graphregion(lcolor(white)) ///
 plotregion(lcolor(white)) graphregion(ilcolor(white)) ylabel(,grid glcolor(gs15)) xlabel(,valuelabel angle(45)) ///
 xlabel(`bins3lab') legend(on) legend(order(3 5 7 9)) 

graph export `path_figures'lags_m.png, replace

****************************************************
**** GRAPH female lags: 0-3 lags, with se of 2 month lags ****
****************************************************
label variable f1 "Contemporaneous "
label variable  f5 "1 lag"
label variable  f9 "2 lags"
label variable  f13 "3 lags"

local bins3lab `"1 "0-10" 2 "10_13" 3 "13_16" 4 "16_19" 5 "19_22" 6 "22_25" 7 "25_28" 8 "28_31" 9 "31+_""'
twoway (rarea b12 b11 x1, fc(gs12) lc(gs12)) || ///
(scatter f9 x1, lc(black) m(O) mc(black)) || ///
(line f9 x1, lp(dash) lc(black)) || ///
(scatter f1 x1, lc(black) m(O) mc(blue)) || ///
 (line f1 x1, lp(dash) lc(blue)) || ///
 (scatter f5 x1, lc(black) m(O) mc(green)) || ///
 (line f5 x1, lp(dash) lc(green)) || /// 
 (scatter f13 x1, lc(black) m(O) mc(red)) || ///
 (line f13 x1, lp(dash) lc(red)) || /// 
 , legend(off) xtitle("Temperature bin") ///
 ytitle("mortality rate") title("Female Temperature response function", color(black)) ///
 graphregion(fcolor(white)) plotregion(ilcolor(white)) graphregion(lcolor(white)) ///
 plotregion(lcolor(white)) graphregion(ilcolor(white)) ylabel(,grid glcolor(gs15)) xlabel(,valuelabel angle(45)) ///
 xlabel(`bins3lab') legend(on) legend(order(3 5 7 9)) 

graph export `path_figures'lags_w.png, replace

****************************************************
**** GRAPH Contemporaneous: State*month*year 
****************************************************

local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
use "`path_intermediate'merged_monthly_97_09", clear
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
//Reg
reghdfe mrate_tot `three' `precip' [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(fips) 

local holder
lincom tavg_bin_ 0C_10C_ 
local reg_c_010_cont = r(estimate)
local reg_se_010_cont = r(se)
local reg_se_010_left = `reg_c_010_cont' - 1.96 * `reg_se_010_cont'
local reg_se_010_right = `reg_c_010_cont'+ 1.96 * `reg_se_010_cont'
local holder "`holder' `reg_c_010_cont' , `reg_se_010_cont' , `reg_se_010_left' , `reg_se_010_right'  "
di "`holder'"

local bins 10C_13C_ 13C_16C_ 16C_19C_ 19C_22C_ 
foreach i of local bins{
lincom tavg_bin_`i' 
local reg_c_010_cont = r(estimate)
local reg_se_010_cont = r(se)
local reg_se_010_left = `reg_c_010_cont' - 1.96 * `reg_se_010_cont'
local reg_se_010_right = `reg_c_010_cont'+ 1.96 * `reg_se_010_cont'
local holder "`holder' \  `reg_c_010_cont' , `reg_se_010_cont' , `reg_se_010_left' , `reg_se_010_right'"
di "`holder'"
}
local holder "`holder' \  0 , 0 , 0 , 0 "

local bins 25C_28C_ 28C_31C_ 31C_Inf_ 
foreach i of local bins{
lincom tavg_bin_`i' 
local reg_c_010_cont = r(estimate)
local reg_se_010_cont = r(se)
local reg_se_010_left = `reg_c_010_cont' - 1.96 * `reg_se_010_cont'
local reg_se_010_right = `reg_c_010_cont'+ 1.96 * `reg_se_010_cont'
local holder "`holder' \  `reg_c_010_cont' , `reg_se_010_cont' , `reg_se_010_left' , `reg_se_010_right'"
di "`holder'"
}

matrix c = (`holder')
matrix list c
svmat c

gen x1 = _n 
replace x1 = . if x1 >10

keep c1-c4 x1

local bins3lab `"1 "0-10" 2 "10_13" 3 "13_16" 4 "16_19" 5 "19_22" 6 "22_25" 7 "25_28" 8 "28_31" 9 "31+_""'
twoway (rarea c4 c3 x1, fc(gs12) lc(gs12)) || ///
(scatter c1 x1, lc(black) m(O) mc(black)) || ///
(line c1 x1, lp(dash) lc(black)) || ///
 , legend(off) xtitle("Temperature bin") ///
 ytitle("Monthly mortality rate") title("Temperature response function", color(black)) ///
 graphregion(fcolor(white)) plotregion(ilcolor(white)) graphregion(lcolor(white)) ///
 plotregion(lcolor(white)) graphregion(ilcolor(white)) ylabel(,grid glcolor(gs15)) xlabel(,valuelabel angle(45)) ///
 xlabel(`bins3lab') legend(off)

local path_figures /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/
graph export `path_figures'cont.png, replace
