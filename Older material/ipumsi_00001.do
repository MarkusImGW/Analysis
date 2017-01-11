* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off

clear
quietly infix              ///
  int     cntry     1-3    ///
  int     year      4-7    ///
  int     sample    8-11   ///
  double  serial    12-21  ///
  long    geo1a_br  22-27  ///
  long    geo2b_br  28-34  ///
  long    munibr    35-41  ///
  int     metrobr   42-44  ///
  int     pernum    45-47  ///
  float   wtper     48-55  ///
  int     age       56-58  ///
  byte    sex       59-59  ///
  using `"ipumsi_00001.dat"'

replace wtper    = wtper    / 100

format serial   %10.0f
format wtper    %8.2f

label var cntry    `"Country"'
label var year     `"Year"'
label var sample   `"IPUMS sample identifier"'
label var serial   `"Household serial number"'
label var geo1a_br `"State, Brazil [Level 1; consistent boundaries over time]"'
label var geo2b_br `"Municipality, Brazil [Level 2; inconsistent boundaries, harmonized by name]"'
label var munibr   `"Municipality, Brazil -- compatible 1980-2000"'
label var metrobr  `"Metropolitan region, Brazil"'
label var pernum   `"Person number"'
label var wtper    `"Person weight"'
label var age      `"Age"'
label var sex      `"Sex"'

label define cntry_lbl 032 `"Argentina"'
label define cntry_lbl 051 `"Armenia"', add
label define cntry_lbl 040 `"Austria"', add
label define cntry_lbl 050 `"Bangladesh"', add
label define cntry_lbl 112 `"Belarus"', add
label define cntry_lbl 068 `"Bolivia"', add
label define cntry_lbl 076 `"Brazil"', add
label define cntry_lbl 854 `"Burkina Faso"', add
label define cntry_lbl 116 `"Cambodia"', add
label define cntry_lbl 120 `"Cameroon"', add
label define cntry_lbl 124 `"Canada"', add
label define cntry_lbl 152 `"Chile"', add
label define cntry_lbl 156 `"China"', add
label define cntry_lbl 170 `"Colombia"', add
label define cntry_lbl 188 `"Costa Rica"', add
label define cntry_lbl 192 `"Cuba"', add
label define cntry_lbl 214 `"Dominican Republic"', add
label define cntry_lbl 218 `"Ecuador"', add
label define cntry_lbl 818 `"Egypt"', add
label define cntry_lbl 222 `"El Salvador"', add
label define cntry_lbl 242 `"Fiji"', add
label define cntry_lbl 250 `"France"', add
label define cntry_lbl 276 `"Germany"', add
label define cntry_lbl 288 `"Ghana"', add
label define cntry_lbl 300 `"Greece"', add
label define cntry_lbl 324 `"Guinea"', add
label define cntry_lbl 332 `"Haiti"', add
label define cntry_lbl 348 `"Hungary"', add
label define cntry_lbl 356 `"India"', add
label define cntry_lbl 360 `"Indonesia"', add
label define cntry_lbl 364 `"Iran"', add
label define cntry_lbl 368 `"Iraq"', add
label define cntry_lbl 372 `"Ireland"', add
label define cntry_lbl 376 `"Israel"', add
label define cntry_lbl 380 `"Italy"', add
label define cntry_lbl 388 `"Jamaica"', add
label define cntry_lbl 400 `"Jordan"', add
label define cntry_lbl 404 `"Kenya"', add
label define cntry_lbl 417 `"Kyrgyz Republic"', add
label define cntry_lbl 430 `"Liberia"', add
label define cntry_lbl 454 `"Malawi"', add
label define cntry_lbl 458 `"Malaysia"', add
label define cntry_lbl 466 `"Mali"', add
label define cntry_lbl 484 `"Mexico"', add
label define cntry_lbl 496 `"Mongolia"', add
label define cntry_lbl 504 `"Morocco"', add
label define cntry_lbl 524 `"Nepal"', add
label define cntry_lbl 528 `"Netherlands"', add
label define cntry_lbl 558 `"Nicaragua"', add
label define cntry_lbl 566 `"Nigeria"', add
label define cntry_lbl 586 `"Pakistan"', add
label define cntry_lbl 275 `"Palestine"', add
label define cntry_lbl 591 `"Panama"', add
label define cntry_lbl 604 `"Peru"', add
label define cntry_lbl 608 `"Philippines"', add
label define cntry_lbl 620 `"Portugal"', add
label define cntry_lbl 630 `"Puerto Rico"', add
label define cntry_lbl 642 `"Romania"', add
label define cntry_lbl 646 `"Rwanda"', add
label define cntry_lbl 662 `"Saint Lucia"', add
label define cntry_lbl 686 `"Senegal"', add
label define cntry_lbl 694 `"Sierra Leone"', add
label define cntry_lbl 705 `"Slovenia"', add
label define cntry_lbl 710 `"South Africa"', add
label define cntry_lbl 728 `"South Sudan"', add
label define cntry_lbl 724 `"Spain"', add
label define cntry_lbl 729 `"Sudan"', add
label define cntry_lbl 756 `"Switzerland"', add
label define cntry_lbl 834 `"Tanzania"', add
label define cntry_lbl 764 `"Thailand"', add
label define cntry_lbl 792 `"Turkey"', add
label define cntry_lbl 800 `"Uganda"', add
label define cntry_lbl 804 `"Ukraine"', add
label define cntry_lbl 826 `"United Kingdom"', add
label define cntry_lbl 840 `"United States"', add
label define cntry_lbl 858 `"Uruguay"', add
label define cntry_lbl 862 `"Venezuela"', add
label define cntry_lbl 704 `"Vietnam"', add
label define cntry_lbl 894 `"Zambia"', add
label values cntry cntry_lbl

label define year_lbl 1960 `"1960"'
label define year_lbl 1962 `"1962"', add
label define year_lbl 1963 `"1963"', add
label define year_lbl 1964 `"1964"', add
label define year_lbl 1966 `"1966"', add
label define year_lbl 1968 `"1968"', add
label define year_lbl 1969 `"1969"', add
label define year_lbl 1970 `"1970"', add
label define year_lbl 1971 `"1971"', add
label define year_lbl 1972 `"1972"', add
label define year_lbl 1973 `"1973"', add
label define year_lbl 1974 `"1974"', add
label define year_lbl 1975 `"1975"', add
label define year_lbl 1976 `"1976"', add
label define year_lbl 1977 `"1977"', add
label define year_lbl 1979 `"1979"', add
label define year_lbl 1980 `"1980"', add
label define year_lbl 1981 `"1981"', add
label define year_lbl 1982 `"1982"', add
label define year_lbl 1983 `"1983"', add
label define year_lbl 1984 `"1984"', add
label define year_lbl 1985 `"1985"', add
label define year_lbl 1986 `"1986"', add
label define year_lbl 1987 `"1987"', add
label define year_lbl 1989 `"1989"', add
label define year_lbl 1990 `"1990"', add
label define year_lbl 1991 `"1991"', add
label define year_lbl 1992 `"1992"', add
label define year_lbl 1993 `"1993"', add
label define year_lbl 1994 `"1994"', add
label define year_lbl 1995 `"1995"', add
label define year_lbl 1996 `"1996"', add
label define year_lbl 1997 `"1997"', add
label define year_lbl 1998 `"1998"', add
label define year_lbl 1999 `"1999"', add
label define year_lbl 2000 `"2000"', add
label define year_lbl 2001 `"2001"', add
label define year_lbl 2002 `"2002"', add
label define year_lbl 2003 `"2003"', add
label define year_lbl 2004 `"2004"', add
label define year_lbl 2005 `"2005"', add
label define year_lbl 2006 `"2006"', add
label define year_lbl 2007 `"2007"', add
label define year_lbl 2008 `"2008"', add
label define year_lbl 2009 `"2009"', add
label define year_lbl 2010 `"2010"', add
label define year_lbl 2011 `"2011"', add
label values year year_lbl

label define sample_lbl 0321 `"Argentina 1970"'
label define sample_lbl 0322 `"Argentina 1980"', add
label define sample_lbl 0323 `"Argentina 1991"', add
label define sample_lbl 0324 `"Argentina 2001"', add
label define sample_lbl 0325 `"Argentina 2010"', add
label define sample_lbl 0511 `"Armenia 2001"', add
label define sample_lbl 0401 `"Austria 1971"', add
label define sample_lbl 0402 `"Austria 1981"', add
label define sample_lbl 0403 `"Austria 1991"', add
label define sample_lbl 0404 `"Austria 2001"', add
label define sample_lbl 0501 `"Bangladesh 1991"', add
label define sample_lbl 0502 `"Bangladesh 2001"', add
label define sample_lbl 0503 `"Bangladesh 2011"', add
label define sample_lbl 0681 `"Bolivia 1976"', add
label define sample_lbl 0682 `"Bolivia 1992"', add
label define sample_lbl 0683 `"Bolivia 2001"', add
label define sample_lbl 0761 `"Brazil 1960"', add
label define sample_lbl 0762 `"Brazil 1970"', add
label define sample_lbl 0763 `"Brazil 1980"', add
label define sample_lbl 0764 `"Brazil 1991"', add
label define sample_lbl 0765 `"Brazil 2000"', add
label define sample_lbl 0766 `"Brazil 2010"', add
label define sample_lbl 1121 `"Belarus 1999"', add
label define sample_lbl 8541 `"Burkina Faso 1985"', add
label define sample_lbl 8542 `"Burkina Faso 1996"', add
label define sample_lbl 8543 `"Burkina Faso 2006"', add
label define sample_lbl 1161 `"Cambodia 1998"', add
label define sample_lbl 1162 `"Cambodia 2008"', add
label define sample_lbl 1201 `"Cameroon 1976"', add
label define sample_lbl 1202 `"Cameroon 1987"', add
label define sample_lbl 1203 `"Cameroon 2005"', add
label define sample_lbl 1241 `"Canada 1971"', add
label define sample_lbl 1242 `"Canada 1981"', add
label define sample_lbl 1243 `"Canada 1991"', add
label define sample_lbl 1244 `"Canada 2001"', add
label define sample_lbl 1521 `"Chile 1960"', add
label define sample_lbl 1522 `"Chile 1970"', add
label define sample_lbl 1523 `"Chile 1982"', add
label define sample_lbl 1524 `"Chile 1992"', add
label define sample_lbl 1525 `"Chile 2002"', add
label define sample_lbl 1561 `"China 1982"', add
label define sample_lbl 1562 `"China 1990"', add
label define sample_lbl 1701 `"Colombia 1964"', add
label define sample_lbl 1702 `"Colombia 1973"', add
label define sample_lbl 1703 `"Colombia 1985"', add
label define sample_lbl 1704 `"Colombia 1993"', add
label define sample_lbl 1705 `"Colombia 2005"', add
label define sample_lbl 1881 `"Costa Rica 1963"', add
label define sample_lbl 1882 `"Costa Rica 1973"', add
label define sample_lbl 1883 `"Costa Rica 1984"', add
label define sample_lbl 1884 `"Costa Rica 2000"', add
label define sample_lbl 1921 `"Cuba 2002"', add
label define sample_lbl 2141 `"Dominican Republic 1960"', add
label define sample_lbl 2142 `"Dominican Republic 1970"', add
label define sample_lbl 2143 `"Dominican Republic 1981"', add
label define sample_lbl 2144 `"Dominican Republic 2002"', add
label define sample_lbl 2145 `"Dominican Republic 2010"', add
label define sample_lbl 2181 `"Ecuador 1962"', add
label define sample_lbl 2182 `"Ecuador 1974"', add
label define sample_lbl 2183 `"Ecuador 1982"', add
label define sample_lbl 2184 `"Ecuador 1990"', add
label define sample_lbl 2185 `"Ecuador 2001"', add
label define sample_lbl 2186 `"Ecuador 2010"', add
label define sample_lbl 8181 `"Egypt 1996"', add
label define sample_lbl 8182 `"Egypt 2006"', add
label define sample_lbl 2221 `"El Salvador 1992"', add
label define sample_lbl 2222 `"El Salvador 2007"', add
label define sample_lbl 2421 `"Fiji 1966"', add
label define sample_lbl 2422 `"Fiji 1976"', add
label define sample_lbl 2423 `"Fiji 1986"', add
label define sample_lbl 2424 `"Fiji 1996"', add
label define sample_lbl 2425 `"Fiji 2007"', add
label define sample_lbl 2501 `"France 1962"', add
label define sample_lbl 2502 `"France 1968"', add
label define sample_lbl 2503 `"France 1975"', add
label define sample_lbl 2504 `"France 1982"', add
label define sample_lbl 2505 `"France 1990"', add
label define sample_lbl 2506 `"France 1999"', add
label define sample_lbl 2507 `"France 2006"', add
label define sample_lbl 2761 `"Germany 1970 (West)"', add
label define sample_lbl 2762 `"Germany 1971 (East)"', add
label define sample_lbl 2763 `"Germany 1981 (East)"', add
label define sample_lbl 2764 `"Germany 1987 (West)"', add
label define sample_lbl 2881 `"Ghana 2000"', add
label define sample_lbl 2882 `"Ghana 2010"', add
label define sample_lbl 3001 `"Greece 1971"', add
label define sample_lbl 3002 `"Greece 1981"', add
label define sample_lbl 3003 `"Greece 1991"', add
label define sample_lbl 3004 `"Greece 2001"', add
label define sample_lbl 3241 `"Guinea 1983"', add
label define sample_lbl 3242 `"Guinea 1996"', add
label define sample_lbl 3321 `"Haiti 1971"', add
label define sample_lbl 3322 `"Haiti 1982"', add
label define sample_lbl 3323 `"Haiti 2003"', add
label define sample_lbl 3481 `"Hungary 1970"', add
label define sample_lbl 3482 `"Hungary 1980"', add
label define sample_lbl 3483 `"Hungary 1990"', add
label define sample_lbl 3484 `"Hungary 2001"', add
label define sample_lbl 3561 `"India 1983"', add
label define sample_lbl 3562 `"India 1987"', add
label define sample_lbl 3563 `"India 1993"', add
label define sample_lbl 3564 `"India 1999"', add
label define sample_lbl 3565 `"India 2004"', add
label define sample_lbl 3601 `"Indonesia 1971"', add
label define sample_lbl 3602 `"Indonesia 1976"', add
label define sample_lbl 3603 `"Indonesia 1980"', add
label define sample_lbl 3604 `"Indonesia 1985"', add
label define sample_lbl 3605 `"Indonesia 1990"', add
label define sample_lbl 3606 `"Indonesia 1995"', add
label define sample_lbl 3607 `"Indonesia 2000"', add
label define sample_lbl 3608 `"Indonesia 2005"', add
label define sample_lbl 3609 `"Indonesia 2010"', add
label define sample_lbl 3641 `"Iran 2006"', add
label define sample_lbl 3681 `"Iraq 1997"', add
label define sample_lbl 3721 `"Ireland 1971"', add
label define sample_lbl 3722 `"Ireland 1979"', add
label define sample_lbl 3723 `"Ireland 1981"', add
label define sample_lbl 3724 `"Ireland 1986"', add
label define sample_lbl 3725 `"Ireland 1991"', add
label define sample_lbl 3726 `"Ireland 1996"', add
label define sample_lbl 3727 `"Ireland 2002"', add
label define sample_lbl 3728 `"Ireland 2006"', add
label define sample_lbl 3729 `"Ireland 2011"', add
label define sample_lbl 3761 `"Israel 1972"', add
label define sample_lbl 3762 `"Israel 1983"', add
label define sample_lbl 3763 `"Israel 1995"', add
label define sample_lbl 3801 `"Italy 2001"', add
label define sample_lbl 3881 `"Jamaica 1982"', add
label define sample_lbl 3882 `"Jamaica 1991"', add
label define sample_lbl 3883 `"Jamaica 2001"', add
label define sample_lbl 4001 `"Jordan 2004"', add
label define sample_lbl 4041 `"Kenya 1969"', add
label define sample_lbl 4042 `"Kenya 1979"', add
label define sample_lbl 4043 `"Kenya 1989"', add
label define sample_lbl 4044 `"Kenya 1999"', add
label define sample_lbl 4045 `"Kenya 2009"', add
label define sample_lbl 4171 `"Kyrgyz Republic 1999"', add
label define sample_lbl 4172 `"Kyrgyz Republic 2009"', add
label define sample_lbl 4301 `"Liberia 1974"', add
label define sample_lbl 4302 `"Liberia 2008"', add
label define sample_lbl 4541 `"Malawi 1987"', add
label define sample_lbl 4542 `"Malawi 1998"', add
label define sample_lbl 4543 `"Malawi 2008"', add
label define sample_lbl 4581 `"Malaysia 1970"', add
label define sample_lbl 4582 `"Malaysia 1980"', add
label define sample_lbl 4583 `"Malaysia 1991"', add
label define sample_lbl 4584 `"Malaysia 2000"', add
label define sample_lbl 4661 `"Mali 1987"', add
label define sample_lbl 4662 `"Mali 1998"', add
label define sample_lbl 4663 `"Mali 2009"', add
label define sample_lbl 4841 `"Mexico 1960"', add
label define sample_lbl 4842 `"Mexico 1970"', add
label define sample_lbl 4843 `"Mexico 1990"', add
label define sample_lbl 4844 `"Mexico 1995"', add
label define sample_lbl 4845 `"Mexico 2000"', add
label define sample_lbl 4846 `"Mexico 2005"', add
label define sample_lbl 4847 `"Mexico 2010"', add
label define sample_lbl 4961 `"Mongolia 1989"', add
label define sample_lbl 4962 `"Mongolia 2000"', add
label define sample_lbl 5041 `"Morocco 1982"', add
label define sample_lbl 5042 `"Morocco 1994"', add
label define sample_lbl 5043 `"Morocco 2004"', add
label define sample_lbl 5241 `"Nepal 2001"', add
label define sample_lbl 5281 `"Netherlands 1960"', add
label define sample_lbl 5282 `"Netherlands 1971"', add
label define sample_lbl 5283 `"Netherlands 2001"', add
label define sample_lbl 5581 `"Nicaragua 1971"', add
label define sample_lbl 5582 `"Nicaragua 1995"', add
label define sample_lbl 5583 `"Nicaragua 2005"', add
label define sample_lbl 5661 `"Nigeria 2006"', add
label define sample_lbl 5662 `"Nigeria 2007"', add
label define sample_lbl 5663 `"Nigeria 2008"', add
label define sample_lbl 5664 `"Nigeria 2009"', add
label define sample_lbl 5665 `"Nigeria 2010"', add
label define sample_lbl 5861 `"Pakistan 1973"', add
label define sample_lbl 5862 `"Pakistan 1981"', add
label define sample_lbl 5863 `"Pakistan 1998"', add
label define sample_lbl 2751 `"Palestine 1997"', add
label define sample_lbl 2752 `"Palestine 2007"', add
label define sample_lbl 5911 `"Panama 1960"', add
label define sample_lbl 5912 `"Panama 1970"', add
label define sample_lbl 5913 `"Panama 1980"', add
label define sample_lbl 5914 `"Panama 1990"', add
label define sample_lbl 5915 `"Panama 2000"', add
label define sample_lbl 5916 `"Panama 2010"', add
label define sample_lbl 6041 `"Peru 1993"', add
label define sample_lbl 6042 `"Peru 2007"', add
label define sample_lbl 6081 `"Philippines 1990"', add
label define sample_lbl 6082 `"Philippines 1995"', add
label define sample_lbl 6083 `"Philippines 2000"', add
label define sample_lbl 6201 `"Portugal 1981"', add
label define sample_lbl 6202 `"Portugal 1991"', add
label define sample_lbl 6203 `"Portugal 2001"', add
label define sample_lbl 6301 `"Puerto Rico 1970"', add
label define sample_lbl 6302 `"Puerto Rico 1980"', add
label define sample_lbl 6303 `"Puerto Rico 1990"', add
label define sample_lbl 6304 `"Puerto Rico 2000"', add
label define sample_lbl 6305 `"Puerto Rico 2005"', add
label define sample_lbl 6421 `"Romania 1977"', add
label define sample_lbl 6422 `"Romania 1992"', add
label define sample_lbl 6423 `"Romania 2002"', add
label define sample_lbl 6461 `"Rwanda 1991"', add
label define sample_lbl 6462 `"Rwanda 2002"', add
label define sample_lbl 6621 `"Saint Lucia 1980"', add
label define sample_lbl 6622 `"Saint Lucia 1991"', add
label define sample_lbl 6861 `"Senegal 1988"', add
label define sample_lbl 6862 `"Senegal 2002"', add
label define sample_lbl 6941 `"Sierra Leone 2004"', add
label define sample_lbl 7051 `"Slovenia 2002"', add
label define sample_lbl 7101 `"South Africa 1996"', add
label define sample_lbl 7102 `"South Africa 2001"', add
label define sample_lbl 7103 `"South Africa 2007"', add
label define sample_lbl 7241 `"Spain 1981"', add
label define sample_lbl 7242 `"Spain 1991"', add
label define sample_lbl 7243 `"Spain 2001"', add
label define sample_lbl 7281 `"South Sudan 2008"', add
label define sample_lbl 7291 `"Sudan 2008"', add
label define sample_lbl 7561 `"Switzerland 1970"', add
label define sample_lbl 7562 `"Switzerland 1980"', add
label define sample_lbl 7563 `"Switzerland 1990"', add
label define sample_lbl 7564 `"Switzerland 2000"', add
label define sample_lbl 8341 `"Tanzania 1988"', add
label define sample_lbl 8342 `"Tanzania 2002"', add
label define sample_lbl 7641 `"Thailand 1970"', add
label define sample_lbl 7642 `"Thailand 1980"', add
label define sample_lbl 7643 `"Thailand 1990"', add
label define sample_lbl 7644 `"Thailand 2000"', add
label define sample_lbl 7921 `"Turkey 1985"', add
label define sample_lbl 7922 `"Turkey 1990"', add
label define sample_lbl 7923 `"Turkey 2000"', add
label define sample_lbl 8001 `"Uganda 1991"', add
label define sample_lbl 8002 `"Uganda 2002"', add
label define sample_lbl 8041 `"Ukraine 2001"', add
label define sample_lbl 8261 `"United Kingdom 1991"', add
label define sample_lbl 8262 `"United Kingdom 2001"', add
label define sample_lbl 8401 `"United States 1960"', add
label define sample_lbl 8402 `"United States 1970"', add
label define sample_lbl 8403 `"United States 1980"', add
label define sample_lbl 8404 `"United States 1990"', add
label define sample_lbl 8405 `"United States 2000"', add
label define sample_lbl 8406 `"United States 2005"', add
label define sample_lbl 8407 `"United States 2010"', add
label define sample_lbl 8581 `"Uruguay 1963"', add
label define sample_lbl 8582 `"Uruguay 1975"', add
label define sample_lbl 8583 `"Uruguay 1985"', add
label define sample_lbl 8584 `"Uruguay 1996"', add
label define sample_lbl 8585 `"Uruguay 2006"', add
label define sample_lbl 8586 `"Uruguay 2011"', add
label define sample_lbl 8621 `"Venezuela 1971"', add
label define sample_lbl 8622 `"Venezuela 1981"', add
label define sample_lbl 8623 `"Venezuela 1990"', add
label define sample_lbl 8624 `"Venezuela 2001"', add
label define sample_lbl 7041 `"Vietnam 1989"', add
label define sample_lbl 7042 `"Vietnam 1999"', add
label define sample_lbl 7043 `"Vietnam 2009"', add
label define sample_lbl 8941 `"Zambia 1990"', add
label define sample_lbl 8942 `"Zambia 2000"', add
label define sample_lbl 8943 `"Zambia 2010"', add
label values sample sample_lbl

label define geo1a_br_lbl 076011 `"Rondonia"'
label define geo1a_br_lbl 076012 `"Acre"', add
label define geo1a_br_lbl 076013 `"Amazonas"', add
label define geo1a_br_lbl 076014 `"Roraima"', add
label define geo1a_br_lbl 076015 `"Pará"', add
label define geo1a_br_lbl 076016 `"Amapa"', add
label define geo1a_br_lbl 076021 `"Maranhao"', add
label define geo1a_br_lbl 076022 `"Piauí"', add
label define geo1a_br_lbl 076023 `"Ceará"', add
label define geo1a_br_lbl 076024 `"Rio Grande do Norte"', add
label define geo1a_br_lbl 076025 `"Paraiba"', add
label define geo1a_br_lbl 076026 `"Pernambuco"', add
label define geo1a_br_lbl 076027 `"Alagoas"', add
label define geo1a_br_lbl 076028 `"Sergipe"', add
label define geo1a_br_lbl 076029 `"Bahia"', add
label define geo1a_br_lbl 076031 `"Minas Gerais"', add
label define geo1a_br_lbl 076032 `"Espírito Santo"', add
label define geo1a_br_lbl 076033 `"Rio de Janeiro"', add
label define geo1a_br_lbl 076035 `"São Paulo"', add
label define geo1a_br_lbl 076041 `"Parana"', add
label define geo1a_br_lbl 076042 `"Santa Catarina"', add
label define geo1a_br_lbl 076043 `"Rio Grande do Sul"', add
label define geo1a_br_lbl 076051 `"Mato Grosso and Mato Grosso do Sul"', add
label define geo1a_br_lbl 076052 `"Goiás and Tocantins"', add
label define geo1a_br_lbl 076053 `"Distrito Federal"', add
label values geo1a_br geo1a_br_lbl

