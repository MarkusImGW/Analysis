/******************************************************************
Project: Social Cost of Carbon

Purpose: Cleaning and merging climate data for Brazil

Author:  Azhar Hussain

Date  :  20 December, 2016
*******************************************************************/



* OPENING COMMANDS:

	clear
	set more off
	pause on
	version 14.0
	cap log close


* AUTOMATED SELECTION OF ROOT PATH BASED ON USER

	if c(os) == "Windows" {
		cd "C:/Users/`c(username)'/Dropbox"
	}
	else if c(os) == "MacOSX" {
		cd "/Users/`c(username)'/Dropbox"
	}
	local DROPBOX `c(pwd)'
	local DROPBOX_ROOT "`DROPBOX'/Viaene_MortalityHospAdmBrazil"


* SETTING PATH SHORTCUTS

	local RAW_DATA "`DROPBOX_ROOT'/Data/Raw/Data"
	local WORKING_DATA "`DROPBOX_ROOT'/Data/Intermediate"
	local FINAL_DATA "`DROPBOX_ROOT'/Data/Final"	
	local DO "`DROPBOX_ROOT'/Analysis/AH_Codes"
	local OUTPUT "`DROPBOX_ROOT'/Results"
	local LOG "`DROPBOX_ROOT'/Results/STATALogFiles"

	//local x = c(current_date)
	//log using "`LOG'/Brazil_Replication_`x'.log", replace    

	
