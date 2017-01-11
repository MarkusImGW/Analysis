******************************
***** Arvid Viaene - UoC *****




******* MERGING OF DATA TO ONE DTA-FILE WHICH CAN BE SAVED***



******* MERGING OF DATA TO ONE DTA-FILE WHICH CAN BE SAVED***

*****************************************************
*** Merging within Mortality data on Municpalities **
*****************************************************

////testing 1996-1997 ////
use 0_0_0_17_0_0_0_0, clear
merge 1:1 municiacutepio month using 0_0_0_16_0_0_0_0
//Reducing it to one month to see numbers
drop if month != 1
tab _merge
// 24 observations from 1996 not matched to 1997
// 505 observations from 1997 not matched with 1996
// 4934 counties matched

////testing 1997-1998 ////
use 0_0_0_16_0_0_0_0, clear
merge 1:1 municiacutepio month using 0_0_0_15_0_0_0_0
//Reducing it to one month to see numbers
drop if month != 1
tab _merge
// 37 counties from 1997 not matched with counties in 1998
// 70 counties from 1998 not matched with counties in 1997
// 5402 counties matched

////testing 1998-1999 ////
use 0_0_0_15_0_0_0_0, clear
merge 1:1 municiacutepio month using 0_0_0_14_0_0_0_0
//Reducing it to one month to see numbers
drop if month != 1
tab _merge
// 13 counties from 1997 not matched with counties in 1998
// 53 counties from 1998 not matched with counties in 1997
// 5459 counties matched

////testing 1999-2000 ////
use 0_0_0_14_0_0_0_0, clear
merge 1:1 municiacutepio month using 0_0_0_13_0_0_0_0
//Reducing it to one month to see numbers
drop if month != 1
tab _merge
// 10 counties from 1997 not matched with counties in 1998
// 21 counties from 1998 not matched with counties in 1997
// 5459 counties matched

forval i=1/17{
use 0_0_0_`i'_0_0_0_0, clear
local j = `i' - 1
merge 1:1 municiacutepio month using 0_0_0_`j'_0_0_0_0
//Reducing it to one month to see numbers
drop if month != 1
di `i'
tab _merge
}
//from 2002 onwards (12), only about 6 unmatched a year

*** /// 2012 and 2013 /// ***
use 0_0_0_1_0_0_0_0, clear
merge 1:1 municiacutepio month using 0_0_0_0_0_0_0_0
drop if month != 1
tab _merge
// The ones from 2012 that are not in 2012 
drop if _merge != 1
* Weird, this seems to be a summary category "ignorado" for a province; not sure what to make of this
* 160000 Munic&iacute;pio ignorado - AP
// The ones from 2013 that are not in 2012
drop if _merge !=2
* 140000 Munic&iacute;pio ignorado - RR but this time in vice versa => could this be the same one?
* 421265 Pescaria Brava; also gained independence in 2013 from munic’pio de Laguna 4209409
* 422000 Balneacute;
* 431454 Pinto Bandeira =>seems to have declared independence in 2013 from Bento Gonalves
* 500627 Para&iacute;so das &Aacute;guas


*** /// 2009 and 2010 /// ***
use 0_0_0_4_0_0_0_0, clear
merge 1:1 municiacutepio month using 0_0_0_3_0_0_0_0
drop if month != 1
tab _merge
// The ones from 2009 that are not in 2010//
drop if _merge != 1
** 120000 Munic&iacute;pio ignorado - AC
// The ones from 2010 that are not in 2009//
drop if _merge !=2
** 140000 Munic&iacute;pio ignorado - RR

*** /// 2008 and 2009 /// ***
use 0_0_0_5_0_0_0_0, clear
merge 1:1 municiacutepio month using 0_0_0_4_0_0_0_0
drop if month != 1
tab _merge
// The ones from 2008 that are not in 2009//
drop if _merge != 1
* 120000 Munic&iacute;pio ignorado - AC
* 120000 Munic&iacute;pio ignorado - AP
* 500000 Munic&iacute;pio ignorado - MS
// The ones from 2009 that are not in 2008//
drop if _merge !=2
// The ones from 2009 that are not in 2008//
* 220672 Naz&aacute;ria
* 260545 Fernando de Noronha
* 430000 Munic&iacute;pio ignorado - RS
* 510788 Serra Nova Dourada

