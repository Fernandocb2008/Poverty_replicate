/********************************************************************************
* PROJECT:	Pobreza - Peru                                 
* TITLE: 	Desarrollo de la infraestructura y reducción de la pobreza
* YEAR:		2021
*********************************************************************************
	
*** Outline:
	0. Set initial configurations and globals
	1. Cleaning 
	2. Appending Datasets (Baseline and FUP1)
	3. Construction 
	4. Tables -- Regressions
	5. Figures

*** Programs:
	1. iebaltab2
	2. packages

*********************************************************************************
*	PART 0: Set initial configurations and globals
********************************************************************************/

*** ----------------------------------------------------------------------------
* Set Packages
*** ----------------------------------------------------------------------------
	
	
*** ----------------------------------------------------------------------------
*** Set  Github directory
*** ----------------------------------------------------------------------------
		
*** 0.1 Set file path
	if inlist("`c(username)'","Fernando"){
		global bases			"D:\BBDD"
		global project			"D:\GIT-Docs\IDP"
		global temp				"D:\BBFF"
		
	} 
	
	
*** 0.2 Setting up folders
	global dofiles		"${project}/dofiles"
	global data			"${project}/data"
	global outputs 		"${project}/outputs/tables"
	global figures		"${project}/outputs/figures"
	
	global enahoa_2010	"${bases}\ENAHO_ANTIGUO\2010"
	global enaho_2018	"${bases}/ENAHO/2018"
	global enaho_2019 	"${bases}/ENAHO/2019"

	global data_int 	"${temp}\intermediate"
	
*** 0.0 Install required packages	
	run "${dofiles}/programs/packages.do"	 

	packages tabout ietoolkit winsor esttab nsplit esttab outreg2
	ieboilstart, version(15.1)
	
	
*** 0.4 Execution globals
	global cleaning 	0
	global append_dta	0
	global construct	0
	global analysis		0
	
	set scheme s1color 	
	
********************************************************************************
***	Part 1:  Cleaning 
********************************************************************************
	
*** Creating easy to read long versions of datasets
	if (${cleaning}==1) {
		do "${dofiles}/cleaning/01_enaho_2017_empleo.do"
		do "${dofiles}/cleaning/02_enaho_2018_empleo.do"
		do "${dofiles}/cleaning/03_enaho_2019_empleo.do"
	}
	
*** Append datasets
	if (${append_dta}==1) {
		do "${dofiles}/cleaning/04_append_datasets.do"
	}
	
*** Construction
	if (${construct}==1) {
		do "${dofiles}/construct/01_construct.do"
	}	
	
*** Analysis
	if (${analysis}==1) {
		do 
	}
 
*	===================================================================================================
*												END		
*	===================================================================================================
