
/* 
* File: table1_fixed_effects_meeting.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)

Objective: The objective of this program is to create the results and tables for the total mortality rates for Brazil on a monthly
level given fixed effects

*/

***********************************************************************************
********* DIFFERENT FIXED EFFECTS ON MUNICIPALITY LEVEL ***************************
***********************************************************************************

********* Preliminaries path and insheet *********
local path_raw /Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/
set matsize 5000
// insheet
use "`path_intermediate'merged_monthly_97_09", clear

gen fips_state_string=string(fips)
gen fips_state=substr(fips_state_string,1,1) // another command is replace fips_state = regexs(0) if(regexm(fips_state_string, "[0-9]"))
destring fips_state, replace
order fips_state fips


*graph bar tavg_bin_0C_1C_ - tavg_bin_35C_Inf_ if year == 2009 , legend(off)
*graph bar tavg_bin_0C_1C_ - tavg_bin_35C_Inf_ if year == 2009, legend(off)


*  by(fips_state) 
// Setting panel variable
*xtset fips_month year

************************************************************
******** 
************************************************************

********* locals temp and precip *********
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local precip precip_ precip_sq
local three2 tavg_bin_0C_09C_ tavg_bin_09C_12C_ tavg_bin_12C_15C_ tavg_bin_15C_18C_ tavg_bin_18C_21C_ tavg_bin_21C_24C_ tavg_bin_24C_27C_ tavg_bin_27C_30C_ tavg_bin_30C_Inf_ 
local precip precip_ precip_sq

** TO ADD: local age_fe "age_pro_pop_0000_ age_pro_pop_4070_ age_pro_pop_70Inf_"

// Table Preliminaries
local name monthly_fe_pres
local title Impact of Temperature on Mortality in Brazil; Omitted bin is 22-25C
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local cluster state_fips
** local name_cluster State // to test 

** Reg - County*Month 

** Required
// 1. No fixed effects
// 2. Unit & year fixed effects
// 3. Unit & year & month fixed effects
// 4. Unit*month and year FE
// 5. Unit*year & month FE
// 6. Unit*year & unit month
// 7. unit*month, state*month*year FE

