
***** Population Data *********
use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/pop_age_2012", clear
format %60s id_municipality 

** Seems to have the same signs as the stata file from 
replace id_municipality  = subinstr(id_municipality ,"�","i",.) // �
replace id_municipality  = subinstr(id_municipality ,"dos indios","dos Indios",.) //
** Interesting, no replacements here, indicating dos Indios is not in the sample or was coded differently.
replace id_municipality  = subinstr(id_municipality ,"�","e",.) // �
replace id_municipality  = subinstr(id_municipality ,"�","e",.) // �
replace id_municipality  = subinstr(id_municipality ,"�","a",.) // �
replace id_municipality  = subinstr(id_municipality ,"�","a",.) // �
replace id_municipality  = subinstr(id_municipality ,"�","a",.) // �
replace id_municipality  = subinstr(id_municipality ,"�","o",.) // �
replace id_municipality  = subinstr(id_municipality ,"�","o",.) // �
replace id_municipality  = subinstr(id_municipality ,"X","o",.) // �
replace id_municipality  = subinstr(id_municipality ,"�","u",.) // �
replace id_municipality  = subinstr(id_municipality ,"�","c",.) // �
replace id_municipality  = subinstr(id_municipality ,"�","a",.) // �

** 110040 Alto Para�so
** 110143 Nova Uni�o
** 110025 Presidente M�dici
110148 S�o Felipe D'Oeste
130008 Anam�

***** Mortality Data *********

use /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_2012_renamed.dta, clear

use "/Users/arvidviaene/Documents/output2/output/0_0_0_9_0_0_0_0" , clear
use /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_2012_renamed.dta, clear

rename municiacutepio id_municipality
replace id_municipality = subinstr(id_municipality,"&iacute;","i",.) // � 
replace id_municipality = subinstr(id_municipality,"&atilde;","a",.) // �
replace id_municipality = subinstr(id_municipality,"&aacute;","a",.) //�
replace id_municipality = subinstr(id_municipality,"&eacute;","e",.) //�
replace id_municipality = subinstr(id_municipality,"&acirc;","a",.) // �
replace id_municipality = subinstr(id_municipality,"&ccedil;a","ca",.) // ��
replace id_municipality = subinstr(id_municipality,"&ocirc;","o",.) // �
replace id_municipality = subinstr(id_municipality,"&oacute;","o",.) // �
replace id_municipality = subinstr(id_municipality,"&ccedil;","c",.) // �
replace id_municipality = subinstr(id_municipality,"&ecirc","e",.) // �
replace id_municipality = subinstr(id_municipality,"&Aacute;","A",.) // �
replace id_municipality = subinstr(id_municipality,"&otilde;","o",.) // �
replace id_municipality = subinstr(id_municipality,"&uacute;","u",.) // �
replace id_municipality = subinstr(id_municipality,"&Iacute","I",.) // �
replace id_municipality = subinstr(id_municipality,"I;n","In",.) // �n
replace id_municipality = subinstr(id_municipality,"e;","e",.) // e






***** TEMPERATURE DATA ********* (already inserted in the Sum_Temp_Bins file)

use /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_year.dta, clear 
rename NAME_1_NAME_2 municipality
keep if year == 2012
* careful with the first one as there are also names starting with this character
** 4 changes made Alagoas-Palmeira dos �ndios // I can just do a search on ( �), now I'll just go ahead BUT CHECK THIS 
replace municipality = subinstr(municipality,"�","i",.) // �
replace municipality = subinstr(municipality,"dos indios","dos Indios",.) //
replace municipallity = subinstr(municipality,"�","e",.) // �
replace municipality = subinstr(municipality,"�","e",.) // �
replace municipality = subinstr(municipality,"�","a",.) // �
replace municipality = subinstr(municipality,"�","a",.) // �
replace municipality = subinstr(municipality,"�","a",.) // �
replace municipality = subinstr(municipality,"�","o",.) // �
replace municipality = subinstr(municipality,"�","o",.) // �
replace municipality = subinstr(municipality,"X","o",.) // �
replace municipality = subinstr(municipality,"�","u",.) // �
replace municipality = subinstr(municipality,"�","c",.) // �
replace municipality = subinstr(municipality,"�","a",.) // �
*Alagoas-�gua Branca
** 11 signs in BEST data that were weird => have 11 so far, let's see if there are more.