label define geo2b_br_lbl 1299999 `"Rest of Acre"'
label define geo2b_br_lbl 1200203 `"Cruzeiro do Sul**"', add
label define geo2b_br_lbl 1200302 `"Feijó"', add
label define geo2b_br_lbl 1200401 `"Rio Branco**"', add
label define geo2b_br_lbl 1200450 `"Senador Guiomard**"', add
label define geo2b_br_lbl 1200500 `"Sena Madureira"', add
label define geo2b_br_lbl 1200609 `"Tarauacá**"', add
label define geo2b_br_lbl 2799999 `"Rest of Alagoas"', add
label define geo2b_br_lbl 2700300 `"Arapiraca*"', add
label define geo2b_br_lbl 2700409 `"Atalaia"', add
label define geo2b_br_lbl 2701001 `"Boca da Mata"', add
label define geo2b_br_lbl 2701407 `"Campo Alegre*"', add
label define geo2b_br_lbl 2702306 `"Coruripe*"', add
label define geo2b_br_lbl 2702355 `"Craíbas"', add
label define geo2b_br_lbl 2702405 `"Delmiro Gouveia"', add
label define geo2b_br_lbl 2702603 `"Feira Grande"', add
label define geo2b_br_lbl 2702900 `"Girau do Ponciano"', add
label define geo2b_br_lbl 2703106 `"Igaci*"', add
label define geo2b_br_lbl 2703205 `"Igreja Nova"', add
label define geo2b_br_lbl 2703809 `"Joaquim Gomes"', add
label define geo2b_br_lbl 2704005 `"Junqueiro*"', add
label define geo2b_br_lbl 2704104 `"Lagoa da Canoa*"', add
label define geo2b_br_lbl 2704203 `"Limoeiro de Anadia"', add
label define geo2b_br_lbl 2704302 `"Maceió"', add
label define geo2b_br_lbl 2704500 `"Maragogi"', add
label define geo2b_br_lbl 2704708 `"Marechal Deodoro"', add
label define geo2b_br_lbl 2705002 `"Mata Grande"', add
label define geo2b_br_lbl 2705101 `"Matriz de Camaragibe"', add
label define geo2b_br_lbl 2705507 `"Murici"', add
label define geo2b_br_lbl 2706307 `"Palmeira dos Índios**"', add
label define geo2b_br_lbl 2706406 `"Pão de Açúcar"', add
label define geo2b_br_lbl 2706703 `"Penedo"', add
label define geo2b_br_lbl 2706901 `"Pilar"', add
label define geo2b_br_lbl 2707305 `"Porto Calvo"', add
label define geo2b_br_lbl 2707701 `"Rio Largo"', add
label define geo2b_br_lbl 2708006 `"Santana do Ipanema*"', add
label define geo2b_br_lbl 2708303 `"São José da Laje"', add
label define geo2b_br_lbl 2708402 `"São José da Tapera*"', add
label define geo2b_br_lbl 2708501 `"São Luís do Quitunde"', add
label define geo2b_br_lbl 2708600 `"São Miguel dos Campos"', add
label define geo2b_br_lbl 2708808 `"São Sebastião"', add
label define geo2b_br_lbl 2709152 `"Teotônio Vilela"', add
label define geo2b_br_lbl 2709202 `"Traipu"', add
label define geo2b_br_lbl 2709301 `"União dos Palmares"', add
label define geo2b_br_lbl 2709400 `"Viçosa"', add
label define geo2b_br_lbl 1699999 `"Rest of Amapá"', add
label define geo2b_br_lbl 1600279 `"Laranjal do Jari**"', add
label define geo2b_br_lbl 1600303 `"Macapá***"', add
label define geo2b_br_lbl 1600600 `"Santana"', add
label define geo2b_br_lbl 1399999 `"Rest of Amazonas"', add
label define geo2b_br_lbl 1300300 `"Autazes"', add
label define geo2b_br_lbl 1300409 `"Barcelos"', add
label define geo2b_br_lbl 1300508 `"Barreirinha*"', add
label define geo2b_br_lbl 1300607 `"Benjamin Constant*"', add
label define geo2b_br_lbl 1300706 `"Boca do Acre"', add
label define geo2b_br_lbl 1300805 `"Borba*"', add
label define geo2b_br_lbl 1301001 `"Carauari*"', add
label define geo2b_br_lbl 1301100 `"Careiro*"', add
label define geo2b_br_lbl 1301209 `"Coari"', add
label define geo2b_br_lbl 1301407 `"Eirunepé"', add
label define geo2b_br_lbl 1301605 `"Fonte Boa*"', add
label define geo2b_br_lbl 1301704 `"Humaitá"', add
label define geo2b_br_lbl 1301852 `"Iranduba"', add
label define geo2b_br_lbl 1301902 `"Itacoatiara*"', add
label define geo2b_br_lbl 1302306 `"Jutaí"', add
label define geo2b_br_lbl 1302405 `"Lábrea"', add
label define geo2b_br_lbl 1302504 `"Manacapuru*"', add
label define geo2b_br_lbl 1302603 `"Manaus*"', add
label define geo2b_br_lbl 1302702 `"Manicoré"', add
label define geo2b_br_lbl 1302900 `"Maués*"', add
label define geo2b_br_lbl 1303106 `"Nova Olinda do Norte"', add
label define geo2b_br_lbl 1303403 `"Parintins"', add
label define geo2b_br_lbl 1303700 `"Santo Antônio do Içá*"', add
label define geo2b_br_lbl 1303809 `"São Gabriel da Cachoeira"', add
label define geo2b_br_lbl 1303908 `"São Paulo de Olivença*"', add
label define geo2b_br_lbl 1304062 `"Tabatinga"', add
label define geo2b_br_lbl 1304104 `"Tapauá*"', add
label define geo2b_br_lbl 1304203 `"Tefé*"', add
label define geo2b_br_lbl 2999999 `"Rest of Bahia"', add
label define geo2b_br_lbl 2900702 `"Alagoinhas*"', add
label define geo2b_br_lbl 2900801 `"Alcobaça*"', add
label define geo2b_br_lbl 2901007 `"Amargosa"', add
label define geo2b_br_lbl 2901106 `"Amélia Rodrigues"', add
label define geo2b_br_lbl 2901205 `"Anagé"', add
label define geo2b_br_lbl 2902104 `"Araci"', add
label define geo2b_br_lbl 2902609 `"Baixa Grande"', add
label define geo2b_br_lbl 2902708 `"Barra*"', add
label define geo2b_br_lbl 2902807 `"Barra da Estiva"', add
label define geo2b_br_lbl 2902906 `"Barra do Choça"', add
label define geo2b_br_lbl 2903201 `"Barreiras"', add
label define geo2b_br_lbl 2903409 `"Belmonte"', add
label define geo2b_br_lbl 2903706 `"Boa Nova*"', add
label define geo2b_br_lbl 2903904 `"Bom Jesus da Lapa*"', add
label define geo2b_br_lbl 2904100 `"Boquira"', add
label define geo2b_br_lbl 2904605 `"Brumado"', add
label define geo2b_br_lbl 2904902 `"Cachoeira"', add
label define geo2b_br_lbl 2905008 `"Caculé"', add
label define geo2b_br_lbl 2905206 `"Caetité*"', add
label define geo2b_br_lbl 2905602 `"Camacan"', add
label define geo2b_br_lbl 2905701 `"Camaçari*"', add
label define geo2b_br_lbl 2905800 `"Camamu*"', add
label define geo2b_br_lbl 2905909 `"Campo Alegre de Lourdes"', add
label define geo2b_br_lbl 2906006 `"Campo Formoso*"', add
label define geo2b_br_lbl 2906204 `"Canarana*"', add
label define geo2b_br_lbl 2906303 `"Canavieiras*"', add
label define geo2b_br_lbl 2906501 `"Candeias"', add
label define geo2b_br_lbl 2906709 `"Cândido Sales"', add
label define geo2b_br_lbl 2906808 `"Cansanção"', add
label define geo2b_br_lbl 2906873 `"Capim Grosso"', add
label define geo2b_br_lbl 2906907 `"Caravelas*"', add
label define geo2b_br_lbl 2907103 `"Carinhanha*"', add
label define geo2b_br_lbl 2907202 `"Casa Nova"', add
label define geo2b_br_lbl 2907301 `"Castro Alves*"', add
label define geo2b_br_lbl 2907509 `"Catu"', add
label define geo2b_br_lbl 2907806 `"Cícero Dantas*"', add
label define geo2b_br_lbl 2908002 `"Coaraci"', add
label define geo2b_br_lbl 2908408 `"Conceição do Coité"', add
label define geo2b_br_lbl 2908507 `"Conceição do Jacuípe"', add
label define geo2b_br_lbl 2908606 `"Conde"', add
label define geo2b_br_lbl 2908903 `"Coração de Maria"', add
label define geo2b_br_lbl 2909208 `"Coronel João Sá"', add
label define geo2b_br_lbl 2909307 `"Correntina*"', add
label define geo2b_br_lbl 2909802 `"Cruz das Almas"', add
label define geo2b_br_lbl 2909901 `"Curaçá"', add
label define geo2b_br_lbl 2910057 `"Dias d'Ávila"', add
label define geo2b_br_lbl 2910404 `"Encruzilhada*"', add
label define geo2b_br_lbl 2910503 `"Entre Rios"', add
label define geo2b_br_lbl 2910602 `"Esplanada"', add
label define geo2b_br_lbl 2910701 `"Euclides da Cunha*"', add
label define geo2b_br_lbl 2910727 `"Eunápolis"', add
label define geo2b_br_lbl 2910800 `"Feira de Santana"', add
label define geo2b_br_lbl 2911204 `"Gandu*"', add
label define geo2b_br_lbl 2911709 `"Guanambi"', add
label define geo2b_br_lbl 2911808 `"Guaratinga"', add
label define geo2b_br_lbl 2911907 `"Iaçu"', add
label define geo2b_br_lbl 2912103 `"Ibicaraí"', add
label define geo2b_br_lbl 2912707 `"Ibirapitanga"', add
label define geo2b_br_lbl 2912905 `"Ibirataia"', add
label define geo2b_br_lbl 2913200 `"Ibotirama"', add
label define geo2b_br_lbl 2913507 `"Iguaí"', add
label define geo2b_br_lbl 2913606 `"Ilhéus"', add
label define geo2b_br_lbl 2913705 `"Inhambupe"', add
label define geo2b_br_lbl 2913903 `"Ipiaú"', add
label define geo2b_br_lbl 2914000 `"Ipirá*"', add
label define geo2b_br_lbl 2914505 `"Irará"', add
label define geo2b_br_lbl 2914604 `"Irecê*"', add
label define geo2b_br_lbl 2914653 `"Itabela"', add
label define geo2b_br_lbl 2914703 `"Itaberaba"', add
label define geo2b_br_lbl 2914802 `"Itabuna*"', add
label define geo2b_br_lbl 2915502 `"Itajuípe"', add
label define geo2b_br_lbl 2915601 `"Itamaraju*"', add
label define geo2b_br_lbl 2915809 `"Itambé"', add
label define geo2b_br_lbl 2916005 `"Itanhém"', add
label define geo2b_br_lbl 2916401 `"Itapetinga"', add
label define geo2b_br_lbl 2916500 `"Itapicuru"', add
label define geo2b_br_lbl 2917003 `"Itiúba"', add
label define geo2b_br_lbl 2917102 `"Itororó"', add
label define geo2b_br_lbl 2917300 `"Ituberá*"', add
label define geo2b_br_lbl 2917508 `"Jacobina*"', add
label define geo2b_br_lbl 2917607 `"Jaguaquara*"', add
label define geo2b_br_lbl 2917706 `"Jaguarari"', add
label define geo2b_br_lbl 2918001 `"Jequié"', add
label define geo2b_br_lbl 2918100 `"Jeremoabo*"', add
label define geo2b_br_lbl 2918308 `"Jitaúna"', add
label define geo2b_br_lbl 2918407 `"Juazeiro*"', add
label define geo2b_br_lbl 2919157 `"Lapão"', add
label define geo2b_br_lbl 2919207 `"Lauro de Freitas"', add
label define geo2b_br_lbl 2919504 `"Livramento de Nossa Senhora"', add
label define geo2b_br_lbl 2919801 `"Macaúbas"', add
label define geo2b_br_lbl 2920106 `"Mairi*"', add
label define geo2b_br_lbl 2920502 `"Maracás*"', add
label define geo2b_br_lbl 2920601 `"Maragogipe"', add
label define geo2b_br_lbl 2921005 `"Mata de São João"', add
label define geo2b_br_lbl 2921104 `"Medeiros Neto"', add
label define geo2b_br_lbl 2921203 `"Miguel Calmon"', add
label define geo2b_br_lbl 2921500 `"Monte Santo"', add
label define geo2b_br_lbl 2921708 `"Morro do Chapéu*"', add
label define geo2b_br_lbl 2922003 `"Mucuri"', add
label define geo2b_br_lbl 2922102 `"Mundo Novo"', add
label define geo2b_br_lbl 2922300 `"Muritiba*"', add
label define geo2b_br_lbl 2922409 `"Mutuípe"', add
label define geo2b_br_lbl 2922508 `"Nazaré"', add
label define geo2b_br_lbl 2922904 `"Nova Soure"', add
label define geo2b_br_lbl 2923001 `"Nova Viçosa"', add
label define geo2b_br_lbl 2923100 `"Olindina"', add
label define geo2b_br_lbl 2923209 `"Oliveira dos Brejinhos"', add
label define geo2b_br_lbl 2923704 `"Paratinga"', add
label define geo2b_br_lbl 2923803 `"Paripiranga*"', add
label define geo2b_br_lbl 2924009 `"Paulo Afonso"', add
label define geo2b_br_lbl 2924405 `"Pilão Arcado"', add
label define geo2b_br_lbl 2924603 `"Pindobaçu*"', add
label define geo2b_br_lbl 2925006 `"Planalto"', add
label define geo2b_br_lbl 2925105 `"Poções*"', add
label define geo2b_br_lbl 2925204 `"Pojuca"', add
label define geo2b_br_lbl 2925303 `"Porto Seguro*"', add
label define geo2b_br_lbl 2925501 `"Prado*"', add
label define geo2b_br_lbl 2925808 `"Queimadas*"', add
label define geo2b_br_lbl 2925907 `"Quijingue"', add
label define geo2b_br_lbl 2925956 `"Rafael Jambeiro"', add
label define geo2b_br_lbl 2926004 `"Remanso"', add
label define geo2b_br_lbl 2926202 `"Riachão das Neves"', add
label define geo2b_br_lbl 2926301 `"Riachão do Jacuípe*"', add
label define geo2b_br_lbl 2926400 `"Riacho de Santana*"', add
label define geo2b_br_lbl 2926608 `"Ribeira do Pombal*"', add
label define geo2b_br_lbl 2927002 `"Rio Real"', add
label define geo2b_br_lbl 2927200 `"Ruy Barbosa"', add
label define geo2b_br_lbl 2927408 `"Salvador*"', add
label define geo2b_br_lbl 2927705 `"Santa Cruz Cabrália*"', add
label define geo2b_br_lbl 2928000 `"Santaluz"', add
label define geo2b_br_lbl 2928109 `"Santa Maria da Vitória*"', add
label define geo2b_br_lbl 2928208 `"Santana"', add
label define geo2b_br_lbl 2928406 `"Santa Rita de Cássia*"', add
label define geo2b_br_lbl 2928604 `"Santo Amaro*"', add
label define geo2b_br_lbl 2928703 `"Santo Antônio de Jesus*"', add
label define geo2b_br_lbl 2928802 `"Santo Estêvão"', add
label define geo2b_br_lbl 2929107 `"São Felipe"', add
label define geo2b_br_lbl 2929206 `"São Francisco do Conde"', add
label define geo2b_br_lbl 2929305 `"São Gonçalo dos Campos"', add
label define geo2b_br_lbl 2929503 `"São Sebastião do Passé"', add
label define geo2b_br_lbl 2929909 `"Seabra"', add
label define geo2b_br_lbl 2930105 `"Senhor do Bonfim*"', add
label define geo2b_br_lbl 2930154 `"Serra do Ramalho"', add
label define geo2b_br_lbl 2930204 `"Sento Sé"', add
label define geo2b_br_lbl 2930501 `"Serrinha"', add
label define geo2b_br_lbl 2930709 `"Simões Filho"', add
label define geo2b_br_lbl 2930774 `"Sobradinho"', add
label define geo2b_br_lbl 2931004 `"Tanhaçu"', add
label define geo2b_br_lbl 2931350 `"Teixeira de Freitas"', add
label define geo2b_br_lbl 2931509 `"Teofilândia"', add
label define geo2b_br_lbl 2931806 `"Tremedal*"', add
label define geo2b_br_lbl 2931905 `"Tucano"', add
label define geo2b_br_lbl 2932002 `"Uauá"', add
label define geo2b_br_lbl 2932101 `"Ubaíra"', add
label define geo2b_br_lbl 2932200 `"Ubaitaba"', add
label define geo2b_br_lbl 2932309 `"Ubatã"', add
label define geo2b_br_lbl 2932507 `"Una*"', add
label define geo2b_br_lbl 2932705 `"Uruçuca"', add
label define geo2b_br_lbl 2932903 `"Valença*"', add
label define geo2b_br_lbl 2933208 `"Vera Cruz"', add
label define geo2b_br_lbl 2933307 `"Vitória da Conquista"', add
label define geo2b_br_lbl 2933505 `"Wenceslau Guimarães*"', add
label define geo2b_br_lbl 2933604 `"Xique-Xique*"', add
label define geo2b_br_lbl 2919553 `"Luís Eduardo Magalhães+"', add
label define geo2b_br_lbl 2399999 `"Rest of Ceará"', add
label define geo2b_br_lbl 2300200 `"Acaraú*"', add
label define geo2b_br_lbl 2300309 `"Acopiara"', add
label define geo2b_br_lbl 2300754 `"Amontada"', add
label define geo2b_br_lbl 2301000 `"Aquiraz*"', add
label define geo2b_br_lbl 2301109 `"Aracati***"', add
label define geo2b_br_lbl 2301208 `"Aracoiaba*"', add
label define geo2b_br_lbl 2301604 `"Assaré*"', add
label define geo2b_br_lbl 2301703 `"Aurora"', add
label define geo2b_br_lbl 2301901 `"Barbalha"', add
label define geo2b_br_lbl 2302107 `"Baturité"', add
label define geo2b_br_lbl 2302206 `"Beberibe"', add
label define geo2b_br_lbl 2302305 `"Bela Cruz"', add
label define geo2b_br_lbl 2302404 `"Boa Viagem"', add
label define geo2b_br_lbl 2302503 `"Brejo Santo"', add
label define geo2b_br_lbl 2302602 `"Camocim*"', add
label define geo2b_br_lbl 2302701 `"Campos Sales*"', add
label define geo2b_br_lbl 2302800 `"Canindé"', add
label define geo2b_br_lbl 2303204 `"Caririaçu"', add
label define geo2b_br_lbl 2303501 `"Cascavel*"', add
label define geo2b_br_lbl 2303709 `"Caucaia"', add
label define geo2b_br_lbl 2303808 `"Cedro"', add
label define geo2b_br_lbl 2304004 `"Coreaú"', add
label define geo2b_br_lbl 2304103 `"Crateús"', add
label define geo2b_br_lbl 2304202 `"Crato"', add
label define geo2b_br_lbl 2304285 `"Eusébio"', add
label define geo2b_br_lbl 2304301 `"Farias Brito"', add
label define geo2b_br_lbl 2304400 `"Fortaleza"', add
label define geo2b_br_lbl 2304707 `"Granja"', add
label define geo2b_br_lbl 2305001 `"Guaraciaba do Norte*"', add
label define geo2b_br_lbl 2305233 `"Horizonte"', add
label define geo2b_br_lbl 2305308 `"Ibiapina"', add
label define geo2b_br_lbl 2305407 `"Icó"', add
label define geo2b_br_lbl 2305506 `"Iguatu*"', add
label define geo2b_br_lbl 2305605 `"Independência*"', add
label define geo2b_br_lbl 2305803 `"Ipu*"', add
label define geo2b_br_lbl 2305902 `"Ipueiras"', add
label define geo2b_br_lbl 2306256 `"Itaitinga"', add
label define geo2b_br_lbl 2306306 `"Itapagé*"', add
label define geo2b_br_lbl 2306405 `"Itapipoca*"', add
label define geo2b_br_lbl 2306553 `"Itarema"', add
label define geo2b_br_lbl 2306900 `"Jaguaribe"', add
label define geo2b_br_lbl 2307007 `"Jaguaruana"', add
label define geo2b_br_lbl 2307106 `"Jardim"', add
label define geo2b_br_lbl 2307304 `"Juazeiro do Norte"', add
label define geo2b_br_lbl 2307403 `"Jucás"', add
label define geo2b_br_lbl 2307502 `"Lavras da Mangabeira"', add
label define geo2b_br_lbl 2307601 `"Limoeiro do Norte"', add
label define geo2b_br_lbl 2307650 `"Maracanaú"', add
label define geo2b_br_lbl 2307700 `"Maranguape*"', add
label define geo2b_br_lbl 2308005 `"Massapê"', add
label define geo2b_br_lbl 2308104 `"Mauriti"', add
label define geo2b_br_lbl 2308302 `"Milagres"', add
label define geo2b_br_lbl 2308401 `"Missão Velha"', add
label define geo2b_br_lbl 2308500 `"Mombaça"', add
label define geo2b_br_lbl 2308708 `"Morada Nova*"', add
label define geo2b_br_lbl 2309300 `"Nova Russas***"', add
label define geo2b_br_lbl 2309409 `"Novo Oriente"', add
label define geo2b_br_lbl 2309458 `"Ocara"', add
label define geo2b_br_lbl 2309508 `"Orós"', add
label define geo2b_br_lbl 2309607 `"Pacajus*"', add
label define geo2b_br_lbl 2309706 `"Pacatuba***"', add
label define geo2b_br_lbl 2310209 `"Paracuru*"', add
label define geo2b_br_lbl 2310258 `"Paraipaba"', add
label define geo2b_br_lbl 2310308 `"Parambu"', add
label define geo2b_br_lbl 2310506 `"Pedra Branca"', add
label define geo2b_br_lbl 2310704 `"Pentecoste"', add
label define geo2b_br_lbl 2311306 `"Quixadá***"', add
label define geo2b_br_lbl 2311405 `"Quixeramobim*"', add
label define geo2b_br_lbl 2311603 `"Redenção*"', add
label define geo2b_br_lbl 2311702 `"Reriutaba*"', add
label define geo2b_br_lbl 2311801 `"Russas"', add
label define geo2b_br_lbl 2312007 `"Santana do Acaraú"', add
label define geo2b_br_lbl 2312205 `"Santa Quitéria**"', add
label define geo2b_br_lbl 2312304 `"São Benedito*"', add
label define geo2b_br_lbl 2312403 `"São Gonçalo do Amarante"', add
label define geo2b_br_lbl 2312700 `"Senador Pompeu"', add
label define geo2b_br_lbl 2312908 `"Sobral*"', add
label define geo2b_br_lbl 2313104 `"Tabuleiro do Norte"', add
label define geo2b_br_lbl 2313203 `"Tamboril"', add
label define geo2b_br_lbl 2313302 `"Tauá"', add
label define geo2b_br_lbl 2313401 `"Tianguá"', add
label define geo2b_br_lbl 2313500 `"Trairi"', add
label define geo2b_br_lbl 2313609 `"Ubajara"', add
label define geo2b_br_lbl 2314003 `"Várzea Alegre"', add
label define geo2b_br_lbl 2314102 `"Viçosa do Ceará"', add
label define geo2b_br_lbl 5300108 `"Brasília"', add
label define geo2b_br_lbl 3200102 `"Afonso Cláudio***"', add
label define geo2b_br_lbl 3299999 `"Rest of Espírito Santo"', add
label define geo2b_br_lbl 3200201 `"Alegre*"', add
label define geo2b_br_lbl 3200607 `"Aracruz"', add
label define geo2b_br_lbl 3200805 `"Baixo Guandu"', add
label define geo2b_br_lbl 3200904 `"Barra de São Francisco*"', add
label define geo2b_br_lbl 3201209 `"Cachoeiro de Itapemirim*"', add
label define geo2b_br_lbl 3201308 `"Cariacica"', add
label define geo2b_br_lbl 3201407 `"Castelo"', add
label define geo2b_br_lbl 3201506 `"Colatina***"', add
label define geo2b_br_lbl 3201605 `"Conceição da Barra*"', add
label define geo2b_br_lbl 3201902 `"Domingos Martins**"', add
label define geo2b_br_lbl 3202108 `"Ecoporanga"', add
label define geo2b_br_lbl 3202306 `"Guaçuí"', add
label define geo2b_br_lbl 3202405 `"Guarapari"', add
label define geo2b_br_lbl 3202801 `"Itapemirim**"', add
label define geo2b_br_lbl 3203007 `"Iúna***"', add
label define geo2b_br_lbl 3203205 `"Linhares***"', add
label define geo2b_br_lbl 3203320 `"Marataízes"', add
label define geo2b_br_lbl 3203403 `"Mimoso do Sul"', add
label define geo2b_br_lbl 3203700 `"Muniz Freire"', add
label define geo2b_br_lbl 3203908 `"Nova Venécia**"', add
label define geo2b_br_lbl 3204005 `"Pancas*"', add
label define geo2b_br_lbl 3204054 `"Pedro Canário"', add
label define geo2b_br_lbl 3204104 `"Pinheiros"', add
label define geo2b_br_lbl 3204559 `"Santa Maria de Jetibá"', add
label define geo2b_br_lbl 3204609 `"Santa Teresa**"', add
label define geo2b_br_lbl 3204708 `"São Gabriel da Palha***"', add
label define geo2b_br_lbl 3204906 `"São Mateus*"', add
label define geo2b_br_lbl 3205002 `"Serra"', add
label define geo2b_br_lbl 3205101 `"Viana"', add
label define geo2b_br_lbl 3205200 `"Vila Velha"', add
label define geo2b_br_lbl 3205309 `"Vitória"', add
label define geo2b_br_lbl 5299999 `"Rest of Goiás"', add
label define geo2b_br_lbl 5200258 `"Águas Lindas de Goiás"', add
label define geo2b_br_lbl 5200308 `"Alexânia"', add
label define geo2b_br_lbl 5201108 `"Anápolis"', add
label define geo2b_br_lbl 5201405 `"Aparecida de Goiânia*"', add
label define geo2b_br_lbl 5204508 `"Caldas Novas*"', add
label define geo2b_br_lbl 5205109 `"Catalão"', add
label define geo2b_br_lbl 5205406 `"Ceres*"', add
label define geo2b_br_lbl 5205497 `"Cidade Ocidental"', add
label define geo2b_br_lbl 5206206 `"Cristalina"', add
label define geo2b_br_lbl 5208004 `"Formosa**"', add
label define geo2b_br_lbl 5208608 `"Goianésia"', add
label define geo2b_br_lbl 5208707 `"Goiânia***"', add
label define geo2b_br_lbl 5208905 `"Goiás*"', add
label define geo2b_br_lbl 5209101 `"Goiatuba**"', add
label define geo2b_br_lbl 5210000 `"Inhumas"', add
label define geo2b_br_lbl 5210109 `"Ipameri"', add
label define geo2b_br_lbl 5210208 `"Iporá"', add
label define geo2b_br_lbl 5210406 `"Itaberaí"', add
label define geo2b_br_lbl 5211206 `"Itapuranga**"', add
label define geo2b_br_lbl 5211503 `"Itumbiara***"', add
label define geo2b_br_lbl 5211800 `"Jaraguá*"', add
label define geo2b_br_lbl 5211909 `"Jataí**"', add
label define geo2b_br_lbl 5212204 `"Jussara*"', add
label define geo2b_br_lbl 5212501 `"Luziânia***"', add
label define geo2b_br_lbl 5213087 `"Minaçu*"', add
label define geo2b_br_lbl 5213103 `"Mineiros"', add
label define geo2b_br_lbl 5213806 `"Morrinhos"', add
label define geo2b_br_lbl 5214606 `"Niquelândia"', add
label define geo2b_br_lbl 5215231 `"Novo Gama"', add
label define geo2b_br_lbl 5215603 `"Padre Bernardo*"', add
label define geo2b_br_lbl 5217104 `"Piracanjuba**"', add
label define geo2b_br_lbl 5217302 `"Pirenópolis**"', add
label define geo2b_br_lbl 5217401 `"Pires do Rio"', add
label define geo2b_br_lbl 5217609 `"Planaltina*"', add
label define geo2b_br_lbl 5218003 `"Porangatu**"', add
label define geo2b_br_lbl 5218300 `"Posse*"', add
label define geo2b_br_lbl 5218508 `"Quirinópolis*"', add
label define geo2b_br_lbl 5218805 `"Rio Verde***"', add
label define geo2b_br_lbl 5219308 `"Santa Helena de Goiás"', add
label define geo2b_br_lbl 5219753 `"Santo Antônio do Descoberto**"', add
label define geo2b_br_lbl 5220108 `"São Luís de Montes Belos"', add
label define geo2b_br_lbl 5220207 `"São Miguel do Araguaia*"', add
label define geo2b_br_lbl 5220454 `"Senador Canedo"', add
label define geo2b_br_lbl 5220603 `"Silvânia*"', add
label define geo2b_br_lbl 5221403 `"Trindade**"', add
label define geo2b_br_lbl 5221601 `"Uruaçu*"', add
label define geo2b_br_lbl 5221858 `"Valparaíso de Goiás"', add
label define geo2b_br_lbl 2100055 `"Açailândia**"', add
label define geo2b_br_lbl 2199999 `"Rest of Maranhão"', add
label define geo2b_br_lbl 2100204 `"Alcântara"', add
label define geo2b_br_lbl 2100436 `"Alto Alegre do Maranhão"', add
label define geo2b_br_lbl 2100477 `"Alto Alegre do Pindaré"', add
label define geo2b_br_lbl 2100600 `"Amarante do Maranhão"', add
label define geo2b_br_lbl 2100709 `"Anajatuba"', add
label define geo2b_br_lbl 2100907 `"Araioses**"', add
label define geo2b_br_lbl 2100956 `"Arame"', add
label define geo2b_br_lbl 2101004 `"Arari*"', add
label define geo2b_br_lbl 2101202 `"Bacabal**"', add
label define geo2b_br_lbl 2101400 `"Balsas"', add
label define geo2b_br_lbl 2101608 `"Barra do Corda**"', add
label define geo2b_br_lbl 2101707 `"Barreirinhas**"', add
label define geo2b_br_lbl 2102002 `"Bom Jardim**"', add
label define geo2b_br_lbl 2102101 `"Brejo**"', add
label define geo2b_br_lbl 2102200 `"Buriti"', add
label define geo2b_br_lbl 2102309 `"Buriti Bravo"', add
label define geo2b_br_lbl 2102325 `"Buriticupu"', add
label define geo2b_br_lbl 2102804 `"Carolina*"', add
label define geo2b_br_lbl 2103000 `"Caxias**"', add
label define geo2b_br_lbl 2103208 `"Chapadinha"', add
label define geo2b_br_lbl 2103307 `"Codó**"', add
label define geo2b_br_lbl 2103406 `"Coelho Neto"', add
label define geo2b_br_lbl 2103505 `"Colinas**"', add
label define geo2b_br_lbl 2103604 `"Coroatá**"', add
label define geo2b_br_lbl 2103703 `"Cururupu**"', add
label define geo2b_br_lbl 2103802 `"Dom Pedro"', add
label define geo2b_br_lbl 2104008 `"Esperantinópolis**"', add
label define geo2b_br_lbl 2104057 `"Estreito**"', add
label define geo2b_br_lbl 2104677 `"Governador Nunes Freire"', add
label define geo2b_br_lbl 2104800 `"Grajaú***"', add
label define geo2b_br_lbl 2105005 `"Humberto de Campos"', add
label define geo2b_br_lbl 2105104 `"Icatu"', add
label define geo2b_br_lbl 2105302 `"Imperatriz***"', add
label define geo2b_br_lbl 2105401 `"Itapecuru Mirim*"', add
label define geo2b_br_lbl 2105427 `"Itinga do Maranhão"', add
label define geo2b_br_lbl 2105500 `"João Lisboa**"', add
label define geo2b_br_lbl 2105708 `"Lago da Pedra**"', add
label define geo2b_br_lbl 2106508 `"Matinha**"', add
label define geo2b_br_lbl 2106607 `"Matões"', add
label define geo2b_br_lbl 2106706 `"Mirador"', add
label define geo2b_br_lbl 2106904 `"Monção*"', add
label define geo2b_br_lbl 2107506 `"Paço do Lumiar**"', add
label define geo2b_br_lbl 2107803 `"Parnarama"', add
label define geo2b_br_lbl 2108207 `"Pedreiras**"', add
label define geo2b_br_lbl 2108306 `"Penalva"', add
label define geo2b_br_lbl 2108504 `"Pindaré-Mirim**"', add
label define geo2b_br_lbl 2108603 `"Pinheiro**"', add
label define geo2b_br_lbl 2108702 `"Pio XII**"', add
label define geo2b_br_lbl 2108900 `"Poção de Pedras"', add
label define geo2b_br_lbl 2109106 `"Presidente Dutra**"', add
label define geo2b_br_lbl 2109502 `"Riachão**"', add
label define geo2b_br_lbl 2109601 `"Rosário**"', add
label define geo2b_br_lbl 2109809 `"Santa Helena"', add
label define geo2b_br_lbl 2109908 `"Santa Inês"', add
label define geo2b_br_lbl 2110005 `"Santa Luzia***"', add
label define geo2b_br_lbl 2110039 `"Santa Luzia do Paruá**"', add
label define geo2b_br_lbl 2110104 `"Santa Quitéria do Maranhão**"', add
label define geo2b_br_lbl 2110203 `"Santa Rita"', add
label define geo2b_br_lbl 2110500 `"São Bento"', add
label define geo2b_br_lbl 2110609 `"São Bernardo**"', add
label define geo2b_br_lbl 2110708 `"São Domingos do Maranhão**"', add
label define geo2b_br_lbl 2111102 `"São João dos Patos**"', add
label define geo2b_br_lbl 2111201 `"São José de Ribamar"', add
label define geo2b_br_lbl 2111300 `"São Luís"', add
label define geo2b_br_lbl 2111409 `"São Luís Gonzaga do Maranhão**"', add
label define geo2b_br_lbl 2111508 `"São Mateus do Maranhão**"', add
label define geo2b_br_lbl 2112100 `"Timbiras"', add
label define geo2b_br_lbl 2112209 `"Timon"', add
label define geo2b_br_lbl 2112308 `"Tuntum**"', add
label define geo2b_br_lbl 2112407 `"Turiaçu***"', add
label define geo2b_br_lbl 2112506 `"Tutóia**"', add
label define geo2b_br_lbl 2112704 `"Vargem Grande"', add
label define geo2b_br_lbl 2112803 `"Viana**"', add
label define geo2b_br_lbl 2112902 `"Vitória do Mearim**"', add
label define geo2b_br_lbl 2113009 `"Vitorino Freire"', add
label define geo2b_br_lbl 2114007 `"Zé Doca**"', add
label define geo2b_br_lbl 5199999 `"Rest of Mato Grosso"', add
label define geo2b_br_lbl 5100250 `"Alta Floresta***"', add
label define geo2b_br_lbl 5101407 `"Aripuanã*"', add
label define geo2b_br_lbl 5101704 `"Barra do Bugres***"', add
label define geo2b_br_lbl 5101803 `"Barra do Garças*"', add
label define geo2b_br_lbl 5102504 `"Cáceres***"', add
label define geo2b_br_lbl 5103205 `"Colíder***"', add
label define geo2b_br_lbl 5103403 `"Cuiabá*"', add
label define geo2b_br_lbl 5104104 `"Guarantã do Norte**"', add
label define geo2b_br_lbl 5104807 `"Jaciara***"', add
label define geo2b_br_lbl 5105101 `"Juara**"', add
label define geo2b_br_lbl 5105150 `"Juína"', add
label define geo2b_br_lbl 5105622 `"Mirassol d'Oeste*** +"', add
label define geo2b_br_lbl 5106422 `"Peixoto de Azevedo**"', add
label define geo2b_br_lbl 5106505 `"Poconé"', add
label define geo2b_br_lbl 5106752 `"Pontes e Lacerda"', add
label define geo2b_br_lbl 5107040 `"Primavera do Leste"', add
label define geo2b_br_lbl 5107602 `"Rondonópolis**"', add
label define geo2b_br_lbl 5107909 `"Sinop***"', add
label define geo2b_br_lbl 5107925 `"Sorriso**"', add
label define geo2b_br_lbl 5107958 `"Tangará da Serra"', add
label define geo2b_br_lbl 5108402 `"Várzea Grande"', add
label define geo2b_br_lbl 5103254 `"Colniza+"', add
label define geo2b_br_lbl 5099999 `"Rest of Mato Grosso do Sul"', add
label define geo2b_br_lbl 5000609 `"Amambaí*"', add
label define geo2b_br_lbl 5000708 `"Anastácio*"', add
label define geo2b_br_lbl 5001102 `"Aquidauana"', add
label define geo2b_br_lbl 5002100 `"Bela Vista"', add
label define geo2b_br_lbl 5002407 `"Caarapó*"', add
label define geo2b_br_lbl 5002704 `"Campo Grande"', add
label define geo2b_br_lbl 5003207 `"Corumbá"', add
label define geo2b_br_lbl 5003306 `"Coxim***"', add
label define geo2b_br_lbl 5003702 `"Dourados*"', add
label define geo2b_br_lbl 5004700 `"Ivinhema**"', add
label define geo2b_br_lbl 5005004 `"Jardim"', add
label define geo2b_br_lbl 5005400 `"Maracaju"', add
label define geo2b_br_lbl 5005608 `"Miranda*"', add
label define geo2b_br_lbl 5005707 `"Naviraí"', add
label define geo2b_br_lbl 5006200 `"Nova Andradina"', add
label define geo2b_br_lbl 5006309 `"Paranaíba*"', add
label define geo2b_br_lbl 5006606 `"Ponta Porã**"', add
label define geo2b_br_lbl 5007208 `"Rio Brilhante**"', add
label define geo2b_br_lbl 5007901 `"Sidrolândia**"', add
label define geo2b_br_lbl 5008305 `"Três Lagoas*"', add
label define geo2b_br_lbl 3199999 `"Rest of Minas Gerais"', add
label define geo2b_br_lbl 3100203 `"Abaeté"', add
label define geo2b_br_lbl 3101102 `"Aimorés"', add
label define geo2b_br_lbl 3101508 `"Além Paraíba"', add
label define geo2b_br_lbl 3101607 `"Alfenas"', add
label define geo2b_br_lbl 3101706 `"Almenara**"', add
label define geo2b_br_lbl 3102605 `"Andradas"', add
label define geo2b_br_lbl 3103405 `"Araçuaí"', add
label define geo2b_br_lbl 3103504 `"Araguari"', add
label define geo2b_br_lbl 3104007 `"Araxá"', add
label define geo2b_br_lbl 3104205 `"Arcos"', add
label define geo2b_br_lbl 3105103 `"Bambuí"', add
label define geo2b_br_lbl 3105400 `"Barão de Cocais"', add
label define geo2b_br_lbl 3105608 `"Barbacena"', add
label define geo2b_br_lbl 3106200 `"Belo Horizonte"', add
label define geo2b_br_lbl 3106705 `"Betim"', add
label define geo2b_br_lbl 3107109 `"Boa Esperança"', add
label define geo2b_br_lbl 3107307 `"Bocaiúva**"', add
label define geo2b_br_lbl 3107406 `"Bom Despacho"', add
label define geo2b_br_lbl 3108602 `"Brasília de Minas**"', add
label define geo2b_br_lbl 3109006 `"Brumadinho"', add
label define geo2b_br_lbl 3109402 `"Buritizeiro"', add
label define geo2b_br_lbl 3110004 `"Caeté"', add
label define geo2b_br_lbl 3110509 `"Camanducaia"', add
label define geo2b_br_lbl 3110608 `"Cambuí**"', add
label define geo2b_br_lbl 3111002 `"Campestre"', add
label define geo2b_br_lbl 3111200 `"Campo Belo"', add
label define geo2b_br_lbl 3111606 `"Campos Gerais"', add
label define geo2b_br_lbl 3112307 `"Capelinha**"', add
label define geo2b_br_lbl 3113008 `"Caraí"', add
label define geo2b_br_lbl 3113206 `"Carandaí"', add
label define geo2b_br_lbl 3113305 `"Carangola**"', add
label define geo2b_br_lbl 3113404 `"Caratinga**"', add
label define geo2b_br_lbl 3113701 `"Carlos Chagas"', add
label define geo2b_br_lbl 3114303 `"Carmo do Paranaíba"', add
label define geo2b_br_lbl 3114402 `"Carmo do Rio Claro"', add
label define geo2b_br_lbl 3115300 `"Cataguases"', add
label define geo2b_br_lbl 3115508 `"Caxambu"', add
label define geo2b_br_lbl 3116605 `"Cláudio"', add
label define geo2b_br_lbl 3118007 `"Congonhas"', add
label define geo2b_br_lbl 3118304 `"Conselheiro Lafaiete"', add
label define geo2b_br_lbl 3118403 `"Conselheiro Pena**"', add
label define geo2b_br_lbl 3118601 `"Contagem"', add
label define geo2b_br_lbl 3118809 `"Coração de Jesus**"', add
label define geo2b_br_lbl 3119104 `"Corinto"', add
label define geo2b_br_lbl 3119302 `"Coromandel"', add
label define geo2b_br_lbl 3119401 `"Coronel Fabriciano"', add
label define geo2b_br_lbl 3120904 `"Curvelo"', add
label define geo2b_br_lbl 3121605 `"Diamantina"', add
label define geo2b_br_lbl 3122306 `"Divinópolis"', add
label define geo2b_br_lbl 3123601 `"Elói Mendes"', add
label define geo2b_br_lbl 3124104 `"Esmeraldas"', add
label define geo2b_br_lbl 3124203 `"Espera Feliz"', add
label define geo2b_br_lbl 3124302 `"Espinosa**"', add
label define geo2b_br_lbl 3126109 `"Formiga**"', add
label define geo2b_br_lbl 3126703 `"Francisco Sá"', add
label define geo2b_br_lbl 3127107 `"Frutal"', add
label define geo2b_br_lbl 3127701 `"Governador Valadares"', add
label define geo2b_br_lbl 3128006 `"Guanhães"', add
label define geo2b_br_lbl 3128709 `"Guaxupé"', add
label define geo2b_br_lbl 3129509 `"Ibiá"', add
label define geo2b_br_lbl 3129806 `"Ibirité**"', add
label define geo2b_br_lbl 3130101 `"Igarapé**"', add
label define geo2b_br_lbl 3130903 `"Inhapim**"', add
label define geo2b_br_lbl 3131307 `"Ipatinga"', add
label define geo2b_br_lbl 3131703 `"Itabira"', add
label define geo2b_br_lbl 3131901 `"Itabirito"', add
label define geo2b_br_lbl 3132404 `"Itajubá"', add
label define geo2b_br_lbl 3132503 `"Itamarandiba**"', add
label define geo2b_br_lbl 3132701 `"Itambacuri"', add
label define geo2b_br_lbl 3133303 `"Itaobim"', add
label define geo2b_br_lbl 3133501 `"Itapecerica"', add
label define geo2b_br_lbl 3133808 `"Itaúna"', add
label define geo2b_br_lbl 3134202 `"Ituiutaba"', add
label define geo2b_br_lbl 3134400 `"Iturama**"', add
label define geo2b_br_lbl 3135050 `"Jaíba"', add
label define geo2b_br_lbl 3135100 `"Janaúba**"', add
label define geo2b_br_lbl 3135209 `"Januária**"', add
label define geo2b_br_lbl 3135803 `"Jequitinhonha"', add
label define geo2b_br_lbl 3136207 `"João Monlevade"', add
label define geo2b_br_lbl 3136306 `"João Pinheiro**"', add
label define geo2b_br_lbl 3136702 `"Juiz de Fora"', add
label define geo2b_br_lbl 3137205 `"Lagoa da Prata"', add
label define geo2b_br_lbl 3137601 `"Lagoa Santa**"', add
label define geo2b_br_lbl 3138203 `"Lavras"', add
label define geo2b_br_lbl 3138401 `"Leopoldina"', add
label define geo2b_br_lbl 3139003 `"Machado"', add
label define geo2b_br_lbl 3139300 `"Manga**"', add
label define geo2b_br_lbl 3139409 `"Manhuaçu**"', add
label define geo2b_br_lbl 3139607 `"Mantena**"', add
label define geo2b_br_lbl 3140001 `"Mariana"', add
label define geo2b_br_lbl 3140704 `"Mateus Leme**"', add
label define geo2b_br_lbl 3141108 `"Matozinhos"', add
label define geo2b_br_lbl 3141405 `"Medina"', add
label define geo2b_br_lbl 3141801 `"Minas Novas**"', add
label define geo2b_br_lbl 3142908 `"Monte Azul**"', add
label define geo2b_br_lbl 3143104 `"Monte Carmelo"', add
label define geo2b_br_lbl 3143203 `"Monte Santo de Minas"', add
label define geo2b_br_lbl 3143302 `"Montes Claros"', add
label define geo2b_br_lbl 3143906 `"Muriaé**"', add
label define geo2b_br_lbl 3144003 `"Mutum"', add
label define geo2b_br_lbl 3144102 `"Muzambinho"', add
label define geo2b_br_lbl 3144300 `"Nanuque"', add
label define geo2b_br_lbl 3144607 `"Nepomuceno"', add
label define geo2b_br_lbl 3144805 `"Nova Lima"', add
label define geo2b_br_lbl 3145208 `"Nova Serrana"', add
label define geo2b_br_lbl 3145307 `"Novo Cruzeiro"', add
label define geo2b_br_lbl 3145604 `"Oliveira"', add
label define geo2b_br_lbl 3145901 `"Ouro Branco"', add
label define geo2b_br_lbl 3146008 `"Ouro Fino"', add
label define geo2b_br_lbl 3146107 `"Ouro Preto"', add
label define geo2b_br_lbl 3147006 `"Paracatu"', add
label define geo2b_br_lbl 3147105 `"Pará de Minas"', add
label define geo2b_br_lbl 3147402 `"Paraopeba"', add
label define geo2b_br_lbl 3147907 `"Passos"', add
label define geo2b_br_lbl 3148004 `"Patos de Minas"', add
label define geo2b_br_lbl 3148103 `"Patrocínio"', add
label define geo2b_br_lbl 3148707 `"Pedra Azul"', add
label define geo2b_br_lbl 3149309 `"Pedro Leopoldo"', add
label define geo2b_br_lbl 3151206 `"Pirapora"', add
label define geo2b_br_lbl 3151404 `"Pitangui"', add
label define geo2b_br_lbl 3151503 `"Piumhi"', add
label define geo2b_br_lbl 3151800 `"Poços de Caldas"', add
label define geo2b_br_lbl 3152006 `"Pompéu"', add
label define geo2b_br_lbl 3152105 `"Ponte Nova**"', add
label define geo2b_br_lbl 3152204 `"Porteirinha**"', add
label define geo2b_br_lbl 3152501 `"Pouso Alegre"', add
label define geo2b_br_lbl 3152808 `"Prata"', add
label define geo2b_br_lbl 3154002 `"Raul Soares**"', add
label define geo2b_br_lbl 3154606 `"Ribeirão das Neves"', add
label define geo2b_br_lbl 3155603 `"Rio Pardo de Minas**"', add
label define geo2b_br_lbl 3156700 `"Sabará"', add
label define geo2b_br_lbl 3156908 `"Sacramento"', add
label define geo2b_br_lbl 3157005 `"Salinas**"', add
label define geo2b_br_lbl 3157203 `"Santa Bárbara**"', add
label define geo2b_br_lbl 3157807 `"Santa Luzia"', add
label define geo2b_br_lbl 3159605 `"Santa Rita do Sapucaí"', add
label define geo2b_br_lbl 3160405 `"Santo Antônio do Monte"', add
label define geo2b_br_lbl 3160702 `"Santos Dumont"', add
label define geo2b_br_lbl 3161106 `"São Francisco**"', add
label define geo2b_br_lbl 3162005 `"São Gonçalo do Sapucaí"', add
label define geo2b_br_lbl 3162104 `"São Gotardo"', add
label define geo2b_br_lbl 3162401 `"São João da Ponte**"', add
label define geo2b_br_lbl 3162500 `"São João del Rei"', add
label define geo2b_br_lbl 3162708 `"São João do Paraíso**"', add
label define geo2b_br_lbl 3162906 `"São João Nepomuceno"', add
label define geo2b_br_lbl 3163706 `"São Lourenço"', add
label define geo2b_br_lbl 3164704 `"São Sebastião do Paraíso"', add
label define geo2b_br_lbl 3167103 `"Serro"', add
label define geo2b_br_lbl 3167202 `"Sete Lagoas"', add
label define geo2b_br_lbl 3168002 `"Taiobeiras**"', add
label define geo2b_br_lbl 3168606 `"Teófilo Otoni**"', add
label define geo2b_br_lbl 3168705 `"Timóteo"', add
label define geo2b_br_lbl 3169307 `"Três Corações"', add
label define geo2b_br_lbl 3169356 `"Três Marias"', add
label define geo2b_br_lbl 3169406 `"Três Pontas"', add
label define geo2b_br_lbl 3169604 `"Tupaciguara**"', add
label define geo2b_br_lbl 3169901 `"Ubá"', add
label define geo2b_br_lbl 3170107 `"Uberaba**"', add
label define geo2b_br_lbl 3170206 `"Uberlândia"', add
label define geo2b_br_lbl 3170404 `"Unaí**"', add
label define geo2b_br_lbl 3170701 `"Varginha"', add
label define geo2b_br_lbl 3170800 `"Várzea da Palma"', add
label define geo2b_br_lbl 3171204 `"Vespasiano**"', add
label define geo2b_br_lbl 3171303 `"Viçosa"', add
label define geo2b_br_lbl 3172004 `"Visconde do Rio Branco"', add
label define geo2b_br_lbl 1500107 `"Abaetetuba"', add
label define geo2b_br_lbl 1599999 `"Rest of Pará"', add
label define geo2b_br_lbl 1500206 `"Acará*"', add
label define geo2b_br_lbl 1500305 `"Afuá"', add
label define geo2b_br_lbl 1500347 `"Água Azul do Norte"', add
label define geo2b_br_lbl 1500404 `"Alenquer**"', add
label define geo2b_br_lbl 1500503 `"Almeirim"', add
label define geo2b_br_lbl 1500602 `"Altamira**"', add
label define geo2b_br_lbl 1500800 `"Ananindeua"', add
label define geo2b_br_lbl 1500909 `"Augusto Corrêa"', add
label define geo2b_br_lbl 1500958 `"Aurora do Pará"', add
label define geo2b_br_lbl 1501204 `"Baião"', add
label define geo2b_br_lbl 1501303 `"Barcarena"', add
label define geo2b_br_lbl 1501402 `"Belém"', add
label define geo2b_br_lbl 1501501 `"Benevides**"', add
label define geo2b_br_lbl 1501709 `"Bragança**"', add
label define geo2b_br_lbl 1501782 `"Breu Branco"', add
label define geo2b_br_lbl 1501808 `"Breves"', add
label define geo2b_br_lbl 1501907 `"Bujaru*"', add
label define geo2b_br_lbl 1502103 `"Cametá"', add
label define geo2b_br_lbl 1502202 `"Capanema"', add
label define geo2b_br_lbl 1502301 `"Capitão Poço"', add
label define geo2b_br_lbl 1502400 `"Castanhal"', add
label define geo2b_br_lbl 1502707 `"Conceição do Araguaia***"', add
label define geo2b_br_lbl 1502756 `"Concórdia do Pará"', add
label define geo2b_br_lbl 1502806 `"Curralinho"', add
label define geo2b_br_lbl 1502905 `"Curuçá**"', add
label define geo2b_br_lbl 1502939 `"Dom Eliseu"', add
label define geo2b_br_lbl 1502954 `"Eldorado dos Carajás"', add
label define geo2b_br_lbl 1503077 `"Garrafão do Norte"', add
label define geo2b_br_lbl 1503093 `"Goianésia do Pará"', add
label define geo2b_br_lbl 1503101 `"Gurupá"', add
label define geo2b_br_lbl 1503200 `"Igarapé-Açu"', add
label define geo2b_br_lbl 1503309 `"Igarapé-Miri"', add
label define geo2b_br_lbl 1503457 `"Ipixuna do Pará"', add
label define geo2b_br_lbl 1503507 `"Irituia***"', add
label define geo2b_br_lbl 1503606 `"Itaituba**"', add
label define geo2b_br_lbl 1503705 `"Itupiranga**"', add
label define geo2b_br_lbl 1503754 `"Jacareacanga"', add
label define geo2b_br_lbl 1503804 `"Jacundá**"', add
label define geo2b_br_lbl 1503903 `"Juruti"', add
label define geo2b_br_lbl 1504059 `"Mãe do Rio"', add
label define geo2b_br_lbl 1504208 `"Marabá*"', add
label define geo2b_br_lbl 1504307 `"Maracanã"', add
label define geo2b_br_lbl 1504406 `"Marapanim"', add
label define geo2b_br_lbl 1504422 `"Marituba"', add
label define geo2b_br_lbl 1504455 `"Medicilândia**"', add
label define geo2b_br_lbl 1504505 `"Melgaço"', add
label define geo2b_br_lbl 1504604 `"Mocajuba"', add
label define geo2b_br_lbl 1504703 `"Moju***"', add
label define geo2b_br_lbl 1504802 `"Monte Alegre"', add
label define geo2b_br_lbl 1504901 `"Muaná"', add
label define geo2b_br_lbl 1505031 `"Novo Progresso"', add
label define geo2b_br_lbl 1505064 `"Novo Repartimento"', add
label define geo2b_br_lbl 1505106 `"Óbidos"', add
label define geo2b_br_lbl 1505205 `"Oeiras do Pará"', add
label define geo2b_br_lbl 1505304 `"Oriximiná**"', add
label define geo2b_br_lbl 1505486 `"Pacajá**"', add
label define geo2b_br_lbl 1505502 `"Paragominas***"', add
label define geo2b_br_lbl 1505536 `"Parauapebas**"', add
label define geo2b_br_lbl 1505809 `"Portel*"', add
label define geo2b_br_lbl 1505908 `"Porto de Moz**"', add
label define geo2b_br_lbl 1506005 `"Prainha*"', add
label define geo2b_br_lbl 1506138 `"Redenção**"', add
label define geo2b_br_lbl 1506187 `"Rondon do Pará**"', add
label define geo2b_br_lbl 1506195 `"Rurópolis"', add
label define geo2b_br_lbl 1506203 `"Salinópolis"', add
label define geo2b_br_lbl 1506500 `"Santa Isabel do Pará"', add
label define geo2b_br_lbl 1506609 `"Santa Maria do Pará"', add
label define geo2b_br_lbl 1506708 `"Santana do Araguaia*"', add
label define geo2b_br_lbl 1506807 `"Santarém**"', add
label define geo2b_br_lbl 1507151 `"São Domingos do Araguaia"', add
label define geo2b_br_lbl 1507201 `"São Domingos do Capim***"', add
label define geo2b_br_lbl 1507300 `"São Félix do Xingu*"', add
label define geo2b_br_lbl 1507458 `"São Geraldo do Araguaia**"', add
label define geo2b_br_lbl 1507607 `"São Miguel do Guamá"', add
label define geo2b_br_lbl 1507953 `"Tailândia"', add
label define geo2b_br_lbl 1508001 `"Tomé-Açu"', add
label define geo2b_br_lbl 1508035 `"Tracuateua"', add
label define geo2b_br_lbl 1508084 `"Tucumã"', add
label define geo2b_br_lbl 1508100 `"Tucuruí***"', add
label define geo2b_br_lbl 1508159 `"Uruará"', add
label define geo2b_br_lbl 1508209 `"Vigia"', add
label define geo2b_br_lbl 1508308 `"Viseu**"', add
label define geo2b_br_lbl 1508407 `"Xinguara**"', add
label define geo2b_br_lbl 2599999 `"Rest of Paraíba"', add
label define geo2b_br_lbl 2500304 `"Alagoa Grande"', add
label define geo2b_br_lbl 2501104 `"Areia"', add
label define geo2b_br_lbl 2501500 `"Bananeiras"', add
label define geo2b_br_lbl 2501807 `"Bayeux"', add
label define geo2b_br_lbl 2503209 `"Cabedelo"', add
label define geo2b_br_lbl 2503704 `"Cajazeiras"', add
label define geo2b_br_lbl 2504009 `"Campina Grande**"', add
label define geo2b_br_lbl 2504306 `"Catolé do Rocha"', add
label define geo2b_br_lbl 2505105 `"Cuité**"', add
label define geo2b_br_lbl 2506004 `"Esperança"', add
label define geo2b_br_lbl 2506301 `"Guarabira"', add
label define geo2b_br_lbl 2506905 `"Itabaiana"', add
label define geo2b_br_lbl 2507002 `"Itaporanga"', add
label define geo2b_br_lbl 2507507 `"João Pessoa"', add
label define geo2b_br_lbl 2508307 `"Lagoa Seca"', add
label define geo2b_br_lbl 2508901 `"Mamanguape**"', add
label define geo2b_br_lbl 2509107 `"Mari"', add
label define geo2b_br_lbl 2509701 `"Monteiro"', add
label define geo2b_br_lbl 2510808 `"Patos"', add
label define geo2b_br_lbl 2511202 `"Pedras de Fogo"', add
label define geo2b_br_lbl 2512101 `"Pombal**"', add
label define geo2b_br_lbl 2512507 `"Queimadas"', add
label define geo2b_br_lbl 2512903 `"Rio Tinto**"', add
label define geo2b_br_lbl 2513703 `"Santa Rita"', add
label define geo2b_br_lbl 2513901 `"São Bento"', add
label define geo2b_br_lbl 2515302 `"Sapé**"', add
label define geo2b_br_lbl 2516003 `"Solânea**"', add
label define geo2b_br_lbl 2516201 `"Sousa**"', add
label define geo2b_br_lbl 4199999 `"Rest of Paraná"', add
label define geo2b_br_lbl 4100400 `"Almirante Tamandaré**"', add
label define geo2b_br_lbl 4101101 `"Andirá"', add
label define geo2b_br_lbl 4101408 `"Apucarana"', add
label define geo2b_br_lbl 4101507 `"Arapongas"', add
label define geo2b_br_lbl 4101606 `"Arapoti"', add
label define geo2b_br_lbl 4101804 `"Araucária"', add
label define geo2b_br_lbl 4102000 `"Assis Chateaubriand*"', add
label define geo2b_br_lbl 4102109 `"Astorga"', add
label define geo2b_br_lbl 4102406 `"Bandeirantes"', add
label define geo2b_br_lbl 4103602 `"Cambará"', add
label define geo2b_br_lbl 4103701 `"Cambé"', add
label define geo2b_br_lbl 4104006 `"Campina Grande do Sul"', add
label define geo2b_br_lbl 4104204 `"Campo Largo"', add
label define geo2b_br_lbl 4104253 `"Campo Magro"', add
label define geo2b_br_lbl 4104303 `"Campo Mourão***"', add
label define geo2b_br_lbl 4104808 `"Cascavel*"', add
label define geo2b_br_lbl 4104907 `"Castro**"', add
label define geo2b_br_lbl 4105409 `"Chopinzinho***"', add
label define geo2b_br_lbl 4105508 `"Cianorte"', add
label define geo2b_br_lbl 4105805 `"Colombo"', add
label define geo2b_br_lbl 4105904 `"Colorado"', add
label define geo2b_br_lbl 4106407 `"Cornélio Procópio"', add
label define geo2b_br_lbl 4106506 `"Coronel Vivida"', add
label define geo2b_br_lbl 4106605 `"Cruzeiro do Oeste"', add
label define geo2b_br_lbl 4106902 `"Curitiba"', add
label define geo2b_br_lbl 4107207 `"Dois Vizinhos**"', add
label define geo2b_br_lbl 4107652 `"Fazenda Rio Grande"', add
label define geo2b_br_lbl 4108304 `"Foz do Iguaçu*"', add
label define geo2b_br_lbl 4108403 `"Francisco Beltrão"', add
label define geo2b_br_lbl 4108601 `"Goioerê**"', add
label define geo2b_br_lbl 4108809 `"Guaíra"', add
label define geo2b_br_lbl 4109401 `"Guarapuava***"', add
label define geo2b_br_lbl 4109609 `"Guaratuba"', add
label define geo2b_br_lbl 4109708 `"Ibaiti"', add
label define geo2b_br_lbl 4109807 `"Ibiporã"', add
label define geo2b_br_lbl 4110102 `"Imbituva**"', add
label define geo2b_br_lbl 4110706 `"Irati"', add
label define geo2b_br_lbl 4111506 `"Ivaiporã**"', add
label define geo2b_br_lbl 4111803 `"Jacarezinho"', add
label define geo2b_br_lbl 4112009 `"Jaguariaíva"', add
label define geo2b_br_lbl 4112108 `"Jandaia do Sul"', add
label define geo2b_br_lbl 4113205 `"Lapa"', add
label define geo2b_br_lbl 4113304 `"Laranjeiras do Sul**"', add
label define geo2b_br_lbl 4113700 `"Londrina**"', add
label define geo2b_br_lbl 4114203 `"Mandaguari"', add
label define geo2b_br_lbl 4114609 `"Marechal Cândido Rondon**"', add
label define geo2b_br_lbl 4114807 `"Marialva*"', add
label define geo2b_br_lbl 4115200 `"Maringá"', add
label define geo2b_br_lbl 4115705 `"Matinhos"', add
label define geo2b_br_lbl 4115804 `"Medianeira***"', add
label define geo2b_br_lbl 4116901 `"Nova Esperança"', add
label define geo2b_br_lbl 4117305 `"Ortigueira"', add
label define geo2b_br_lbl 4117503 `"Paiçandu"', add
label define geo2b_br_lbl 4117602 `"Palmas**"', add
label define geo2b_br_lbl 4117701 `"Palmeira"', add
label define geo2b_br_lbl 4117909 `"Palotina**"', add
label define geo2b_br_lbl 4118204 `"Paranaguá**"', add
label define geo2b_br_lbl 4118402 `"Paranavaí"', add
label define geo2b_br_lbl 4118501 `"Pato Branco**"', add
label define geo2b_br_lbl 4119152 `"Pinhais"', add
label define geo2b_br_lbl 4119301 `"Pinhão**"', add
label define geo2b_br_lbl 4119400 `"Piraí do Sul"', add
label define geo2b_br_lbl 4119509 `"Piraquara**"', add
label define geo2b_br_lbl 4119608 `"Pitanga***"', add
label define geo2b_br_lbl 4119905 `"Ponta Grossa**"', add
label define geo2b_br_lbl 4120606 `"Prudentópolis"', add
label define geo2b_br_lbl 4120903 `"Quedas do Iguaçu**"', add
label define geo2b_br_lbl 4121703 `"Reserva**"', add
label define geo2b_br_lbl 4122206 `"Rio Branco do Sul**"', add
label define geo2b_br_lbl 4122305 `"Rio Negro"', add
label define geo2b_br_lbl 4122404 `"Rolândia**"', add
label define geo2b_br_lbl 4123501 `"Santa Helena*"', add
label define geo2b_br_lbl 4124103 `"Santo Antônio da Platina"', add
label define geo2b_br_lbl 4125506 `"São José dos Pinhais"', add
label define geo2b_br_lbl 4125605 `"São Mateus do Sul"', add
label define geo2b_br_lbl 4125704 `"São Miguel do Iguaçu**"', add
label define geo2b_br_lbl 4126256 `"Sarandi"', add
label define geo2b_br_lbl 4127106 `"Telêmaco Borba**"', add
label define geo2b_br_lbl 4127700 `"Toledo***"', add
label define geo2b_br_lbl 4128005 `"Ubiratã"', add
label define geo2b_br_lbl 4128104 `"Umuarama**"', add
label define geo2b_br_lbl 4128203 `"União da Vitória"', add
label define geo2b_br_lbl 4128500 `"Wenceslau Braz"', add
label define geo2b_br_lbl 2600054 `"Abreu e Lima"', add
label define geo2b_br_lbl 2600104 `"Afogados da Ingazeira"', add
label define geo2b_br_lbl 2699999 `"Rest of Pernambuco"', add
label define geo2b_br_lbl 2600302 `"Agrestina"', add
label define geo2b_br_lbl 2600401 `"Água Preta**"', add
label define geo2b_br_lbl 2600500 `"Águas Belas"', add
label define geo2b_br_lbl 2600708 `"Aliança"', add
label define geo2b_br_lbl 2600807 `"Altinho"', add
label define geo2b_br_lbl 2600906 `"Amaraji"', add
label define geo2b_br_lbl 2601102 `"Araripina"', add
label define geo2b_br_lbl 2601201 `"Arcoverde"', add
label define geo2b_br_lbl 2601409 `"Barreiros"', add
label define geo2b_br_lbl 2601607 `"Belém de São Francisco"', add
label define geo2b_br_lbl 2601706 `"Belo Jardim"', add
label define geo2b_br_lbl 2601904 `"Bezerros"', add
label define geo2b_br_lbl 2602001 `"Bodocó"', add
label define geo2b_br_lbl 2602100 `"Bom Conselho"', add
label define geo2b_br_lbl 2602209 `"Bom Jardim"', add
label define geo2b_br_lbl 2602308 `"Bonito"', add
label define geo2b_br_lbl 2602605 `"Brejo da Madre de Deus"', add
label define geo2b_br_lbl 2602803 `"Buíque"', add
label define geo2b_br_lbl 2602902 `"Cabo de Santo Agostinho"', add
label define geo2b_br_lbl 2603009 `"Cabrobó"', add
label define geo2b_br_lbl 2603207 `"Caetés"', add
label define geo2b_br_lbl 2603454 `"Camaragibe"', add
label define geo2b_br_lbl 2603702 `"Canhotinho"', add
label define geo2b_br_lbl 2603801 `"Capoeiras"', add
label define geo2b_br_lbl 2604007 `"Carpina**"', add
label define geo2b_br_lbl 2604106 `"Caruaru"', add
label define geo2b_br_lbl 2604205 `"Catende"', add
label define geo2b_br_lbl 2604601 `"Condado"', add
label define geo2b_br_lbl 2604908 `"Cumaru"', add
label define geo2b_br_lbl 2605004 `"Cupira"', add
label define geo2b_br_lbl 2605103 `"Custódia"', add
label define geo2b_br_lbl 2605202 `"Escada"', add
label define geo2b_br_lbl 2605301 `"Exu"', add
label define geo2b_br_lbl 2605608 `"Flores"', add
label define geo2b_br_lbl 2605707 `"Floresta**"', add
label define geo2b_br_lbl 2605905 `"Gameleira"', add
label define geo2b_br_lbl 2606002 `"Garanhuns"', add
label define geo2b_br_lbl 2606101 `"Glória do Goitá"', add
label define geo2b_br_lbl 2606200 `"Goiana"', add
label define geo2b_br_lbl 2606408 `"Gravatá"', add
label define geo2b_br_lbl 2606606 `"Ibimirim"', add
label define geo2b_br_lbl 2606804 `"Igarassu***"', add
label define geo2b_br_lbl 2607208 `"Ipojuca"', add
label define geo2b_br_lbl 2607307 `"Ipubi"', add
label define geo2b_br_lbl 2607505 `"Itaíba"', add
label define geo2b_br_lbl 2607653 `"Itambé"', add
label define geo2b_br_lbl 2607752 `"Itapissuma"', add
label define geo2b_br_lbl 2607901 `"Jaboatão dos Guararapes"', add
label define geo2b_br_lbl 2608107 `"João Alfredo"', add
label define geo2b_br_lbl 2608800 `"Lajedo"', add
label define geo2b_br_lbl 2608909 `"Limoeiro"', add
label define geo2b_br_lbl 2609006 `"Macaparana"', add
label define geo2b_br_lbl 2609402 `"Moreno"', add
label define geo2b_br_lbl 2609501 `"Nazaré da Mata"', add
label define geo2b_br_lbl 2609600 `"Olinda"', add
label define geo2b_br_lbl 2609709 `"Orobó"', add
label define geo2b_br_lbl 2609907 `"Ouricuri**"', add
label define geo2b_br_lbl 2610004 `"Palmares"', add
label define geo2b_br_lbl 2610202 `"Panelas"', add
label define geo2b_br_lbl 2610400 `"Parnamirim"', add
label define geo2b_br_lbl 2610509 `"Passira"', add
label define geo2b_br_lbl 2610608 `"Paudalho*"', add
label define geo2b_br_lbl 2610707 `"Paulista*"', add
label define geo2b_br_lbl 2610905 `"Pesqueira"', add
label define geo2b_br_lbl 2611002 `"Petrolândia**"', add
label define geo2b_br_lbl 2611101 `"Petrolina**"', add
label define geo2b_br_lbl 2611309 `"Pombos"', add
label define geo2b_br_lbl 2611507 `"Quipapá"', add
label define geo2b_br_lbl 2611606 `"Recife*"', add
label define geo2b_br_lbl 2611804 `"Ribeirão"', add
label define geo2b_br_lbl 2611903 `"Rio Formoso**"', add
label define geo2b_br_lbl 2612208 `"Salgueiro"', add
label define geo2b_br_lbl 2612505 `"Santa Cruz do Capibaribe"', add
label define geo2b_br_lbl 2612604 `"Santa Maria da Boa Vista**"', add
label define geo2b_br_lbl 2613008 `"São Bento do Una"', add
label define geo2b_br_lbl 2613107 `"São Caitano"', add
label define geo2b_br_lbl 2613305 `"São Joaquim do Monte"', add
label define geo2b_br_lbl 2613503 `"São José do Belmonte"', add
label define geo2b_br_lbl 2613602 `"São José do Egito"', add
label define geo2b_br_lbl 2613701 `"São Lourenço da Mata*"', add
label define geo2b_br_lbl 2613909 `"Serra Talhada"', add
label define geo2b_br_lbl 2614105 `"Sertânia"', add
label define geo2b_br_lbl 2614204 `"Sirinhaém"', add
label define geo2b_br_lbl 2614501 `"Surubim**"', add
label define geo2b_br_lbl 2614600 `"Tabira"', add
label define geo2b_br_lbl 2615003 `"Taquaritinga do Norte"', add
label define geo2b_br_lbl 2615300 `"Timbaúba"', add
label define geo2b_br_lbl 2615409 `"Toritama"', add
label define geo2b_br_lbl 2615607 `"Trindade"', add
label define geo2b_br_lbl 2615805 `"Tupanatinga"', add
label define geo2b_br_lbl 2616308 `"Vicência"', add
label define geo2b_br_lbl 2616407 `"Vitória de Santo Antão"', add
label define geo2b_br_lbl 2299999 `"Rest of Piauí"', add
label define geo2b_br_lbl 2200400 `"Altos**"', add
label define geo2b_br_lbl 2201200 `"Barras**"', add
label define geo2b_br_lbl 2201507 `"Batalha**"', add
label define geo2b_br_lbl 2202208 `"Campo Maior**"', add
label define geo2b_br_lbl 2202703 `"Cocal**"', add
label define geo2b_br_lbl 2202901 `"Corrente**"', add
label define geo2b_br_lbl 2203701 `"Esperantina**"', add
label define geo2b_br_lbl 2203909 `"Floriano"', add
label define geo2b_br_lbl 2205508 `"José de Freitas"', add
label define geo2b_br_lbl 2205706 `"Luís Correia**"', add
label define geo2b_br_lbl 2205805 `"Luzilândia**"', add
label define geo2b_br_lbl 2206209 `"Miguel Alves**"', add
label define geo2b_br_lbl 2207009 `"Oeiras**"', add
label define geo2b_br_lbl 2207702 `"Parnaíba**"', add
label define geo2b_br_lbl 2207900 `"Pedro II**"', add
label define geo2b_br_lbl 2208007 `"Picos***"', add
label define geo2b_br_lbl 2208304 `"Piracuruca**"', add
label define geo2b_br_lbl 2208403 `"Piripiri**"', add
label define geo2b_br_lbl 2210607 `"São Raimundo Nonato***"', add
label define geo2b_br_lbl 2211001 `"Teresina**"', add
label define geo2b_br_lbl 2211100 `"União**"', add
label define geo2b_br_lbl 2211308 `"Valença do Piauí**"', add
label define geo2b_br_lbl 3300100 `"Angra dos Reis"', add
label define geo2b_br_lbl 3399999 `"Rest of Rio de Janeiro"', add
label define geo2b_br_lbl 3300209 `"Araruama"', add
label define geo2b_br_lbl 3300258 `"Arraial do Cabo"', add
label define geo2b_br_lbl 3300308 `"Barra do Piraí"', add
label define geo2b_br_lbl 3300407 `"Barra Mansa**"', add
label define geo2b_br_lbl 3300456 `"Belford Roxo"', add
label define geo2b_br_lbl 3300506 `"Bom Jardim"', add
label define geo2b_br_lbl 3300605 `"Bom Jesus do Itabapoana"', add
label define geo2b_br_lbl 3300704 `"Cabo Frio***"', add
label define geo2b_br_lbl 3300803 `"Cachoeiras de Macacu"', add
label define geo2b_br_lbl 3301009 `"Campos dos Goytacazes***"', add
label define geo2b_br_lbl 3301306 `"Casimiro de Abreu**"', add
label define geo2b_br_lbl 3301702 `"Duque de Caxias"', add
label define geo2b_br_lbl 3301850 `"Guapimirim"', add
label define geo2b_br_lbl 3301900 `"Itaboraí**"', add
label define geo2b_br_lbl 3302007 `"Itaguaí**"', add
label define geo2b_br_lbl 3302106 `"Itaocara"', add
label define geo2b_br_lbl 3302205 `"Itaperuna"', add
label define geo2b_br_lbl 3302254 `"Itatiaia"', add
label define geo2b_br_lbl 3302270 `"Japeri"', add
label define geo2b_br_lbl 3302403 `"Macaé***"', add
label define geo2b_br_lbl 3302502 `"Magé**"', add
label define geo2b_br_lbl 3302601 `"Mangaratiba"', add
label define geo2b_br_lbl 3302700 `"Maricá"', add
label define geo2b_br_lbl 3302908 `"Miguel Pereira"', add
label define geo2b_br_lbl 3303005 `"Miracema"', add
label define geo2b_br_lbl 3303203 `"Nilópolis"', add
label define geo2b_br_lbl 3303302 `"Niterói"', add
label define geo2b_br_lbl 3303401 `"Nova Friburgo"', add
label define geo2b_br_lbl 3303500 `"Nova Iguaçu**"', add
label define geo2b_br_lbl 3303609 `"Paracambi"', add
label define geo2b_br_lbl 3303708 `"Paraíba do Sul"', add
label define geo2b_br_lbl 3303807 `"Parati"', add
label define geo2b_br_lbl 3303856 `"Paty do Alferes"', add
label define geo2b_br_lbl 3303906 `"Petrópolis*"', add
label define geo2b_br_lbl 3304003 `"Piraí**"', add
label define geo2b_br_lbl 3304144 `"Queimados"', add
label define geo2b_br_lbl 3304201 `"Resende***"', add
label define geo2b_br_lbl 3304300 `"Rio Bonito"', add
label define geo2b_br_lbl 3304524 `"Rio das Ostras"', add
label define geo2b_br_lbl 3304557 `"Rio de Janeiro"', add
label define geo2b_br_lbl 3304706 `"Santo Antônio de Pádua**"', add
label define geo2b_br_lbl 3304755 `"São Francisco de Itabapoana"', add
label define geo2b_br_lbl 3304805 `"São Fidélis"', add
label define geo2b_br_lbl 3304904 `"São Gonçalo"', add
label define geo2b_br_lbl 3305000 `"São João da Barra**"', add
label define geo2b_br_lbl 3305109 `"São João de Meriti"', add
label define geo2b_br_lbl 3305208 `"São Pedro da Aldeia**"', add
label define geo2b_br_lbl 3305505 `"Saquarema"', add
label define geo2b_br_lbl 3305554 `"Seropédica"', add
label define geo2b_br_lbl 3305604 `"Silva Jardim"', add
label define geo2b_br_lbl 3305752 `"Tanguá"', add
label define geo2b_br_lbl 3305802 `"Teresópolis"', add
label define geo2b_br_lbl 3306008 `"Três Rios**"', add
label define geo2b_br_lbl 3306107 `"Valença"', add
label define geo2b_br_lbl 3306206 `"Vassouras*"', add
label define geo2b_br_lbl 3306305 `"Volta Redonda"', add
label define geo2b_br_lbl 3302858 `"Mesquita+"', add
label define geo2b_br_lbl 2499999 `"Rest of Rio Grande do Norte"', add
label define geo2b_br_lbl 2400208 `"Açu*"', add
label define geo2b_br_lbl 2401008 `"Apodi"', add
label define geo2b_br_lbl 2401107 `"Areia Branca*"', add
label define geo2b_br_lbl 2402006 `"Caicó"', add
label define geo2b_br_lbl 2402204 `"Canguaretama"', add
label define geo2b_br_lbl 2402600 `"Ceará-Mirim"', add
label define geo2b_br_lbl 2403103 `"Currais Novos"', add
label define geo2b_br_lbl 2403251 `"Parnamirim"', add
label define geo2b_br_lbl 2405801 `"João Câmara"', add
label define geo2b_br_lbl 2407104 `"Macaíba"', add
label define geo2b_br_lbl 2407203 `"Macau"', add
label define geo2b_br_lbl 2408003 `"Mossoró*"', add
label define geo2b_br_lbl 2408102 `"Natal"', add
label define geo2b_br_lbl 2408300 `"Nova Cruz"', add
label define geo2b_br_lbl 2409407 `"Pau dos Ferros"', add
label define geo2b_br_lbl 2411205 `"Santa Cruz"', add
label define geo2b_br_lbl 2411502 `"Santo Antônio"', add
label define geo2b_br_lbl 2412005 `"São Gonçalo do Amarante"', add
label define geo2b_br_lbl 2412203 `"São José de Mipibu"', add
label define geo2b_br_lbl 2412500 `"São Miguel**"', add
label define geo2b_br_lbl 2414407 `"Touros**"', add
label define geo2b_br_lbl 4399999 `"Rest of Rio Grande do Sul"', add
label define geo2b_br_lbl 4300406 `"Alegrete**"', add
label define geo2b_br_lbl 4300604 `"Alvorada"', add
label define geo2b_br_lbl 4301602 `"Bagé**"', add
label define geo2b_br_lbl 4302105 `"Bento Gonçalves**"', add
label define geo2b_br_lbl 4302808 `"Caçapava do Sul"', add
label define geo2b_br_lbl 4303004 `"Cachoeira do Sul***"', add
label define geo2b_br_lbl 4303103 `"Cachoeirinha"', add
label define geo2b_br_lbl 4303509 `"Camaquã***"', add
label define geo2b_br_lbl 4303905 `"Campo Bom"', add
label define geo2b_br_lbl 4304200 `"Candelária**"', add
label define geo2b_br_lbl 4304408 `"Canela"', add
label define geo2b_br_lbl 4304507 `"Canguçu"', add
label define geo2b_br_lbl 4304606 `"Canoas***"', add
label define geo2b_br_lbl 4304630 `"Capão da Canoa**"', add
label define geo2b_br_lbl 4304663 `"Capão do Leão"', add
label define geo2b_br_lbl 4304705 `"Carazinho**"', add
label define geo2b_br_lbl 4304804 `"Carlos Barbosa*"', add
label define geo2b_br_lbl 4305108 `"Caxias do Sul"', add
label define geo2b_br_lbl 4305355 `"Charqueadas"', add
label define geo2b_br_lbl 4306106 `"Cruz Alta*"', add
label define geo2b_br_lbl 4306403 `"Dois Irmãos***"', add
label define geo2b_br_lbl 4306601 `"Dom Pedrito"', add
label define geo2b_br_lbl 4306767 `"Eldorado do Sul"', add
label define geo2b_br_lbl 4306908 `"Encruzilhada do Sul*"', add
label define geo2b_br_lbl 4307005 `"Erechim*"', add
label define geo2b_br_lbl 4307609 `"Estância Velha"', add
label define geo2b_br_lbl 4307708 `"Esteio"', add
label define geo2b_br_lbl 4307807 `"Estrela***"', add
label define geo2b_br_lbl 4307906 `"Farroupilha"', add
label define geo2b_br_lbl 4308201 `"Flores da Cunha**"', add
label define geo2b_br_lbl 4308508 `"Frederico Westphalen*"', add
label define geo2b_br_lbl 4308607 `"Garibaldi***"', add
label define geo2b_br_lbl 4309100 `"Gramado"', add
label define geo2b_br_lbl 4309209 `"Gravataí*"', add
label define geo2b_br_lbl 4309308 `"Guaíba***"', add
label define geo2b_br_lbl 4310108 `"Igrejinha"', add
label define geo2b_br_lbl 4310207 `"Ijuí**"', add
label define geo2b_br_lbl 4310603 `"Itaqui**"', add
label define geo2b_br_lbl 4311007 `"Jaguarão"', add
label define geo2b_br_lbl 4311205 `"Júlio de Castilhos***"', add
label define geo2b_br_lbl 4311304 `"Lagoa Vermelha***"', add
label define geo2b_br_lbl 4311403 `"Lajeado***"', add
label define geo2b_br_lbl 4311809 `"Marau***"', add
label define geo2b_br_lbl 4312401 `"Montenegro***"', add
label define geo2b_br_lbl 4313409 `"Novo Hamburgo"', add
label define geo2b_br_lbl 4313508 `"Osório***"', add
label define geo2b_br_lbl 4313706 `"Palmeira das Missões***"', add
label define geo2b_br_lbl 4313904 `"Panambi"', add
label define geo2b_br_lbl 4314050 `"Parobé"', add
label define geo2b_br_lbl 4314100 `"Passo Fundo***"', add
label define geo2b_br_lbl 4314407 `"Pelotas***"', add
label define geo2b_br_lbl 4314803 `"Portão*"', add
label define geo2b_br_lbl 4314902 `"Porto Alegre"', add
label define geo2b_br_lbl 4315305 `"Quaraí"', add
label define geo2b_br_lbl 4315602 `"Rio Grande"', add
label define geo2b_br_lbl 4315701 `"Rio Pardo***"', add
label define geo2b_br_lbl 4316402 `"Rosário do Sul"', add
label define geo2b_br_lbl 4316808 `"Santa Cruz do Sul***"', add
label define geo2b_br_lbl 4316907 `"Santa Maria***"', add
label define geo2b_br_lbl 4317103 `"Santana do Livramento"', add
label define geo2b_br_lbl 4317202 `"Santa Rosa"', add
label define geo2b_br_lbl 4317301 `"Santa Vitória do Palmar**"', add
label define geo2b_br_lbl 4317400 `"Santiago***"', add
label define geo2b_br_lbl 4317509 `"Santo Ângelo***"', add
label define geo2b_br_lbl 4317608 `"Santo Antônio da Patrulha**"', add
label define geo2b_br_lbl 4318002 `"São Borja***"', add
label define geo2b_br_lbl 4318101 `"São Francisco de Assis**"', add
label define geo2b_br_lbl 4318309 `"São Gabriel**"', add
label define geo2b_br_lbl 4318408 `"São Jerônimo***"', add
label define geo2b_br_lbl 4318507 `"São José do Norte"', add
label define geo2b_br_lbl 4318705 `"São Leopoldo"', add
label define geo2b_br_lbl 4318804 `"São Lourenço do Sul**"', add
label define geo2b_br_lbl 4318903 `"São Luiz Gonzaga*"', add
label define geo2b_br_lbl 4319604 `"São Sepé**"', add
label define geo2b_br_lbl 4319901 `"Sapiranga***"', add
label define geo2b_br_lbl 4320008 `"Sapucaia do Sul"', add
label define geo2b_br_lbl 4320800 `"Soledade***"', add
label define geo2b_br_lbl 4321204 `"Taquara*"', add
label define geo2b_br_lbl 4321303 `"Taquari***"', add
label define geo2b_br_lbl 4321451 `"Teutônia"', add
label define geo2b_br_lbl 4321501 `"Torres***"', add
label define geo2b_br_lbl 4321600 `"Tramandaí*"', add
label define geo2b_br_lbl 4321808 `"Três de Maio***"', add
label define geo2b_br_lbl 4321907 `"Três Passos**"', add
label define geo2b_br_lbl 4322004 `"Triunfo"', add
label define geo2b_br_lbl 4322202 `"Tupanciretã***"', add
label define geo2b_br_lbl 4322400 `"Uruguaiana**"', add
label define geo2b_br_lbl 4322509 `"Vacaria***"', add
label define geo2b_br_lbl 4322608 `"Venâncio Aires***"', add
label define geo2b_br_lbl 4322707 `"Vera Cruz"', add
label define geo2b_br_lbl 4323002 `"Viamão*"', add
label define geo2b_br_lbl 1100015 `"Alta Floresta D'Oeste**"', add
label define geo2b_br_lbl 1100023 `"Ariquemes***"', add
label define geo2b_br_lbl 1199999 `"Rest of Rondônia"', add
label define geo2b_br_lbl 1100049 `"Cacoal***"', add
label define geo2b_br_lbl 1100064 `"Colorado do Oeste**"', add
label define geo2b_br_lbl 1100098 `"Espigão D'Oeste"', add
label define geo2b_br_lbl 1100106 `"Guajará-Mirim*"', add
label define geo2b_br_lbl 1100114 `"Jaru**"', add
label define geo2b_br_lbl 1100122 `"Ji-Paraná*"', add
label define geo2b_br_lbl 1100130 `"Machadinho D'Oeste**"', add
label define geo2b_br_lbl 1100155 `"Ouro Preto do Oeste**"', add
label define geo2b_br_lbl 1100189 `"Pimenta Bueno***"', add
label define geo2b_br_lbl 1100205 `"Porto Velho**"', add
label define geo2b_br_lbl 1100254 `"Presidente Médici"', add
label define geo2b_br_lbl 1100288 `"Rolim de Moura**"', add
label define geo2b_br_lbl 1100304 `"Vilhena***"', add
label define geo2b_br_lbl 1100320 `"São Miguel do Guaporé**"', add
label define geo2b_br_lbl 1100452 `"Buritis"', add
label define geo2b_br_lbl 1499999 `"Rest of Roraima"', add
label define geo2b_br_lbl 1400100 `"Boa Vista***"', add
label define geo2b_br_lbl 4299999 `"Rest of Santa Catarina"', add
label define geo2b_br_lbl 4201307 `"Araquari**"', add
label define geo2b_br_lbl 4201406 `"Araranguá**"', add
label define geo2b_br_lbl 4202008 `"Balneário Camboriú"', add
label define geo2b_br_lbl 4202305 `"Biguaçu"', add
label define geo2b_br_lbl 4202404 `"Blumenau"', add
label define geo2b_br_lbl 4202800 `"Braço do Norte"', add
label define geo2b_br_lbl 4202909 `"Brusque"', add
label define geo2b_br_lbl 4203006 `"Caçador**"', add
label define geo2b_br_lbl 4203204 `"Camboriú"', add
label define geo2b_br_lbl 4203600 `"Campos Novos***"', add
label define geo2b_br_lbl 4203808 `"Canoinhas**"', add
label define geo2b_br_lbl 4203907 `"Capinzal"', add
label define geo2b_br_lbl 4204202 `"Chapecó**"', add
label define geo2b_br_lbl 4204301 `"Concórdia***"', add
label define geo2b_br_lbl 4204608 `"Criciúma*"', add
label define geo2b_br_lbl 4204806 `"Curitibanos**"', add
label define geo2b_br_lbl 4205407 `"Florianópolis"', add
label define geo2b_br_lbl 4205506 `"Fraiburgo"', add
label define geo2b_br_lbl 4205902 `"Gaspar"', add
label define geo2b_br_lbl 4206504 `"Guaramirim"', add
label define geo2b_br_lbl 4206702 `"Herval d'Oeste+"', add
label define geo2b_br_lbl 4207007 `"Içara"', add
label define geo2b_br_lbl 4207304 `"Imbituba"', add
label define geo2b_br_lbl 4207502 `"Indaial*"', add
label define geo2b_br_lbl 4208203 `"Itajaí"', add
label define geo2b_br_lbl 4208302 `"Itapema"', add
label define geo2b_br_lbl 4208906 `"Jaraguá do Sul"', add
label define geo2b_br_lbl 4209003 `"Joaçaba**"', add
label define geo2b_br_lbl 4209102 `"Joinville"', add
label define geo2b_br_lbl 4209300 `"Lages***"', add
label define geo2b_br_lbl 4209409 `"Laguna"', add
label define geo2b_br_lbl 4210100 `"Mafra"', add
label define geo2b_br_lbl 4211306 `"Navegantes"', add
label define geo2b_br_lbl 4211900 `"Palhoça"', add
label define geo2b_br_lbl 4213203 `"Pomerode"', add
label define geo2b_br_lbl 4213609 `"Porto União"', add
label define geo2b_br_lbl 4214805 `"Rio do Sul"', add
label define geo2b_br_lbl 4215000 `"Rio Negrinho"', add
label define geo2b_br_lbl 4215802 `"São Bento do Sul"', add
label define geo2b_br_lbl 4216206 `"São Francisco do Sul"', add
label define geo2b_br_lbl 4216503 `"São Joaquim*"', add
label define geo2b_br_lbl 4216602 `"São José**"', add
label define geo2b_br_lbl 4217204 `"São Miguel do Oeste**"', add
label define geo2b_br_lbl 4217709 `"Sombrio***"', add
label define geo2b_br_lbl 4218004 `"Tijucas"', add
label define geo2b_br_lbl 4218202 `"Timbó"', add
label define geo2b_br_lbl 4218707 `"Tubarão**"', add
label define geo2b_br_lbl 4219309 `"Videira**"', add
label define geo2b_br_lbl 4219507 `"Xanxerê**"', add
label define geo2b_br_lbl 4219705 `"Xaxim***"', add
label define geo2b_br_lbl 3500105 `"Adamantina"', add
label define geo2b_br_lbl 3599999 `"Rest of São Paulo"', add
label define geo2b_br_lbl 3500303 `"Aguaí"', add
label define geo2b_br_lbl 3500709 `"Agudos**"', add
label define geo2b_br_lbl 3501301 `"Álvares Machado"', add
label define geo2b_br_lbl 3501608 `"Americana"', add
label define geo2b_br_lbl 3501707 `"Américo Brasiliense"', add
label define geo2b_br_lbl 3501905 `"Amparo"', add
label define geo2b_br_lbl 3502101 `"Andradina"', add
label define geo2b_br_lbl 3502507 `"Aparecida"', add
label define geo2b_br_lbl 3502705 `"Apiaí**"', add
label define geo2b_br_lbl 3502804 `"Araçatuba**"', add
label define geo2b_br_lbl 3502903 `"Araçoiaba da Serra"', add
label define geo2b_br_lbl 3503208 `"Araraquara**"', add
label define geo2b_br_lbl 3503307 `"Araras"', add
label define geo2b_br_lbl 3503802 `"Artur Nogueira**"', add
label define geo2b_br_lbl 3503901 `"Arujá"', add
label define geo2b_br_lbl 3504008 `"Assis**"', add
label define geo2b_br_lbl 3504107 `"Atibaia"', add
label define geo2b_br_lbl 3504503 `"Avaré"', add
label define geo2b_br_lbl 3505203 `"Bariri"', add
label define geo2b_br_lbl 3505302 `"Barra Bonita"', add
label define geo2b_br_lbl 3505500 `"Barretos"', add
label define geo2b_br_lbl 3505609 `"Barrinha"', add
label define geo2b_br_lbl 3505708 `"Barueri"', add
label define geo2b_br_lbl 3505807 `"Bastos"', add
label define geo2b_br_lbl 3505906 `"Batatais"', add
label define geo2b_br_lbl 3506003 `"Bauru"', add
label define geo2b_br_lbl 3506102 `"Bebedouro"', add
label define geo2b_br_lbl 3506359 `"Bertioga"', add
label define geo2b_br_lbl 3506508 `"Birigui"', add
label define geo2b_br_lbl 3506607 `"Biritiba-Mirim"', add
label define geo2b_br_lbl 3507001 `"Boituva"', add
label define geo2b_br_lbl 3507506 `"Botucatu"', add
label define geo2b_br_lbl 3507605 `"Bragança Paulista**"', add
label define geo2b_br_lbl 3508405 `"Cabreúva"', add
label define geo2b_br_lbl 3508504 `"Caçapava"', add
label define geo2b_br_lbl 3508603 `"Cachoeira Paulista"', add
label define geo2b_br_lbl 3509007 `"Caieiras"', add
label define geo2b_br_lbl 3509205 `"Cajamar"', add
label define geo2b_br_lbl 3509254 `"Cajati"', add
label define geo2b_br_lbl 3509403 `"Cajuru**"', add
label define geo2b_br_lbl 3509502 `"Campinas"', add
label define geo2b_br_lbl 3509601 `"Campo Limpo Paulista"', add
label define geo2b_br_lbl 3509700 `"Campos do Jordão"', add
label define geo2b_br_lbl 3510005 `"Cândido Mota"', add
label define geo2b_br_lbl 3510203 `"Capão Bonito**"', add
label define geo2b_br_lbl 3510401 `"Capivari"', add
label define geo2b_br_lbl 3510500 `"Caraguatatuba"', add
label define geo2b_br_lbl 3510609 `"Carapicuíba"', add
label define geo2b_br_lbl 3510807 `"Casa Branca"', add
label define geo2b_br_lbl 3511102 `"Catanduva**"', add
label define geo2b_br_lbl 3511508 `"Cerquilho"', add
label define geo2b_br_lbl 3512209 `"Conchal"', add
label define geo2b_br_lbl 3512803 `"Cosmópolis**"', add
label define geo2b_br_lbl 3513009 `"Cotia*"', add
label define geo2b_br_lbl 3513108 `"Cravinhos"', add
label define geo2b_br_lbl 3513405 `"Cruzeiro"', add
label define geo2b_br_lbl 3513504 `"Cubatão"', add
label define geo2b_br_lbl 3513603 `"Cunha"', add
label define geo2b_br_lbl 3513702 `"Descalvado"', add
label define geo2b_br_lbl 3513801 `"Diadema"', add
label define geo2b_br_lbl 3514106 `"Dois Córregos"', add
label define geo2b_br_lbl 3514403 `"Dracena"', add
label define geo2b_br_lbl 3515004 `"Embu"', add
label define geo2b_br_lbl 3515103 `"Embu-Guaçu+"', add
label define geo2b_br_lbl 3515186 `"Espírito Santo do Pinhal"', add
label define geo2b_br_lbl 3515509 `"Fernandópolis"', add
label define geo2b_br_lbl 3515707 `"Ferraz de Vasconcelos"', add
label define geo2b_br_lbl 3516200 `"Franca"', add
label define geo2b_br_lbl 3516309 `"Francisco Morato"', add
label define geo2b_br_lbl 3516408 `"Franco da Rocha"', add
label define geo2b_br_lbl 3516705 `"Garça"', add
label define geo2b_br_lbl 3517406 `"Guaíra"', add
label define geo2b_br_lbl 3518206 `"Guararapes"', add
label define geo2b_br_lbl 3518305 `"Guararema"', add
label define geo2b_br_lbl 3518404 `"Guaratinguetá**"', add
label define geo2b_br_lbl 3518602 `"Guariba"', add
label define geo2b_br_lbl 3518701 `"Guarujá"', add
label define geo2b_br_lbl 3518800 `"Guarulhos"', add
label define geo2b_br_lbl 3519071 `"Hortolândia"', add
label define geo2b_br_lbl 3519303 `"Ibaté"', add
label define geo2b_br_lbl 3519600 `"Ibitinga"', add
label define geo2b_br_lbl 3519709 `"Ibiúna"', add
label define geo2b_br_lbl 3520004 `"Igaraçu do Tietê"', add
label define geo2b_br_lbl 3520103 `"Igarapava"', add
label define geo2b_br_lbl 3520301 `"Iguape**"', add
label define geo2b_br_lbl 3520400 `"Ilhabela"', add
label define geo2b_br_lbl 3520442 `"Ilha Solteira"', add
label define geo2b_br_lbl 3520509 `"Indaiatuba"', add
label define geo2b_br_lbl 3521804 `"Itaí"', add
label define geo2b_br_lbl 3522109 `"Itanhaém"', add
label define geo2b_br_lbl 3522208 `"Itapecerica da Serra**"', add
label define geo2b_br_lbl 3522307 `"Itapetininga**"', add
label define geo2b_br_lbl 3522406 `"Itapeva**"', add
label define geo2b_br_lbl 3522505 `"Itapevi"', add
label define geo2b_br_lbl 3522604 `"Itapira"', add
label define geo2b_br_lbl 3522703 `"Itápolis"', add
label define geo2b_br_lbl 3523107 `"Itaquaquecetuba"', add
label define geo2b_br_lbl 3523206 `"Itararé**"', add
label define geo2b_br_lbl 3523404 `"Itatiba"', add
label define geo2b_br_lbl 3523909 `"Itu"', add
label define geo2b_br_lbl 3524006 `"Itupeva"', add
label define geo2b_br_lbl 3524105 `"Ituverava"', add
label define geo2b_br_lbl 3524303 `"Jaboticabal"', add
label define geo2b_br_lbl 3524402 `"Jacareí"', add
label define geo2b_br_lbl 3524709 `"Jaguariúna**"', add
label define geo2b_br_lbl 3524808 `"Jales**"', add
label define geo2b_br_lbl 3525003 `"Jandira"', add
label define geo2b_br_lbl 3525102 `"Jardinópolis"', add
label define geo2b_br_lbl 3525300 `"Jaú"', add
label define geo2b_br_lbl 3525706 `"José Bonifácio**"', add
label define geo2b_br_lbl 3525904 `"Jundiaí"', add
label define geo2b_br_lbl 3526100 `"Juquiá"', add
label define geo2b_br_lbl 3526209 `"Juquitiba"', add
label define geo2b_br_lbl 3526407 `"Laranjal Paulista"', add
label define geo2b_br_lbl 3526704 `"Leme"', add
label define geo2b_br_lbl 3526803 `"Lençóis Paulista**"', add
label define geo2b_br_lbl 3526902 `"Limeira"', add
label define geo2b_br_lbl 3527108 `"Lins"', add
label define geo2b_br_lbl 3527207 `"Lorena**"', add
label define geo2b_br_lbl 3527306 `"Louveira"', add
label define geo2b_br_lbl 3528403 `"Mairinque**"', add
label define geo2b_br_lbl 3528502 `"Mairiporã"', add
label define geo2b_br_lbl 3529005 `"Marília"', add
label define geo2b_br_lbl 3529203 `"Martinópolis"', add
label define geo2b_br_lbl 3529302 `"Matão"', add
label define geo2b_br_lbl 3529401 `"Mauá"', add
label define geo2b_br_lbl 3529906 `"Miracatu"', add
label define geo2b_br_lbl 3530102 `"Mirandópolis"', add
label define geo2b_br_lbl 3530300 `"Mirassol"', add
label define geo2b_br_lbl 3530508 `"Mococa"', add
label define geo2b_br_lbl 3530607 `"Mogi das Cruzes"', add
label define geo2b_br_lbl 3530706 `"Mogi Guaçu**"', add
label define geo2b_br_lbl 3530805 `"Moji Mirim"', add
label define geo2b_br_lbl 3531100 `"Mongaguá"', add
label define geo2b_br_lbl 3531308 `"Monte Alto"', add
label define geo2b_br_lbl 3531803 `"Monte Mor"', add
label define geo2b_br_lbl 3531902 `"Morro Agudo"', add
label define geo2b_br_lbl 3533403 `"Nova Odessa"', add
label define geo2b_br_lbl 3533502 `"Novo Horizonte"', add
label define geo2b_br_lbl 3533908 `"Olímpia"', add
label define geo2b_br_lbl 3534302 `"Orlândia"', add
label define geo2b_br_lbl 3534401 `"Osasco"', add
label define geo2b_br_lbl 3534609 `"Osvaldo Cruz"', add
label define geo2b_br_lbl 3534708 `"Ourinhos"', add
label define geo2b_br_lbl 3535309 `"Palmital"', add
label define geo2b_br_lbl 3535507 `"Paraguaçu Paulista"', add
label define geo2b_br_lbl 3536505 `"Paulínia"', add
label define geo2b_br_lbl 3536703 `"Pederneiras"', add
label define geo2b_br_lbl 3537107 `"Pedreira"', add
label define geo2b_br_lbl 3537305 `"Penápolis"', add
label define geo2b_br_lbl 3537404 `"Pereira Barreto**"', add
label define geo2b_br_lbl 3537602 `"Peruíbe"', add
label define geo2b_br_lbl 3537800 `"Piedade"', add
label define geo2b_br_lbl 3537909 `"Pilar do Sul"', add
label define geo2b_br_lbl 3538006 `"Pindamonhangaba"', add
label define geo2b_br_lbl 3538600 `"Piracaia"', add
label define geo2b_br_lbl 3538709 `"Piracicaba**"', add
label define geo2b_br_lbl 3538808 `"Piraju"', add
label define geo2b_br_lbl 3538907 `"Pirajuí"', add
label define geo2b_br_lbl 3539202 `"Pirapozinho"', add
label define geo2b_br_lbl 3539301 `"Pirassununga"', add
label define geo2b_br_lbl 3539509 `"Pitangueiras**"', add
label define geo2b_br_lbl 3539806 `"Poá"', add
label define geo2b_br_lbl 3540200 `"Pontal"', add
label define geo2b_br_lbl 3540606 `"Porto Feliz"', add
label define geo2b_br_lbl 3540705 `"Porto Ferreira"', add
label define geo2b_br_lbl 3541000 `"Praia Grande"', add
label define geo2b_br_lbl 3541307 `"Presidente Epitácio"', add
label define geo2b_br_lbl 3541406 `"Presidente Prudente"', add
label define geo2b_br_lbl 3541505 `"Presidente Venceslau"', add
label define geo2b_br_lbl 3541604 `"Promissão"', add
label define geo2b_br_lbl 3542206 `"Rancharia"', add
label define geo2b_br_lbl 3542602 `"Registro"', add
label define geo2b_br_lbl 3543006 `"Ribeirão Branco"', add
label define geo2b_br_lbl 3543303 `"Ribeirão Pires"', add
label define geo2b_br_lbl 3543402 `"Ribeirão Preto**"', add
label define geo2b_br_lbl 3543907 `"Rio Claro"', add
label define geo2b_br_lbl 3544004 `"Rio das Pedras"', add
label define geo2b_br_lbl 3544103 `"Rio Grande da Serra"', add
label define geo2b_br_lbl 3544251 `"Rosana"', add
label define geo2b_br_lbl 3545209 `"Salto"', add
label define geo2b_br_lbl 3545308 `"Salto de Pirapora"', add
label define geo2b_br_lbl 3545803 `"Santa Bárbara d'Oeste"', add
label define geo2b_br_lbl 3546306 `"Santa Cruz das Palmeiras"', add
label define geo2b_br_lbl 3546405 `"Santa Cruz do Rio Pardo**"', add
label define geo2b_br_lbl 3546603 `"Santa Fé do Sul**"', add
label define geo2b_br_lbl 3546801 `"Santa Isabel"', add
label define geo2b_br_lbl 3547304 `"Santana de Parnaíba"', add
label define geo2b_br_lbl 3547502 `"Santa Rita do Passa Quatro"', add
label define geo2b_br_lbl 3547601 `"Santa Rosa de Viterbo"', add
label define geo2b_br_lbl 3547700 `"Santo Anastácio**"', add
label define geo2b_br_lbl 3547809 `"Santo André"', add
label define geo2b_br_lbl 3548500 `"Santos**"', add
label define geo2b_br_lbl 3548708 `"São Bernardo do Campo"', add
label define geo2b_br_lbl 3548807 `"São Caetano do Sul"', add
label define geo2b_br_lbl 3548906 `"São Carlos"', add
label define geo2b_br_lbl 3549102 `"São João da Boa Vista"', add
label define geo2b_br_lbl 3549409 `"São Joaquim da Barra"', add
label define geo2b_br_lbl 3549706 `"São José do Rio Pardo"', add
label define geo2b_br_lbl 3549805 `"São José do Rio Preto**"', add
label define geo2b_br_lbl 3549904 `"São José dos Campos"', add
label define geo2b_br_lbl 3550100 `"São Manuel**"', add
label define geo2b_br_lbl 3550209 `"São Miguel Arcanjo"', add
label define geo2b_br_lbl 3550308 `"São Paulo"', add
label define geo2b_br_lbl 3550407 `"São Pedro"', add
label define geo2b_br_lbl 3550605 `"São Roque**"', add
label define geo2b_br_lbl 3550704 `"São Sebastião"', add
label define geo2b_br_lbl 3551009 `"São Vicente"', add
label define geo2b_br_lbl 3551504 `"Serrana"', add
label define geo2b_br_lbl 3551603 `"Serra Negra"', add
label define geo2b_br_lbl 3551702 `"Sertãozinho"', add
label define geo2b_br_lbl 3552106 `"Socorro"', add
label define geo2b_br_lbl 3552205 `"Sorocaba"', add
label define geo2b_br_lbl 3552403 `"Sumaré**"', add
label define geo2b_br_lbl 3552502 `"Suzano"', add
label define geo2b_br_lbl 3552809 `"Taboão da Serra"', add
label define geo2b_br_lbl 3553302 `"Tambaú"', add
label define geo2b_br_lbl 3553401 `"Tanabi"', add
label define geo2b_br_lbl 3553708 `"Taquaritinga"', add
label define geo2b_br_lbl 3553807 `"Taquarituba"', add
label define geo2b_br_lbl 3554003 `"Tatuí**"', add
label define geo2b_br_lbl 3554102 `"Taubaté"', add
label define geo2b_br_lbl 3554300 `"Teodoro Sampaio**"', add
label define geo2b_br_lbl 3554508 `"Tietê**"', add
label define geo2b_br_lbl 3554805 `"Tremembé"', add
label define geo2b_br_lbl 3555000 `"Tupã**"', add
label define geo2b_br_lbl 3555406 `"Ubatuba"', add
label define geo2b_br_lbl 3556206 `"Valinhos"', add
label define geo2b_br_lbl 3556404 `"Vargem Grande do Sul"', add
label define geo2b_br_lbl 3556453 `"Vargem Grande Paulista"', add
label define geo2b_br_lbl 3556503 `"Várzea Paulista"', add
label define geo2b_br_lbl 3556701 `"Vinhedo"', add
label define geo2b_br_lbl 3557006 `"Votorantim"', add
label define geo2b_br_lbl 3557105 `"Votuporanga**"', add
label define geo2b_br_lbl 2899999 `"Rest of Sergipe"', add
label define geo2b_br_lbl 2800308 `"Aracaju"', add
label define geo2b_br_lbl 2800670 `"Boquim"', add
label define geo2b_br_lbl 2801306 `"Capela"', add
label define geo2b_br_lbl 2802106 `"Estância"', add
label define geo2b_br_lbl 2802908 `"Itabaiana"', add
label define geo2b_br_lbl 2803005 `"Itabaianinha"', add
label define geo2b_br_lbl 2803203 `"Itaporanga d'Ajuda+"', add
label define geo2b_br_lbl 2803500 `"Lagarto"', add
label define geo2b_br_lbl 2803609 `"Laranjeiras"', add
label define geo2b_br_lbl 2804508 `"Nossa Senhora da Glória"', add
label define geo2b_br_lbl 2804607 `"Nossa Senhora das Dores"', add
label define geo2b_br_lbl 2804805 `"Nossa Senhora do Socorro"', add
label define geo2b_br_lbl 2805406 `"Poço Redondo"', add
label define geo2b_br_lbl 2805604 `"Porto da Folha"', add
label define geo2b_br_lbl 2805703 `"Propriá"', add
label define geo2b_br_lbl 2806701 `"São Cristóvão"', add
label define geo2b_br_lbl 2807105 `"Simão Dias"', add
label define geo2b_br_lbl 2807402 `"Tobias Barreto"', add
label define geo2b_br_lbl 1799999 `"Rest of Tocantins"', add
label define geo2b_br_lbl 1702109 `"Araguaína**"', add
label define geo2b_br_lbl 1702208 `"Araguatins**"', add
label define geo2b_br_lbl 1705508 `"Colinas do Tocantins"', add
label define geo2b_br_lbl 1709500 `"Gurupi**"', add
label define geo2b_br_lbl 1713205 `"Miracema do Tocantins**"', add
label define geo2b_br_lbl 1716109 `"Paraíso do Tocantins**"', add
label define geo2b_br_lbl 1718204 `"Porto Nacional**"', add
label define geo2b_br_lbl 1721000 `"Palmas"', add
label define geo2b_br_lbl 1721208 `"Tocantinópolis**"', add
label values geo2b_br geo2b_br_lbl

