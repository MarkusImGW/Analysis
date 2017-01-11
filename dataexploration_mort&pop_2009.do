***********************************************************************************

* File: dataexploration_mort&pop_2009.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)
/* 
Objective: The objective of this program is to explore
- for different age groups
1) the population data in levels
2) the mortality data in levels
3) Merge and explore mortality rates; log(Mort/Pop*1000)

- for months in 2009 (new data-files needed)
1) the population data in levels
2) the mortality data in levels
3) Merge and explore mortality rates; log(Mort/Pop*1000)
4) Run fixed effects

- for years 2002-2010 and months
1) the population data in levels
2) the mortality data in levels
3) Merge and explore mortality rates; log(Mort/Pop*1000)
4) Run fixed effects

Structure:
1. Insheet all data and get ready for merge
2. Merge
3. Rename and change characters
4. Save
*/
***********************************************************************************

****** Preliminaries *****
global mypath  /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/

**************************
*** UNIT: BRAZIL - YEAR **
**************************
use "${mypath}mort_brazil_tmf_allage_2009", clear
drop mort_female_22 mort_male_22 mort_tot_22
drop mort_tot_total mort_male_total mort_female_total
gen country = "brazil"
graph bar mort_male_01_04-mort_male_80_110, title("Male") saving(male)
graph bar mort_female_01_04-mort_female_80_110, title("Female") saving(female)
gr combine "male" "female" , ycommon
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/Mortality_mf_2009.pdf, replace


// using the reshape for mort_tot_
use "${mypath}mort_brazil_tmf_allage_2009", clear
drop mort_female_22 mort_male_22 mort_tot_22
drop mort_tot_total mort_male_total mort_female_total
keep mort_tot_*
gen country = "brazil"
*reshape long mort_tot_, i(country) j(age) string
reshape long mort_tot_, i(country) j(age) string
encode age, gen(age_num)
line mort_tot_ age_num

// testing reshape on multiple names
use "${mypath}mort_brazil_tmf_allage_2009", clear
drop mort_female_22 mort_male_22 mort_tot_22
drop mort_tot_total mort_male_total mort_female_total
gen country = "brazil"
reshape long mort_tot_ mort_male_ mort_female_ , i(country) j(age) string
* beautiful!!
encode age, gen(age_num)
line mort_tot_ age_num

**************************
*** POPULATION UNIT: BRAZIL - YEAR **
**************************
use "${mypath}pop_tot_allage_2009", clear
keep age_* total
ds
destring `r(varlist)', replace
ds
collapse (sum) `r(varlist)'
ds
foreach v of var `r(varlist)' { 
replace `v'= `v'/1000
} 
graph bar age_00_01-age_80_inf, title("Total Population in 2009 for age categories") ytitle("Population in thousands")
gen age_00_09 =  age_00_01 + age_01_04 + age_05_09
gen age_10_19 =  age_10_14 + age_15_19
drop age_00_01 age_01_04 age_05_09 age_10_14 age_15_19
order age_00_09 age_10_19, first
graph bar age_00_09-age_80_inf, title("Total Population in 2009 for age categories") ytitle("Population in thousands")
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/Pop_total_2009.pdf, replace


use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/UDEL-temp.dta", clear
keep if year == 2009



// MORTALITY RATES

use "${mypath}pop_tot_allage_2009", clear
keep age_* total
ds
destring `r(varlist)', replace
ds
collapse (sum) `r(varlist)'
ds
foreach v of var `r(varlist)' { 
replace `v'= `v'/1000
} 
gen age_00_09 =  age_00_01 + age_01_04 + age_05_09
gen age_10_19 =  age_10_14 + age_15_19
drop age_00_01 age_01_04 age_05_09 age_10_14 age_15_19
order age_00_09 age_10_19, first
gen id_municipality = "Total"
merge 1:1 id_municipality using "${mypath}mort_brazil_tmf_allage_2009"

foreach i in 
drop mort_female_22 mort_male_22 mort_tot_22
drop mort_tot_total mort_male_total mort_female_total
gen country = "brazil"
graph bar mort_male_01_04-mort_male_80_110, title("Male Rates") saving(male_r)
graph bar mort_female_01_04-mort_female_80_110, title("Female Rates") saving(female_r)
gr combine "male_r" "female_r" , ycommon
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/MortalityRates_mf_2009.pdf, replace


