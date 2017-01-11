
/* 
table2_lagsleads
Objective: The objective of this program is to create a dataset for municipalities and brazil for the year 2009
for all categories

Structure:
1. Insheet all data and get ready for merge
2. Merge
3. Rename and change characters
4. Save
*/
***********************************************************************************

********* Preliminaries path and insheet *********
local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
set matsize 5000
// insheet
use "`path_intermediate'merged_monthly_97_09", clear
// Setting panel variable
xtset fips_month year

********* locals temp and precip *********
* 3-bins, lags and leads
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local three_l1 l1_tavg_bin_0C_10C_ l1_tavg_bin_10C_13C_ l1_tavg_bin_13C_16C_ l1_tavg_bin_16C_19C_ l1_tavg_bin_19C_22C_ l1_tavg_bin_25C_28C_ l1_tavg_bin_28C_31C_ l1_tavg_bin_31C_Inf_
local three_l2 l2_tavg_bin_0C_10C_ l2_tavg_bin_10C_13C_ l2_tavg_bin_13C_16C_ l2_tavg_bin_16C_19C_ l2_tavg_bin_19C_22C_ l2_tavg_bin_25C_28C_ l2_tavg_bin_28C_31C_ l2_tavg_bin_31C_Inf_
local three_l3 l3_tavg_bin_0C_10C_ l3_tavg_bin_10C_13C_ l3_tavg_bin_13C_16C_ l3_tavg_bin_16C_19C_ l3_tavg_bin_19C_22C_ l3_tavg_bin_25C_28C_ l3_tavg_bin_28C_31C_ l3_tavg_bin_31C_Inf_

local three_f1 f1_tavg_bin_0C_10C_ f1_tavg_bin_10C_13C_ f1_tavg_bin_13C_16C_ f1_tavg_bin_16C_19C_ f1_tavg_bin_19C_22C_ f1_tavg_bin_25C_28C_ f1_tavg_bin_28C_31C_ f1_tavg_bin_31C_Inf_
local three_f2 f2_tavg_bin_0C_10C_ f2_tavg_bin_10C_13C_ f2_tavg_bin_13C_16C_ f2_tavg_bin_16C_19C_ f2_tavg_bin_19C_22C_ f2_tavg_bin_25C_28C_ f2_tavg_bin_28C_31C_ f2_tavg_bin_31C_Inf_
local three_f3 f3_tavg_bin_0C_10C_ f3_tavg_bin_10C_13C_ f3_tavg_bin_13C_16C_ f3_tavg_bin_16C_19C_ f3_tavg_bin_19C_22C_ f3_tavg_bin_25C_28C_ f3_tavg_bin_28C_31C_ f3_tavg_bin_31C_Inf_

* Precip
* precip_2 precip_3 precip_4 precip_5 precip_6 precip_7 precip_8 precip_9 precip_10 precip_11 precip_12
* lag 1,2 and 3


** Reg 1 - County*Month
* areg mrate_tot `three' [aw=pop_tot_weights], absorb(fips_month)
*areg mrate_tot `three' i.year#i.month [aw=pop_tot_weights], absorb(fips_month) vce(cluster fips)
// This took five minutes too run; The coefficient on the upper bin became insignificant now, the rest remains highly significatn
*areg mrate_tot `three' `three_l1' `three_f1' i.year#i.month [aw=pop_tot_weights], absorb(fips_month) vce(cluster fips) // took another 5 minutes to run 
*nearly all lags are significant, and the 31_Inf goes up to -0.58, whic is really strong and significatn
** forward lag in this category is also very significant and negative. => Is this the harvesting phenomenon? but the forward one would not make much sense
areg mrate_tot `three' `three_l1' `three_l2' `three_l3' i.year#i.month [aw=pop_tot_weights], absorb(fips_month) vce(cluster fips)
