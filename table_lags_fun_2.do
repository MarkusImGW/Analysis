
***
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

*log using table_lags_fun, replace

********* Preliminaries path and insheet *********
*local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
*local path_intermediate /home/aviaene/Viaene_MortalityHospAdmBrazil/Analysis/Data/Intermediate/
*set matsize 500
use "`path_intermediate'merged_monthly_97_09.dta", clear
*xtset fips_month year
*use "/home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Intermediate/merged_monthly_97_09.dta"


********* locals temp and precip *********
* 3-bins, lags and leads
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local three_2 tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local three_l1 l1_tavg_bin_0C_10C_ l1_tavg_bin_10C_13C_ l1_tavg_bin_13C_16C_ l1_tavg_bin_16C_19C_ l1_tavg_bin_19C_22C_ l1_tavg_bin_25C_28C_ l1_tavg_bin_28C_31C_ l1_tavg_bin_31C_Inf_
local three_l2 l2_tavg_bin_0C_10C_ l2_tavg_bin_10C_13C_ l2_tavg_bin_13C_16C_ l2_tavg_bin_16C_19C_ l2_tavg_bin_19C_22C_ l2_tavg_bin_25C_28C_ l2_tavg_bin_28C_31C_ l2_tavg_bin_31C_Inf_
local three_l3 l3_tavg_bin_0C_10C_ l3_tavg_bin_10C_13C_ l3_tavg_bin_13C_16C_ l3_tavg_bin_16C_19C_ l3_tavg_bin_19C_22C_ l3_tavg_bin_25C_28C_ l3_tavg_bin_28C_31C_ l3_tavg_bin_31C_Inf_
local three_l4 l4_tavg_bin_0C_10C_ l4_tavg_bin_10C_13C_ l4_tavg_bin_13C_16C_ l4_tavg_bin_16C_19C_ l4_tavg_bin_19C_22C_ l4_tavg_bin_25C_28C_ l4_tavg_bin_28C_31C_ l4_tavg_bin_31C_Inf_

local precip precip_ precip_sq

local three_f1 f1_tavg_bin_0C_10C_ f1_tavg_bin_10C_13C_ f1_tavg_bin_13C_16C_ f1_tavg_bin_16C_19C_ f1_tavg_bin_19C_22C_ f1_tavg_bin_25C_28C_ f1_tavg_bin_28C_31C_ f1_tavg_bin_31C_Inf_
local three_f2 f2_tavg_bin_0C_10C_ f2_tavg_bin_10C_13C_ f2_tavg_bin_13C_16C_ f2_tavg_bin_16C_19C_ f2_tavg_bin_19C_22C_ f2_tavg_bin_25C_28C_ f2_tavg_bin_28C_31C_ f2_tavg_bin_31C_Inf_
local three_f3 f3_tavg_bin_0C_10C_ f3_tavg_bin_10C_13C_ f3_tavg_bin_13C_16C_ f3_tavg_bin_16C_19C_ f3_tavg_bin_19C_22C_ f3_tavg_bin_25C_28C_ f3_tavg_bin_28C_31C_ f3_tavg_bin_31C_Inf_
// Table Preliminaries
local name monthly_three_fun
local title Impact of Temperature on Mortality in Brazil; Omitted bin is 22-25C
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_

**********************
** start
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local precip precip_ precip_sq
reg mrate_tot `three' `precip'
*areg mrate_tot `three' [aw=pop_tot_weights], absorb(fips_month)

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

*drop b1 b2 b3 b4
matrix b = (`holder')
matrix list b


// Generating the graphs


** 1 lag
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local three_2 tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local three_l1 l1_tavg_bin_0C_10C_ l1_tavg_bin_10C_13C_ l1_tavg_bin_13C_16C_ l1_tavg_bin_16C_19C_ l1_tavg_bin_19C_22C_ l1_tavg_bin_25C_28C_ l1_tavg_bin_28C_31C_ l1_tavg_bin_31C_Inf_

*areg mrate_tot `three' `three_l1' [aw=pop_tot_weights], absorb(fips_month)
reg mrate_tot `three' `three_l1'

**
local holder
lincom tavg_bin_0C_10C_ + l1_tavg_bin_0C_10C_ 
local reg_c_010_cont = r(estimate)
local reg_se_010_cont = r(se)
local reg_se_010_left = `reg_c_010_cont' - 1.96 * `reg_se_010_cont'
local reg_se_010_right = `reg_c_010_cont'+ 1.96 * `reg_se_010_cont'
local holder "`holder' `reg_c_010_cont' , `reg_se_010_cont' , `reg_se_010_left' , `reg_se_010_right'  "
di "`holder'"