* POPULATION DATA

	//Insheeting and merging the population data for all years and genders
	foreach sex in "tot" "male" "female" {
		///Insheeting
		foreach t of numlist 1996(1)2010 {
			local chk_v15 0
			insheet using "`RAW_DATA'/Population_age/age_`sex'_`t'.csv", delimiter(";") clear
			describe, varlist
			foreach v in `r(varlist)' {
				di "`v'"
				if("`v'" == "v15") {
					local chk_v15 1
				}
			}
			di "`chk_v15'"
			drop if v5 == "" //Drop declaration rows
			drop in 1 //Drop header row
			drop if v1 == "Total" //Drop totals row

			////Renaming variables
			rename v1 id_municipality
			format %60s id_municipality
			rename v2 pop_`sex'_00_01_`t'
			rename v3 pop_`sex'_01_04_`t'
			rename v4 pop_`sex'_05_09_`t'
			rename v5 pop_`sex'_10_14_`t'
			rename v6 pop_`sex'_15_19_`t' 
			rename v7 pop_`sex'_20_29_`t' 
			rename v8 pop_`sex'_30_39_`t'
			rename v9 pop_`sex'_40_49_`t'
			rename v10 pop_`sex'_50_59_`t'
			rename v11 pop_`sex'_60_69_`t'
			rename v12 pop_`sex'_70_79_`t'
			rename v13 pop_`sex'_80_inf_`t'
			if (`chk_v15'==0) {
				rename v14 pop_`sex'_total_`t'
			}
			else {
				rename v14 pop_`sex'_unknown_`t'
			}
			cap rename v15 pop_`sex'_total_`t'

			////Generating IDs
			gen fips = regexs(0) if(regexm(id_municipality, "[0-9][0-9][0-9][0-9][0-9][0-9]"))
			gen municipality = substr(id_municipality, 8, .)
			gen state_fips = substr(id_municipality, 1, 2)

			////Labelling variables
			label variable pop_`sex'_00_01 "`sex' population in 0-1 age group in year `t'"
			label variable pop_`sex'_01_04 "`sex' population in 1-4 age group in year `t'"
			label variable pop_`sex'_05_09 "`sex' population in 5-9 age group in year `t'"
			label variable pop_`sex'_10_14 "`sex' population in 10-14 age group in year `t'"
			label variable pop_`sex'_15_19 "`sex' population in 15-19 age group in year `t'"
			label variable pop_`sex'_20_29 "`sex' population in 20-29 age group in year `t'"
			label variable pop_`sex'_30_39 "`sex' population in 30-39 age group in year `t'"
			label variable pop_`sex'_40_49 "`sex' population in 40-49 age group in year `t'"
			label variable pop_`sex'_50_59 "`sex' population in 50-59 age group in year `t'"
			label variable pop_`sex'_60_69 "`sex' population in 60-69 age group in year `t'"
			label variable pop_`sex'_70_79 "`sex' population in 70-79 age group in year `t'"
			label variable pop_`sex'_80_inf "`sex' population in 80-80+ age group in year `t'"
			label variable pop_`sex'_total "`sex' total population in year `t'"
			cap label variable pop_`sex'_unknown "`sex' population in unknown age group in year `t'"			
			label variable fips "Municipality FIPS code"
			label variable municipality "Municipality name"
			label variable state_fips "State FIPS code"
			label variable id_municipality "FIPS code and municipality name combined"

			*Flag 1: In the previous version of code this was coded 0, and not all the bins were checked
			////Replacing missing population as blanks/missing
			foreach age in "total" "00_01" "01_04" "05_09" "10_14" "15_19" "20_29" ///
				"30_39" "40_49" "50_59" "60_69" "70_79" "80_inf" {
				replace pop_`sex'_`age'_`t' = "" if pop_`sex'_`age'_`t' == "-"
			}
			
			describe, varlist
			destring `r(varlist)', replace

			tempfile pop_`sex'_allage_`t'
			save "`pop_`sex'_allage_`t''"
		}

		///Merging
		use `pop_`sex'_allage_2010', clear
		foreach t of numlist 2009(-1)1997 { //Skipping 1996 because of large number of missing entries
			merge 1:1 fips using `pop_`sex'_allage_`t'', gen(merge_`sex'_`t')
			keep if merge_`sex'_`t'==3
		}
		drop *_unknown* //Drop unknown age categories
	
		///Generating age categories
		foreach year of numlist 1997(1)2010 {
			egen pop_`sex'_01_20_`year' = rowtotal(pop_`sex'_01_04_`year' pop_`sex'_05_09_`year' pop_`sex'_10_14_`year' pop_`sex'_15_19_`year')
			egen pop_`sex'_20_40_`year' = rowtotal(pop_`sex'_20_29_`year' pop_`sex'_30_39_`year')
			egen pop_`sex'_40_60_`year' = rowtotal(pop_`sex'_40_49_`year' pop_`sex'_50_59_`year')
			egen pop_`sex'_60_80_`year' = rowtotal(pop_`sex'_60_69_`year' pop_`sex'_70_79_`year')
		}

		/*Flag 2: This original code is causing problems at the end-month (12) and end-year
		(2009), by making all the entries same for all age groups within each gender. Also, 
		interpolation for a year should ideally be done using the preceding year, and not
		the successive year, asssuming the yearly pop counts represent end of the year readings
		local gender "tot male female"
		local age_bins total 00_01 01_20 20_40 40_60 60_80 80_inf
		foreach var of local gender{
			foreach i of numlist 1(1)12{
				foreach age of local age_bins{
					foreach year of numlist 1997(1)2009{
						local j = `year' + 1
						gen pop_`var'_`age'_`i'_`year' = ((12-`i')/12) * pop_`var'_`age'_`year' + (`i'/12) * pop_`var'_total_`j'
					}
					gen pop_`var'_`age'_`i'_2009 = pop_`var'_`age'_2009 // 2009 as end year
				}
			} 
		}*/

		///Creating month variables using linear interpolation
		foreach i of numlist 1(1)12 {
			foreach age in "total" "00_01" "01_20" "20_40" "40_60" "60_80" "80_inf" {
				foreach year of numlist 1998(1)2010 {
					local j = `year' - 1
					gen pop_`sex'_`age'_`i'_`year' = ((12-`i')/12) * pop_`sex'_`age'_`j' + (`i'/12) * pop_`sex'_`age'_`year'
				}
				//Don't have 1996 data to interpolate months in 1997
				gen pop_`sex'_`age'_`i'_1997 = pop_`sex'_`age'_1997
			}
		}
		drop pop_`sex'_total_* pop_`sex'_??_??_???? pop_`sex'_??_???_???? merge*
		order id_municipality state_fips fips municipality, first
		tostring(fips), replace
		tempfile pop_`sex'_all
		save "`pop_`sex'_all'"
	}

	//Merging male, female and total results for all years
	use `pop_male_all'
	merge 1:1 fips using `pop_female_all', nogen
	merge 1:1 fips using `pop_tot_all', nogen

	//Declaring local to be used in rest of the program
	local years 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010
	local sex "tot male female"
	local age_bins "00_01 01_20 20_40 40_60 60_80 80_inf"
	local cat "1 2 3 4 5 6 7 8 9 10 11 12"

	//Storing all the variables in 'bins' local
	local bins
	foreach i of local cat {
		foreach age of local age_bins {
			foreach var of local sex {
				local bins "`bins' pop_`var'_`age'_`i'_"
			}
		}
	}
	di "`bins'"

	//Reshaping to extract year as a variable
	reshape long `bins', i(fips) j(year)

	//Rename the months to get rid of the _ at the end
	foreach i of local cat {
		foreach age of local age_bins {
			foreach var of local sex {
				rename pop_`var'_`age'_`i'_ pop_`var'_`age'_`i'
			}
		}
	}

	//Storing all the variables in 'bins' local
	local bins
	foreach age of local age_bins {
		foreach var of local sex {
			local bins "`bins' pop_`var'_`age'_"
		}
	}
	di "`bins'"
	
	reshape long `bins', i(fips year) j(month)
	
	foreach age of local age_bins {
		foreach var of local sex {
			rename pop_`var'_`age'_ pop_`var'_`age'
		}
	}

	//Saving the final cleaned population data
	save "`WORKING_DATA'/pop_tmf_total_97_09_monthly_ages_AH", replace


* MORTALITY DATA

