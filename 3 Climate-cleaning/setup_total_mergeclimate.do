***********************************************************************************

* File: .do
* Modified by: Arvid Viaene (viaene@uchicago.edu)
* Contact: Arvid Viaene (viaene@uchicago.edu)
/* 
Objective: The objective of this program is to create the fips variable for temperature based
on the excel file that the brazilian government has
http://www.ibge.gov.br/home/geociencias/cartografia/default_territ_area.shtm


Structure:

*/

***********************************************************************************
local path_raw /Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/

// Insert new big file and get state and name variables
use "`path_intermediate'merged_climate_dataset", clear
// synchronizing the name
rename NAME_1_NAME_2 state_municipality
// creating municipality and state name
split state_municipality, parse(-)
sort state_municipality3
gen municipality = state_municipality2
replace municipality = state_municipality2+"-"+state_municipality3 if state_municipality3!=""
drop state_municipality3 state_municipality2
rename state_municipality1 state
order state_municipality year state municipality
sort municipality state
*keep if year == 2009
** Check is ok, has the same number of duplicates
duplicates report state municipality year
*duplicates list state municipality
duplicates drop state municipality year, force
* this drops 9 duplicates. Deirdre commented that some cities had two observations, with and without accent but they should have the same
* temperature data
// Getting them to upper case letters
replace municipality = upper(municipality)
replace state = upper(state)

merge m:1 municipality state using "`path_intermediate'UDEl-temp_fips"
drop if _merge == 1
**If I check it for 2009,  this worked and has 46 unmatched observations but none unmatched from the using file! So I am dropping these
drop _merge

bysort fips: egen climate = mean(temp_annual_pop) if year > 1979 & year <2011 // 30 year time horizon for climate

drop if year < 1996
save "`path_intermediate'merged_climate_dataset_fips_2", replace

********** USING THE ORIGINAL FILE *************
local path_raw /Users/arvidviaene/Dropbox/2 Mortality/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/2 Mortality/Data/Intermediate/

use "`path_intermediate'merged_climate_dataset_fips", clear
bysort fips: egen climate = mean(temp_annual_pop) if year > 1979 & year < 2014 // 30 year time horizon for climate
save "`path_intermediate'merged_climate_dataset_fips", replace

/*
Trouble-shooting code
keep if year==2009
order fips municipality
sort fips municipality
duplicates report fips 
duplicates list fips municipality
*/

