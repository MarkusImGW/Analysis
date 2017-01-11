local path_raw /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/Population_age/
local path_intermediate /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/
set matsize 5000
// insheet
use "`path_intermediate'merged_monthly_ages_97_09", clear

sum mort_female_00_01 mort_female_01_20
sum mort_female_00_01, detail

hist mort_female_00_01 if mort_female_00_01>50 & year==1997, freq
** total of 25 municipalities with a mortality rate higher than 50, which is really high. Probably all coming from small municipalities
hist pop_tot_total_ if year==1997
hist pop_tot_total_ if year==1997 & pop_tot_total_ <50000
** Plot a pareto distribution with a fat tail through the distribution of municipalites (note that these aren not cities)
*

hist mort_female_00_01
