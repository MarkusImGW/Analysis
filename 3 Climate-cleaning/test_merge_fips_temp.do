***********************************************************************************

* File: Test_merge_temp_fips.do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)
/* 
Objective: The objective of this program is to create the fips variable for temperature based
on the excel file that the brazilian government has
http://www.ibge.gov.br/home/geociencias/cartografia/default_territ_area.shtm


Structure:
*/

***********************************************************************************

***************** TESTING MERGE BETWEEN AREA_CODING AND POPULATION ON FIPS **********


local path_raw /Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/
use `path_intermediate'pop_tot_allage_2009 , clear
sort fips
by fips: assert _N==1
use "/Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/area_coding_2",clear 
sort fips
by fips: assert _N==1
*redefine string?
*** Merge between fips and population to check the actual number of matches
use "/Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/area_coding_2",clear 
sort fips
gen fips2 = regexs(0) if(regexm(fips, "[0-9][0-9][0-9][0-9][0-9][0-9]"))
duplicates list fips2
** One variable has first 6 letters in common =>maybe they split
duplicates drop fips2, force
replace fips = fips2
merge 1:1 fips using "`path_intermediate'pop_tot_allage_2009"
sort _merge

** only six states did not get merged, which is very promising as this is 2009 vs 2013!!


************************

******* PART 1: Creating the dta.file area_coding
/*
Method of copy paste: I copy pasted the excel file "area_coding" into stata, selecting first row as variables
Note: Insheet excel => again, doing this loses the portuguese characters, so I will use the copy paste method and
then convert the geocoding to a string
*/
use "/Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/area_coding", clear
drop fips
gen fips = string(cd_geocodigo)
rename nm_uf state
rename nm_mun_2013 municipality
replace state = "Esp’rito Santo" if state== "Espirito Santo"
duplicates report state municipality
duplicates list state municipality
replace municipality = "AMAJARI" in 137
replace area_2013_km2 = 28472.326 if municipality=="AMAJARI"
drop in 138/139
replace municipality = "FLEXEIRAS" in 1681
replace area_2013_km2 = 333.233 if municipality=="FLEXEIRAS"
drop in 1682/1685
** Removing portuguese characters
removecharacters state
removecharacters municipality

** GETTING THEM to all upper characthers
replace municipality = upper(municipality)
replace state = upper(state)
save "/Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/area_coding_2", replace


************************************************
******* PART 2: Using the temperature file *****
************************************************

** READ IN RECODED TEMPERATURE FILE
use "/Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/Data/ClimateData_2/UDEL-temp.dta", clear
keep if year == 2009
* this has about 70 states less than 2013 and 63 municipalities less than 2009
rename NAME_1_NAME_2 state_municipality
split state_municipality, parse(-)
** Split splits on "-", however, a couple of states have it in their name , which causes a third variable to be created
sort state_municipality3
gen municipality = state_municipality2
replace municipality = state_municipality2+"-"+state_municipality3 if state_municipality3!=""
drop state_municipality3 state_municipality2
rename state_municipality1 state
order state_municipality year state municipality
sort municipality state
duplicates report state municipality
duplicates list state municipality
duplicates drop state municipality, force
* this drops 9 duplicates. Deirdre commented that some cities had two observations, with and without accent but they should have the same
* temperature data
// Getting them to upper case letters
replace municipality = upper(municipality)
replace state = upper(state)

merge 1:1 municipality state using "/Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/area_coding_2"
sort _merge state municipality
** excel modifications
keep id fips state_municipality year state municipality _merge
drop if _merge==2
drop if fips ==""
drop _merge
*46 still unmatched
replace fips = substr(fips, 1, 6)
save "/Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/UDEl-temp_fips", replace
* has 5410 observations

*****************************************************************
******* TEMPERATURE and MORTALITY on Municipality and State *****
*****************************************************************
/*
local path_raw /Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/

use `path_intermediate'pop_tot_allage_2009 , clear
*/












