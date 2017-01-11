****************************************************************************
*Creates annual sum for every temperature bin and merges everything together
****************************************************************************

clear
cd "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2"
****Set weight to use for climate data: area, pop, or crop 
loc weight = "pop"



****Sum over months for positive temperature files.

local Positive_Temps
forvalues T1 = 0(1)34 {
	local T2 = `T1' + 1
	local Positive_Temps `Positive_Temps' BEST_tavg_BIN_`T1'C_`T2'C
}

** Starting values for the next loop
local T1 = 0
local T2 = 1

** This foreach loop creates the summation of monthly values into yearly values, for each temperature bin.

foreach x in `Positive_Temps' {
	tempfile `T1'_`T2'
	use `x', clear
	sort NAME_1_NAME_2 year
  egen yearly_sum_`T1'C_`T2'C = rowtotal(tavg_bin_`T1'C_`T2'C_m1_`weight'-tavg_bin_`T1'C_`T2'C_m12_`weight')
  // Notice that here he only keeps the year and yearly_sum, thus discarding the months
  keep NAME_1_NAME_2 year yearly_sum_`T1'C_`T2'C 
  save ``T1'_`T2''
  local T1 = `T1'+1
  local T2 = `T2'+1
  }

****Sum over months for 35C to +Inf and use as base file to merge off of.

