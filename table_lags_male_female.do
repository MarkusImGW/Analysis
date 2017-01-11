
***
/*
* Modified by: Arvid Viaene 
* Contact: Arvid Viaene (viaene@uchicago.edu)

Objective: The objective of this program is to create the cumulative effect of the lags
The output will be a table summarizing the cumulative effect of each weater bin, with se, coeff - and + se in the second, third and fourth column
There will be 9 rows for the bins and 16 columns as the program goes from 0 -3 lags

*/
***********************************************************************************

log using table_lags_male_female, replace
set matsize 800

********* Preliminaries path and insheet *********
*local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
*local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
*local path_intermediate /home/aviaene/Viaene_MortalityHospAdmBrazil/Analysis/Data/Intermediate/
*set matsize 500
*use "`path_intermediate'merged_monthly_97_09.dta", clear
*xtset fips_month year
use "/home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Intermediate/merged_monthly_97_09.dta"


********* locals temp and precip *********
* 3-bins, lags and leads
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local three_2 tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local three_l1 l1_tavg_bin_0C_10C_ l1_tavg_bin_10C_13C_ l1_tavg_bin_13C_16C_ l1_tavg_bin_16C_19C_ l1_tavg_bin_19C_22C_ l1_tavg_bin_25C_28C_ l1_tavg_bin_28C_31C_ l1_tavg_bin_31C_Inf_
local three_l2 l2_tavg_bin_0C_10C_ l2_tavg_bin_10C_13C_ l2_tavg_bin_13C_16C_ l2_tavg_bin_16C_19C_ l2_tavg_bin_19C_22C_ l2_tavg_bin_25C_28C_ l2_tavg_bin_28C_31C_ l2_tavg_bin_31C_Inf_
local three_l3 l3_tavg_bin_0C_10C_ l3_tavg_bin_10C_13C_ l3_tavg_bin_13C_16C_ l3_tavg_bin_16C_19C_ l3_tavg_bin_19C_22C_ l3_tavg_bin_25C_28C_ l3_tavg_bin_28C_31C_ l3_tavg_bin_31C_Inf_

local precip precip_ precip_sq

local three_f1 f1_tavg_bin_0C_10C_ f1_tavg_bin_10C_13C_ f1_tavg_bin_13C_16C_ f1_tavg_bin_16C_19C_ f1_tavg_bin_19C_22C_ f1_tavg_bin_25C_28C_ f1_tavg_bin_28C_31C_ f1_tavg_bin_31C_Inf_
local three_f2 f2_tavg_bin_0C_10C_ f2_tavg_bin_10C_13C_ f2_tavg_bin_13C_16C_ f2_tavg_bin_16C_19C_ f2_tavg_bin_19C_22C_ f2_tavg_bin_25C_28C_ f2_tavg_bin_28C_31C_ f2_tavg_bin_31C_Inf_
local three_f3 f3_tavg_bin_0C_10C_ f3_tavg_bin_10C_13C_ f3_tavg_bin_13C_16C_ f3_tavg_bin_16C_19C_ f3_tavg_bin_19C_22C_ f3_tavg_bin_25C_28C_ f3_tavg_bin_28C_31C_ f3_tavg_bin_31C_Inf_
// Table Preliminaries
local name monthly_three_fun
local title Impact of Temperature on Mortality in Brazil; Omitted bin is 22-25C
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_

timer on 1
timer on 2
**********************
** start
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
areg mrate_male `three' `precip' i.month#i.year i.state_fips#i.year [aw=pop_male_weights], absorb(fips_month) vce(cluster fips)

