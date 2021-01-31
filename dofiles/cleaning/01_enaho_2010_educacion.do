/********************************************************************************
* PROJECT:	Poverty                              
* TITLE: 	
* YEAR:		2021
*********************************************************************************
	
*** Outline:
	0. Set initial configurations and globals
	1. Cleaning 
	2. Appending Datasets (Baseline and FUP1)
	3. Construction 
	4. Tables -- Regressions
	5. Figures

*********************************************************************************
*	PART 0: Set initial configurations and globals
********************************************************************************/

*** Load data
	use "${enahoa_2010}/enaho01a_2010_300.dta", clear
	gen miemb_hogar=   ( p204==1 | (p204==2 & p206==1) )
	keep if p203==1

***========================================================
*** 	Etiquetas de variables dicotómicas
***========================================================

	*** Etiquetas para variables dummies
	label define dummy 1 "Yes" 0 "No"

* CAPITAL HUMANO

	* Sin Nivel
	gen 	e_none		=		(p301a==1 | p301a==.)
	label 	var 	e_none "Don't have educational level"
	lab 	val 	e_none dummy
	
* Primaria Completa
	gen 	e_primary	=		(p301a==4 | p301a==5)
	label 	var 	e_primary "Have complete primary"
	lab 	val 	e_primary dummy

* Secundaria Completa
	gen 	e_hschool		=		(p301a==7 | p301a==6 | p301a==9)
	label 	var 	e_hschool "Have completed high school"
	lab 	val 	e_hschool dummy

* Superior Completo
	gen 	e_higher		=		(p301a>=8 & p301a!=9)
	label 	var 	e_higher "Have higher education"
	lab 	val 	e_higher dummy

*Lengua
* 1 = quechua, aymara u otra lengua nativa
	gen 	language		=(p300a==1 | p300a==2 | p300a==3)
	label 	var 	language "Indigenous language"
	lab 	val 	language dummy

* Sexo
	gen 	sex			=(p207==1)
	label 	var 	sex "Head of household sex: Male"
	lab 	val 	sex dummy
	
* Edad
	gen 	age			= p208a
	label 	var 	age "Age of head of household"
	lab 	val 	age dummy
	
* Edad al cuadrado
	gen 	age2			= age*age
	label 	var 	age2 "Age squared of head of household"
	lab 	val 	age2 dummy	
	

	keep conglome vivienda hogar e_none e_primary e_hschool e_higher language sex age  	age2 factor


*** Save dataset
	save "${data_int}/education_10.dta", replace 

	
	
	
	
	