tempfile 35_Inf
use BEST_tavg_BIN_35C_Inf, clear
sort NAME_1_NAME_2 year
egen yearly_sum_35C_Inf = rowtotal(tavg_bin_35C_Inf_m1_`weight'-tavg_bin_35C_Inf_m12_`weight')
keep NAME_1_NAME_2 year yearly_sum_35C_Inf

****Merge positive temperature files.

forvalues T1 = 0(1)34{
  loc T2 = `T1' + 1
  merge 1:1 NAME_1_NAME_2 year using ``T1'_`T2''
  drop _merge
}

****Sum over all temperature bins to check that it adds up to ~365 days.
order NAME_1_NAME_2 year yearly_sum_0C_1C yearly_sum_1C_2C yearly_sum_2C_3C yearly_sum_3C_4C yearly_sum_4C_5C yearly_sum_5C_6C yearly_sum_6C_7C yearly_sum_7C_8C yearly_sum_8C_9C yearly_sum_9C_10C
drop check_365
order yearly_sum_35C_Inf, last
egen check_365 = rowtotal(yearly_sum_0C_1C - yearly_sum_35C_Inf)

order check_365
sort check_365
preserve
drop if check_365>364
hist check_365, freq
restore

***********************************
***** FIRST SAVE BEFORE RENAMING
***********************************
*save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_year.dta, replace
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_year.dta, replace


************************************
***** Rename with normal letters ***
************************************

use /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_year.dta, clear
rename NAME_1_NAME_2 state_municipality
replace state_municipality = subinstr(state_municipality,"�","i",.) // �
** careful with this one as there are also names starting with this character
replace state_municipality = subinstr(state_municipality,"dos indios","dos Indios",.) //
* 4 changes made
* Alagoas-Palmeira dos �ndios
** I can just do a search on ( �), now I'll just go ahead BUT CHECK THIS 
replace state_municipality = subinstr(state_municipality,"Xambio�","Cambio",.) // cambio
replace state_municipality = subinstr(state_municipality,"�","e",.) // �
replace state_municipality = subinstr(state_municipality,"�","e",.) // �
replace state_municipality = subinstr(state_municipality,"�","a",.) // �
replace state_municipality = subinstr(state_municipality,"�","a",.) // �
replace state_municipality = subinstr(state_municipality,"�","a",.) // �
replace state_municipality = subinstr(state_municipality,"�","o",.) // �
replace state_municipality = subinstr(state_municipality,"�","o",.) // �
replace state_municipality = subinstr(state_municipality,"X","o",.) // �
replace state_municipality = subinstr(state_municipality ," o"," X",.) // �
replace state_municipality = subinstr(state_municipality ,"-o","-X",.) // �
replace state_municipality = subinstr(state_municipality,"�","u",.) // �
replace state_municipality = subinstr(state_municipality,"�","c",.) // �
replace state_municipality = subinstr(state_municipality,"�","a",.) // �
**
replace state_municipality  = subinstr(state_municipality ,"�","u",.) // �
replace state_municipality  = subinstr(state_municipality ,"�","c",.) // �
replace state_municipality  = subinstr(state_municipality ,"�","a",.) // �
replace state_municipality  = subinstr(state_municipality ,"�","o",.) // o
replace state_municipality  = subinstr(state_municipality ," a"," A",.) // o
replace state_municipality  = subinstr(state_municipality ,"�","I",.) // �
replace state_municipality  = subinstr(state_municipality ,"'a","'A",.) //  
replace state_municipality  = subinstr(state_municipality ,"�","O",.) // �
replace state_municipality  = subinstr(state_municipality ,"�","A",.) // �
replace state_municipality  = subinstr(state_municipality ,"�","E",.) // �
**

replace state_municipality  = subinstr(state_municipality,"&Oacute","O",.) // �
replace state_municipality   = subinstr(state_municipality  ,"moji","mogi",.) // 
replace state_municipality   = subinstr(state_municipality  ,"Moji","Mogi",.) // 
replace state_municipality   = subinstr(state_municipality  ,"Tocos do Mogi","Tocos do Moji",.) 
replace state_municipality = subinstr(state_municipality,"I;r","Ir",.) // �
replace state_municipality   = subinstr(state_municipality  ,"&Acirc;","A",.) // �
replace state_municipality   = subinstr(state_municipality  ,"&Eacute;","E",.) // �
// cambioa => oambioa, c has been replaced to an o => check that with the o's

split state_municipality, parse(-)
** Split splits on "-", however, a couple of states have it in their name , which causes a third variable to be created
sort state_municipality3
gen municipality = state_municipality2
replace municipality = state_municipality2+"-"+state_municipality3 if state_municipality3!=""
**This one worke throug concatenation
drop state_municipality3 state_municipality2
rename state_municipality1 state

***** Storage

save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_year_renamed.dta, replace

use /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_year_renamed.dta, clear
preserve
keep if year==2009
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_2009_renamed.dta, replace
restore

preserve
keep if year==2012
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_2012_renamed.dta, replace
restore

****** EXPLORATION MISSING DATA *****
order check_365 state
sort check_365 state
// Bahia, Piaui, Maranhao, Sergipe, Ceara, Pernambco, Rio Grande do Norte, Alagoas, Paraiba, Espirito Santo


************************************
***** Rename with portuguese letters ***
************************************
use /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_year.dta, clear
rename NAME_1_NAME_2 state_municipality
* for analysis: focus on one year, makes it easier to scroll
*keep if year == 2002
replace state_municipality = subinstr(state_municipality,"�","�",.) // �
** careful with this one as there are also names starting with this character
replace state_municipality = subinstr(state_municipality,"dos �ndios","dos �ndios",.) //
* 4 changes made
* Alagoas-Palmeira dos �ndios
** I can just do a search on ( �), now I'll just go ahead BUT CHECK THIS 
replace state_municipality = subinstr(state_municipality,"Xambio�","Cambio",.) // cambio
replace state_municipality = subinstr(state_municipality,"�","�",.) // �
replace state_municipality = subinstr(state_municipality,"�","�",.) // �
replace state_municipality = subinstr(state_municipality,"�","�",.) // �
replace state_municipality = subinstr(state_municipality,"�","�",.) // �
replace state_municipality = subinstr(state_municipality,"�","�",.) // �
replace state_municipality = subinstr(state_municipality,"�","�",.) // �
replace state_municipality = subinstr(state_municipality,"�","�",.) // �
replace state_municipality = subinstr(state_municipality,"X","�",.) // �
replace state_municipality = subinstr(state_municipality ," �"," X",.) // �
replace state_municipality = subinstr(state_municipality ,"-�","-X",.) // �
replace state_municipality = subinstr(state_municipality,"�","�",.) // �
replace state_municipality = subinstr(state_municipality,"�","�",.) // �
**really, this one?
replace state_municipality = subinstr(state_municipality,"�","�",.) // � 

replace state_municipality  = subinstr(state_municipality ,"�","o",.) // o
replace state_municipality  = subinstr(state_municipality ," a"," A",.) // o
replace state_municipality  = subinstr(state_municipality ,"�","I",.) // �
*This one seems strange
replace state_municipality  = subinstr(state_municipality ,"'a","'A",.) //  
replace state_municipality  = subinstr(state_municipality ,"�","�",.) // �
replace state_municipality  = subinstr(state_municipality ,"�","�",.) // �
replace state_municipality  = subinstr(state_municipality ,"�","�",.) // �
split state_municipality, parse(-)
** Split splits on "-", however, a couple of states have it in their name , which causes a third variable to be created
sort state_municipality3
gen municipality = state_municipality2
replace municipality = state_municipality2+"-"+state_municipality3 if state_municipality3!=""
**This one worke throug concatenation
drop state_municipality3 state_municipality2
rename state_municipality1 state
gen state_fips  = "11" if state == "Rond�nia"
replace state_fips  = "12" if state=="Acre"
replace state_fips  = "13" if state=="Amazonas"
replace state_fips  = "14" if state=="Roraima"
replace state_fips  = "15" if state=="Par�"
replace state_fips  = "16" if state=="Amap�"
replace state_fips  = "17" if state=="Tocantins"
replace state_fips  = "21" if state=="Maranh�o"
replace state_fips  = "22" if state=="Piau�"
replace state_fips  = "23" if state=="Cear�"
replace state_fips  = "24" if state=="Rio Grande do Norte"
replace state_fips  = "25" if state=="Para�ba"
replace state_fips  = "26" if state=="Pernambuco"
replace state_fips  = "27" if state=="Alagoas"
replace state_fips  = "28" if state=="Sergipe"
replace state_fips  = "29" if state=="Bahia"
replace state_fips  = "31" if state=="Minas Gerais"
replace state_fips  = "32" if state=="Esp�rito Santo"
replace state_fips  = "33" if state=="Rio de Janeiro"
replace state_fips  = "35" if state=="S�o Paulo"
replace state_fips  = "41" if state=="Paran�"
replace state_fips  = "42" if state=="Santa Catarina"
replace state_fips  = "43" if state=="Rio Grande do Sul"
replace state_fips  = "50" if state=="Mato Grosso do Sul"
replace state_fips  = "51" if state=="Mato Grosso"
replace state_fips  = "52" if state=="Goi�s"
replace state_fips  = "53" if state=="Distrito Federal"
/*
* Checking for duplicates, none observed
preserve
keep if year==2009
duplicates list state_municipality
restore
*/ 

save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_year_renamed_port.dta, replace

use /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_year_renamed_port.dta, clear
preserve
keep if year==2009
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_2009_renamed_port.dta, replace
restore

preserve
keep if year==2012
save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_2012_renamed_port.dta, replace
restore


