
/* 
* File: table1_fixed_effects.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)


Objective: The objective of this program is to create a table for the total mortality rate under fixed effecs
*/

***********************************************************************************

********* Preliminaries path and insheet *********
local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
set matsize 5000
// insheet
use "`path_intermediate'merged_monthly_97_09", clear

// Setting panel variable
*xtset fips_month year

********* locals temp and precip *********
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local precip precip_ precip_sq

// Table Preliminaries
local name monthly_rural
local title Impact of Temperature on Mortality in Brazil; Omitted bin is 22-25C
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_

** Reg - County*Month State*Month*Year
reghdfe mrate_tot `three' `precip' if shares_rural_ > 0.75 [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) replace ctitle(">0.75") title("Rural vs Urban") drop(`precip') auto(2)label /// 
	addtext(County-Month, "X", Month-Year, - , State-Year, - , State-Month-Year, "X", Cluster, County) 

reghdfe mrate_tot `three' `precip' if shares_rural_>0.5 & shares_rural_<0.75 [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("0.5-0.75") drop(`precip') auto(2)label ///
	addtext(County-Month, "X", Month-Year, - , State-Year, - , State-Month-Year, "X", Cluster, County) 

reghdfe mrate_tot `three' `precip' if shares_rural_<0.5 [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("<0.5") drop(`precip') auto(2)label ///
	addtext(County-Month, "X", Month-Year, - , State-Year, - , State-Month-Year, "X", Cluster, County) 
	
*******************
********* Preliminaries path and insheet *********
local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
set matsize 5000
// insheet
use "`path_intermediate'merged_monthly_97_09", clear

// Setting panel variable
*xtset fips_month year

********* locals temp and precip *********
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local precip precip_ precip_sq

// Table Preliminaries
local name monthly_climate
local title Impact of Temperature on Mortality in Brazil; Omitted bin is 22-25C
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_

** Reg - County*Month State*Month*Year
reghdfe mrate_tot `three' `precip' if tercile == 1  [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) replace ctitle("Coldest tercile") title("Rural vs Urban") drop(`precip') auto(2)label /// 
	addtext(County-Month, "X", Month-Year, - , State-Year, - , State-Month-Year, "X", Cluster, County) 

reghdfe mrate_tot `three' `precip' if tercile == 2 [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("Intermediate Tercile") drop(`precip') auto(2)label ///
	addtext(County-Month, "X", Month-Year, - , State-Year, - , State-Month-Year, "X", Cluster, County) 

reghdfe mrate_tot `three' `precip' if tercile == 3 [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("Warmest Tercile") drop(`precip') auto(2)label ///
	addtext(County-Month, "X", Month-Year, - , State-Year, - , State-Month-Year, "X", Cluster, County) 
	
/*
	reg mrate_tot `three' `precip' if shares_rural_>0.75, robust
reg mrate_tot `three' `precip' if shares_rural_>0.25 & shares_rural_<0.75, robust
reg mrate_tot `three' `precip' if shares_rural_<0.25, robust



