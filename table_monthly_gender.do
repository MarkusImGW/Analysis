
/* 
* File: table_monthly_gender.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)

Objective: The objective of this program is to create the table for the total, male and femal mortality rate for county-month and
state-month-year fixed effects
*/

***********************************************************************************

********* Preliminaries path and insheet *********
local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
set matsize 5000
// insheet
use "`path_intermediate'merged_monthly_97_09", clear

********* locals temp and precip *********

// Table Preliminaries
local name table_monthly_gender
local title Impact of Temperature on Mortality in Brazil; Omitted bin is 22-25C
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local precip precip_ precip_sq

** Reg - County*Month 
reghdfe mrate_tot `three' `precip' [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(fips) 
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) replace ctitle("total") drop(`precip') auto(2) label ///
	addtext(County-Month, "X", Month-Year, - , State-Year, - , State-Month-Year, X , Cluster, County ) 
** Reg - County*Month Month*Year 
reghdfe mrate_male `three' `precip' [aw=pop_male_weights], absorb(fips_month year#month#state_fips) cluster(fips) 
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("Male") drop(`precip') auto(2) label ///
	 addtext(County-Month, "X", Month-Year, -, State-Year, - , State-Month-Year, X , Cluster, County ) 

** Reg - County*Month Month*Year State*Year 
reghdfe mrate_female `three' `precip' [aw=pop_female_weights], absorb(fips_month year#month#state_fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append  ctitle("Female") drop(`precip') auto(2) label /// 
	 addtext(County-Month, "X", Month-Year, - , State-Year, - , State-Month-Year, X , Cluster, County ) 

************* DIFFERENT BEGIN AND END BINS
local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
set matsize 5000
// insheet
use "`path_intermediate'merged_monthly_97_09", clear

local name table2_monthly_g
local title Impact of Temperature on Mortality in Brazil; Omitted bin is 21-24C
local three2 tavg_bin_0C_09C_ tavg_bin_09C_12C_ tavg_bin_12C_15C_ tavg_bin_15C_18C_ tavg_bin_18C_21C_ tavg_bin_21C_24C_ tavg_bin_24C_27C_ tavg_bin_27C_30C_ tavg_bin_30C_Inf_ 
local precip precip_ precip_sq
**

** Reg - County*Month 
reghdfe mrate_tot `three2' `precip' [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(fips) 
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) replace ctitle("total") drop(`precip') auto(2) label ///
	addtext(County-Month, "X", Month-Year, - , State-Year, - , State-Month-Year, X , Cluster, County ) 
** Reg - County*Month Month*Year 
reghdfe mrate_male `three2' `precip' [aw=pop_male_weights], absorb(fips_month year#month#state_fips) cluster(fips) 
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("Male") drop(`precip') auto(2) label ///
	 addtext(County-Month, "X", Month-Year, -, State-Year, - , State-Month-Year, X , Cluster, County ) 

** Reg - County*Month Month*Year State*Year 
reghdfe mrate_female `three2' `precip' [aw=pop_female_weights], absorb(fips_month year#month#state_fips) cluster(fips)
outreg2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Tables/`name'.text" ///
	, tex(frag) append  ctitle("Female") drop(`precip') auto(2) label /// 
	 addtext(County-Month, "X", Month-Year, - , State-Year, - , State-Month-Year, X , Cluster, County ) 