save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_2012_renamed.dta, replace



// Renaming Population data 

// This is the MORTALITY DATA!!
*use "/Users/arvidviaene/Documents/output2/output/0_0_0_9_0_0_0_0" , clear
use /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/0_0_0_1_0_0_0_0 , clear
drop if month != 13
rename municiacutepio municipality
** Going to replace the letters with normal letters instead of the portuguese ones, so that other transformations between stata and formats preserve the format
replace municipality = subinstr(municipality,"&iacute;","i",.) // � 
replace municipality = subinstr(municipality,"&atilde;","a",.) // �
replace municipality = subinstr(municipality,"&aacute;","a",.) //�
replace municipality = subinstr(municipality,"&eacute;","e",.) //�
replace municipality = subinstr(municipality,"&acirc;","a",.) // �
replace municipality = subinstr(municipality,"&ccedil;a","ca",.) // ��
replace municipality = subinstr(municipality,"&ocirc;","o",.) // �
replace municipality = subinstr(municipality,"&oacute;","o",.) // �
replace municipality = subinstr(municipality,"&ccedil;","c",.) // �
replace municipality = subinstr(municipality,"&ecirc","e",.) // �
replace municipality = subinstr(municipality,"&Aacute;","A",.) // �
replace municipality = subinstr(municipality,"&otilde;","o",.) // �
replace municipality = subinstr(municipality,"&uacute;","u",.) // �
replace municipality = subinstr(municipality,"&Iacute","I",.) // �
replace municipality = subinstr(municipality,"I;n","In",.) // �n
replace municipality = subinstr(municipality,"e;","e",.) // e
** 11 signs in BEST data that were weird => have 11 so far, let's see if there are more.

** 150613 Reden&ccedil;ao // &ccedil;a = ��
**&ocirc; // &ocirc = �
** 150620 Salin&oacute;polis &oacute; //&oacute; = �
** 170300 Baba&ccedil;ulandia �ul�ndia // &ccedil; = �  //BABA�UL�NDIA
** 220710 Olho D'&Aacute;gua do Piaui // &Aacute; = �
** 520465 Campina&ccedil; // &ccedil; = �
** 432185 Tr&ecirc;s Palmeiras // &ecirc; = �
** 210663 Mat&otilde;es do Norte
** 240870 Para&uacute;
** 350335 Arco-&Iacute;ris
** 431555 Rio dos I;ndios



*************************

use /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_year.dta, clear 
*keep if year == 2002
replace municipality = subinstr(municipality,"�","i",.) // �
** careful with this one as there are also names starting with this character
replace municipality = subinstr(municipality,"dos indios","dos Indios",.) //
* 4 changes made
* Alagoas-Palmeira dos �ndios
** I can just do a search on ( �), now I'll just go ahead BUT CHECK THIS 

replace municipality = subinstr(municipality,"�","e",.) // �
replace municipality = subinstr(municipality,"�","e",.) // �
replace municipality = subinstr(municipality,"�","a",.) // �
replace municipality = subinstr(municipality,"�","a",.) // �
replace municipality = subinstr(municipality,"�","a",.) // �
replace municipality = subinstr(municipality,"�","o",.) // �
replace municipality = subinstr(municipality,"�","o",.) // �
replace municipality = subinstr(municipality,"X","o",.) // �
replace municipality = subinstr(municipality,"�","u",.) // �
replace municipality = subinstr(municipality,"�","c",.) // �
replace municipality = subinstr(municipality,"�","a",.) // �
*Alagoas-�gua Branca
** 11 signs in BEST data that were weird => have 11 so far, let's see if there are more.

save /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_2012_renamed.dta, replace


