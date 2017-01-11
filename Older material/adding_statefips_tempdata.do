** Number list (no portuguese characters)
use /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_2009_renamed_port.dta, clear
gen state_fips  = "11" if state == "Rond™nia"
replace state_fips  = "12" if state=="Acre"
replace state_fips  = "13" if state=="Amazonas"
replace state_fips  = "14" if state=="Roraima"
replace state_fips  = "15" if state=="Par‡"
replace state_fips  = "16" if state=="Amap‡"
replace state_fips  = "17" if state=="Tocantins"
replace state_fips  = "21" if state=="Maranh‹o"
replace state_fips  = "22" if state=="Piau’"
replace state_fips  = "23" if state=="Cear‡"
replace state_fips  = "24" if state=="Rio Grande do Norte"
replace state_fips  = "25" if state=="Para’ba"
replace state_fips  = "26" if state=="Pernambuco"
replace state_fips  = "27" if state=="Alagoas"
replace state_fips  = "28" if state=="Sergipe"
replace state_fips  = "29" if state=="Bahia"
replace state_fips  = "31" if state=="Minas Gerais"
replace state_fips  = "32" if state=="Esp’rito Santo"
replace state_fips  = "33" if state=="Rio de Janeiro"
replace state_fips  = "35" if state=="S‹o Paulo"
replace state_fips  = "41" if state=="Paran‡"
replace state_fips  = "42" if state=="Santa Catarina"
replace state_fips  = "43" if state=="Rio Grande do Sul"
replace state_fips  = "50" if state=="Mato Grosso do Sul"
replace state_fips  = "51" if state=="Mato Grosso"
replace state_fips  = "52" if state=="Goi‡s"
replace state_fips  = "53" if state=="Distrito Federal"

save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_2009_renamed_port_statefips, replace

use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/pop_tot_age_2009", clear


29	Bahia31	Minas Gerais32	Espirito Santo33	Rio de Janeiro35	S‹o Paulo41	Paran‡42	Santa Catarina43	Rio Grande do Sul50	Mato Grosso do Sul51	Mato Grosso52	Goi‡s53	Distrito Federal




11	Rond™nia12	Acre13	Amazonas14	Roraima15	Par‡16	Amap‡17	Tocantinsreplace state_fips = 21	Maranh‹oreplace state_fips = 22	Piau’replace state_fips = 23	Cear‡replace state_fips = 24	Rio Grande do Nortereplace state_fips = 25	Para’bareplace state_fips = 26	Pernambucoreplace state_fips = 27	Alagoasreplace state_fips = 28	Sergipe29	Bahia31	Minas Gerais32	Espirito Santo33	Rio de Janeiro35	S‹o Paulo41	Paran‡42	Santa Catarina43	Rio Grande do Sul50	Mato Grosso do Sul51	Mato Grosso52	Goi‡s53	Distrito Federal
