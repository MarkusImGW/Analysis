
use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/BEST_tavg_BIN_22C_23C.dta", clear
sort year NAME_1_NAME_2
keep if year==2000
keep if year==1996
** 5504 observations
** 
NAME_1_NAME_2
gen str12 province = subinstr("Acre,"È","é",.)

** Information on string manipulation: http://www.ats.ucla.edu/stat/stata/faq/regex.htm

é - È
õ - ı
í - Ì 
ã - „
ç - Á
á - ·
ó - Û
â - ,
ú - ˙
ê - Í
