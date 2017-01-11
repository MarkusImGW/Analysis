***********************************************************************************

* File: merge_pop_betweenyears.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)
/* 
Objective: The objective of this program is to create a balanced panel for 2000-2010 and identify the municipalities that did not get matched


Structure:
*/

***********************************************************************************

********* Preliminaries *********
local path_raw "/Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/Data/Population_age/"
local path_intermediate "/Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/"

********* Requirements *********
/*
- 2000-2009 population data, seperated by fips which is a unique identifier
 First, generate the data for population through data-insheet
 - can obtain this from? 
*/


********* MERGERS *********

// setting up the baseline file
use "`path_intermediate'pop_tot_allage_2009" , clear

/* TEST THIS CODE TO GET male, female and total population
local gender "tot male female"
foreach var of local gender{
foreach t in `year'{
di `t'
merge 1:1 fips using "`path_intermediate'pop_`var'_allage_`t'"
*drop if _merge == 1 | _merge == 2
*drop _merge
rename _merge merge_`var'_`t'
}
}
drop *_unkown*
*/

************************************
// Merging in the Population file
************************************
********* Merge from 1997, 1996 has a lot of changes *********
local year 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 
** start with 2009

foreach t in `year'{
di `t'
merge 1:1 fips using "`path_intermediate'pop_tot_allage_`t'"
rename _merge merge_`t'
}

************************************
// Merging in the Mortality file
************************************

merge 1:1 fips using "`path_intermediate'mort_mun_tmf_allage_97_10"
drop if _merge == 1 |_merge == 2
drop _merge id_municipality merge_* pop_tot_unkown_*
** still 5,565 observations left

reshape long pop_tot_00_01_ pop_tot_01_04_ pop_tot_05_09_ pop_tot_10_14_ pop_tot_15_19_ pop_tot_20_29_ pop_tot_30_39_ pop_tot_40_49_ pop_tot_50_59_ pop_tot_60_69_ pop_tot_70_79_ pop_tot_80_inf_ pop_tot_unkown_ pop_tot_total_ ///
mort_tot_total_ mort_tot_00_01_ mort_tot_01_04_ mort_tot_05_09_ mort_tot_10_14_ mort_tot_15_19_ mort_tot_20_24_ mort_tot_25_29_ mort_tot_30_34_ mort_tot_35_39_ mort_tot_40_44_ mort_tot_45_49_ mort_tot_50_54_ mort_tot_55_59_ mort_tot_60_64_ mort_tot_65_69_ mort_tot_70_74_ mort_tot_75_79_ mort_tot_80_110_ mort_tot_22_ ///
mort_male_total_ mort_male_00_01_ mort_male_01_04_ mort_male_05_09_ mort_male_10_14_ mort_male_15_19_ mort_male_20_24_ mort_male_25_29_ mort_male_30_34_ mort_male_35_39_ mort_male_40_44_ mort_male_45_49_ mort_male_50_54_ mort_male_55_59_ mort_male_60_64_ mort_male_65_69_ mort_male_70_74_ mort_male_75_79_ mort_male_80_110_ mort_male_22_ ///
mort_female_total_ mort_female_00_01_ mort_female_01_04_ mort_female_05_09_ mort_female_10_14_ mort_female_15_19_ mort_female_20_24_ mort_female_25_29_ mort_female_30_34_ mort_female_35_39_ mort_female_40_44_ mort_female_45_49_ mort_female_50_54_ mort_female_55_59_ mort_female_60_64_ mort_female_65_69_ mort_female_70_74_ mort_female_75_79_ mort_female_80_110_ mort_female_22_ ///
, i(fips) j(year)
// 77,910 observations

**********************************************************
// Merging in the Urban/Rural file & Creating Rural Shares
***********************************************************

merge 1:1 fips year using "`path_intermediate'rural_97_2012_yearly"
order fips year _merge
sort fips year _merge
tab _merge if year==2009 
** only 1 municipality not merged
drop if _merge == 1 |_merge == 2
drop _merge