timer off 1
timer list 1

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
matrix m = (`holder')
matrix list m

************
** 1-lag ***
************
areg mrate_male `three' `three_l1' `precip'  i.month#i.year i.state_fips#i.year [aw=pop_male_weights], absorb(fips_month) vce(cluster fips)
//
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
matrix m1 = (`holder')
matrix list m1


************
** 2-lag ***
************
areg mrate_male `three' `three_l1' `three_l2' `precip' i.month#i.year i.state_fips#i.year [aw=pop_male_weights], absorb(fips_month) vce(cluster fips)
//
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

matrix m2 = (`holder')
matrix list m2


************
** 3-lag ***
************
areg mrate_male `three' `three_l1' `three_l2' `three_l3' `precip'  i.month#i.year i.state_fips#i.year [aw=pop_male_weights], absorb(fips_month) vce(cluster fips)
//
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

timer off 2
timer list 2

matrix m3 = (`holder')
matrix list m3


**********************************************
** Combining matrices and saving it as dta ***
**********************************************
matrix m = m, m1, m2, m3
matrix list m
svmat m

gen x1 = _n 
replace x1 = . if x1 >10

keep m1-m16 x1

local path_int /home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
saveold "`path_int'figures_lags_male", replace version(12)


**********************************
************  Female  ************
**********************************


********* Preliminaries path and insheet *********
*local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
*local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
*local path_intermediate /home/aviaene/Viaene_MortalityHospAdmBrazil/Analysis/Data/Intermediate/
*set matsize 500
*use "`path_intermediate'merged_monthly_97_09.dta", clear
*xtset fips_month year
use "/home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Intermediate/merged_monthly_97_09.dta"


********* locals temp and precip *********
* 3-bins, lags and leads
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local three_2 tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local three_l1 l1_tavg_bin_0C_10C_ l1_tavg_bin_10C_13C_ l1_tavg_bin_13C_16C_ l1_tavg_bin_16C_19C_ l1_tavg_bin_19C_22C_ l1_tavg_bin_25C_28C_ l1_tavg_bin_28C_31C_ l1_tavg_bin_31C_Inf_
local three_l2 l2_tavg_bin_0C_10C_ l2_tavg_bin_10C_13C_ l2_tavg_bin_13C_16C_ l2_tavg_bin_16C_19C_ l2_tavg_bin_19C_22C_ l2_tavg_bin_25C_28C_ l2_tavg_bin_28C_31C_ l2_tavg_bin_31C_Inf_
local three_l3 l3_tavg_bin_0C_10C_ l3_tavg_bin_10C_13C_ l3_tavg_bin_13C_16C_ l3_tavg_bin_16C_19C_ l3_tavg_bin_19C_22C_ l3_tavg_bin_25C_28C_ l3_tavg_bin_28C_31C_ l3_tavg_bin_31C_Inf_

local precip precip_ precip_sq

local three_f1 f1_tavg_bin_0C_10C_ f1_tavg_bin_10C_13C_ f1_tavg_bin_13C_16C_ f1_tavg_bin_16C_19C_ f1_tavg_bin_19C_22C_ f1_tavg_bin_25C_28C_ f1_tavg_bin_28C_31C_ f1_tavg_bin_31C_Inf_
local three_f2 f2_tavg_bin_0C_10C_ f2_tavg_bin_10C_13C_ f2_tavg_bin_13C_16C_ f2_tavg_bin_16C_19C_ f2_tavg_bin_19C_22C_ f2_tavg_bin_25C_28C_ f2_tavg_bin_28C_31C_ f2_tavg_bin_31C_Inf_
local three_f3 f3_tavg_bin_0C_10C_ f3_tavg_bin_10C_13C_ f3_tavg_bin_13C_16C_ f3_tavg_bin_16C_19C_ f3_tavg_bin_19C_22C_ f3_tavg_bin_25C_28C_ f3_tavg_bin_28C_31C_ f3_tavg_bin_31C_Inf_
// Table Preliminaries
local name monthly_three_fun
local title Impact of Temperature on Mortality in Brazil; Omitted bin is 22-25C
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_

timer on 1
timer on 2
**********************
** start
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
*reg mrate_male `three'
areg mrate_female `three' `precip' i.month#i.year i.state_fips#i.year [aw=pop_female_weights], absorb(fips_month) vce(cluster fips)

timer off 1
timer list 1

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
matrix f = (`holder')
matrix list f

************
** 1-lag ***
************
areg mrate_female `three' `three_l1' `precip'  i.month#i.year i.state_fips#i.year [aw=pop_female_weights], absorb(fips_month) vce(cluster fips)
//
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
matrix f1 = (`holder')
matrix list f1


************
** 2-lag ***
************
areg mrate_female `three' `three_l1' `three_l2' `precip' i.month#i.year i.state_fips#i.year [aw=pop_female_weights], absorb(fips_month) vce(cluster fips)
//
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

matrix f2 = (`holder')
matrix list f2


************
** 3-lag ***
************
areg mrate_female `three' `three_l1' `three_l2' `three_l3' `precip'  i.month#i.year i.state_fips#i.year [aw=pop_female_weights], absorb(fips_month) vce(cluster fips)
//
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

timer off 2
timer list 2

matrix f3 = (`holder')
matrix list f3


**********************************************
** Combining matrices and saving it as dta ***
**********************************************
matrix f = f, f1, f2, f3
matrix list f
svmat f

gen x1 = _n 
replace x1 = . if x1 >10

keep f1-f16 x1

local path_int /home/aviaene/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
saveold "`path_int'figures_lags_female", replace version(12)


*** close the log file
log off


