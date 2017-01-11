*************************************
***** Arvid Viaene - UoC ************
***** Last changed: 3 July, 2015 ****
*************************************

******************************************************************************
**** Creating temperature distribution for Brazil, weighted by population*****
******************************************************************************

use /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_year.dta, clear
*drop yearly_sum_1C_2C yearly_sum_0C_1C yearly_sum_2C_3C yearly_sum_3C_4C yearly_sum_4C_5C yearly_sum_5C_6C yearly_sum_6C_7C yearly_sum_7C_8C yearly_sum_8C_9C
rename yearly_sum_0C_1C yearly_sum_00C_01C
rename yearly_sum_1C_2C yearly_sum_01C_02C
rename yearly_sum_2C_3C yearly_sum_02C_03C
rename yearly_sum_3C_4C yearly_sum_03C_04C
rename yearly_sum_4C_5C yearly_sum_04C_05C
rename yearly_sum_5C_6C yearly_sum_05C_06C 
rename yearly_sum_6C_7C yearly_sum_06C_07C 
rename yearly_sum_7C_8C yearly_sum_07C_08C 
rename yearly_sum_8C_9C yearly_sum_08C_09C 
rename yearly_sum_9C_10C yearly_sum_09C_10C 
rename NAME_1_NAME_2 municipality
*order 
*keep if municipality=="Acre-Acrelândia"
keep if year==2012
// Can you use and if statement for the graph
* Going to drop some variables

//Use the following if you want to select a state
gen state2 = regexs(1) if regexm(municipality, "([a-zA-Z]*[][a-zA-Z]*)[\-]*[a-zA-Z]*")
split municipality, p("-")
* keep if state2=="Acre"

**keep if municipality1 =="São Paulo" | municipality1 == "Rio de Janeiro"|municipality1 =="Minas Gerais"|municipality1 =="Bahia"|municipality1 =="Rio Grande do Sul"
// Going to move the bins to one variable so I can plot them
duplicates drop municipality, force
reshape long yearly_sum_, i(municipality) j(temp) string


// By 5 most important population states
graph hbar yearly_sum_ if municipality1 == "São Paulo", over(temp) ///
title("Unweighted Distribution of degree days in Sao Paulo") ytitle("Number of days in Bin")
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/temperature_SaoPaolo.pdf, replace

graph hbar yearly_sum_ if municipality1 =="Rio de Janeiro", over(temp)  ///
title("Unweighted Distribution of degree days in Rio de Janeiro") ytitle("Number of days in Bin")
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/temperature_RiodeJaneiro.pdf, replace

graph hbar yearly_sum_ if municipality1 =="Minas Gerais", over(temp)  ///
title("Unweighted Distribution of degree days in Minas Gerais") ytitle("Number of days in Bin")
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/temperature_MinasGerais.pdf, replace

graph hbar yearly_sum_ if municipality1 =="Bahia", over(temp)   ///
title("Unweighted Distribution of degree days in Bahia") ytitle("Number of days in Bin")
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/temperature_Bahia.pdf, replace

graph hbar yearly_sum_ if municipality1 =="Rio Grande do Sul", over(temp) ///
title("Unweighted Distribution of degree days in Rio Grande do Sul") ytitle("Number of days in Bin")
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/temperature_RioGrandedoSul.pdf, replace



graph bar yearly_sum_, over(temp) 
graph bar yearly_sum_, over(temp) by (state) 
graph hbar yearly_sum_, over(temp) 
graph hbar yearly_sum_, over(temp) over(state)
graph hbar yearly_sum_, over(temp) by(state) 

*twoway (line yearly_sum_ ntemp)=> can do this to get clearer view of overlapping distributions

egen temp_mean = mean(yearly_sum_), by(temp)
graph bar temp_mean if state=="Bahia", over(temp) xlabel("","")
//The two below are good, but much work needs to be done.
graph hbar yearly_sum_, over(temp) by(state) 
graph bar yearly_sum_, over(temp) by(state) 

graph bar yearly_sum_, over(municipality) over(temp) 
*Another way to do this if they are in order is to use 
* Way to create numerical variable from a categorical variable is encode temp, gen(ntemp)

********************************************
// Creating the unweighted graph //
********************************************
// Now creating the normal mean on each of the temperature bins across the country/state/whatever the unit of observation is
// (careful if multiple years are still in here, in which case probably another by() is needed
egen temp_mean = mean(yearly_sum_), by(temp)
* this one worked, gave the mean averaged over the municipalities in a state,
*keep if municipality=="Acre-Acrelândia"
keep if municipality=="São Paulo-Adamantina"
graph hbar temp_mean, over(temp) ///
title("Unweighted Distribution of degree days in Sao Paulo") ytitle("Number of days in Bin")
** sweet!
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/temperature_SaoPaolo.pdf, replace

********************************************
// Creating the unweighted graph for Brazil //
********************************************

use /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_year.dta, clear
*drop yearly_sum_1C_2C yearly_sum_0C_1C yearly_sum_2C_3C yearly_sum_3C_4C yearly_sum_4C_5C yearly_sum_5C_6C yearly_sum_6C_7C yearly_sum_7C_8C yearly_sum_8C_9C
rename yearly_sum_0C_1C yearly_sum_00C_01C
rename yearly_sum_1C_2C yearly_sum_01C_02C
rename yearly_sum_2C_3C yearly_sum_02C_03C
rename yearly_sum_3C_4C yearly_sum_03C_04C
rename yearly_sum_4C_5C yearly_sum_04C_05C
rename yearly_sum_5C_6C yearly_sum_05C_06C 
rename yearly_sum_6C_7C yearly_sum_06C_07C 
rename yearly_sum_7C_8C yearly_sum_07C_08C 
rename yearly_sum_8C_9C yearly_sum_08C_09C 
rename yearly_sum_9C_10C yearly_sum_09C_10C 
rename NAME_1_NAME_2 municipality
keep if year==2012
gen state2 = regexs(1) if regexm(municipality, "([a-zA-Z]*[][a-zA-Z]*)[\-]*[a-zA-Z]*")
split municipality, p("-")
duplicates drop municipality, force
reshape long yearly_sum_, i(municipality) j(temp) string