// Creating the rural shares here - following the convention of 50% split
// is there such a convention? Ask; India data has classified, but here might be arbitrary

order year shares_rural_ fips 
sort year shares_rural_ // this variable is the percentage of people living in a rural area according to the town
// Note that the majority of brazilians lives in urban region, about 85%

egen rural_tercile = xtile(shares_rural_), by(year) n(3)
egen rural_tercile2 = xtile(shares_rural_), by(year) n(2)

** going forwards with rural_tercile2 means rural or urban
gen rural = 1 if rural_tercile2 == 2
replace rural = 0 if rural_tercile2 != 2
gen urban = 1 if rural_tercile2 == 1
replace urban = 0 if rural_tercile2 != 1
*hist shares_rural_


************************************
// Merging in the temperature file
************************************

*merge 1:1 fips year using "`path_intermediate'merged_climate_dataset_fips"
* order year climate tercile // the climate variable got created in the temperature data-set, create it again using averages
merge 1:1 fips year using "`path_intermediate'merged_climate_dataset_fips2_93"
order fips year _merge
sort fips year _merge
tab year _merge
// 5,445 observations got merged for the entire sample
// 62 from the master did not get merged
// 4 from the climate data
** the climate data goes until 2013 so all the 2011-2013 years did not get matched
// only for "master only" does it not go until 2013
// also before 1997 does not get matched
drop if _merge == 1 |_merge == 2
drop if year == 2010

ds
destring fips, replace

xtset fips year

** unbalanced:
** There are two unmerged variables: the ones from the master file, and the ones from using
** but within using, there are the unmatched, and the other years
** just proceed as is with the lags and leads, and then drop the ones that did not got matched using _merge
******


ds
destring `r(varlist)', replace
// dropping the ones with - ? Why not replace with zero? These municipalities don't have any population data
sort pop_tot_00_01 year
order pop_tot_00_01 year
// Very dangereous line drop if pop_tot_00_01_=="" | pop_tot_00_01_=="-" 
replace pop_tot_00_01_ = "0" if pop_tot_00_01_=="" | pop_tot_00_01_=="-" 
destring pop_tot_00_01_, replace


***************************************************
******** Creating MORTALITY BINS AND RATES ********
***************************************************
// Creating total
gen mrate_tot_total_ = 100000*mort_tot_total_/pop_tot_total_
gen lmrate_tot_total_ = log(mrate_tot_total_)
order mrate_tot_total_
sort mrate_tot_total_ municipality


// Replace . with 0 
local gender "tot male female"
local years 00_01_ 01_04_ 05_09_ 10_14_ 15_19_ 20_24_ 25_29_ 30_34_ 35_39_ 40_44_ 45_49_ 50_54_ 55_59_ 60_64_ 65_69_ 70_74_ 75_79_ 80_110_
foreach y of local gender{
foreach x of local years {
                display "`x'"
replace mort_`y'_`x' = 0 if mort_`y'_`x'==.
}
}

*** If I have inserted male and female population, foreach loop goes here
*foreach var of local gender {  end of loop here}
* // replace tot with `var'

*************************************************************
********** Creating Mortality&Pop Age categories ************
*************************************************************


// Creating the mortality bins by 10 years, with a special bin for early deaths and 80+
gen mort_tot_01_10_ = mort_tot_01_04_ + mort_tot_05_09_
gen mort_tot_10_19_ = mort_tot_10_14_ + mort_tot_15_19_
gen mort_tot_20_29_ = mort_tot_20_24_ + mort_tot_25_29_
gen mort_tot_30_39_ = mort_tot_30_34_ + mort_tot_35_39_
gen mort_tot_40_49_ = mort_tot_40_44_ + mort_tot_45_49_
gen mort_tot_50_59_ = mort_tot_50_54_ + mort_tot_55_59_
gen mort_tot_60_69_ = mort_tot_60_64_ + mort_tot_65_69_
gen mort_tot_70_79_ = mort_tot_70_74_ + mort_tot_75_79_
// creating mortality bins for 20 years
gen mort_tot_01_19_ = mort_tot_00_01_ + mort_tot_01_04_ + mort_tot_05_09_ +mort_tot_10_14_ + mort_tot_15_19_
gen mort_tot_20_39_ = mort_tot_20_24_ + mort_tot_25_29_ + mort_tot_30_34_ + mort_tot_35_39_
gen mort_tot_40_59_ = mort_tot_40_44_ + mort_tot_45_49_ + mort_tot_50_54_ + mort_tot_55_59_ 
gen mort_tot_60_79_ = mort_tot_60_64_ + mort_tot_65_69_ +  mort_tot_70_74_ + mort_tot_75_79_