*** /// 2007 and 2008 /// ***
use 0_0_0_6_0_0_0_0, clear
merge 1:1 municiacutepio month using 0_0_0_5_0_0_0_0
drop if month != 1
tab _merge
// The ones from 2007 that are not in 2008//
drop if _merge != 1
* 260545 Fernando de Noronha
* 430000 Munic&iacute;pio ignorado - RS
* 510788 Serra Nova Dourada
// The ones from 2008 that are not in 2009//
drop if _merge !=2
// The ones from 2009 that are not in 2008//
* 500000 Munic&iacute;pio ignorado - MS

*** /// 2006 and 2007 /// ***
use 0_0_0_7_0_0_0_0, clear
merge 1:1 municiacutepio month using 0_0_0_6_0_0_0_0
drop if month != 1
tab _merge
// The ones from 2006 that are not in 2007//
drop if _merge != 1
* 260545 Fernando de Noronha
* 430000 Munic&iacute;pio ignorado - RS
* 510788 Serra Nova Dourada
// The ones from 2008 that are not in 2009//
drop if _merge !=2
// The ones from 2007 that are not in 2006//
* 240000 Munic&iacute;pio ignorado - RN

*** /// 2005 and 2006 /// ***
use 0_0_0_8_0_0_0_0, clear
merge 1:1 municiacutepio month using 0_0_0_7_0_0_0_0
drop if month != 1
tab _merge
// The ones from 2005 that are not in 2006//
drop if _merge != 1
di municiacutepio
* 240000 Munic&iacute;pio ignorado - RN
* 500000 Munic&iacute;pio ignorado - MS
// The ones from 2008 that are not in 2009//
drop if _merge !=2
// The ones from 2006 that are not in 2005//
* 160000 Munic&iacute;pio ignorado - AP
* 172085 Sucupira

******************************************
*** Merging mortality with Temperature ***
******************************************
// Checking this for 2005
use "/Users/arvidviaene/Documents/output2/output/0_0_0_8_0_0_0_0", clear
rename municiacutepio NAME_1_NAME_2
drop if month !=13
drop month
merge 1:1 NAME_1_NAME_2 using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/BEST_tavg_BIN_26C_27C.dta"

******************************************
*** Merging mortality with population ****
******************************************
// Checking this for 2004
use "/Users/arvidviaene/Documents/output2/output/0_0_0_9_0_0_0_0" , clear
drop if month != 13
drop month
merge 1:1 municiacutepio using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Intermediate/pop_tot_age_2004"
sort municiacutepio
** The mismatches do come from the fact that stata reads in the files differently and thus has different characters for some of the special signs.

******************************************
*** Merging population with temperature **
******************************************
use /Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/sum_2012_renamed.dta, clear
merge 1:1
save "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Intermediate/Intermediate/pop_tot_age_2012", replace

******************************************
*** Merging between temperature datasets**
******************************************


use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/BEST_tavg_BIN_26C_27C.dta"
merge 1:1 NAME_1_NAME_2 year using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/BEST_tavg_BIN_25C_26C.dta"
drop _merge
merge 1:1 NAME_1_NAME_2 year using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/BEST_tavg_BIN_24C_25C.dta"
** perfect match
use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/BEST_tavg_BIN_26C_27C.dta", clear

use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/UDEL-temp.dta", clear
merge 1:1 NAME_1_NAME_2 year using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/BEST_tavg_BIN_24C_25C.dta"
** 11008 observations not matched from the 335,744 data points
** they all seem to be in the years 2011-2012. (5504x2) 
** => UDEL does not have data from 2010 onwards? How do we get precipitation in that case?
** BEST data goes until 2012

use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/NCEP-dd20.dta", clear
merge 1:1 NAME_1_NAME_2 year using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/BEST_tavg_BIN_24C_25C.dta"
** NCEP data goes from 1948 to 2013
** 16,512 (so three years are not matched here: 2013, and 1948 and 1949 as BEST starts from 1950. Otherwise there is perfect fit between the counties

use "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/NCEP-dd20.dta", clear
merge 1:1 NAME_1_NAME_2 year using "/Users/arvidviaene/Dropbox/Viaene_MortalityHospAdmBrazil/Data/Raw/Data/ClimateData_2/BEST_tavg_BIN_24C_25C.dta"








