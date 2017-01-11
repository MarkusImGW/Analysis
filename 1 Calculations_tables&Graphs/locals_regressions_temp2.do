

**** T-R/U-
local omitted_bin bin_22C_25C_urban
local bins bin_0C_13C bin_13C_16C bin_16C_19C bin_19C_22C bin_22C_25C bin_25C_28C bin_28C_Inf
local ruralvar rural urban
*local climate COLD MEDIUM HOT
foreach i of local bins{
	foreach j of local ruralvar{
			if "`i'_`j'" != "`omitted_bin'" {
			di "`i'_`j'"
			local rhs `rhs' `i'_`j'
			  }
			else {
			di "omitted bin `i'_`j'
			}
	}	
}

********************************************************************************
********* Table 4: Rural-Urban Interactions// Semi and Full, County & Year FE - C&S-YFE  **********
********************************************************************************

*************
*** FULL ****
*************

**** T-M/C/H ; Creating the regression interactions for temperature and Climate
local omitted_bin bin_22C_25C_MEDIUM
local bins bin_0C_13C bin_13C_16C bin_16C_19C bin_19C_22C bin_22C_25C bin_25C_28C bin_28C_Inf
* local ruralvar rural urban
local climate COLD MEDIUM HOT
foreach i of local bins{
	foreach j of local climate{
			if "`i'_`j'" != "`omitted_bin'" {
			di "`i'_`j'"
			local rhs `rhs' `i'_`j'
			  }
			else {
			di "omitted bin `i'_`j'
			}
	}	
}

*************
*** SEMI ****
*************



**** All interactions T-R/U-M/C/H ;
local omitted_bin bin_22C_25C_urban_MEDIUM
local bins bin_0C_13C bin_13C_16C bin_16C_19C bin_19C_22C bin_22C_25C bin_25C_28C bin_28C_Inf
local ruralvar rural urban
local climate COLD MEDIUM HOT
foreach i of local bins{
	foreach j of local ruralvar{
		foreach k of local climate {
			if "`i'_`j'_`k'" != "`omitted_bin'" {
			di "`i'_`j'_`k'"
			local rhs `rhs' `i'_`j'_`k'
			  }
			else {
			di "omitted bin `i'_`j'_`k'"
			}
		}
	}	
}