// Creating 10 year bins for population for 1 to 20
gen pop_tot_01_10_ = pop_tot_01_04_ + pop_tot_05_09_
gen pop_tot_10_19_ = pop_tot_10_14_ + pop_tot_15_19_
gen pop_tot_80_110_ = pop_tot_80_inf

// Creating 20 year bins for populatiom
gen pop_tot_01_19_ = pop_tot_00_01_ + pop_tot_01_04_ + pop_tot_05_09_ +pop_tot_10_14_ + pop_tot_15_19_
gen pop_tot_20_39_ = pop_tot_20_29_ + pop_tot_30_39_
gen pop_tot_40_59_ = pop_tot_40_49_ + pop_tot_50_59_ 
gen pop_tot_60_79_ = pop_tot_60_69_ +  pop_tot_70_79_

** creating the Proportions for Age for regressions
gen pop_4070 = pop_tot_40_49_ + pop_tot_50_59_ + pop_tot_60_69_
gen pop_70Inf_ = pop_tot_70_79_ + pop_tot_80_110_
gen pop_0140_ = pop_tot_01_04_ + pop_tot_05_09_ +pop_tot_10_14_ + pop_tot_15_19_ + pop_tot_20_29_ + pop_tot_30_39_

gen age_pro_pop_0000_ = pop_tot_00_01_/pop_tot_total_
gen age_pro_pop_4070_ = pop_4070/pop_tot_total_
gen age_pro_pop_70Inf_= pop_70Inf_/pop_tot_total_
gen age_pro_pop_0140_= pop_0140_/pop_tot_total_

** ordering and summing to check that all proportions sum to one
order age_pro_pop_0000_ age_pro_pop_0140_ age_pro_pop_4070_ age_pro_pop_70Inf_
egen age_pro_sum = rowtotal(age_pro_pop_0000_ - age_pro_pop_70Inf_)

** order age_pro_sum // sort age_pro_sum // sum age_pro_sum

*hist age_pro_pop_4070_ if year == 2009 

// Create mortality rates for each age category
local years_ten "00_01_ 01_10_ 10_19_ 20_29_ 30_39_ 40_49_ 50_59_ 60_69_ 70_79_  01_19_ 20_39_ 40_59_ 60_79_"
// the population count from 80 to inf is missing ; 80_110_
foreach var of local years_ten { 
gen mrate_tot_`var' = 100000*mort_tot_`var'/pop_tot_`var'
di "`var'"
}

*******************************************
********** Creating DD totals *************
*******************************************

egen DD_total = rowtotal(DD*)
egen DD0_total = rowtotal(DD0*)
egen DD5_total = rowtotal(DD5*)
egen DD10_total = rowtotal(DD10*)
egen DD15_total = rowtotal(DD15*)
egen DD20_total = rowtotal(DD20*)
egen DD25_total = rowtotal(DD25*)
egen DD30_total = rowtotal(DD30*)
sum DD_total DD0_total DD5_total DD10_total DD15_total DD20_total DD25_total DD30_total
* ok

*****************************************************
********** Creating Precipitation bins **************
*****************************************************


bysort year: egen pop_weights = total(pop_tot_total_)
replace pop_weights =  pop_tot_total_/pop_weights

** scale precipitation to yearly level
** Scaling precipitation upwards will adjust the coefficient downwars by the same scale
** degree days is useful to compare the results

replace precip_annual_pop = precip_annual_pop * 12