graph bar yearly_sum_00C_01C-yearly_sum_35C_Inf if year==2009, legend(off)
graph bar yearly_sum_00C_01C-yearly_sum_35C_Inf if year==2008, legend(off)
twoway line yearly_sum_00C_01C-yearly_sum_35C_Inf if year==2007, legend(off)

graph hbar yearly_sum_, over(temp) ///
title("Unweighted distribution of degree days in Brazil") ytitle("Number of days in Bin")
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/temperature_Brazil.pdf, replace

********************************************
// Creating the weighted graph by population
********************************************
* 1) Insheeting the standard 2) merge 3) create graph based on subpop that got matched
use /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_year.dta, clear 
merge 1:1 municipality state using XXX/mun_totsex_totage_2012


*********************************************************
**** Creating Mortality graphs for Brazil as a whole*****
*********************************************************

cd "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate"
use master_years, clear
drop if municiacutepio!="Total" 
drop if month == 13

local years 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 
foreach i of numlist `years'{
rename mortality_0_`i'_0_0_0_0 mortality_`i'
label var mortality_`i' "`i'"
}

************************
***** Deaths by year ***
************************
local months mortality_2013 mortality_2012 mortality_2011 mortality_2010 ///
mortality_1999 mortality_1998 mortality_1997 mortality_1996
twoway connected `months' month, ///
xlabel(1 "J" 2 "F" 3 "M" 4 "A" 5 "M" 6 "J" 7 "J" 8 "A" 9 "S" 10 "O" 11 "N" 12 "D") xtitle("Months") ytitle("Deaths") title("Mortality in Brazil", margin(b+2.5))
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/mortality.pdf, replace
** If shackleton is windows, I might have to change the directory, as well as the slashes.

local months mortality_0_2013_0_0_0_0 mortality_0_2012_0_0_0_0 mortality_0_2011_0_0_0_0 mortality_0_2010_0_0_0_0 ///
mortality_0_2009_0_0_0_0 mortality_0_2008_0_0_0_0 mortality_0_2007_0_0_0_0 mortality_0_2006_0_0_0_0 ///
mortality_0_2005_0_0_0_0 mortality_0_2004_0_0_0_0 mortality_0_2003_0_0_0_0 mortality_0_2002_0_0_0_0 ///
mortality_0_2001_0_0_0_0 mortality_0_2000_0_0_0_0 ///
mortality_0_1999_0_0_0_0 mortality_0_1998_0_0_0_0 mortality_0_1997_0_0_0_0 mortality_0_1996_0_0_0_0
twoway connected `months' month
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/mortality2.pdf, replace
** If shackleton is windows, I might have to change the directory, as well as the slashes.

***********************
***** Deaths by sex ***
***********************
cd "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate"
use master, clear
drop if municiacutepio!="Total" 
drop if month == 13

*local years 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 

label var mortality_0_2013_0_0_1_0 2013_male
label var mortality_0_2013_0_0_2_0 2013_female
label var mortality_0_2012_0_0_1_0 2012_male
label var mortality_0_2012_0_0_2_0 2012_female

local months_sex mortality_0_2013_0_0_1_0 mortality_0_2013_0_0_2_0 mortality_0_2012_0_0_1_0 mortality_0_2012_0_0_2_0
twoway connected `months_sex' month, ///
xlabel(1 "J" 2 "F" 3 "M" 4 "A" 5 "M" 6 "J" 7 "J" 8 "A" 9 "S" 10 "O" 11 "N" 12 "D") xtitle("Months") ytitle("Deaths") title("Mortality by gender in Brazil", margin(b+2.5))
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/mortality_sex.pdf, replace

***** Deaths by location **
local location mortality_0_2013_0_0_0_0 mortality_0_2013_0_0_0_1 mortality_0_2013_0_0_0_2 mortality_0_2013_0_0_0_3 mortality_0_2013_0_0_0_4 mortality_0_2013_0_0_0_5 mortality_0_2013_0_0_0_6
twoway connected `location' month
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/mortality_location.pdf, replace

***** Deaths by cause **
local cause mortality_0_2013_1_0_0_0 mortality_0_2013_2_0_0_0 mortality_0_2013_3_0_0_0 mortality_0_2013_4_0_0_0 mortality_0_2013_5_0_0_0 mortality_0_2013_6_0_0_0 
twoway connected `cause' month
graph export /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Results/Figures/mortality_location.pdf, replace

label var mortality_2013 "2013"
gen str10 Month = "Januari" if month==1
replace Month = "February" if month==2
replace Month = "March" if month==3
replace Month = "April" if month==4
replace Month = "Mai" if month==5
replace Month = "June" if month==6
replace Month = "July" if month==7
replace Month = "August" if month==8
replace Month = "September" if month==9
replace Month = "October" if month==10
replace Month = "November" if month==11
replace Month = "December" if month==12


local years 2013
local sex 0 1 2
foreach j of numlist `sex'{
foreach i of numlist `years'{
cap noi rename mortality_0_`i'_0_0_`j'_0 mortality_`i'_`j'
if `j'==0{
label var mortality_`i'_`j' "`i'"}
else if `j'==1{
label var mortality_`i'_`j' "`i'_male"}
}
else if `j'==2{
label var mortality_`i'_`j' "`i'_female"
}
}