label define munibr_lbl 1199901 `"Cacoal merged"'
label define munibr_lbl 1199902 `"Porto Velho merged"', add
label define munibr_lbl 1200302 `"Feijó"', add
label define munibr_lbl 1299901 `"Cruzeiro do Sul merged"', add
label define munibr_lbl 1299902 `"Rio Branco merged"', add
label define munibr_lbl 1299903 `"Sena Madureira merged"', add
label define munibr_lbl 1299904 `"Senador Guiomard merged"', add
label define munibr_lbl 1299905 `"Tarauacá merged"', add
label define munibr_lbl 1300300 `"Autazes"', add
label define munibr_lbl 1300409 `"Barcelos"', add
label define munibr_lbl 1300706 `"Boca do Acre"', add
label define munibr_lbl 1301209 `"Coari"', add
label define munibr_lbl 1301407 `"Eirunepé"', add
label define munibr_lbl 1301704 `"Humaitá"', add
label define munibr_lbl 1302306 `"Jutaí"', add
label define munibr_lbl 1302405 `"Lábrea"', add
label define munibr_lbl 1302702 `"Manicoré"', add
label define munibr_lbl 1303106 `"Nova Olinda do Norte"', add
label define munibr_lbl 1303403 `"Parintins"', add
label define munibr_lbl 1303809 `"São Gabriel da Cachoeira"', add
label define munibr_lbl 1399901 `"Carauari merged"', add
label define munibr_lbl 1399902 `"Ipixuna merged"', add
label define munibr_lbl 1399903 `"Manaus merged"', add
label define munibr_lbl 1399904 `"Maués merged"', add
label define munibr_lbl 1399905 `"Tabatinga merged"', add
label define munibr_lbl 1399906 `"Tefé merged"', add
label define munibr_lbl 1399999 `"Rest of Amazonas"', add
label define munibr_lbl 1499901 `"Boa Vista merged"', add
label define munibr_lbl 1500107 `"Abaetetuba"', add
label define munibr_lbl 1500305 `"Afuá"', add
label define munibr_lbl 1500503 `"Almeirim"', add
label define munibr_lbl 1500800 `"Ananindeua"', add
label define munibr_lbl 1500909 `"Augusto Corrêa"', add
label define munibr_lbl 1501204 `"Baião"', add
label define munibr_lbl 1501303 `"Barcarena"', add
label define munibr_lbl 1501402 `"Belém"', add
label define munibr_lbl 1501808 `"Breves"', add
label define munibr_lbl 1502103 `"Cametá"', add
label define munibr_lbl 1502202 `"Capanema"', add
label define munibr_lbl 1502301 `"Capitão Poço"', add
label define munibr_lbl 1502400 `"Castanhal"', add
label define munibr_lbl 1502806 `"Curralinho"', add
label define munibr_lbl 1503101 `"Gurupá"', add
label define munibr_lbl 1503200 `"Igarapé-Açu"', add
label define munibr_lbl 1503309 `"Igarapé-Miri"', add
label define munibr_lbl 1503903 `"Juruti"', add
label define munibr_lbl 1504307 `"Maracanã"', add
label define munibr_lbl 1504406 `"Marapanim"', add
label define munibr_lbl 1504505 `"Melgaço"', add
label define munibr_lbl 1504604 `"Mocajuba"', add
label define munibr_lbl 1504802 `"Monte Alegre"', add
label define munibr_lbl 1504901 `"Muaná"', add
label define munibr_lbl 1505106 `"Óbidos"', add
label define munibr_lbl 1505205 `"Oeiras do Pará"', add
label define munibr_lbl 1506203 `"Salinópolis"', add
label define munibr_lbl 1506500 `"Santa Isabel do Pará"', add
label define munibr_lbl 1506609 `"Santa Maria do Pará"', add
label define munibr_lbl 1507607 `"São Miguel do Guamá"', add
label define munibr_lbl 1508001 `"Tomé-Açu"', add
label define munibr_lbl 1508209 `"Vigia"', add
label define munibr_lbl 1599901 `"Acará merged"', add
label define munibr_lbl 1599902 `"Alenquer merged"', add
label define munibr_lbl 1599903 `"Altamira merged"', add
label define munibr_lbl 1599904 `"Bragança merged"', add
label define munibr_lbl 1599905 `"Bujaru merged"', add
label define munibr_lbl 1599906 `"Curuçá merged"', add
label define munibr_lbl 1599907 `"Itaituba merged"', add
label define munibr_lbl 1599908 `"Marabá merged"', add
label define munibr_lbl 1599909 `"Marituba merged"', add
label define munibr_lbl 1599910 `"Oriximiná merged"', add
label define munibr_lbl 1599911 `"Paragominas merged"', add
label define munibr_lbl 1599912 `"Redenção merged"', add
label define munibr_lbl 1599913 `"Rurópolis merged"', add
label define munibr_lbl 1599914 `"Santana do Araguaia merged"', add
label define munibr_lbl 1599915 `"Santarém merged"', add
label define munibr_lbl 1599916 `"São Félix do Xingu merged"', add
label define munibr_lbl 1599917 `"São João de Pirabas merged"', add
label define munibr_lbl 1599999 `"Rest of Pará"', add
label define munibr_lbl 1699901 `"Laranjal do Jari merged"', add
label define munibr_lbl 1699902 `"Macapá merged"', add
label define munibr_lbl 1705508 `"Colinas do Tocantins"', add
label define munibr_lbl 1799901 `"Araguaína merged"', add
label define munibr_lbl 1799902 `"Araguatins merged"', add
label define munibr_lbl 1799903 `"Goiatins merged"', add
label define munibr_lbl 1799904 `"Guaraí merged"', add
label define munibr_lbl 1799905 `"Miracema do Tocantins merged"', add
label define munibr_lbl 1799906 `"Natividade merged"', add
label define munibr_lbl 1799907 `"Nova Olinda merged"', add
label define munibr_lbl 1799908 `"Palmas merged"', add
label define munibr_lbl 1799909 `"Paraíso do Tocantins merged"', add
label define munibr_lbl 1799910 `"Paranã merged"', add
label define munibr_lbl 1799911 `"Peixe merged"', add
label define munibr_lbl 1799912 `"São Miguel do Tocantins merged"', add
label define munibr_lbl 1799913 `"Tocantinópolis merged"', add
label define munibr_lbl 1799999 `"Rest of Tocantins"', add
label define munibr_lbl 2100204 `"Alcântara"', add
label define munibr_lbl 2100600 `"Amarante do Maranhão"', add
label define munibr_lbl 2100709 `"Anajatuba"', add
label define munibr_lbl 2101400 `"Balsas"', add
label define munibr_lbl 2102200 `"Buriti"', add
label define munibr_lbl 2102309 `"Buriti Bravo"', add
label define munibr_lbl 2103208 `"Chapadinha"', add
label define munibr_lbl 2103406 `"Coelho Neto"', add
label define munibr_lbl 2103802 `"Dom Pedro"', add
label define munibr_lbl 2105005 `"Humberto de Campos"', add
label define munibr_lbl 2105104 `"Icatu"', add
label define munibr_lbl 2106607 `"Matões"', add
label define munibr_lbl 2107803 `"Parnarama"', add
label define munibr_lbl 2108306 `"Penalva"', add
label define munibr_lbl 2108900 `"Poção de Pedras"', add
label define munibr_lbl 2109809 `"Santa Helena"', add
label define munibr_lbl 2109908 `"Santa Inês"', add
label define munibr_lbl 2110203 `"Santa Rita"', add
label define munibr_lbl 2110500 `"São Bento"', add
label define munibr_lbl 2111201 `"São José de Ribamar"', add
label define munibr_lbl 2111300 `"São Luís"', add
label define munibr_lbl 2112100 `"Timbiras"', add
label define munibr_lbl 2112209 `"Timon"', add
label define munibr_lbl 2112704 `"Vargem Grande"', add
label define munibr_lbl 2113009 `"Vitorino Freire"', add
label define munibr_lbl 2199901 `"Araioses merged"', add
label define munibr_lbl 2199902 `"Bacuri merged"', add
label define munibr_lbl 2199903 `"Barra do Corda merged"', add
label define munibr_lbl 2199904 `"Barreirinhas merged"', add
label define munibr_lbl 2199905 `"Bom Jardim merged"', add
label define munibr_lbl 2199906 `"Carolina merged"', add
label define munibr_lbl 2199907 `"Carutapera merged"', add
label define munibr_lbl 2199908 `"Caxias merged"', add
label define munibr_lbl 2199909 `"Codó merged"', add
label define munibr_lbl 2199910 `"Colinas merged"', add
label define munibr_lbl 2199911 `"Cururupu merged"', add
label define munibr_lbl 2199912 `"Esperantinópolis merged"', add
label define munibr_lbl 2199913 `"Governador Eugênio Barros merged"', add
label define munibr_lbl 2199914 `"Governador Nunes Freire merged"', add
label define munibr_lbl 2199915 `"Imperatriz merged"', add
label define munibr_lbl 2199916 `"Itapecuru Mirim merged"', add
label define munibr_lbl 2199917 `"João Lisboa merged"', add
label define munibr_lbl 2199918 `"Lago da Pedra merged"', add
label define munibr_lbl 2199919 `"Mirinzal merged"', add
label define munibr_lbl 2199920 `"Montes Altos merged"', add
label define munibr_lbl 2199921 `"Morros merged"', add
label define munibr_lbl 2199922 `"Paço do Lumiar merged"', add
label define munibr_lbl 2199923 `"Passagem Franca merged"', add
label define munibr_lbl 2199924 `"Pastos Bons merged"', add
label define munibr_lbl 2199925 `"Paulo Ramos merged"', add
label define munibr_lbl 2199926 `"Pedreiras merged"', add
label define munibr_lbl 2199927 `"Pindaré-Mirim merged"', add
label define munibr_lbl 2199928 `"Pinheiro merged"', add
label define munibr_lbl 2199929 `"Pio XII merged"', add
label define munibr_lbl 2199930 `"Porto Franco merged"', add
label define munibr_lbl 2199931 `"Presidente Dutra merged"', add
label define munibr_lbl 2199932 `"Primeira Cruz merged"', add
label define munibr_lbl 2199933 `"Riachão merged"', add
label define munibr_lbl 2199934 `"Rosário merged"', add
label define munibr_lbl 2199935 `"Santa Luzia merged"', add
label define munibr_lbl 2199936 `"Santa Quitéria do Maranhão merged"', add
label define munibr_lbl 2199937 `"São Bernardo merged"', add
label define munibr_lbl 2199938 `"São Domingos do Maranhão merged"', add
label define munibr_lbl 2199939 `"São João dos Patos merged"', add
label define munibr_lbl 2199940 `"Tuntum merged"', add
label define munibr_lbl 2199941 `"Turiaçu merged"', add
label define munibr_lbl 2199942 `"Urbano Santos merged"', add
label define munibr_lbl 2199943 `"Viana merged"', add
label define munibr_lbl 2199944 `"Vitória do Mearim merged"', add
label define munibr_lbl 2199945 `"Zé Doca merged"', add
label define munibr_lbl 2199999 `"Rest of Maranhão"', add
label define munibr_lbl 2203909 `"Floriano"', add
label define munibr_lbl 2205508 `"José de Freitas"', add
label define munibr_lbl 2299901 `"Altos merged"', add
label define munibr_lbl 2299902 `"Avelino Lopes merged"', add
label define munibr_lbl 2299903 `"Barras merged"', add
label define munibr_lbl 2299904 `"Bom Jesus merged"', add
label define munibr_lbl 2299905 `"Campo Maior merged"', add
label define munibr_lbl 2299906 `"Castelo do Piauí merged"', add
label define munibr_lbl 2299907 `"Cocal merged"', add
label define munibr_lbl 2299908 `"Corrente merged"', add
label define munibr_lbl 2299909 `"Jaicós merged"', add
label define munibr_lbl 2299910 `"Luzilândia merged"', add
label define munibr_lbl 2299911 `"Oeiras merged"', add
label define munibr_lbl 2299912 `"Padre Marcos merged"', add
label define munibr_lbl 2299913 `"Parnaíba merged"', add
label define munibr_lbl 2299914 `"Paulistana merged"', add
label define munibr_lbl 2299915 `"Picos merged"', add
label define munibr_lbl 2299916 `"Pio IX merged"', add
label define munibr_lbl 2299917 `"Piripiri merged"', add
label define munibr_lbl 2299918 `"Regeneração merged"', add
label define munibr_lbl 2299919 `"São Miguel do Tapuio merged"', add
label define munibr_lbl 2299920 `"São Raimundo Nonato merged"', add
label define munibr_lbl 2299921 `"Simões merged"', add
label define munibr_lbl 2299922 `"Teresina merged"', add
label define munibr_lbl 2299923 `"Uruçuí merged"', add
label define munibr_lbl 2299924 `"Valença do Piauí merged"', add
label define munibr_lbl 2299999 `"Rest of Piauí"', add
label define munibr_lbl 2300309 `"Acopiara"', add
label define munibr_lbl 2301703 `"Aurora"', add
label define munibr_lbl 2301901 `"Barbalha"', add
label define munibr_lbl 2302008 `"Barro"', add
label define munibr_lbl 2302107 `"Baturité"', add
label define munibr_lbl 2302206 `"Beberibe"', add
label define munibr_lbl 2302305 `"Bela Cruz"', add
label define munibr_lbl 2302404 `"Boa Viagem"', add
label define munibr_lbl 2302503 `"Brejo Santo"', add
label define munibr_lbl 2302800 `"Canindé"', add
label define munibr_lbl 2303204 `"Caririaçu"', add
label define munibr_lbl 2303709 `"Caucaia"', add
label define munibr_lbl 2303808 `"Cedro"', add
label define munibr_lbl 2304103 `"Crateús"', add
label define munibr_lbl 2304202 `"Crato"', add
label define munibr_lbl 2304301 `"Farias Brito"', add
label define munibr_lbl 2304400 `"Fortaleza"', add
label define munibr_lbl 2304707 `"Granja"', add
label define munibr_lbl 2305308 `"Ibiapina"', add
label define munibr_lbl 2305407 `"Icó"', add
label define munibr_lbl 2305902 `"Ipueiras"', add
label define munibr_lbl 2306900 `"Jaguaribe"', add
label define munibr_lbl 2307007 `"Jaguaruana"', add
label define munibr_lbl 2307106 `"Jardim"', add
label define munibr_lbl 2307304 `"Juazeiro do Norte"', add
label define munibr_lbl 2307403 `"Jucás"', add
label define munibr_lbl 2307502 `"Lavras da Mangabeira"', add
label define munibr_lbl 2307601 `"Limoeiro do Norte"', add
label define munibr_lbl 2307809 `"Marco"', add
label define munibr_lbl 2308005 `"Massapê"', add
label define munibr_lbl 2308104 `"Mauriti"', add
label define munibr_lbl 2308302 `"Milagres"', add
label define munibr_lbl 2308401 `"Missão Velha"', add
label define munibr_lbl 2308500 `"Mombaça"', add
label define munibr_lbl 2309409 `"Novo Oriente"', add
label define munibr_lbl 2309508 `"Orós"', add
label define munibr_lbl 2310308 `"Parambu"', add
label define munibr_lbl 2310506 `"Pedra Branca"', add
label define munibr_lbl 2310704 `"Pentecoste"', add
label define munibr_lbl 2311801 `"Russas"', add
label define munibr_lbl 2312007 `"Santana do Acaraú"', add
label define munibr_lbl 2312403 `"São Gonçalo do Amarante"', add
label define munibr_lbl 2312700 `"Senador Pompeu"', add
label define munibr_lbl 2313104 `"Tabuleiro do Norte"', add
label define munibr_lbl 2313203 `"Tamboril"', add
label define munibr_lbl 2313302 `"Tauá"', add
label define munibr_lbl 2313401 `"Tianguá"', add
label define munibr_lbl 2313500 `"Trairi"', add
label define munibr_lbl 2313609 `"Ubajara"', add
label define munibr_lbl 2314003 `"Várzea Alegre"', add
label define munibr_lbl 2314102 `"Viçosa do Ceará"', add
label define munibr_lbl 2399901 `"Acaraú merged"', add
label define munibr_lbl 2399902 `"Aquiraz merged"', add
label define munibr_lbl 2399903 `"Aracati merged"', add
label define munibr_lbl 2399904 `"Aracoiaba merged"', add
label define munibr_lbl 2399905 `"Assaré merged"', add
label define munibr_lbl 2399906 `"Camocim merged"', add
label define munibr_lbl 2399907 `"Campos Sales merged"', add
label define munibr_lbl 2399908 `"Cascavel merged"', add
label define munibr_lbl 2399909 `"Guaraciaba do Norte merged"', add
label define munibr_lbl 2399910 `"Iguatu merged"', add
label define munibr_lbl 2399911 `"Independência merged"', add
label define munibr_lbl 2399912 `"Ipu merged"', add
label define munibr_lbl 2399913 `"Itapagé merged"', add
label define munibr_lbl 2399914 `"Itapipoca merged"', add
label define munibr_lbl 2399915 `"Maracanaú merged"', add
label define munibr_lbl 2399916 `"Morada Nova merged"', add
label define munibr_lbl 2399917 `"Nova Russas merged"', add
label define munibr_lbl 2399918 `"Pacajus merged"', add
label define munibr_lbl 2399919 `"Pacatuba merged"', add
label define munibr_lbl 2399920 `"Paracuru merged"', add
label define munibr_lbl 2399921 `"Pereiro merged"', add
label define munibr_lbl 2399922 `"Quixadá merged"', add
label define munibr_lbl 2399923 `"Quixeramobim merged"', add
label define munibr_lbl 2399924 `"Redenção merged"', add
label define munibr_lbl 2399925 `"Reriutaba merged"', add
label define munibr_lbl 2399926 `"Santa Quitéria merged"', add
label define munibr_lbl 2399927 `"São Benedito merged"', add
label define munibr_lbl 2399928 `"Sobral merged"', add
label define munibr_lbl 2399929 `"Solonópole merged"', add
label define munibr_lbl 2399930 `"Umirim merged"', add
label define munibr_lbl 2399999 `"Rest of Ceará"', add
label define munibr_lbl 2401008 `"Apodi"', add
label define munibr_lbl 2402006 `"Caicó"', add
label define munibr_lbl 2402204 `"Canguaretama"', add
label define munibr_lbl 2402600 `"Ceará-Mirim"', add
label define munibr_lbl 2403103 `"Currais Novos"', add
label define munibr_lbl 2403251 `"Parnamirim"', add
label define munibr_lbl 2405801 `"João Câmara"', add
label define munibr_lbl 2407104 `"Macaíba"', add
label define munibr_lbl 2407203 `"Macau"', add
label define munibr_lbl 2408102 `"Natal"', add
label define munibr_lbl 2408300 `"Nova Cruz"', add
label define munibr_lbl 2409407 `"Pau dos Ferros"', add
label define munibr_lbl 2411205 `"Santa Cruz"', add
label define munibr_lbl 2411502 `"Santo Antônio"', add
label define munibr_lbl 2412005 `"São Gonçalo do Amarante"', add
label define munibr_lbl 2412203 `"São José de Mipibu"', add
label define munibr_lbl 2499901 `"Mossoró merged"', add
label define munibr_lbl 2499902 `"São Miguel merged"', add
label define munibr_lbl 2499903 `"Touros merged"', add
label define munibr_lbl 2499999 `"Rest of Rio Grande do Norte"', add
label define munibr_lbl 2500304 `"Alagoa Grande"', add
label define munibr_lbl 2501104 `"Areia"', add
label define munibr_lbl 2501500 `"Bananeiras"', add
label define munibr_lbl 2501807 `"Bayeux"', add
label define munibr_lbl 2503209 `"Cabedelo"', add
label define munibr_lbl 2503704 `"Cajazeiras"', add
label define munibr_lbl 2504306 `"Catolé do Rocha"', add
label define munibr_lbl 2506004 `"Esperança"', add
label define munibr_lbl 2506301 `"Guarabira"', add
label define munibr_lbl 2506905 `"Itabaiana"', add
label define munibr_lbl 2507002 `"Itaporanga"', add
label define munibr_lbl 2507507 `"João Pessoa"', add
label define munibr_lbl 2508307 `"Lagoa Seca"', add
label define munibr_lbl 2509107 `"Mari"', add
label define munibr_lbl 2509701 `"Monteiro"', add
label define munibr_lbl 2510808 `"Patos"', add
label define munibr_lbl 2511202 `"Pedras de Fogo"', add
label define munibr_lbl 2512507 `"Queimadas"', add
label define munibr_lbl 2513703 `"Santa Rita"', add
label define munibr_lbl 2513901 `"São Bento"', add
label define munibr_lbl 2599901 `"Alagoa Nova merged"', add
label define munibr_lbl 2599902 `"Aroeiras merged"', add
label define munibr_lbl 2599903 `"Boqueirão merged"', add
label define munibr_lbl 2599904 `"Campina Grande merged"', add
label define munibr_lbl 2599905 `"Conceição merged"', add
label define munibr_lbl 2599906 `"Cuité merged"', add
label define munibr_lbl 2599907 `"Gurinhém merged"', add
label define munibr_lbl 2599908 `"Ingá merged"', add
label define munibr_lbl 2599909 `"Juazeirinho merged"', add
label define munibr_lbl 2599910 `"Mamanguape merged"', add
label define munibr_lbl 2599911 `"Picuí merged"', add
label define munibr_lbl 2599912 `"Pombal merged"', add
label define munibr_lbl 2599913 `"Princesa Isabel merged"', add
label define munibr_lbl 2599914 `"Rio Tinto merged"', add
label define munibr_lbl 2599915 `"São João do Rio do Peixe merged"', add
label define munibr_lbl 2599916 `"Sapé merged"', add
label define munibr_lbl 2599917 `"Solânea merged"', add
label define munibr_lbl 2599918 `"Sousa merged"', add
label define munibr_lbl 2599919 `"Uiraúna merged"', add
label define munibr_lbl 2599999 `"Rest of Paraíba"', add
label define munibr_lbl 2600104 `"Afogados da Ingazeira"', add
label define munibr_lbl 2600302 `"Agrestina"', add
label define munibr_lbl 2600500 `"Águas Belas"', add
label define munibr_lbl 2600708 `"Aliança"', add
label define munibr_lbl 2600807 `"Altinho"', add
label define munibr_lbl 2600906 `"Amaraji"', add
label define munibr_lbl 2601102 `"Araripina"', add
label define munibr_lbl 2601201 `"Arcoverde"', add
label define munibr_lbl 2601409 `"Barreiros"', add
label define munibr_lbl 2601607 `"Belém de São Francisco"', add
label define munibr_lbl 2601706 `"Belo Jardim"', add
label define munibr_lbl 2601904 `"Bezerros"', add
label define munibr_lbl 2602001 `"Bodocó"', add
label define munibr_lbl 2602100 `"Bom Conselho"', add
label define munibr_lbl 2602209 `"Bom Jardim"', add
label define munibr_lbl 2602308 `"Bonito"', add
label define munibr_lbl 2602605 `"Brejo da Madre de Deus"', add
label define munibr_lbl 2602803 `"Buíque"', add
label define munibr_lbl 2602902 `"Cabo de Santo Agostinho"', add
label define munibr_lbl 2603009 `"Cabrobó"', add
label define munibr_lbl 2603207 `"Caetés"', add
label define munibr_lbl 2603702 `"Canhotinho"', add
label define munibr_lbl 2604106 `"Caruaru"', add
label define munibr_lbl 2604205 `"Catende"', add
label define munibr_lbl 2604601 `"Condado"', add
label define munibr_lbl 2604908 `"Cumaru"', add
label define munibr_lbl 2605004 `"Cupira"', add
label define munibr_lbl 2605103 `"Custódia"', add
label define munibr_lbl 2605202 `"Escada"', add
label define munibr_lbl 2605301 `"Exu"', add
label define munibr_lbl 2605608 `"Flores"', add
label define munibr_lbl 2605905 `"Gameleira"', add
label define munibr_lbl 2606002 `"Garanhuns"', add
label define munibr_lbl 2606101 `"Glória do Goitá"', add
label define munibr_lbl 2606200 `"Goiana"', add
label define munibr_lbl 2606408 `"Gravatá"', add
label define munibr_lbl 2606606 `"Ibimirim"', add
label define munibr_lbl 2607208 `"Ipojuca"', add
label define munibr_lbl 2607307 `"Ipubi"', add
label define munibr_lbl 2607505 `"Itaíba"', add
label define munibr_lbl 2607653 `"Itambé"', add
label define munibr_lbl 2607901 `"Jaboatão dos Guararapes"', add
label define munibr_lbl 2608107 `"João Alfredo"', add
label define munibr_lbl 2608503 `"Lagoa do Itaenga"', add
label define munibr_lbl 2608800 `"Lajedo"', add
label define munibr_lbl 2608909 `"Limoeiro"', add
label define munibr_lbl 2609006 `"Macaparana"', add
label define munibr_lbl 2609402 `"Moreno"', add
label define munibr_lbl 2609501 `"Nazaré da Mata"', add
label define munibr_lbl 2609600 `"Olinda"', add
label define munibr_lbl 2609709 `"Orobó"', add
label define munibr_lbl 2610004 `"Palmares"', add
label define munibr_lbl 2610202 `"Panelas"', add
label define munibr_lbl 2610509 `"Passira"', add
label define munibr_lbl 2610806 `"Pedra"', add
label define munibr_lbl 2610905 `"Pesqueira"', add
label define munibr_lbl 2611309 `"Pombos"', add
label define munibr_lbl 2611507 `"Quipapá"', add
label define munibr_lbl 2611804 `"Ribeirão"', add
label define munibr_lbl 2612208 `"Salgueiro"', add
label define munibr_lbl 2612505 `"Santa Cruz do Capibaribe"', add
label define munibr_lbl 2613008 `"São Bento do Una"', add
label define munibr_lbl 2613107 `"São Caitano"', add
label define munibr_lbl 2613503 `"São José do Belmonte"', add
label define munibr_lbl 2613602 `"São José do Egito"', add
label define munibr_lbl 2613909 `"Serra Talhada"', add
label define munibr_lbl 2614105 `"Sertânia"', add
label define munibr_lbl 2614204 `"Sirinhaém"', add
label define munibr_lbl 2614600 `"Tabira"', add
label define munibr_lbl 2615300 `"Timbaúba"', add
label define munibr_lbl 2615409 `"Toritama"', add
label define munibr_lbl 2615607 `"Trindade"', add
label define munibr_lbl 2615805 `"Tupanatinga"', add
label define munibr_lbl 2616308 `"Vicência"', add
label define munibr_lbl 2616407 `"Vitória de Santo Antão"', add
label define munibr_lbl 2699901 `"Água Preta merged"', add
label define munibr_lbl 2699902 `"Carnaíba merged"', add
label define munibr_lbl 2699903 `"Carpina merged"', add
label define munibr_lbl 2699904 `"Floresta merged"', add
label define munibr_lbl 2699905 `"Inajá merged"', add
label define munibr_lbl 2699906 `"Jupi merged"', add
label define munibr_lbl 2699907 `"Maraial merged"', add
label define munibr_lbl 2699908 `"Ouricuri merged"', add
label define munibr_lbl 2699909 `"Paulista merged"', add
label define munibr_lbl 2699910 `"Petrolândia merged"', add
label define munibr_lbl 2699911 `"Petrolina merged"', add
label define munibr_lbl 2699912 `"Recife merged"', add
label define munibr_lbl 2699913 `"Rio Formoso merged"', add
label define munibr_lbl 2699914 `"Santa Maria da Boa Vista merged"', add
label define munibr_lbl 2699915 `"Surubim merged"', add
label define munibr_lbl 2699916 `"Triunfo merged"', add
label define munibr_lbl 2699999 `"Rest of Pernambuco"', add
label define munibr_lbl 2700409 `"Atalaia"', add
label define munibr_lbl 2701001 `"Boca da Mata"', add
label define munibr_lbl 2702405 `"Delmiro Gouveia"', add
label define munibr_lbl 2702603 `"Feira Grande"', add
label define munibr_lbl 2702900 `"Girau do Ponciano"', add
label define munibr_lbl 2703205 `"Igreja Nova"', add
label define munibr_lbl 2703809 `"Joaquim Gomes"', add
label define munibr_lbl 2704203 `"Limoeiro de Anadia"', add
label define munibr_lbl 2704302 `"Maceió"', add
label define munibr_lbl 2704500 `"Maragogi"', add
label define munibr_lbl 2704708 `"Marechal Deodoro"', add
label define munibr_lbl 2705002 `"Mata Grande"', add
label define munibr_lbl 2705101 `"Matriz de Camaragibe"', add
label define munibr_lbl 2705507 `"Murici"', add
label define munibr_lbl 2706406 `"Pão de Açúcar"', add
label define munibr_lbl 2706703 `"Penedo"', add
label define munibr_lbl 2706901 `"Pilar"', add
label define munibr_lbl 2707107 `"Piranhas"', add
label define munibr_lbl 2707305 `"Porto Calvo"', add
label define munibr_lbl 2707701 `"Rio Largo"', add
label define munibr_lbl 2708303 `"São José da Laje"', add
label define munibr_lbl 2708501 `"São Luís do Quitunde"', add
label define munibr_lbl 2708600 `"São Miguel dos Campos"', add
label define munibr_lbl 2708808 `"São Sebastião"', add
label define munibr_lbl 2709202 `"Traipu"', add
label define munibr_lbl 2709301 `"União dos Palmares"', add
label define munibr_lbl 2709400 `"Viçosa"', add
label define munibr_lbl 2799901 `"Água Branca merged"', add
label define munibr_lbl 2799902 `"Arapiraca merged"', add
label define munibr_lbl 2799903 `"Coruripe merged"', add
label define munibr_lbl 2799904 `"Palmeira dos Índios merged"', add
label define munibr_lbl 2799905 `"Santana do Ipanema merged"', add
label define munibr_lbl 2799999 `"Rest of Alagoas"', add
label define munibr_lbl 2800308 `"Aracaju"', add
label define munibr_lbl 2800670 `"Boquim"', add
label define munibr_lbl 2801306 `"Capela"', add
label define munibr_lbl 2802106 `"Estância"', add
label define munibr_lbl 2802908 `"Itabaiana"', add
label define munibr_lbl 2803005 `"Itabaianinha"', add
label define munibr_lbl 2803203 `"Itaporanga d'Ajuda"', add
label define munibr_lbl 2803500 `"Lagarto"', add
label define munibr_lbl 2803609 `"Laranjeiras"', add
label define munibr_lbl 2804508 `"Nossa Senhora da Glória"', add
label define munibr_lbl 2804607 `"Nossa Senhora das Dores"', add
label define munibr_lbl 2804805 `"Nossa Senhora do Socorro"', add
label define munibr_lbl 2805406 `"Poço Redondo"', add
label define munibr_lbl 2805604 `"Porto da Folha"', add
label define munibr_lbl 2805703 `"Propriá"', add
label define munibr_lbl 2806701 `"São Cristóvão"', add
label define munibr_lbl 2807105 `"Simão Dias"', add
label define munibr_lbl 2807402 `"Tobias Barreto"', add
label define munibr_lbl 2899901 `"Neópolis merged"', add
label define munibr_lbl 2899999 `"Rest of Sergipe"', add
label define munibr_lbl 2901007 `"Amargosa"', add
label define munibr_lbl 2901106 `"Amélia Rodrigues"', add
label define munibr_lbl 2901205 `"Anagé"', add
label define munibr_lbl 2902104 `"Araci"', add
label define munibr_lbl 2902609 `"Baixa Grande"', add
label define munibr_lbl 2902807 `"Barra da Estiva"', add
label define munibr_lbl 2902906 `"Barra do Choça"', add
label define munibr_lbl 2903201 `"Barreiras"', add
label define munibr_lbl 2903409 `"Belmonte"', add
label define munibr_lbl 2904100 `"Boquira"', add
label define munibr_lbl 2904605 `"Brumado"', add
label define munibr_lbl 2904902 `"Cachoeira"', add
label define munibr_lbl 2905008 `"Caculé"', add
label define munibr_lbl 2905602 `"Camacan"', add
label define munibr_lbl 2905909 `"Campo Alegre de Lourdes"', add
label define munibr_lbl 2906501 `"Candeias"', add
label define munibr_lbl 2906709 `"Cândido Sales"', add
label define munibr_lbl 2906808 `"Cansanção"', add
label define munibr_lbl 2907202 `"Casa Nova"', add
label define munibr_lbl 2907509 `"Catu"', add
label define munibr_lbl 2908002 `"Coaraci"', add
label define munibr_lbl 2908408 `"Conceição do Coité"', add
label define munibr_lbl 2908507 `"Conceição do Jacuípe"', add
label define munibr_lbl 2908606 `"Conde"', add
label define munibr_lbl 2908903 `"Coração de Maria"', add
label define munibr_lbl 2909802 `"Cruz das Almas"', add
label define munibr_lbl 2909901 `"Curaçá"', add
label define munibr_lbl 2910503 `"Entre Rios"', add
label define munibr_lbl 2910602 `"Esplanada"', add
label define munibr_lbl 2910800 `"Feira de Santana"', add
label define munibr_lbl 2911709 `"Guanambi"', add
label define munibr_lbl 2911808 `"Guaratinga"', add
label define munibr_lbl 2911907 `"Iaçu"', add
label define munibr_lbl 2912103 `"Ibicaraí"', add
label define munibr_lbl 2912707 `"Ibirapitanga"', add
label define munibr_lbl 2912905 `"Ibirataia"', add
label define munibr_lbl 2913200 `"Ibotirama"', add
label define munibr_lbl 2913507 `"Iguaí"', add
label define munibr_lbl 2913606 `"Ilhéus"', add
label define munibr_lbl 2913705 `"Inhambupe"', add
label define munibr_lbl 2913903 `"Ipiaú"', add
label define munibr_lbl 2914505 `"Irará"', add
label define munibr_lbl 2914703 `"Itaberaba"', add
label define munibr_lbl 2915502 `"Itajuípe"', add
label define munibr_lbl 2915809 `"Itambé"', add
label define munibr_lbl 2916005 `"Itanhém"', add
label define munibr_lbl 2916401 `"Itapetinga"', add
label define munibr_lbl 2916500 `"Itapicuru"', add
label define munibr_lbl 2917003 `"Itiúba"', add
label define munibr_lbl 2917706 `"Jaguarari"', add
label define munibr_lbl 2918001 `"Jequié"', add
label define munibr_lbl 2918308 `"Jitaúna"', add
label define munibr_lbl 2919207 `"Lauro de Freitas"', add
label define munibr_lbl 2919504 `"Livramento de Nossa Senhora"', add
label define munibr_lbl 2919801 `"Macaúbas"', add
label define munibr_lbl 2920601 `"Maragogipe"', add
label define munibr_lbl 2921005 `"Mata de São João"', add
label define munibr_lbl 2921104 `"Medeiros Neto"', add
label define munibr_lbl 2921203 `"Miguel Calmon"', add
label define munibr_lbl 2921500 `"Monte Santo"', add
label define munibr_lbl 2922003 `"Mucuri"', add
label define munibr_lbl 2922102 `"Mundo Novo"', add
label define munibr_lbl 2922409 `"Mutuípe"', add
label define munibr_lbl 2922508 `"Nazaré"', add
label define munibr_lbl 2922904 `"Nova Soure"', add
label define munibr_lbl 2923001 `"Nova Viçosa"', add
label define munibr_lbl 2923100 `"Olindina"', add
label define munibr_lbl 2923209 `"Oliveira dos Brejinhos"', add
label define munibr_lbl 2923407 `"Palmas de Monte Alto"', add
label define munibr_lbl 2923704 `"Paratinga"', add
label define munibr_lbl 2924009 `"Paulo Afonso"', add
label define munibr_lbl 2924405 `"Pilão Arcado"', add
label define munibr_lbl 2925006 `"Planalto"', add
label define munibr_lbl 2925204 `"Pojuca"', add
label define munibr_lbl 2925907 `"Quijingue"', add
label define munibr_lbl 2926004 `"Remanso"', add
label define munibr_lbl 2926202 `"Riachão das Neves"', add
label define munibr_lbl 2927002 `"Rio Real"', add
label define munibr_lbl 2927200 `"Ruy Barbosa"', add
label define munibr_lbl 2928000 `"Santaluz"', add
label define munibr_lbl 2928208 `"Santana"', add
label define munibr_lbl 2928802 `"Santo Estêvão"', add
label define munibr_lbl 2929107 `"São Felipe"', add
label define munibr_lbl 2929206 `"São Francisco do Conde"', add
label define munibr_lbl 2929305 `"São Gonçalo dos Campos"', add
label define munibr_lbl 2929503 `"São Sebastião do Passé"', add
label define munibr_lbl 2929909 `"Seabra"', add
label define munibr_lbl 2930204 `"Sento Sé"', add
label define munibr_lbl 2930501 `"Serrinha"', add
label define munibr_lbl 2930709 `"Simões Filho"', add
label define munibr_lbl 2931004 `"Tanhaçu"', add
label define munibr_lbl 2931509 `"Teofilândia"', add
label define munibr_lbl 2931905 `"Tucano"', add
label define munibr_lbl 2932002 `"Uauá"', add
label define munibr_lbl 2932101 `"Ubaíra"', add
label define munibr_lbl 2932200 `"Ubaitaba"', add
label define munibr_lbl 2932309 `"Ubatã"', add
label define munibr_lbl 2932705 `"Uruçuca"', add
label define munibr_lbl 2933208 `"Vera Cruz"', add
label define munibr_lbl 2933307 `"Vitória da Conquista"', add
label define munibr_lbl 2999901 `"Alagoinhas merged"', add
label define munibr_lbl 2999902 `"Andaraí merged"', add
label define munibr_lbl 2999903 `"Antas merged"', add
label define munibr_lbl 2999904 `"Barra merged"', add
label define munibr_lbl 2999905 `"Boa Nova merged"', add
label define munibr_lbl 2999906 `"Bom Jesus da Lapa merged"', add
label define munibr_lbl 2999907 `"Buerarema merged"', add
label define munibr_lbl 2999908 `"Caetité merged"', add
label define munibr_lbl 2999909 `"Camaçari merged"', add
label define munibr_lbl 2999910 `"Camamu merged"', add
label define munibr_lbl 2999911 `"Campo Formoso merged"', add
label define munibr_lbl 2999912 `"Canarana merged"', add
label define munibr_lbl 2999913 `"Canavieiras merged"', add
label define munibr_lbl 2999914 `"Carinhanha merged"', add
label define munibr_lbl 2999915 `"Cícero Dantas merged"', add
label define munibr_lbl 2999916 `"Condeúba merged"', add
label define munibr_lbl 2999917 `"Correntina merged"', add
label define munibr_lbl 2999918 `"Encruzilhada merged"', add
label define munibr_lbl 2999919 `"Euclides da Cunha merged"', add
label define munibr_lbl 2999920 `"Gandu merged"', add
label define munibr_lbl 2999921 `"Ibitiara merged"', add
label define munibr_lbl 2999922 `"Ipirá merged"', add
label define munibr_lbl 2999923 `"Irecê merged"', add
label define munibr_lbl 2999924 `"Itabuna merged"', add
label define munibr_lbl 2999925 `"Itamaraju merged"', add
label define munibr_lbl 2999926 `"Itatim merged"', add
label define munibr_lbl 2999927 `"Ituberá merged"', add
label define munibr_lbl 2999928 `"Jacobina merged"', add
label define munibr_lbl 2999929 `"Jaguaquara merged"', add
label define munibr_lbl 2999930 `"Jeremoabo merged"', add
label define munibr_lbl 2999931 `"Juazeiro merged"', add
label define munibr_lbl 2999932 `"Mairi merged"', add
label define munibr_lbl 2999933 `"Malhada merged"', add
label define munibr_lbl 2999934 `"Maracás merged"', add
label define munibr_lbl 2999935 `"Morro do Chapéu merged"', add
label define munibr_lbl 2999936 `"Muritiba merged"', add
label define munibr_lbl 2999937 `"Paramirim merged"', add
label define munibr_lbl 2999938 `"Paripiranga merged"', add
label define munibr_lbl 2999939 `"Pindobaçu merged"', add
label define munibr_lbl 2999940 `"Poções merged"', add
label define munibr_lbl 2999941 `"Ponto Novo merged"', add
label define munibr_lbl 2999942 `"Porto Seguro merged"', add
label define munibr_lbl 2999943 `"Prado merged"', add
label define munibr_lbl 2999944 `"Presidente Jânio Quadros merged"', add
label define munibr_lbl 2999945 `"Queimadas merged"', add
label define munibr_lbl 2999946 `"Riachão do Jacuípe merged"', add
label define munibr_lbl 2999947 `"Riacho de Santana merged"', add
label define munibr_lbl 2999948 `"Ribeira do Amparo merged"', add
label define munibr_lbl 2999949 `"Ribeira do Pombal merged"', add
label define munibr_lbl 2999950 `"Salvador merged"', add
label define munibr_lbl 2999951 `"Santa Maria da Vitória merged"', add
label define munibr_lbl 2999952 `"Santa Rita de Cássia merged"', add
label define munibr_lbl 2999953 `"Santo Amaro merged"', add
label define munibr_lbl 2999954 `"Santo Antônio de Jesus merged"', add
label define munibr_lbl 2999955 `"Senhor do Bonfim merged"', add
label define munibr_lbl 2999956 `"Serrolândia merged"', add
label define munibr_lbl 2999957 `"Teixeira de Freitas merged"', add
label define munibr_lbl 2999958 `"Tremedal merged"', add
label define munibr_lbl 2999959 `"Una merged"', add
label define munibr_lbl 2999960 `"Valença merged"', add
label define munibr_lbl 2999961 `"Valente merged"', add
label define munibr_lbl 2999962 `"Wanderley merged"', add
label define munibr_lbl 2999963 `"Xique-Xique merged"', add
label define munibr_lbl 2999999 `"Rest of Bahia"', add
label define munibr_lbl 2919553 `"Luís Eduardo Magalhães"', add
label define munibr_lbl 3100203 `"Abaeté"', add
label define munibr_lbl 3101102 `"Aimorés"', add
label define munibr_lbl 3101508 `"Além Paraíba"', add
label define munibr_lbl 3101607 `"Alfenas"', add
label define munibr_lbl 3102605 `"Andradas"', add
label define munibr_lbl 3103405 `"Araçuaí"', add
label define munibr_lbl 3103504 `"Araguari"', add
label define munibr_lbl 3104007 `"Araxá"', add
label define munibr_lbl 3104205 `"Arcos"', add
label define munibr_lbl 3105103 `"Bambuí"', add
label define munibr_lbl 3105400 `"Barão de Cocais"', add
label define munibr_lbl 3105608 `"Barbacena"', add
label define munibr_lbl 3106200 `"Belo Horizonte"', add
label define munibr_lbl 3106705 `"Betim"', add
label define munibr_lbl 3107109 `"Boa Esperança"', add
label define munibr_lbl 3107406 `"Bom Despacho"', add
label define munibr_lbl 3109006 `"Brumadinho"', add
label define munibr_lbl 3109303 `"Buritis"', add
label define munibr_lbl 3109402 `"Buritizeiro"', add
label define munibr_lbl 3110004 `"Caeté"', add
label define munibr_lbl 3110509 `"Camanducaia"', add
label define munibr_lbl 3111002 `"Campestre"', add
label define munibr_lbl 3111200 `"Campo Belo"', add
label define munibr_lbl 3111606 `"Campos Gerais"', add
label define munibr_lbl 3113008 `"Caraí"', add
label define munibr_lbl 3113206 `"Carandaí"', add
label define munibr_lbl 3113701 `"Carlos Chagas"', add
label define munibr_lbl 3114303 `"Carmo do Paranaíba"', add
label define munibr_lbl 3115300 `"Cataguases"', add
label define munibr_lbl 3115508 `"Caxambu"', add
label define munibr_lbl 3116605 `"Cláudio"', add
label define munibr_lbl 3118007 `"Congonhas"', add
label define munibr_lbl 3118304 `"Conselheiro Lafaiete"', add
label define munibr_lbl 3118601 `"Contagem"', add
label define munibr_lbl 3119104 `"Corinto"', add
label define munibr_lbl 3119302 `"Coromandel"', add
label define munibr_lbl 3119401 `"Coronel Fabriciano"', add
label define munibr_lbl 3120904 `"Curvelo"', add
label define munibr_lbl 3121605 `"Diamantina"', add
label define munibr_lbl 3122306 `"Divinópolis"', add
label define munibr_lbl 3123601 `"Elói Mendes"', add
label define munibr_lbl 3124104 `"Esmeraldas"', add
label define munibr_lbl 3124203 `"Espera Feliz"', add
label define munibr_lbl 3126703 `"Francisco Sá"', add
label define munibr_lbl 3127107 `"Frutal"', add
label define munibr_lbl 3127701 `"Governador Valadares"', add
label define munibr_lbl 3128006 `"Guanhães"', add
label define munibr_lbl 3128709 `"Guaxupé"', add
label define munibr_lbl 3129509 `"Ibiá"', add
label define munibr_lbl 3131307 `"Ipatinga"', add
label define munibr_lbl 3131703 `"Itabira"', add
label define munibr_lbl 3131901 `"Itabirito"', add
label define munibr_lbl 3132404 `"Itajubá"', add
label define munibr_lbl 3132701 `"Itambacuri"', add
label define munibr_lbl 3133303 `"Itaobim"', add
label define munibr_lbl 3133501 `"Itapecerica"', add
label define munibr_lbl 3133808 `"Itaúna"', add
label define munibr_lbl 3134202 `"Ituiutaba"', add
label define munibr_lbl 3135803 `"Jequitinhonha"', add
label define munibr_lbl 3136207 `"João Monlevade"', add
label define munibr_lbl 3136702 `"Juiz de Fora"', add
label define munibr_lbl 3137205 `"Lagoa da Prata"', add
label define munibr_lbl 3138203 `"Lavras"', add
label define munibr_lbl 3138401 `"Leopoldina"', add
label define munibr_lbl 3139003 `"Machado"', add
label define munibr_lbl 3140001 `"Mariana"', add
label define munibr_lbl 3141108 `"Matozinhos"', add
label define munibr_lbl 3141405 `"Medina"', add
label define munibr_lbl 3143104 `"Monte Carmelo"', add
label define munibr_lbl 3143203 `"Monte Santo de Minas"', add
label define munibr_lbl 3143302 `"Montes Claros"', add
label define munibr_lbl 3144003 `"Mutum"', add
label define munibr_lbl 3144102 `"Muzambinho"', add
label define munibr_lbl 3144300 `"Nanuque"', add
label define munibr_lbl 3144607 `"Nepomuceno"', add
label define munibr_lbl 3144805 `"Nova Lima"', add
label define munibr_lbl 3145208 `"Nova Serrana"', add
label define munibr_lbl 3145307 `"Novo Cruzeiro"', add
label define munibr_lbl 3145604 `"Oliveira"', add
label define munibr_lbl 3145901 `"Ouro Branco"', add
label define munibr_lbl 3146008 `"Ouro Fino"', add
label define munibr_lbl 3146107 `"Ouro Preto"', add
label define munibr_lbl 3147006 `"Paracatu"', add
label define munibr_lbl 3147105 `"Pará de Minas"', add
label define munibr_lbl 3147402 `"Paraopeba"', add
label define munibr_lbl 3147907 `"Passos"', add
label define munibr_lbl 3148004 `"Patos de Minas"', add
label define munibr_lbl 3148103 `"Patrocínio"', add
label define munibr_lbl 3148707 `"Pedra Azul"', add
label define munibr_lbl 3149309 `"Pedro Leopoldo"', add
label define munibr_lbl 3151206 `"Pirapora"', add
label define munibr_lbl 3151404 `"Pitangui"', add
label define munibr_lbl 3151503 `"Piumhi"', add
label define munibr_lbl 3151800 `"Poços de Caldas"', add
label define munibr_lbl 3152006 `"Pompéu"', add
label define munibr_lbl 3152501 `"Pouso Alegre"', add
label define munibr_lbl 3152808 `"Prata"', add
label define munibr_lbl 3154606 `"Ribeirão das Neves"', add
label define munibr_lbl 3156700 `"Sabará"', add
label define munibr_lbl 3156908 `"Sacramento"', add
label define munibr_lbl 3157807 `"Santa Luzia"', add
label define munibr_lbl 3159605 `"Santa Rita do Sapucaí"', add
label define munibr_lbl 3160405 `"Santo Antônio do Monte"', add
label define munibr_lbl 3160702 `"Santos Dumont"', add
label define munibr_lbl 3162005 `"São Gonçalo do Sapucaí"', add
label define munibr_lbl 3162104 `"São Gotardo"', add
label define munibr_lbl 3162500 `"São João del Rei"', add
label define munibr_lbl 3162906 `"São João Nepomuceno"', add
label define munibr_lbl 3163706 `"São Lourenço"', add
label define munibr_lbl 3164704 `"São Sebastião do Paraíso"', add
label define munibr_lbl 3167103 `"Serro"', add
label define munibr_lbl 3167202 `"Sete Lagoas"', add
label define munibr_lbl 3168705 `"Timóteo"', add
label define munibr_lbl 3169307 `"Três Corações"', add
label define munibr_lbl 3169356 `"Três Marias"', add
label define munibr_lbl 3169406 `"Três Pontas"', add
label define munibr_lbl 3169901 `"Ubá"', add
label define munibr_lbl 3170206 `"Uberlândia"', add
label define munibr_lbl 3170701 `"Varginha"', add
label define munibr_lbl 3170800 `"Várzea da Palma"', add
label define munibr_lbl 3171303 `"Viçosa"', add
label define munibr_lbl 3172004 `"Visconde do Rio Branco"', add
label define munibr_lbl 3199901 `"Açucena merged"', add
label define munibr_lbl 3199902 `"Águas Formosas merged"', add
label define munibr_lbl 3199903 `"Águas Vermelhas merged"', add
label define munibr_lbl 3199904 `"Almenara merged"', add
label define munibr_lbl 3199905 `"Alpinópolis merged"', add
label define munibr_lbl 3199906 `"Bocaiúva merged"', add
label define munibr_lbl 3199907 `"Brasília de Minas merged"', add
label define munibr_lbl 3199908 `"Cambuí merged"', add
label define munibr_lbl 3199909 `"Capelinha merged"', add
label define munibr_lbl 3199910 `"Carangola merged"', add
label define munibr_lbl 3199911 `"Caratinga merged"', add
label define munibr_lbl 3199912 `"Conselheiro Pena merged"', add
label define munibr_lbl 3199913 `"Coração de Jesus merged"', add
label define munibr_lbl 3199914 `"Divino merged"', add
label define munibr_lbl 3199915 `"Espinosa merged"', add
label define munibr_lbl 3199916 `"Formiga merged"', add
label define munibr_lbl 3199917 `"Grão Mogol merged"', add
label define munibr_lbl 3199918 `"Ibirité merged"', add
label define munibr_lbl 3199919 `"Igarapé merged"', add
label define munibr_lbl 3199920 `"Inhapim merged"', add
label define munibr_lbl 3199921 `"Itacarambi merged"', add
label define munibr_lbl 3199922 `"Itamarandiba merged"', add
label define munibr_lbl 3199923 `"Itaú de Minas merged"', add
label define munibr_lbl 3199924 `"Itinga merged"', add
label define munibr_lbl 3199925 `"Iturama merged"', add
label define munibr_lbl 3199926 `"Jaíba merged"', add
label define munibr_lbl 3199927 `"Janaúba merged"', add
label define munibr_lbl 3199928 `"Januária merged"', add
label define munibr_lbl 3199929 `"João Pinheiro merged"', add
label define munibr_lbl 3199930 `"Lagoa Santa merged"', add
label define munibr_lbl 3199931 `"Malacacheta merged"', add
label define munibr_lbl 3199932 `"Manhuaçu merged"', add
label define munibr_lbl 3199933 `"Manhumirim merged"', add
label define munibr_lbl 3199934 `"Mantena merged"', add
label define munibr_lbl 3199935 `"Mateus Leme merged"', add
label define munibr_lbl 3199936 `"Minas Novas merged"', add
label define munibr_lbl 3199937 `"Muriaé merged"', add
label define munibr_lbl 3199938 `"Peçanha merged"', add
label define munibr_lbl 3199939 `"Ponte Nova merged"', add
label define munibr_lbl 3199940 `"Porteirinha merged"', add
label define munibr_lbl 3199941 `"Presidente Olegário merged"', add
label define munibr_lbl 3199942 `"Raul Soares merged"', add
label define munibr_lbl 3199943 `"Rio Pardo de Minas merged"', add
label define munibr_lbl 3199944 `"Salinas merged"', add
label define munibr_lbl 3199945 `"Santa Bárbara merged"', add
label define munibr_lbl 3199946 `"Santana do Paraíso merged"', add
label define munibr_lbl 3199947 `"São Francisco merged"', add
label define munibr_lbl 3199948 `"São João da Ponte merged"', add
label define munibr_lbl 3199949 `"São João do Paraíso merged"', add
label define munibr_lbl 3199950 `"Taiobeiras merged"', add
label define munibr_lbl 3199951 `"Teófilo Otoni merged"', add
label define munibr_lbl 3199952 `"Tupaciguara merged"', add
label define munibr_lbl 3199953 `"Turmalina merged"', add
label define munibr_lbl 3199954 `"Uberaba merged"', add
label define munibr_lbl 3199955 `"Unaí merged"', add
label define munibr_lbl 3199956 `"Vespasiano merged"', add
label define munibr_lbl 3199999 `"Rest of Minas Gerais"', add
label define munibr_lbl 3200607 `"Aracruz"', add
label define munibr_lbl 3200805 `"Baixo Guandu"', add
label define munibr_lbl 3201308 `"Cariacica"', add
label define munibr_lbl 3201407 `"Castelo"', add
label define munibr_lbl 3202108 `"Ecoporanga"', add
label define munibr_lbl 3202306 `"Guaçuí"', add
label define munibr_lbl 3202405 `"Guarapari"', add
label define munibr_lbl 3203403 `"Mimoso do Sul"', add
label define munibr_lbl 3204104 `"Pinheiros"', add
label define munibr_lbl 3205002 `"Serra"', add
label define munibr_lbl 3205101 `"Viana"', add
label define munibr_lbl 3205200 `"Vila Velha"', add
label define munibr_lbl 3205309 `"Vitória"', add
label define munibr_lbl 3299901 `"Afonso Cláudio merged"', add
label define munibr_lbl 3299902 `"Alegre merged"', add
label define munibr_lbl 3299903 `"Barra de São Francisco merged"', add
label define munibr_lbl 3299904 `"Cachoeiro de Itapemirim merged"', add
label define munibr_lbl 3299905 `"Colatina merged"', add
label define munibr_lbl 3299906 `"Conceição da Barra merged"', add
label define munibr_lbl 3299907 `"Domingos Martins merged"', add
label define munibr_lbl 3299908 `"Iúna merged"', add
label define munibr_lbl 3299909 `"João Neiva merged"', add
label define munibr_lbl 3299910 `"Linhares merged"', add
label define munibr_lbl 3299911 `"Marataízes merged"', add
label define munibr_lbl 3299912 `"Nova Venécia merged"', add
label define munibr_lbl 3299913 `"Pancas merged"', add
label define munibr_lbl 3299914 `"Santa Maria de Jetibá merged"', add
label define munibr_lbl 3299915 `"Santa Teresa merged"', add
label define munibr_lbl 3299916 `"São Mateus merged"', add
label define munibr_lbl 3299917 `"Venda Nova do Imigrante merged"', add
label define munibr_lbl 3299999 `"Rest of Espírito Santo"', add
label define munibr_lbl 3300100 `"Angra dos Reis"', add
label define munibr_lbl 3300209 `"Araruama"', add
label define munibr_lbl 3300308 `"Barra do Piraí"', add
label define munibr_lbl 3300506 `"Bom Jardim"', add
label define munibr_lbl 3300605 `"Bom Jesus do Itabapoana"', add
label define munibr_lbl 3300803 `"Cachoeiras de Macacu"', add
label define munibr_lbl 3301702 `"Duque de Caxias"', add
label define munibr_lbl 3302106 `"Itaocara"', add
label define munibr_lbl 3302205 `"Itaperuna"', add
label define munibr_lbl 3302601 `"Mangaratiba"', add
label define munibr_lbl 3302700 `"Maricá"', add
label define munibr_lbl 3302908 `"Miguel Pereira"', add
label define munibr_lbl 3303005 `"Miracema"', add
label define munibr_lbl 3303203 `"Nilópolis"', add
label define munibr_lbl 3303302 `"Niterói"', add
label define munibr_lbl 3303401 `"Nova Friburgo"', add
label define munibr_lbl 3303609 `"Paracambi"', add
label define munibr_lbl 3303708 `"Paraíba do Sul"', add
label define munibr_lbl 3303807 `"Parati"', add
label define munibr_lbl 3304300 `"Rio Bonito"', add
label define munibr_lbl 3304557 `"Rio de Janeiro"', add
label define munibr_lbl 3304805 `"São Fidélis"', add
label define munibr_lbl 3304904 `"São Gonçalo"', add
label define munibr_lbl 3305109 `"São João de Meriti"', add
label define munibr_lbl 3305505 `"Saquarema"', add
label define munibr_lbl 3305604 `"Silva Jardim"', add
label define munibr_lbl 3305802 `"Teresópolis"', add
label define munibr_lbl 3306107 `"Valença"', add
label define munibr_lbl 3306305 `"Volta Redonda"', add
label define munibr_lbl 3399901 `"Barra Mansa merged"', add
label define munibr_lbl 3399902 `"Cabo Frio merged"', add
label define munibr_lbl 3399903 `"Cambuci merged"', add
label define munibr_lbl 3399904 `"Campos dos Goytacazes merged"', add
label define munibr_lbl 3399905 `"Cantagalo merged"', add
label define munibr_lbl 3399906 `"Itaboraí merged"', add
label define munibr_lbl 3399907 `"Itaguaí merged"', add
label define munibr_lbl 3399908 `"Macaé merged"', add
label define munibr_lbl 3399909 `"Magé merged"', add
label define munibr_lbl 3399910 `"Natividade merged"', add
label define munibr_lbl 3399911 `"Nova Iguaçu merged"', add
label define munibr_lbl 3399912 `"Petrópolis merged"', add
label define munibr_lbl 3399913 `"Piraí merged"', add
label define munibr_lbl 3399914 `"Resende merged"', add
label define munibr_lbl 3399915 `"Rio das Ostras merged"', add
label define munibr_lbl 3399916 `"Santo Antônio de Pádua merged"', add
label define munibr_lbl 3399917 `"São Francisco de Itabapoana merged"', add
label define munibr_lbl 3399918 `"São Pedro da Aldeia merged"', add
label define munibr_lbl 3399919 `"Três Rios merged"', add
label define munibr_lbl 3399920 `"Vassouras merged"', add
label define munibr_lbl 3399999 `"Rest of Rio de Janeiro"', add
label define munibr_lbl 3302858 `"Mesquita"', add
label define munibr_lbl 3500105 `"Adamantina"', add
label define munibr_lbl 3500303 `"Aguaí"', add
label define munibr_lbl 3501301 `"Álvares Machado"', add
label define munibr_lbl 3501608 `"Americana"', add
label define munibr_lbl 3501707 `"Américo Brasiliense"', add
label define munibr_lbl 3501905 `"Amparo"', add
label define munibr_lbl 3502101 `"Andradina"', add
label define munibr_lbl 3502507 `"Aparecida"', add
label define munibr_lbl 3503307 `"Araras"', add
label define munibr_lbl 3503901 `"Arujá"', add
label define munibr_lbl 3504107 `"Atibaia"', add
label define munibr_lbl 3504503 `"Avaré"', add
label define munibr_lbl 3505203 `"Bariri"', add
label define munibr_lbl 3505302 `"Barra Bonita"', add
label define munibr_lbl 3505500 `"Barretos"', add
label define munibr_lbl 3505609 `"Barrinha"', add
label define munibr_lbl 3505708 `"Barueri"', add
label define munibr_lbl 3505807 `"Bastos"', add
label define munibr_lbl 3505906 `"Batatais"', add
label define munibr_lbl 3506003 `"Bauru"', add
label define munibr_lbl 3506102 `"Bebedouro"', add
label define munibr_lbl 3506508 `"Birigui"', add
label define munibr_lbl 3506607 `"Biritiba-Mirim"', add
label define munibr_lbl 3507001 `"Boituva"', add
label define munibr_lbl 3507506 `"Botucatu"', add
label define munibr_lbl 3508405 `"Cabreúva"', add
label define munibr_lbl 3508504 `"Caçapava"', add
label define munibr_lbl 3508603 `"Cachoeira Paulista"', add
label define munibr_lbl 3509007 `"Caieiras"', add
label define munibr_lbl 3509205 `"Cajamar"', add
label define munibr_lbl 3509502 `"Campinas"', add
label define munibr_lbl 3509601 `"Campo Limpo Paulista"', add
label define munibr_lbl 3509700 `"Campos do Jordão"', add
label define munibr_lbl 3510005 `"Cândido Mota"', add
label define munibr_lbl 3510401 `"Capivari"', add
label define munibr_lbl 3510500 `"Caraguatatuba"', add
label define munibr_lbl 3510609 `"Carapicuíba"', add
label define munibr_lbl 3510807 `"Casa Branca"', add
label define munibr_lbl 3511508 `"Cerquilho"', add
label define munibr_lbl 3512209 `"Conchal"', add
label define munibr_lbl 3513108 `"Cravinhos"', add
label define munibr_lbl 3513405 `"Cruzeiro"', add
label define munibr_lbl 3513504 `"Cubatão"', add
label define munibr_lbl 3513603 `"Cunha"', add
label define munibr_lbl 3513702 `"Descalvado"', add
label define munibr_lbl 3513801 `"Diadema"', add
label define munibr_lbl 3514106 `"Dois Córregos"', add
label define munibr_lbl 3514403 `"Dracena"', add
label define munibr_lbl 3515004 `"Embu"', add
label define munibr_lbl 3515103 `"Embu-Guaçu"', add
label define munibr_lbl 3515186 `"Espírito Santo do Pinhal"', add
label define munibr_lbl 3515509 `"Fernandópolis"', add
label define munibr_lbl 3515707 `"Ferraz de Vasconcelos"', add
label define munibr_lbl 3516200 `"Franca"', add
label define munibr_lbl 3516309 `"Francisco Morato"', add
label define munibr_lbl 3516408 `"Franco da Rocha"', add
label define munibr_lbl 3516705 `"Garça"', add
label define munibr_lbl 3517406 `"Guaíra"', add
label define munibr_lbl 3518206 `"Guararapes"', add
label define munibr_lbl 3518305 `"Guararema"', add
label define munibr_lbl 3518602 `"Guariba"', add
label define munibr_lbl 3518701 `"Guarujá"', add
label define munibr_lbl 3518800 `"Guarulhos"', add
label define munibr_lbl 3519303 `"Ibaté"', add
label define munibr_lbl 3519600 `"Ibitinga"', add
label define munibr_lbl 3519709 `"Ibiúna"', add
label define munibr_lbl 3520004 `"Igaraçu do Tietê"', add
label define munibr_lbl 3520103 `"Igarapava"', add
label define munibr_lbl 3520400 `"Ilhabela"', add
label define munibr_lbl 3520509 `"Indaiatuba"', add
label define munibr_lbl 3521804 `"Itaí"', add
label define munibr_lbl 3522109 `"Itanhaém"', add
label define munibr_lbl 3522505 `"Itapevi"', add
label define munibr_lbl 3522604 `"Itapira"', add
label define munibr_lbl 3522703 `"Itápolis"', add
label define munibr_lbl 3523107 `"Itaquaquecetuba"', add
label define munibr_lbl 3523404 `"Itatiba"', add
label define munibr_lbl 3523909 `"Itu"', add
label define munibr_lbl 3524006 `"Itupeva"', add
label define munibr_lbl 3524105 `"Ituverava"', add
label define munibr_lbl 3524303 `"Jaboticabal"', add
label define munibr_lbl 3524402 `"Jacareí"', add
label define munibr_lbl 3525003 `"Jandira"', add
label define munibr_lbl 3525102 `"Jardinópolis"', add
label define munibr_lbl 3525300 `"Jaú"', add
label define munibr_lbl 3525904 `"Jundiaí"', add
label define munibr_lbl 3526100 `"Juquiá"', add
label define munibr_lbl 3526209 `"Juquitiba"', add
label define munibr_lbl 3526407 `"Laranjal Paulista"', add
label define munibr_lbl 3526704 `"Leme"', add
label define munibr_lbl 3526902 `"Limeira"', add
label define munibr_lbl 3527108 `"Lins"', add
label define munibr_lbl 3527306 `"Louveira"', add
label define munibr_lbl 3528502 `"Mairiporã"', add
label define munibr_lbl 3529005 `"Marília"', add
label define munibr_lbl 3529203 `"Martinópolis"', add
label define munibr_lbl 3529302 `"Matão"', add
label define munibr_lbl 3529401 `"Mauá"', add
label define munibr_lbl 3529906 `"Miracatu"', add
label define munibr_lbl 3530102 `"Mirandópolis"', add
label define munibr_lbl 3530300 `"Mirassol"', add
label define munibr_lbl 3530508 `"Mococa"', add
label define munibr_lbl 3530607 `"Mogi das Cruzes"', add
label define munibr_lbl 3530805 `"Moji Mirim"', add
label define munibr_lbl 3531100 `"Mongaguá"', add
label define munibr_lbl 3531308 `"Monte Alto"', add
label define munibr_lbl 3531803 `"Monte Mor"', add
label define munibr_lbl 3531902 `"Morro Agudo"', add
label define munibr_lbl 3533403 `"Nova Odessa"', add
label define munibr_lbl 3533502 `"Novo Horizonte"', add
label define munibr_lbl 3533908 `"Olímpia"', add
label define munibr_lbl 3534302 `"Orlândia"', add
label define munibr_lbl 3534401 `"Osasco"', add
label define munibr_lbl 3534609 `"Osvaldo Cruz"', add
label define munibr_lbl 3534708 `"Ourinhos"', add
label define munibr_lbl 3535309 `"Palmital"', add
label define munibr_lbl 3535507 `"Paraguaçu Paulista"', add
label define munibr_lbl 3536505 `"Paulínia"', add
label define munibr_lbl 3536703 `"Pederneiras"', add
label define munibr_lbl 3537107 `"Pedreira"', add
label define munibr_lbl 3537305 `"Penápolis"', add
label define munibr_lbl 3537602 `"Peruíbe"', add
label define munibr_lbl 3537800 `"Piedade"', add
label define munibr_lbl 3537909 `"Pilar do Sul"', add
label define munibr_lbl 3538006 `"Pindamonhangaba"', add
label define munibr_lbl 3538600 `"Piracaia"', add
label define munibr_lbl 3538808 `"Piraju"', add
label define munibr_lbl 3538907 `"Pirajuí"', add
label define munibr_lbl 3539202 `"Pirapozinho"', add
label define munibr_lbl 3539301 `"Pirassununga"', add
label define munibr_lbl 3539806 `"Poá"', add
label define munibr_lbl 3540200 `"Pontal"', add
label define munibr_lbl 3540606 `"Porto Feliz"', add
label define munibr_lbl 3540705 `"Porto Ferreira"', add
label define munibr_lbl 3541000 `"Praia Grande"', add
label define munibr_lbl 3541307 `"Presidente Epitácio"', add
label define munibr_lbl 3541406 `"Presidente Prudente"', add
label define munibr_lbl 3541505 `"Presidente Venceslau"', add
label define munibr_lbl 3541604 `"Promissão"', add
label define munibr_lbl 3542206 `"Rancharia"', add
label define munibr_lbl 3542602 `"Registro"', add
label define munibr_lbl 3543006 `"Ribeirão Branco"', add
label define munibr_lbl 3543303 `"Ribeirão Pires"', add
label define munibr_lbl 3543907 `"Rio Claro"', add
label define munibr_lbl 3544004 `"Rio das Pedras"', add
label define munibr_lbl 3544103 `"Rio Grande da Serra"', add
label define munibr_lbl 3545209 `"Salto"', add
label define munibr_lbl 3545308 `"Salto de Pirapora"', add
label define munibr_lbl 3545803 `"Santa Bárbara d'Oeste"', add
label define munibr_lbl 3546306 `"Santa Cruz das Palmeiras"', add
label define munibr_lbl 3546801 `"Santa Isabel"', add
label define munibr_lbl 3547304 `"Santana de Parnaíba"', add
label define munibr_lbl 3547502 `"Santa Rita do Passa Quatro"', add
label define munibr_lbl 3547601 `"Santa Rosa de Viterbo"', add
label define munibr_lbl 3547809 `"Santo André"', add
label define munibr_lbl 3548708 `"São Bernardo do Campo"', add
label define munibr_lbl 3548807 `"São Caetano do Sul"', add
label define munibr_lbl 3548906 `"São Carlos"', add
label define munibr_lbl 3549102 `"São João da Boa Vista"', add
label define munibr_lbl 3549409 `"São Joaquim da Barra"', add
label define munibr_lbl 3549706 `"São José do Rio Pardo"', add
label define munibr_lbl 3549904 `"São José dos Campos"', add
label define munibr_lbl 3550209 `"São Miguel Arcanjo"', add
label define munibr_lbl 3550308 `"São Paulo"', add
label define munibr_lbl 3550407 `"São Pedro"', add
label define munibr_lbl 3550704 `"São Sebastião"', add
label define munibr_lbl 3551009 `"São Vicente"', add
label define munibr_lbl 3551504 `"Serrana"', add
label define munibr_lbl 3551603 `"Serra Negra"', add
label define munibr_lbl 3551702 `"Sertãozinho"', add
label define munibr_lbl 3552106 `"Socorro"', add
label define munibr_lbl 3552205 `"Sorocaba"', add
label define munibr_lbl 3552502 `"Suzano"', add
label define munibr_lbl 3552809 `"Taboão da Serra"', add
label define munibr_lbl 3553302 `"Tambaú"', add
label define munibr_lbl 3553401 `"Tanabi"', add
label define munibr_lbl 3553708 `"Taquaritinga"', add
label define munibr_lbl 3553807 `"Taquarituba"', add
label define munibr_lbl 3554102 `"Taubaté"', add
label define munibr_lbl 3554805 `"Tremembé"', add
label define munibr_lbl 3555406 `"Ubatuba"', add
label define munibr_lbl 3556206 `"Valinhos"', add
label define munibr_lbl 3556404 `"Vargem Grande do Sul"', add
label define munibr_lbl 3556503 `"Várzea Paulista"', add
label define munibr_lbl 3556701 `"Vinhedo"', add
label define munibr_lbl 3557006 `"Votorantim"', add
label define munibr_lbl 3599901 `"Agudos merged"', add
label define munibr_lbl 3599902 `"Angatuba merged"', add
label define munibr_lbl 3599903 `"Apiaí merged"', add
label define munibr_lbl 3599904 `"Araçatuba merged"', add
label define munibr_lbl 3599905 `"Araraquara merged"', add
label define munibr_lbl 3599906 `"Assis merged"', add
label define munibr_lbl 3599907 `"Bragança Paulista merged"', add
label define munibr_lbl 3599908 `"Cajati merged"', add
label define munibr_lbl 3599909 `"Cajuru merged"', add
label define munibr_lbl 3599910 `"Capão Bonito merged"', add
label define munibr_lbl 3599911 `"Catanduva merged"', add
label define munibr_lbl 3599912 `"Cosmópolis merged"', add
label define munibr_lbl 3599913 `"Cotia merged"', add
label define munibr_lbl 3599914 `"Guaratinguetá merged"', add
label define munibr_lbl 3599915 `"Iguape merged"', add
label define munibr_lbl 3599916 `"Itapecerica da Serra merged"', add
label define munibr_lbl 3599917 `"Itapetininga merged"', add
label define munibr_lbl 3599918 `"Itapeva merged"', add
label define munibr_lbl 3599919 `"Itararé merged"', add
label define munibr_lbl 3599920 `"Jales merged"', add
label define munibr_lbl 3599921 `"José Bonifácio merged"', add
label define munibr_lbl 3599922 `"Lençóis Paulista merged"', add
label define munibr_lbl 3599923 `"Lorena merged"', add
label define munibr_lbl 3599924 `"Mairinque merged"', add
label define munibr_lbl 3599925 `"Mogi Guaçu merged"', add
label define munibr_lbl 3599926 `"Pereira Barreto merged"', add
label define munibr_lbl 3599927 `"Piracicaba merged"', add
label define munibr_lbl 3599928 `"Pitangueiras merged"', add
label define munibr_lbl 3599929 `"Ribeirão Preto merged"', add
label define munibr_lbl 3599930 `"Rosana merged"', add
label define munibr_lbl 3599931 `"Santa Cruz do Rio Pardo merged"', add
label define munibr_lbl 3599932 `"Santa Fé do Sul merged"', add
label define munibr_lbl 3599933 `"Santo Anastácio merged"', add
label define munibr_lbl 3599934 `"Santos merged"', add
label define munibr_lbl 3599935 `"São José do Rio Preto merged"', add
label define munibr_lbl 3599936 `"São Manuel merged"', add
label define munibr_lbl 3599937 `"São Roque merged"', add
label define munibr_lbl 3599938 `"Sumaré merged"', add
label define munibr_lbl 3599939 `"Tatuí merged"', add
label define munibr_lbl 3599940 `"Tietê merged"', add
label define munibr_lbl 3599941 `"Tupã merged"', add
label define munibr_lbl 3599942 `"Votuporanga merged"', add
label define munibr_lbl 3599999 `"Rest of São Paulo"', add
label define munibr_lbl 4101101 `"Andirá"', add
label define munibr_lbl 4101408 `"Apucarana"', add
label define munibr_lbl 4101507 `"Arapongas"', add
label define munibr_lbl 4101606 `"Arapoti"', add
label define munibr_lbl 4101804 `"Araucária"', add
label define munibr_lbl 4102109 `"Astorga"', add
label define munibr_lbl 4102406 `"Bandeirantes"', add
label define munibr_lbl 4103602 `"Cambará"', add
label define munibr_lbl 4103701 `"Cambé"', add
label define munibr_lbl 4104006 `"Campina Grande do Sul"', add
label define munibr_lbl 4104204 `"Campo Largo"', add
label define munibr_lbl 4105508 `"Cianorte"', add
label define munibr_lbl 4105805 `"Colombo"', add
label define munibr_lbl 4105904 `"Colorado"', add
label define munibr_lbl 4106407 `"Cornélio Procópio"', add
label define munibr_lbl 4106506 `"Coronel Vivida"', add
label define munibr_lbl 4106605 `"Cruzeiro do Oeste"', add
label define munibr_lbl 4106902 `"Curitiba"', add
label define munibr_lbl 4108403 `"Francisco Beltrão"', add
label define munibr_lbl 4108809 `"Guaíra"', add
label define munibr_lbl 4109609 `"Guaratuba"', add
label define munibr_lbl 4109708 `"Ibaiti"', add
label define munibr_lbl 4109807 `"Ibiporã"', add
label define munibr_lbl 4110706 `"Irati"', add
label define munibr_lbl 4111803 `"Jacarezinho"', add
label define munibr_lbl 4112009 `"Jaguariaíva"', add
label define munibr_lbl 4113205 `"Lapa"', add
label define munibr_lbl 4114203 `"Mandaguari"', add
label define munibr_lbl 4115200 `"Maringá"', add
label define munibr_lbl 4115705 `"Matinhos"', add
label define munibr_lbl 4116901 `"Nova Esperança"', add
label define munibr_lbl 4117305 `"Ortigueira"', add
label define munibr_lbl 4117503 `"Paiçandu"', add
label define munibr_lbl 4117701 `"Palmeira"', add
label define munibr_lbl 4118402 `"Paranavaí"', add
label define munibr_lbl 4119400 `"Piraí do Sul"', add
label define munibr_lbl 4120606 `"Prudentópolis"', add
label define munibr_lbl 4122305 `"Rio Negro"', add
label define munibr_lbl 4124103 `"Santo Antônio da Platina"', add
label define munibr_lbl 4125506 `"São José dos Pinhais"', add
label define munibr_lbl 4125605 `"São Mateus do Sul"', add
label define munibr_lbl 4128005 `"Ubiratã"', add
label define munibr_lbl 4128203 `"União da Vitória"', add
label define munibr_lbl 4199901 `"Almirante Tamandaré merged"', add
label define munibr_lbl 4199902 `"Altônia merged"', add
label define munibr_lbl 4199903 `"Assis Chateaubriand merged"', add
label define munibr_lbl 4199904 `"Campo Mourão merged"', add
label define munibr_lbl 4199905 `"Capitão Leônidas Marques merged"', add
label define munibr_lbl 4199906 `"Cascavel merged"', add
label define munibr_lbl 4199907 `"Cerro Azul merged"', add
label define munibr_lbl 4199908 `"Chopinzinho merged"', add
label define munibr_lbl 4199909 `"Corbélia merged"', add
label define munibr_lbl 4199910 `"Curiúva merged"', add
label define munibr_lbl 4199911 `"Dois Vizinhos merged"', add
label define munibr_lbl 4199912 `"Fazenda Rio Grande merged"', add
label define munibr_lbl 4199913 `"Foz do Iguaçu merged"', add
label define munibr_lbl 4199914 `"Goioerê merged"', add
label define munibr_lbl 4199915 `"Guaraniaçu merged"', add
label define munibr_lbl 4199916 `"Guarapuava merged"', add
label define munibr_lbl 4199917 `"Imbituva merged"', add
label define munibr_lbl 4199918 `"Iporã merged"', add
label define munibr_lbl 4199919 `"Ivaiporã merged"', add
label define munibr_lbl 4199920 `"Jesuítas merged"', add
label define munibr_lbl 4199921 `"Laranjeiras do Sul merged"', add
label define munibr_lbl 4199922 `"Londrina merged"', add
label define munibr_lbl 4199923 `"Mamborê merged"', add
label define munibr_lbl 4199924 `"Mangueirinha merged"', add
label define munibr_lbl 4199925 `"Marechal Cândido Rondon merged"', add
label define munibr_lbl 4199926 `"Marmeleiro merged"', add
label define munibr_lbl 4199927 `"Medianeira merged"', add
label define munibr_lbl 4199928 `"Palmas merged"', add
label define munibr_lbl 4199929 `"Palmital merged"', add
label define munibr_lbl 4199930 `"Palotina merged"', add
label define munibr_lbl 4199931 `"Paranaguá merged"', add
label define munibr_lbl 4199932 `"Pato Branco merged"', add
label define munibr_lbl 4199933 `"Pinhais merged"', add
label define munibr_lbl 4199934 `"Pinhão merged"', add
label define munibr_lbl 4199935 `"Pitanga merged"', add
label define munibr_lbl 4199936 `"Ponta Grossa merged"', add
label define munibr_lbl 4199937 `"Quedas do Iguaçu merged"', add
label define munibr_lbl 4199938 `"Rio Branco do Sul merged"', add
label define munibr_lbl 4199939 `"Rolândia merged"', add
label define munibr_lbl 4199940 `"Salto do Lontra merged"', add
label define munibr_lbl 4199941 `"Santa Helena merged"', add
label define munibr_lbl 4199942 `"Santo Antônio do Sudoeste merged"', add
label define munibr_lbl 4199943 `"São João do Ivaí merged"', add
label define munibr_lbl 4199944 `"São Miguel do Iguaçu merged"', add
label define munibr_lbl 4199945 `"Sarandi merged"', add
label define munibr_lbl 4199946 `"Telêmaco Borba merged"', add
label define munibr_lbl 4199947 `"Tibagi merged"', add
label define munibr_lbl 4199948 `"Três Barras do Paraná merged"', add
label define munibr_lbl 4199949 `"Umuarama merged"', add
label define munibr_lbl 4199999 `"Rest of Paraná"', add
label define munibr_lbl 4202008 `"Balneário Camboriú"', add
label define munibr_lbl 4202305 `"Biguaçu"', add
label define munibr_lbl 4202404 `"Blumenau"', add
label define munibr_lbl 4202800 `"Braço do Norte"', add
label define munibr_lbl 4202909 `"Brusque"', add
label define munibr_lbl 4203204 `"Camboriú"', add
label define munibr_lbl 4205407 `"Florianópolis"', add
label define munibr_lbl 4205506 `"Fraiburgo"', add
label define munibr_lbl 4205902 `"Gaspar"', add
label define munibr_lbl 4206504 `"Guaramirim"', add
label define munibr_lbl 4206702 `"Herval d'Oeste"', add
label define munibr_lbl 4207007 `"Içara"', add
label define munibr_lbl 4207304 `"Imbituba"', add
label define munibr_lbl 4208203 `"Itajaí"', add
label define munibr_lbl 4208302 `"Itapema"', add
label define munibr_lbl 4208906 `"Jaraguá do Sul"', add
label define munibr_lbl 4209102 `"Joinville"', add
label define munibr_lbl 4209409 `"Laguna"', add
label define munibr_lbl 4210100 `"Mafra"', add
label define munibr_lbl 4211306 `"Navegantes"', add
label define munibr_lbl 4211702 `"Orleans"', add
label define munibr_lbl 4211900 `"Palhoça"', add
label define munibr_lbl 4213203 `"Pomerode"', add
label define munibr_lbl 4213609 `"Porto União"', add
label define munibr_lbl 4214805 `"Rio do Sul"', add
label define munibr_lbl 4215000 `"Rio Negrinho"', add
label define munibr_lbl 4215802 `"São Bento do Sul"', add
label define munibr_lbl 4216206 `"São Francisco do Sul"', add
label define munibr_lbl 4218004 `"Tijucas"', add
label define munibr_lbl 4218202 `"Timbó"', add
label define munibr_lbl 4299901 `"Anita Garibaldi merged"', add
label define munibr_lbl 4299902 `"Araquari merged"', add
label define munibr_lbl 4299903 `"Araranguá merged"', add
label define munibr_lbl 4299904 `"Caçador merged"', add
label define munibr_lbl 4299905 `"Campos Novos merged"', add
label define munibr_lbl 4299906 `"Canoinhas merged"', add
label define munibr_lbl 4299907 `"Chapecó merged"', add
label define munibr_lbl 4299908 `"Concórdia merged"', add
label define munibr_lbl 4299909 `"Criciúma merged"', add
label define munibr_lbl 4299910 `"Curitibanos merged"', add
label define munibr_lbl 4299911 `"Garuva merged"', add
label define munibr_lbl 4299912 `"Ibirama merged"', add
label define munibr_lbl 4299913 `"Indaial merged"', add
label define munibr_lbl 4299914 `"Itaiópolis merged"', add
label define munibr_lbl 4299915 `"Itapiranga merged"', add
label define munibr_lbl 4299916 `"Ituporanga merged"', add
label define munibr_lbl 4299917 `"Jaguaruna merged"', add
label define munibr_lbl 4299918 `"Joaçaba merged"', add
label define munibr_lbl 4299919 `"Lages merged"', add
label define munibr_lbl 4299920 `"Santa Cecília merged"', add
label define munibr_lbl 4299921 `"São Joaquim merged"', add
label define munibr_lbl 4299922 `"São José merged"', add
label define munibr_lbl 4299923 `"São Lourenço do Oeste merged"', add
label define munibr_lbl 4299924 `"São Miguel do Oeste merged"', add
label define munibr_lbl 4299925 `"Seara merged"', add
label define munibr_lbl 4299926 `"Sombrio merged"', add
label define munibr_lbl 4299927 `"Tubarão merged"', add
label define munibr_lbl 4299928 `"Urussanga merged"', add
label define munibr_lbl 4299929 `"Videira merged"', add
label define munibr_lbl 4299930 `"Xanxerê merged"', add
label define munibr_lbl 4299999 `"Rest of Santa Catarina"', add
label define munibr_lbl 4300604 `"Alvorada"', add
label define munibr_lbl 4302808 `"Caçapava do Sul"', add
label define munibr_lbl 4303103 `"Cachoeirinha"', add
label define munibr_lbl 4303905 `"Campo Bom"', add
label define munibr_lbl 4304408 `"Canela"', add
label define munibr_lbl 4304507 `"Canguçu"', add
label define munibr_lbl 4305108 `"Caxias do Sul"', add
label define munibr_lbl 4306601 `"Dom Pedrito"', add
label define munibr_lbl 4307609 `"Estância Velha"', add
label define munibr_lbl 4307708 `"Esteio"', add
label define munibr_lbl 4307906 `"Farroupilha"', add
label define munibr_lbl 4309100 `"Gramado"', add
label define munibr_lbl 4310108 `"Igrejinha"', add
label define munibr_lbl 4311007 `"Jaguarão"', add
label define munibr_lbl 4313409 `"Novo Hamburgo"', add
label define munibr_lbl 4313904 `"Panambi"', add
label define munibr_lbl 4314902 `"Porto Alegre"', add
label define munibr_lbl 4315305 `"Quaraí"', add
label define munibr_lbl 4315602 `"Rio Grande"', add
label define munibr_lbl 4316402 `"Rosário do Sul"', add
label define munibr_lbl 4317103 `"Santana do Livramento"', add
label define munibr_lbl 4317202 `"Santa Rosa"', add
label define munibr_lbl 4318507 `"São José do Norte"', add
label define munibr_lbl 4318705 `"São Leopoldo"', add
label define munibr_lbl 4320008 `"Sapucaia do Sul"', add
label define munibr_lbl 4322004 `"Triunfo"', add
label define munibr_lbl 4322707 `"Vera Cruz"', add
label define munibr_lbl 4399901 `"Alegrete merged"', add
label define munibr_lbl 4399902 `"Arroio do Meio merged"', add
label define munibr_lbl 4399903 `"Bagé merged"', add
label define munibr_lbl 4399904 `"Butiá merged"', add
label define munibr_lbl 4399905 `"Cachoeira do Sul merged"', add
label define munibr_lbl 4399906 `"Canoas merged"', add
label define munibr_lbl 4399907 `"Crissiumal merged"', add
label define munibr_lbl 4399908 `"Cruz Alta merged"', add
label define munibr_lbl 4399909 `"Dois Irmãos merged"', add
label define munibr_lbl 4399910 `"Encantado merged"', add
label define munibr_lbl 4399911 `"Erechim merged"', add
label define munibr_lbl 4399912 `"Feliz merged"', add
label define munibr_lbl 4399913 `"Flores da Cunha merged"', add
label define munibr_lbl 4399914 `"Frederico Westphalen merged"', add
label define munibr_lbl 4399915 `"Giruá merged"', add
label define munibr_lbl 4399916 `"Gravataí merged"', add
label define munibr_lbl 4399917 `"Guaíba merged"', add
label define munibr_lbl 4399918 `"Guaporé merged"', add
label define munibr_lbl 4399919 `"Horizontina merged"', add
label define munibr_lbl 4399920 `"Ijuí merged"', add
label define munibr_lbl 4399921 `"Itaqui merged"', add
label define munibr_lbl 4399922 `"Júlio de Castilhos merged"', add
label define munibr_lbl 4399923 `"Nonoai merged"', add
label define munibr_lbl 4399924 `"Palmeira das Missões merged"', add
label define munibr_lbl 4399925 `"Pelotas merged"', add
label define munibr_lbl 4399926 `"Rio Pardo merged"', add
label define munibr_lbl 4399927 `"Rolante merged"', add
label define munibr_lbl 4399928 `"Sananduva merged"', add
label define munibr_lbl 4399929 `"Santa Cruz do Sul merged"', add
label define munibr_lbl 4399930 `"Santa Maria merged"', add
label define munibr_lbl 4399931 `"Santa Vitória do Palmar merged"', add
label define munibr_lbl 4399932 `"Santiago merged"', add
label define munibr_lbl 4399933 `"Santo Ângelo merged"', add
label define munibr_lbl 4399934 `"Santo Antônio da Patrulha merged"', add
label define munibr_lbl 4399935 `"Santo Cristo merged"', add
label define munibr_lbl 4399936 `"São Borja merged"', add
label define munibr_lbl 4399937 `"São Francisco de Paula merged"', add
label define munibr_lbl 4399938 `"São Gabriel merged"', add
label define munibr_lbl 4399939 `"São Pedro do Sul merged"', add
label define munibr_lbl 4399940 `"Sapiranga merged"', add
label define munibr_lbl 4399941 `"Taquari merged"', add
label define munibr_lbl 4399942 `"Tenente Portela merged"', add
label define munibr_lbl 4399943 `"Torres merged"', add
label define munibr_lbl 4399944 `"Três de Maio merged"', add
label define munibr_lbl 4399945 `"Três Passos merged"', add
label define munibr_lbl 4399946 `"Tuparendi merged"', add
label define munibr_lbl 4399947 `"Uruguaiana merged"', add
label define munibr_lbl 4399948 `"Veranópolis merged"', add
label define munibr_lbl 4399949 `"Viamão merged"', add
label define munibr_lbl 4399999 `"Rest of Rio Grande do Sul"', add
label define munibr_lbl 5001102 `"Aquidauana"', add
label define munibr_lbl 5002100 `"Bela Vista"', add
label define munibr_lbl 5002704 `"Campo Grande"', add
label define munibr_lbl 5003207 `"Corumbá"', add
label define munibr_lbl 5005004 `"Jardim"', add
label define munibr_lbl 5005400 `"Maracaju"', add
label define munibr_lbl 5005707 `"Naviraí"', add
label define munibr_lbl 5006200 `"Nova Andradina"', add
label define munibr_lbl 5099901 `"Amambaí merged"', add
label define munibr_lbl 5099902 `"Anastácio merged"', add
label define munibr_lbl 5099903 `"Caarapó merged"', add
label define munibr_lbl 5099904 `"Dourados merged"', add
label define munibr_lbl 5099905 `"Fátima do Sul merged"', add
label define munibr_lbl 5099906 `"Itaquiraí merged"', add
label define munibr_lbl 5099907 `"Ivinhema merged"', add
label define munibr_lbl 5099908 `"Miranda merged"', add
label define munibr_lbl 5099909 `"Paranaíba merged"', add
label define munibr_lbl 5099910 `"Ponta Porã merged"', add
label define munibr_lbl 5099911 `"Sidrolândia merged"', add
label define munibr_lbl 5099912 `"Três Lagoas merged"', add
label define munibr_lbl 5099999 `"Rest of Mato Grosso do Sul"', add
label define munibr_lbl 5106505 `"Poconé"', add
label define munibr_lbl 5107958 `"Tangará da Serra"', add
label define munibr_lbl 5108402 `"Várzea Grande"', add
label define munibr_lbl 5199901 `"Alta Floresta merged"', add
label define munibr_lbl 5199902 `"Cáceres merged"', add
label define munibr_lbl 5199903 `"Cuiabá merged"', add
label define munibr_lbl 5199904 `"Guiratinga merged"', add
label define munibr_lbl 5199905 `"Pontes e Lacerda merged"', add
label define munibr_lbl 5199906 `"Rondonópolis merged"', add
label define munibr_lbl 5199999 `"Rest of Mato Grosso"', add
label define munibr_lbl 5103254 `"Colniza"', add
label define munibr_lbl 5200308 `"Alexânia"', add
label define munibr_lbl 5201108 `"Anápolis"', add
label define munibr_lbl 5205109 `"Catalão"', add
label define munibr_lbl 5206206 `"Cristalina"', add
label define munibr_lbl 5208608 `"Goianésia"', add
label define munibr_lbl 5210000 `"Inhumas"', add
label define munibr_lbl 5210109 `"Ipameri"', add
label define munibr_lbl 5210208 `"Iporá"', add
label define munibr_lbl 5210406 `"Itaberaí"', add
label define munibr_lbl 5213103 `"Mineiros"', add
label define munibr_lbl 5213806 `"Morrinhos"', add
label define munibr_lbl 5214606 `"Niquelândia"', add
label define munibr_lbl 5217401 `"Pires do Rio"', add
label define munibr_lbl 5219308 `"Santa Helena de Goiás"', add
label define munibr_lbl 5220108 `"São Luís de Montes Belos"', add
label define munibr_lbl 5299901 `"Acreúna merged"', add
label define munibr_lbl 5299902 `"Anicuns merged"', add
label define munibr_lbl 5299903 `"Caiapônia merged"', add
label define munibr_lbl 5299904 `"Caldas Novas merged"', add
label define munibr_lbl 5299905 `"Ceres merged"', add
label define munibr_lbl 5299906 `"Cocalzinho de Goiás merged"', add
label define munibr_lbl 5299907 `"Crixás merged"', add
label define munibr_lbl 5299908 `"Formosa merged"', add
label define munibr_lbl 5299909 `"Goiânia merged"', add
label define munibr_lbl 5299910 `"Goianira merged"', add
label define munibr_lbl 5299911 `"Goiás merged"', add
label define munibr_lbl 5299912 `"Goiatuba merged"', add
label define munibr_lbl 5299913 `"Itapaci merged"', add
label define munibr_lbl 5299914 `"Itapuranga merged"', add
label define munibr_lbl 5299915 `"Itumbiara merged"', add
label define munibr_lbl 5299916 `"Jaraguá merged"', add
label define munibr_lbl 5299917 `"Jataí merged"', add
label define munibr_lbl 5299918 `"Jussara merged"', add
label define munibr_lbl 5299919 `"Luziânia merged"', add
label define munibr_lbl 5299920 `"Mara Rosa merged"', add
label define munibr_lbl 5299921 `"Minaçu merged"', add
label define munibr_lbl 5299922 `"Padre Bernardo merged"', add
label define munibr_lbl 5299923 `"Palmeiras de Goiás merged"', add
label define munibr_lbl 5299924 `"Piracanjuba merged"', add
label define munibr_lbl 5299925 `"Pirenópolis merged"', add
label define munibr_lbl 5299926 `"Planaltina merged"', add
label define munibr_lbl 5299927 `"Pontalina merged"', add
label define munibr_lbl 5299928 `"Porangatu merged"', add
label define munibr_lbl 5299929 `"Posse merged"', add
label define munibr_lbl 5299930 `"Quirinópolis merged"', add
label define munibr_lbl 5299931 `"Rio Verde merged"', add
label define munibr_lbl 5299932 `"Rubiataba merged"', add
label define munibr_lbl 5299933 `"Santa Terezinha de Goiás merged"', add
label define munibr_lbl 5299934 `"São Miguel do Araguaia merged"', add
label define munibr_lbl 5299935 `"Silvânia merged"', add
label define munibr_lbl 5299999 `"Rest of Goiás"', add
label define munibr_lbl 5300108 `"Brasília"', add
label values munibr munibr_lbl

