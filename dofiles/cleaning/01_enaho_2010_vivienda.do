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

*** Programs:
	1. iebaltab2
	2. packages

*********************************************************************************
*	PART 0: Set initial configurations and globals
********************************************************************************/

*** Load data
	use "${enahoa_2010}/enaho01_2010_100.dta", clear
	
	keep if result < 3
	sort conglome vivienda hogar
	

**********************************
*		 INFRAESTRUCTURA
***********************************

***========================================================
*** 	Etiquetas de variables dicotómicas
***========================================================

	*** Etiquetas para variables dummies
	label define dummy 1 "Yes" 0 "No"


	*** Recodificando el área de residencia
	gen area=(estrato<=5)
	label var area "Area of residency: Urban"
	label value area dummy
	
*** Completando la información faltante

	foreach k of varlist p101 p102 p103 p103a p104  {
		by  conglome vivienda, sort: egen a=max(`k')
		replace `k'=a 	if (`k'==. | `k'==9) 
		drop a
	}
* Titulo de Propiedad
	gen 	v_title	= (p106a==1)
	label 	var 	v_title "Possession of property title"
	lab 	val 	v_title dummy

* Vivienda Propia
	gen 	v_propia=(p105a==2 | p105a==3 | p105a==4)
	label 	var 	v_propia "Owns a house"
	lab 	val 	v_propia dummy

* Viviendad Alquilada
	gen		v_rented =(p105a==1)
	label 	var 	v_rented "The house is rented"
	lab 	val 	v_rented dummy

* Numero de habitaciones
	gen		v_room    = 	p104
	label 	var 		v_room "Number of rooms"

* Tipo de pared
	gen	 	v_wall	=	(p102==1)
	label 	var 	v_wall "Wall Material: brick or cinder block"
	lab 	val 	v_wall dummy

* Tipo de pisos
	gen		v_floor	=	(p103==1)
	label 	var 	v_floor "Flooring material: parquet"
	lab 	val 	v_floor dummy

* Agua potable: 
	gen		v_water	=	(p110==1 | p110==2)
	label 	var 	v_water "Source of drinking water: public network"
	lab 	val 	v_water dummy

* Desague:
	gen 	v_drain	=	(p111==1 | p111==2)
	label 	var 	v_drain "Source of drinking water: public network"
	lab 	val 	v_drain dummy

* Electricidad
	gen		v_elec	=	(p1121)
	label 	var 	v_elec "Have electricity"
	lab 	val 	v_elec dummy

* Combustible
	gen		v_fuel	=	(p113a==1 | p113a==2 | p113a==3)
	label 	var 	v_fuel "Type fo cooking fuel: electricity, gas"
	lab 	val 	v_fuel dummy

* Teléfono
	gen		v_phone	=	(p1141==1 | p1142==1)
	label 	var 	v_phone "Have a landline or mobile phone"
	lab 	val 	v_phone dummy

* Internet
	gen		v_net	=	(p1144==1)
	label 	var 	v_net "Have an internet"
	lab 	val 	v_net dummy


keep conglome vivienda hogar v_* factor
*** Save dataset
	save "${data_int}/infraestructure_10.dta", replace 

	
	
	
	
	