local var precip_annual_pop
foreach i of numlist 10(10)90{
bysort year: egen pct`i'= pctile(`var'), p(`i')
}
bysort year: egen pct0=min(`var')
bysort year: egen pct100=max(`var')

foreach i of numlist 0(10)90{
local j = `i' + 10
gen precip`i'_`j'= 0
replace precip`i'_`j' = 1 if `var'>pct`i' & `var'<=pct`j'
}


************************************************************************
************************************************************************

**** IMPORTANT DELETION OF VARIABLES **** KEEP REGRESSION RELEVANT VARIABLES *****
keep _merge mrate_* mort_tot_00_01_ pop_tot_00_01_ pop_weights precip* fips state_fips ///
year mrate_tot_total_ mrate_tot_total_ pop_tot_total_ *annual_pop shares_rural_ /// 
rural* urban* age_pro_pop_0000_ age_pro_pop_0140_ age_pro_pop_4070_ age_pro_pop_70Inf_
drop m_*
*order precip* state_fips tavg_*  fips year mrate_tot_total mrate_tot_total pop_tot_total 
*order precip* fips state_fips year mrate_tot_total mrate_tot_total pop_tot_total *annual_pop 

local bin_ordering
foreach i of numlist 0(1)34{
local j = `i' + 1
local bin_ordering "`bin_ordering' tavg_bin_`i'C_`j'C_"
}
local bin_ordering "`bin_ordering' tavg_bin_35C_Inf_"
*di "`bin_ordering'"
order `bin_ordering'

***************************************************************
************** Creating yearly values for the regressions *****
***************************************************************
egen tavg_bin_total = rowtotal(tavg_bin_0C_1C_annual_pop -  tavg_bin_35C_Inf_annual_pop)
drop if tavg_bin_total <29
*sum tavg_bin_total
*gen dummy_days = 1 if tavg_bin_total < 29

foreach vv of var tavg_bin_0C_1C_annual_pop -  tavg_bin_35C_Inf_annual_pop  {
	replace `vv' = `vv'*12
}

***************************************************************
************** Creating the 5 and 3 year bins *****
***************************************************************


egen tavg_bin_0C_5C_annual_pop = rowtotal(tavg_bin_0C_1C_annual_pop-tavg_bin_4C_5C_annual_pop)
egen tavg_bin_5C_10C_annual_pop = rowtotal(tavg_bin_5C_6C_annual_pop-tavg_bin_9C_10C_annual_pop)
egen tavg_bin_10C_15C_annual_pop = rowtotal(tavg_bin_10C_11C_annual_pop-tavg_bin_14C_15C_annual_pop)
egen tavg_bin_15C_20C_annual_pop = rowtotal(tavg_bin_15C_16C_annual_pop-tavg_bin_19C_20C_annual_pop)
egen tavg_bin_20C_25C_annual_pop = rowtotal(tavg_bin_20C_21C_annual_pop-tavg_bin_24C_25C_annual_pop)
egen tavg_bin_25C_30C_annual_pop = rowtotal(tavg_bin_25C_26C_annual_pop-tavg_bin_29C_30C_annual_pop)
egen tavg_bin_30C_35C_annual_pop = rowtotal(tavg_bin_30C_31C_annual_pop-tavg_bin_35C_Inf_annual_pop)
egen tavg_bin_0C_10C_annual_pop = rowtotal(tavg_bin_0C_1C_annual_pop-tavg_bin_9C_10C_annual_pop)

// 3 degree bins, with 0-12
egen tavg_bin_0C_13C_annual_pop = rowtotal(tavg_bin_0C_1C_annual_pop-tavg_bin_12C_13C_annual_pop)
egen tavg_bin_10C_13C_annual_pop = rowtotal(tavg_bin_10C_11C_annual_pop-tavg_bin_12C_13C_annual_pop)
egen tavg_bin_13C_16C_annual_pop = rowtotal(tavg_bin_13C_14C_annual_pop-tavg_bin_15C_16C_annual_pop)
egen tavg_bin_16C_19C_annual_pop = rowtotal(tavg_bin_16C_17C_annual_pop-tavg_bin_18C_19C_annual_pop)
egen tavg_bin_19C_22C_annual_pop = rowtotal(tavg_bin_19C_20C_annual_pop-tavg_bin_21C_22C_annual_pop)
egen tavg_bin_22C_25C_annual_pop = rowtotal(tavg_bin_22C_23C_annual_pop-tavg_bin_24C_25C_annual_pop)
egen tavg_bin_25C_28C_annual_pop = rowtotal(tavg_bin_25C_26C_annual_pop-tavg_bin_27C_28C_annual_pop)
egen tavg_bin_28C_31C_annual_pop = rowtotal(tavg_bin_28C_29C_annual_pop-tavg_bin_30C_31C_annual_pop)
egen tavg_bin_31C_Inf_annual_pop = rowtotal(tavg_bin_31C_32C_annual_pop-tavg_bin_35C_Inf_annual_pop)
egen tavg_bin_28C_Inf_annual_pop = rowtotal(tavg_bin_28C_29C_annual_pop-tavg_bin_35C_Inf_annual_pop)
egen tavg_bin_0C_16C_annual_pop = rowtotal(tavg_bin_0C_1C_annual_pop-tavg_bin_15C_16C_annual_pop)

label variable tavg_bin_0C_10C_annual_pop "0C to 10C"
label variable tavg_bin_10C_13C_annual_pop "10C to 13C"
label variable tavg_bin_13C_16C_annual_pop "13C to 16C"
label variable tavg_bin_16C_19C_annual_pop "16C to 19C"
label variable tavg_bin_19C_22C_annual_pop "19C to 22C"
label variable tavg_bin_22C_25C_annual_pop "22C to 25C"
label variable tavg_bin_25C_28C_annual_pop "25C to 28C"
label variable tavg_bin_28C_31C_annual_pop "28C to 31C"
label variable tavg_bin_31C_Inf_annual_pop "31C to Inf"
label variable tavg_bin_0C_13C_annual_pop "0C to 13C"
label variable tavg_bin_28C_Inf_annual_pop "28C+"

*************************************************************
************** Creating the lags and the leads **************
*************************************************************


sort fips year
local bins tavg_bin_0C_13C_annual_pop tavg_bin_0C_16C_annual_pop tavg_bin_28C_Inf_annual_pop tavg_bin_0C_10C_annual_pop tavg_bin_10C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_31C_annual_pop tavg_bin_31C_Inf_annual_pop
foreach i of numlist 1(1)4{
foreach var of local bins {
gen l`i'_`var' = l`i'.`var'
gen f`i'_`var' = f`i'.`var'
}
}

* order tavg_bin_19C_22C_annual_pop l4_tavg_bin_19C_22C_annual_pop f4_tavg_bin_19C_22C_annual_pop
* test is good

order fips year _merge
sort fips year _merge

** order tavg_bin_0C_13C_ l1_tavg_bin_0C_13C_
// unit test works => the fips finds the municipalities that are the same even though they have a different name
// and the lag and lead take care of the rest

drop if year > 2009
drop if year < 1997
// dropping the lags and lead years
** now it works

** yes, 5,445 municipalities remaining

local path_raw /Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/



*********************************************
**** Creating the Climate Variables *****
*********************************************

************************
// Climate subdivision 1 - Ishan Style - Taking Modes
local three tavg_bin_0C_10C_annual_pop tavg_bin_10C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_22C_25C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_31C_annual_pop tavg_bin_31C_Inf_annual_pop
egen modetempdays = rowmax(`three')

gen modetempbin = 0
replace modetempbin = 5 if modetempdays == tavg_bin_0C_10C_annual_pop
replace modetempbin = 11.5 if modetempdays == tavg_bin_10C_13C_annual_pop
replace modetempbin = 14.5 if modetempdays == tavg_bin_13C_16C_annual_pop
replace modetempbin = 17.5 if modetempdays == tavg_bin_16C_19C_annual_pop
replace modetempbin = 20.5 if modetempdays == tavg_bin_19C_22C_annual_pop
replace modetempbin = 23.5 if modetempdays == tavg_bin_22C_25C_annual_pop
replace modetempbin = 26.5 if modetempdays == tavg_bin_25C_28C_annual_pop
replace modetempbin = 29.5 if modetempdays == tavg_bin_28C_31C_annual_pop
replace modetempbin = 33 if modetempdays == tavg_bin_31C_Inf_annual_pop

gen COLD = 0
replace COLD = 1 if modetempbin <23.5
gen MEDIUM = 0
replace MEDIUM =1 if modetempbin ==23.5
gen HOT =0
replace HOT = 1 if modetempbin >23.5

************************
// Climate subdivision 2 - Amir Style - Taking average of yearly temperatures over 13 years

*hist temp_annual_pop
*twoway kdensity temp_annual_pop if year == 2009 || kdensity temp_annual_pop if year == 2008 ||  ///
*kdensity temp_annual_pop if year == 2007 || kdensity temp_annual_pop if year == 2006 ||  kdensity temp_annual_pop if year == 2005

order temp_annual_pop fips year
by fips, sort: egen climate = mean(temp_annual_pop)
order climate

pctile climate_terciles = climate, nq(3) 
_pctile climate, nq(3) 
return list
scalar scalar1 = r(r1)
scalar scalar2 = r(r2)

gen climate_cold = 1 if climate <scalar1
replace climate_cold = 0 if climate >=scalar1
gen climate_medium = 1 if climate >= scalar1 & climate <= scalar2
replace climate_medium = 0 if climate < scalar1 | climate > scalar2
gen climate_hot = 1 if climate > scalar2
replace climate_hot = 0 if climate <= scalar2

egen sum = rowtotal(climate_hot climate_cold climate_medium)
tab sum

*********************************************
**** Creating the interaction variables *****
*********************************************

** local bins tavg_bin_0C_13C_annual_pop tavg_bin_13C_16C_annual_pop tavg_bin_16C_19C_annual_pop tavg_bin_19C_22C_annual_pop tavg_bin_25C_28C_annual_pop tavg_bin_28C_Inf_annual_pop 

order rural urban MEDIUM COLD HOT bin_0C_13C bin_13C_16C bin_16C_19C bin_19C_22C bin_22C_25C bin_25C_28C bin_28C_Inf
***************************
// Generating new bin names 
***************************
local bins 0C_13C 13C_16C 16C_19C 19C_22C 22C_25C 25C_28C 28C_Inf
foreach i of local bins{
	gen bin_`i' = tavg_bin_`i'_annual_pop
}

***************************
//  Interactions between temperatures and climate
***************************

local bins bin_0C_13C bin_13C_16C bin_16C_19C bin_19C_22C bin_22C_25C bin_25C_28C bin_28C_Inf
local climate COLD MEDIUM HOT
** local climate2 climate_cold climate_medium climate_hot

foreach i of local bins{
	foreach j of local climate{
	di "`i'_`j'"
	gen `i'_`j'=`i'*`j'
	}
}

***************************
//  Interactions between temperatures and R/U
***************************

local bins bin_0C_13C bin_13C_16C bin_16C_19C bin_19C_22C bin_22C_25C bin_25C_28C bin_28C_Inf
order rural_ 
local ruralvar rural urban
foreach i of local bins{
	foreach j of local ruralvar{
	di "`i'_`j'"
	gen `i'_`j'=`i'*`j'
	}
}
***************************
// Interactions between TEMP - RU - CLIMATE
***************************
local bins bin_0C_13C bin_13C_16C bin_16C_19C bin_19C_22C bin_22C_25C bin_25C_28C bin_28C_Inf
local ruralvar rural urban
local climate COLD MEDIUM HOT

foreach i of local bins{
	foreach j of local ruralvar{
		foreach k of local climate{
		di "`i'_`j'_`k'"
		gen `i'_`j'_`k'=`i'*`j'*`k'
		}
	}	
}
*********** SAVING ***********

save "`path_intermediate'mort-pop_mun_tmf_allage_97_10", replace