label define metrobr_lbl 000 `"Not in metropolitan region"'
label define metrobr_lbl 010 `"Manaus"', add
label define metrobr_lbl 020 `"Belém"', add
label define metrobr_lbl 030 `"Macapá"', add
label define metrobr_lbl 040 `"Grande São Luís"', add
label define metrobr_lbl 050 `"Suoeste Maranhense"', add
label define metrobr_lbl 060 `"Cariri"', add
label define metrobr_lbl 070 `"Fortaleza"', add
label define metrobr_lbl 080 `"Natal"', add
label define metrobr_lbl 090 `"Campina Grande"', add
label define metrobr_lbl 100 `"João Pessoa"', add
label define metrobr_lbl 110 `"Recife"', add
label define metrobr_lbl 120 `"Agreste"', add
label define metrobr_lbl 130 `"Maceió"', add
label define metrobr_lbl 140 `"Aracaju"', add
label define metrobr_lbl 150 `"Salvador"', add
label define metrobr_lbl 160 `"Belo Horizonte"', add
label define metrobr_lbl 169 `"Belt around the Belo Horizonte MR (Metropolitan Region)"', add
label define metrobr_lbl 170 `"Vale do Aço"', add
label define metrobr_lbl 179 `"Belt around Vale do Aço MR"', add
label define metrobr_lbl 180 `"Vitória"', add
label define metrobr_lbl 190 `"Rio de Janeiro"', add
label define metrobr_lbl 200 `"São Paulo"', add
label define metrobr_lbl 210 `"Santos Coastal Region"', add
label define metrobr_lbl 220 `"Campinas"', add
label define metrobr_lbl 230 `"Curitiba"', add
label define metrobr_lbl 240 `"Maringá"', add
label define metrobr_lbl 250 `"Londrina"', add
label define metrobr_lbl 260 `"Florianópolis"', add
label define metrobr_lbl 269 `"Metropolitan Expansion Area - Florianópolis MR"', add
label define metrobr_lbl 280 `"Vale do Itajaí"', add
label define metrobr_lbl 290 `"Metropolitan expansion area of Vale do Itajaí"', add
label define metrobr_lbl 270 `"North/NE Santa Catarina"', add
label define metrobr_lbl 279 `"Metropolitan Expansion Area - North/NE Santa Catarina"', add
label define metrobr_lbl 300 `"Carbonífera"', add
label define metrobr_lbl 310 `"Tubarão"', add
label define metrobr_lbl 320 `"Lages"', add
label define metrobr_lbl 330 `"Chapecó"', add
label define metrobr_lbl 340 `"Porto Alegre"', add
label define metrobr_lbl 350 `"Vale do Rio Cuiabá"', add
label define metrobr_lbl 360 `"Goiânia"', add
label define metrobr_lbl 370 `"Caxias do Sul"', add
label define metrobr_lbl 380 `"Pelotas"', add
label define metrobr_lbl 400 `"Distrito Federal and surroundings"', add
label define metrobr_lbl 410 `"Grande Terseina"', add
label define metrobr_lbl 420 `"Petrolina e Juazeiro"', add
label define metrobr_lbl 430 `"Undocumented"', add
label values metrobr metrobr_lbl

label define age_lbl 000 `"Less than 1 year"'
label define age_lbl 001 `"1 year"', add
label define age_lbl 002 `"2 years"', add
label define age_lbl 003 `"3"', add
label define age_lbl 004 `"4"', add
label define age_lbl 005 `"5"', add
label define age_lbl 006 `"6"', add
label define age_lbl 007 `"7"', add
label define age_lbl 008 `"8"', add
label define age_lbl 009 `"9"', add
label define age_lbl 010 `"10"', add
label define age_lbl 011 `"11"', add
label define age_lbl 012 `"12"', add
label define age_lbl 013 `"13"', add
label define age_lbl 014 `"14"', add
label define age_lbl 015 `"15"', add
label define age_lbl 016 `"16"', add
label define age_lbl 017 `"17"', add
label define age_lbl 018 `"18"', add
label define age_lbl 019 `"19"', add
label define age_lbl 020 `"20"', add
label define age_lbl 021 `"21"', add
label define age_lbl 022 `"22"', add
label define age_lbl 023 `"23"', add
label define age_lbl 024 `"24"', add
label define age_lbl 025 `"25"', add
label define age_lbl 026 `"26"', add
label define age_lbl 027 `"27"', add
label define age_lbl 028 `"28"', add
label define age_lbl 029 `"29"', add
label define age_lbl 030 `"30"', add
label define age_lbl 031 `"31"', add
label define age_lbl 032 `"32"', add
label define age_lbl 033 `"33"', add
label define age_lbl 034 `"34"', add
label define age_lbl 035 `"35"', add
label define age_lbl 036 `"36"', add
label define age_lbl 037 `"37"', add
label define age_lbl 038 `"38"', add
label define age_lbl 039 `"39"', add
label define age_lbl 040 `"40"', add
label define age_lbl 041 `"41"', add
label define age_lbl 042 `"42"', add
label define age_lbl 043 `"43"', add
label define age_lbl 044 `"44"', add
label define age_lbl 045 `"45"', add
label define age_lbl 046 `"46"', add
label define age_lbl 047 `"47"', add
label define age_lbl 048 `"48"', add
label define age_lbl 049 `"49"', add
label define age_lbl 050 `"50"', add
label define age_lbl 051 `"51"', add
label define age_lbl 052 `"52"', add
label define age_lbl 053 `"53"', add
label define age_lbl 054 `"54"', add
label define age_lbl 055 `"55"', add
label define age_lbl 056 `"56"', add
label define age_lbl 057 `"57"', add
label define age_lbl 058 `"58"', add
label define age_lbl 059 `"59"', add
label define age_lbl 060 `"60"', add
label define age_lbl 061 `"61"', add
label define age_lbl 062 `"62"', add
label define age_lbl 063 `"63"', add
label define age_lbl 064 `"64"', add
label define age_lbl 065 `"65"', add
label define age_lbl 066 `"66"', add
label define age_lbl 067 `"67"', add
label define age_lbl 068 `"68"', add
label define age_lbl 069 `"69"', add
label define age_lbl 070 `"70"', add
label define age_lbl 071 `"71"', add
label define age_lbl 072 `"72"', add
label define age_lbl 073 `"73"', add
label define age_lbl 074 `"74"', add
label define age_lbl 075 `"75"', add
label define age_lbl 076 `"76"', add
label define age_lbl 077 `"77"', add
label define age_lbl 078 `"78"', add
label define age_lbl 079 `"79"', add
label define age_lbl 080 `"80"', add
label define age_lbl 081 `"81"', add
label define age_lbl 082 `"82"', add
label define age_lbl 083 `"83"', add
label define age_lbl 084 `"84"', add
label define age_lbl 085 `"85"', add
label define age_lbl 086 `"86"', add
label define age_lbl 087 `"87"', add
label define age_lbl 088 `"88"', add
label define age_lbl 089 `"89"', add
label define age_lbl 090 `"90"', add
label define age_lbl 091 `"91"', add
label define age_lbl 092 `"92"', add
label define age_lbl 093 `"93"', add
label define age_lbl 094 `"94"', add
label define age_lbl 095 `"95"', add
label define age_lbl 096 `"96"', add
label define age_lbl 097 `"97"', add
label define age_lbl 098 `"98"', add
label define age_lbl 099 `"99"', add
label define age_lbl 100 `"100+"', add
label define age_lbl 999 `"Not reported/missing"', add
label values age age_lbl

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label define sex_lbl 9 `"Unknown"', add
label values sex sex_lbl