local bins 10C_13C_ 13C_16C_ 16C_19C_ 19C_22C_ 
foreach i of local bins{
lincom tavg_bin_`i' + l1_tavg_bin_`i'
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
lincom tavg_bin_`i' + l1_tavg_bin_`i'
local reg_c_010_cont = r(estimate)
local reg_se_010_cont = r(se)
local reg_se_010_left = `reg_c_010_cont' - 1.96 * `reg_se_010_cont'
local reg_se_010_right = `reg_c_010_cont'+ 1.96 * `reg_se_010_cont'
local holder "`holder' \  `reg_c_010_cont' , `reg_se_010_cont' , `reg_se_010_left' , `reg_se_010_right'"
di "`holder'"
}
** Adding the matris 
matrix b1 = (`holder')
matrix list b1

*** Now adding two lags ***
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local three_2 tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local three_l1 l1_tavg_bin_0C_10C_ l1_tavg_bin_10C_13C_ l1_tavg_bin_13C_16C_ l1_tavg_bin_16C_19C_ l1_tavg_bin_19C_22C_ l1_tavg_bin_25C_28C_ l1_tavg_bin_28C_31C_ l1_tavg_bin_31C_Inf_
local three_l2 l2_tavg_bin_0C_10C_ l2_tavg_bin_10C_13C_ l2_tavg_bin_13C_16C_ l2_tavg_bin_16C_19C_ l2_tavg_bin_19C_22C_ l2_tavg_bin_25C_28C_ l2_tavg_bin_28C_31C_ l2_tavg_bin_31C_Inf_
*areg mrate_tot `three' `three_l1' `three_l2' [aw=pop_tot_weights], absorb(fips_month)
reg mrate_tot `three' `three_l1' `three_l2' 

local holder
lincom tavg_bin_0C_10C_ + l1_tavg_bin_0C_10C_ + l2_tavg_bin_0C_10C_ 
local reg_c_010_cont = r(estimate)
local reg_se_010_cont = r(se)
local reg_se_010_left = `reg_c_010_cont' - 1.96 * `reg_se_010_cont'
local reg_se_010_right = `reg_c_010_cont'+ 1.96 * `reg_se_010_cont'
local holder "`holder' `reg_c_010_cont' , `reg_se_010_cont' , `reg_se_010_left' , `reg_se_010_right'"

local bins 10C_13C_ 13C_16C_ 16C_19C_ 19C_22C_ 
foreach i of local bins{
lincom tavg_bin_`i' + l1_tavg_bin_`i' + l2_tavg_bin_`i'
local reg_c_010_cont = r(estimate)
local reg_se_010_cont = r(se)
local reg_se_010_left = `reg_c_010_cont' - 1.96 * `reg_se_010_cont'
local reg_se_010_right = `reg_c_010_cont'+ 1.96 * `reg_se_010_cont'
local holder "`holder' \  `reg_c_010_cont' , `reg_se_010_cont' , `reg_se_010_left' , `reg_se_010_right'"
}
di "`holder'"

local holder "`holder' \  0 , 0 , 0 , 0 "

local bins 25C_28C_ 28C_31C_ 31C_Inf_  
foreach i of local bins{
lincom tavg_bin_`i' + l1_tavg_bin_`i' + l2_tavg_bin_`i'
local reg_c_010_cont = r(estimate)
local reg_se_010_cont = r(se)
local reg_se_010_left = `reg_c_010_cont' - 1.96 * `reg_se_010_cont'
local reg_se_010_right = `reg_c_010_cont'+ 1.96 * `reg_se_010_cont'
local holder "`holder' \  `reg_c_010_cont' , `reg_se_010_cont' , `reg_se_010_left' , `reg_se_010_right'"
}
di "`holder'"

matrix b2 = (`holder')
matrix list b2



*** three lags
*areg mrate_tot `three' `three_l1' `three_l2' [aw=pop_tot_weights], absorb(fips_month)
reg mrate_tot `three' `three_l1' `three_l2' `three_l3' , robust

local holder
lincom tavg_bin_0C_10C_ + l1_tavg_bin_0C_10C_ + l2_tavg_bin_0C_10C_ + l3_tavg_bin_0C_10C_
local reg_c_010_cont = r(estimate)
local reg_se_010_cont = r(se)
local reg_se_010_left = `reg_c_010_cont' - 1.96 * `reg_se_010_cont'
local reg_se_010_right = `reg_c_010_cont'+ 1.96 * `reg_se_010_cont'
local holder "`holder' `reg_c_010_cont' , `reg_se_010_cont' , `reg_se_010_left' , `reg_se_010_right'"

local bins 10C_13C_ 13C_16C_ 16C_19C_ 19C_22C_   
foreach i of local bins{
lincom tavg_bin_`i' + l1_tavg_bin_`i' + l2_tavg_bin_`i' + l3_tavg_bin_`i'
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
lincom tavg_bin_`i' + l1_tavg_bin_`i' + l2_tavg_bin_`i' + l3_tavg_bin_`i'
local reg_c_010_cont = r(estimate)
local reg_se_010_cont = r(se)
local reg_se_010_left = `reg_c_010_cont' - 1.96 * `reg_se_010_cont'
local reg_se_010_right = `reg_c_010_cont'+ 1.96 * `reg_se_010_cont'
local holder "`holder' \  `reg_c_010_cont' , `reg_se_010_cont' , `reg_se_010_left' , `reg_se_010_right'"
di "`holder'"
}

matrix b3 = (`holder')
matrix list b3



** Get to dta file
*combining
matrix b = b, b1, b2, b3
matrix list b
svmat b

gen x1 = _n 
replace x1 = . if x1 >10

keep b1-b16 x1

local path_int /home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
saveold "`path_int'merged", replace version(12)

/*
local bins3lab `"1 "0-10" 2 "10_13" 3 "13_16" 4 "16_19" 5 "19_22" 6 "22_25" 7 "25_28" 8 "28_31" 9 "31+_""'
twoway (rarea b12 b11 x1, fc(gs12) lc(gs12)) || ///
(scatter b9 x1, lc(black) m(O) mc(black)) || ///
 (line b9 x1, lp(dash) lc(black)) || ///
(scatter b1 x1, lc(black) m(O) mc(black)) || ///
 (line b1 x1, lp(dash) lc(black)) || ///
 , legend(off) xtitle("Temperature bin") ///
 ytitle("mrate_total") title("Temperature response function:mrate_total", color(black)) ///
 graphregion(fcolor(white)) plotregion(ilcolor(white)) graphregion(lcolor(white)) ///
 plotregion(lcolor(white)) graphregion(ilcolor(white)) ylabel(,grid glcolor(gs15)) xlabel(,valuelabel angle(45)) ///
 xlabel(`bins3lab') 
 


/*

** rename
matrix rownames b = 0_to_10 _ 10C_to_13C_  _ 13C_to_16C_  _ 16C_to_19C_  _ 19C_to_22C_  _ 25C_to_28C_  _ 28C_to_31C_  _ 31C_to_Inf_  _ 
matrix list b

** outtable
outtable using  /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/auto ///
, mat(b) nobox caption("Lags" ) format(%6.2f) replace


************** END
 

scalar reg_c_`i' = r(estimate)

reghdfe mrate_tot tavg_bin_0C_10C_ l1_tavg_bin_0C_10C_ l2_tavg_bin_0C_10C_ [aw=pop_tot_weights], absorb(year) 
lincom tavg_bin_0C_10C_ + l1_tavg_bin_0C_10C_ + l2_tavg_bin_0C_10C_	
scalar reg_c_010_cont = r(estimate)
scalar reg_se_010_cont = r(se)
matrix coeff = coeff, (reg_c_010_cont \ reg_se_010_cont)
matrix list coeff

reghdfe mrate_tot tavg_bin_0C_10C_ l1_tavg_bin_0C_10C_ l2_tavg_bin_0C_10C_ l3_tavg_bin_0C_10C_ [aw=pop_tot_weights], absorb(year) 
lincom tavg_bin_0C_10C_ + l1_tavg_bin_0C_10C_ + l2_tavg_bin_0C_10C_	+ l3_tavg_bin_0C_10C_
scalar reg_c_010_cont = r(estimate)
scalar reg_se_010_cont = r(se)
matrix coeff = coeff , (reg_c_010_cont \ reg_se_010_cont)
matrix list coeff



		local coef = r(estimate)
		local coef = round(`coef', .01)
		local coef = "`coef'"
		if length("`coef'") < 3 {
			local coef = "`coef'" + "0"
		}
		local coef = substr("`coef'", 1, 6)
		local se = r(se)
		local tstat = r(estimate)/r(se)
		local pval = tprob(r(df), abs(`tstat'))
		local pval = round(`pval', .01)
		
		if `pval' <= .01 {
			local coef = "`coef'" + "***"
		}
		if `pval' > .01 & `pval' <= .05 {
			local coef = "`coef'" + "**"
		}
		if `pval' > .05 & `pval' <= .1 {
			local coef = "`coef'" + "*"
		}
		if length("`pval'") < 3 {
			local pval = "`pval'" + "0"
		}

local coef 2
local coef = substr("`coef'", 1, 6)
di "`coef'"
local coef = "`coef'" + "*"
di "`coef'" 
** so this works to add a * to 

local coef 1
local coef = substr("`coef'", 1, 6)
di "`coef'" 
local pval 0.4
local pval = round(`pval', .01)
if `pval' > .01 & `pval' < .05 {
	local coef = "`coef'" + "**"
}
di "`coef'"

		if `pval' <= .01 {
			local coef = "`coef'" + "***"
		}
		if `pval' > .01 & `pval' <= .05 {
			local coef = "`coef'" + "**"
		}
		if `pval' > .05 & `pval' <= .1 {
			local coef = "`coef'" + "*"
		}
		if length("`pval'") < 3 {
			local pval = "`pval'" + "0"
		}
di `pval'
di "`coef'"


outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) replace ctitle("c1") auto(2) 
lincom tavg_bin_0C_10C_ + L1.tavg_bin_0C_10C_ + L2.tavg_bin_0C_10C_
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("c2") auto(2)  