// 1. No FE
reg mrate_tot `three' `precip' [aw=pop_tot_weights], vce(cluster state_fips) 
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) replace ctitle("c1") drop(`precip') auto(2) label ///
	addtext(County, - , Year, - , Month, - , County-Year, - , County-Month, - , County-Month, "X", Month-Year, - , State-Year, - , State-Month-Year, - , Cluster, State) 

// 2. Unit & year fixed effects
reghdfe mrate_tot `three' `precip' [aw=pop_tot_weights], absorb(fips year) cluster(state_fips) 
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("c2") drop(`precip') auto(2) label ///
	addtext(County, "X" , Year, "X", Month, - , County-Year, - , County-Month, - , County-Month, - , Month-Year, - , State-Year, - , State-Month-Year, - , Cluster, State) 

// 3. Unit & year & month fixed effects
reghdfe mrate_tot `three' `precip' [aw=pop_tot_weights], absorb(fips month year) cluster(state_fips) 
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("c3") drop(`precip') auto(2) label ///
	addtext(County, "X" , Year, "X" , Month, "X" , County-Year, - , County-Month, - , Month-Year, - , State-Year, - , State-Month-Year, - , Cluster, State) 

// 4. Unit*month and year FE
reghdfe mrate_tot `three' `precip' [aw=pop_tot_weights], absorb(fips_month year) cluster(state_fips) 
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("c4") drop(`precip') auto(2) label ///
	addtext(County, - , Year, "X" , Month, - , County-Year, - , County-Month, "X" , Month-Year, - , State-Year, - , State-Month-Year, - , Cluster, State) 

// 5. Unit*year and month FE
reghdfe mrate_tot `three' `precip' [aw=pop_tot_weights], absorb(fips#year year) cluster(state_fips) 
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("c5") drop(`precip') auto(2) label ///
	addtext(County, - , Year, - , Month, "X", County-Year, "X" , County-Month, - , Month-Year, - , State-Year, - , State-Month-Year, - , Cluster, State) 

// 6. Unit*year & unit*month
reghdfe mrate_tot `three' `precip' [aw=pop_tot_weights], absorb(fips#year fips_month) cluster(state_fips) 
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("c6") drop(`precip') auto(2) label ///
	addtext(County, - , Year, - , Month, - , County-Year, "X" , County-Month, "X" , Month-Year, - , State-Year, - , State-Month-Year, - , Cluster, State) 

// 7. unit*month, state*month state-year (extra!)
reghdfe mrate_tot `three' `precip' [aw=pop_tot_weights], absorb(fips_month year#month state_fips#year) cluster(state_fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("c7") drop(`precip') auto(2) label ///
	addtext(County, - , Year, - , Month, - , County-Year, - , County-Month, "X" , Month-Year, "X" , State-Year, "X" , State-Month-Year, - , Cluster, State) 

// 8. (7.) unit*month, state*month*year FE
reghdfe mrate_tot `three' `precip' [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(state_fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("c8") drop(`precip') auto(2) label ///
	addtext(County, - , Year, - , Month, - , County-Year, - , County-Month, "X" , Month-Year, - , State-Year, - , State-Month-Year, "X" , Cluster, State) 



********************************************************************************************************
** /// Climate Calculations: Using the terciles from the average yearly temperature, averaged over the last 15 years for each count ****
********************************************************************************************************

/// Climate Calculations: Using the terciles from the average yearly temperature, averaged over the last 15 years for each count
/// Then I  break this up into terciles

********* Preliminaries path and insheet *********
local path_raw /Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/
set matsize 5000
// insheet
use "`path_intermediate'merged_monthly_97_09", clear

// Setting panel variable
*xtset fips_month year

********* locals temp and precip *********
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local precip precip_ precip_sq
local three2 tavg_bin_0C_09C_ tavg_bin_09C_12C_ tavg_bin_12C_15C_ tavg_bin_15C_18C_ tavg_bin_18C_21C_ tavg_bin_21C_24C_ tavg_bin_24C_27C_ tavg_bin_27C_30C_ tavg_bin_30C_Inf_ 
local precip precip_ precip_sq

// Table Preliminaries
local name monthly_fe_pres_climate
local title Impact of Temperature on Mortality in Brazil; Omitted bin is 22-25C
local three tavg_bin_0C_10C_ tavg_bin_10C_13C_ tavg_bin_13C_16C_ tavg_bin_16C_19C_ tavg_bin_19C_22C_ tavg_bin_25C_28C_ tavg_bin_28C_31C_ tavg_bin_31C_Inf_
local cluster state_fips
** local name_cluster State // to test 

// 8. (7.) unit*month, state*month*year FE
reghdfe mrate_tot `three' if tercile==1 [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(state_fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) replace ctitle("cold") drop(`precip') auto(2) label ///
	addtext(County, - , Year, - , Month, - , County-Year, - , County-Month, "X" , Month-Year, - , State-Year, - , State-Month-Year, "X" , Cluster, State) 

reghdfe mrate_tot `three' if tercile==2 [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(state_fips) 
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("medium") drop(`precip') auto(2) label ///
	addtext(County, - , Year, - , Month, - , County-Year, - , County-Month, "X" , Month-Year, - , State-Year, - , State-Month-Year, "X" , Cluster, State) 

reghdfe mrate_tot `three' if tercile==3 [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(state_fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("hot") drop(`precip') auto(2) label ///
	addtext(County, - , Year, - , Month, - , County-Year, - , County-Month, "X" , Month-Year, - , State-Year, - , State-Month-Year, "X" , Cluster, State) 



********************************************************************************************************
********************************************************************************************************




/*


reghdfe mrate_tot `three' `precip' [aw=pop_tot_weights], absorb(fips_month year) cluster(state_fips) 
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) replace ctitle("c1") drop(`precip') auto(2) label ///
	addtext(County-Month, "X", Month-Year, - , State-Year, - , State-Month-Year, - , Cluster, State) 

// 
** Reg - County*Month Month*Year 
reghdfe mrate_tot `three' [aw=pop_tot_weights], absorb(fips_month year#month) cluster(state_fips) 
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("c2") drop(`precip') auto(2) label ///
	 addtext(County-Month, "X", Month-Year, "X", State-Year, - , State-Month-Year, - , Cluster, State) 

// 8. Unit-month, year-month and state-year FE
** Reg - County*Month Month*Year State*Year 
reghdfe mrate_tot `three' [aw=pop_tot_weights], absorb(fips_month year#month state_fips#year) cluster(state_fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("c3") drop(`precip') auto(2) label /// 
	 addtext(County-Month, "X", Month-Year, "X", State-Year, "X", State-Month-Year, - , Cluster, State) 

// 7. unit*month, state*month*year FE
** Reg - County*Month State*Month*Year
reghdfe mrate_tot `three' [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(state_fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("c4") drop(`precip') auto(2)label ///
	addtext(County-Month, "X", Month-Year, - , State-Year, - , State-Month-Year, "X", Cluster, State) 

******************************************
local path_raw /Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/
set matsize 5000
// insheet
use "`path_intermediate'merged_monthly_97_09", clear
**
local precip precip_ precip_sq
local name monthly_three_fesp2
local title Impact of Temperature on Mortality in Brazil; Omitted bin is 21-24C
local three2 tavg_bin_0C_09C_ tavg_bin_09C_12C_ tavg_bin_12C_15C_ tavg_bin_15C_18C_ tavg_bin_18C_21C_ tavg_bin_21C_24C_ tavg_bin_24C_27C_ tavg_bin_27C_30C_ tavg_bin_30C_Inf_ 


** Reg - County*Month 
reghdfe mrate_tot `three2' `precip' [aw=pop_tot_weights], absorb(fips_month year) cluster(state_fips) 
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) replace ctitle("c1") drop(`precip') auto(2) label ///
	addtext(County-Month, "X", Month-Year, - , State-Year, - , State-Month-Year, - , Cluster, State) 
** Reg - County*Month Month*Year 
reghdfe mrate_tot `three2' [aw=pop_tot_weights], absorb(fips_month year#month) cluster(state_fips) 
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("c2") drop(`precip') auto(2) label ///
	 addtext(County-Month, "X", Month-Year, "X", State-Year, - , State-Month-Year, - , Cluster, State) 

** Reg - County*Month Month*Year State*Year 
reghdfe mrate_tot `three2' [aw=pop_tot_weights], absorb(fips_month year#month state_fips#year) cluster(state_fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("c3") drop(`precip') auto(2) label /// 
	 addtext(County-Month, "X", Month-Year, "X", State-Year, "X", State-Month-Year, - , Cluster, State) 

** Reg - County*Month State*Month*Year
reghdfe mrate_tot `three2' [aw=pop_tot_weights], absorb(fips_month year#month#state_fips) cluster(state_fips)
outreg2 using "/Users/arvidviaene/Dropbox/2 Mortality/Results/Tables/`name'.text" ///
	, tex(frag) append ctitle("c4") drop(`precip') auto(2)label ///
	addtext(County-Month, "X", Month-Year, - , State-Year, - , State-Month-Year, "X", Cluster, State) 


******************************************

** Reg - County*Month Month*Year State-time trend

/*
local coefplot_commands `"vertical offset(0) recast(connected) lwidth(*2) fcolor(*.5) ciopts(recast(rconnected) lp(dash)) omitted graphregion(color(white))"'
local bins3lab `"1 "0-10" 2 "10_13" 3 "13_16" 4 "16_19" 5 "19_22" 6 "22_25" 7 "25_28" 8 "28_31" 9 "31+_""'

eststo hfp_y: areg mrate_tot `three' i.year#i.month [aw=pop_tot_weights], absorb(fips_month)
coefplot (hfp_y), xtitle(Days in Temperature Bin (C)) ytitle("Daily admissions per 100,000 population" "(as % of mean)") keep(tavg_bin_0C_10C_-tavg_bin_31C_Inf_ precip_popt2) xlab(`bins3lab')  `coef_commands'
* not used : rescale(`mean')
 
