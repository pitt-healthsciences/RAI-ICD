/*************************************************
Adaptation, Recalibration, and Validation of the Risk Analysis Index for Frailty Assessment Using International Classification of Diseases Codes
Khamzina et. al. 

Stata code for the derivation of the RAI-ICD, finalized 6/7/2023

Contact:
Reitzkm2@upmc.edu
Khamzinay2@upmc.edu
*************************************************/

//Severe cancer variable 

//Below is the code for active severe variables cancer that have corresponding remission (Z) code

generate cancer_rai_severe = 0

generate remission_esophagus = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_esophagus = 1 if (inlist(`var', "Z8501"))
}
}

generate cancer_esophagus = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_esophagus = 1 if (inlist(`var', "C153", "C154", "C155", "C158", "C159"))
}
}

gen active_esophagus = 1 if cancer_esophagus == 1 & remission_esophagus!= 1 

//

generate remission_liver = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_liver = 1 if (inlist(`var', "Z8505"))
}
}

generate cancer_liver = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_liver = 1 if (inlist(`var', "C220", "C221", "C222", "C223", "C224") | inlist(`var', "C227", "C228", "C229"))
}
}

gen active_liver = 1 if cancer_liver==1 & remission_liver!=1
//

generate remission_pancreas = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_pancreas = 1 if (inlist(`var', "Z8507"))
}
}

generate cancer_pancreas = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_pancreas = 1 if (inlist(`var', "C250", "C251", "C252", "C253", "C254") | inlist(`var', "C257", "C258", "C259"))
}
}

gen active_pancreas = 1 if cancer_pancreas==1 & remission_pancreas!=1
// pancreas

generate remission_trachea = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_trachea = 1 if (inlist(`var', "Z8512"))
}
}

generate cancer_trachea = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_trachea = 1 if (inlist(`var', "C33"))
}
}

gen active_trachea = 1 if cancer_trachea==1 & remission_trachea!=1
// trachea
//

generate remission_bronch_lung = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_bronch_lung = 1 if (inlist(`var', "Z85118"))
}
}

generate cancer_bronch_lung = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_bronch_lung = 1 if (inlist(`var', "C3400", "C3401", "C3402", "C3410", "C3411") | inlist(`var', "C3412", "C342", "C3430", "C3431", "C3432") | inlist(`var', "C3480", "C3481", "C3482", "C3490", "C3491") | inlist(`var', "C3492"))
}
}

gen active_bronch = 1 if cancer_bronch_lung==1 & remission_bronch_lung!=1
// bronch&lungs
//

generate remission_brain = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_brain = 1 if (inlist(`var', "Z85841"))
}
}

generate cancer_brain = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_brain = 1 if (inlist(`var', "C710", "C711", "C712") | inlist(`var', "C713", "C714", "C715", "C716", "C717") | inlist(`var', "C718", "C719"))
}
}

gen active_brain =1 if cancer_brain==1 & remission_brain!=1
//brain
//

generate remission_leukemia = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace remission_leukemia = 1 if (inlist(`var', "Z856"))
}
}

generate cancer_leukemia_severe = 0 
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_leukemia_severe = 1 if (inlist(`var', "C9200", "C9202") | inlist(`var', "C9260", "C9262", "C92A0", "C92A2", "C9300") | inlist(`var', "C9302", "C9310", "C9312", "C9330", "C9332") | inlist(`var', "C93Z0", "C93Z2", "C9390", "C9392"))
}
}

gen active_leukemia_severe = 1 if cancer_leukemia_severe==1 & remission_leukemia!=1
//leukemia
//

**This will add in only active (cancer diagnosis without remission diagnosis) cancer variables
foreach var of varlist active_* {
	replace cancer_rai_severe = 1 if `var'==1
}

**Below are cancer codes that don't have corresponding remission codes; considered active cancer
foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cancer_rai_severe = 1 if (inlist(`var', "C23" "C240") | inlist(`var', "C241", "C248", "C249", "C450", "C451") | inlist(`var', "C452", "C457", "C459", "C770", "C771") | inlist(`var', "C772") | inlist(`var', "C773", "C774", "C775", "C778", "C779") | inlist(`var', "C7800", "C7801", "C7802", "C781", "C782") | inlist(`var', "C7830", "C7839", "C784", "C785", "C786") | inlist(`var', "C787", "C7880", "C7889") | inlist(`var', "C7900", "C7901", "C7902", "C7910", "C7911") | inlist(`var', "C7919", "C792", "C7931", "C7932", "C7940") | inlist(`var', "C7949", "C7951", "C7952", "C7960", "C7961") | inlist(`var', "C7962", "C7963", "C7970", "C7971", "C7972") | inlist(`var', "C7981", "C7982", "C7989", "C799") | inlist(`var', "C800") | inlist(`var', "C7B00", "C7B01", "C7B02", "C7B03", "C7B04") | inlist(`var', "C7B09", "C7B1", "C7B8"))
}
}

*Category 1 AGE & cancer (severe)

gen age_cat_rai_severe=.
replace age_cat_rai_severe=0 if age<=19
replace age_cat_rai_severe=43 if age<=19 & cancer_rai_severe == 1

replace age_cat_rai_severe=2 if age>=20 & age<25
replace age_cat_rai_severe=43 if age>=20 & age<25 & cancer_rai_severe == 1

replace age_cat_rai_severe=4 if age>=25 & age<30
replace age_cat_rai_severe=43 if age>=25 & age<30 & cancer_rai_severe == 1

replace age_cat_rai_severe=6 if age>=30 & age<35
replace age_cat_rai_severe=44 if age>=30 & age<35 & cancer_rai_severe == 1

replace age_cat_rai_severe=9 if age>=35 & age<40
replace age_cat_rai_severe=44 if age>=35 & age<40 & cancer_rai_severe == 1

replace age_cat_rai_severe=11 if age>=40 & age<45
replace age_cat_rai_severe=44 if age>=40 & age<45 & cancer_rai_severe == 1

replace age_cat_rai_severe=13 if age>=45 & age<50
replace age_cat_rai_severe=44 if age>=45 & age<50 & cancer_rai_severe == 1

replace age_cat_rai_severe=15 if age>=50 & age<55
replace age_cat_rai_severe=44 if age>=50 & age<55 & cancer_rai_severe == 1

replace age_cat_rai_severe=18 if age>=55 & age<60
replace age_cat_rai_severe=44 if age>=55 & age<60 & cancer_rai_severe == 1

replace age_cat_rai_severe=20 if age>=60 & age<65
replace age_cat_rai_severe=45 if age>=60 & age<65 & cancer_rai_severe == 1

replace age_cat_rai_severe=22 if age>=65 & age<70
replace age_cat_rai_severe=45 if age>=65 & age<70 & cancer_rai_severe == 1

replace age_cat_rai_severe=25 if age>=70 & age<75
replace age_cat_rai_severe=45 if age>=70 & age<75 & cancer_rai_severe == 1

replace age_cat_rai_severe=27 if age>=75 & age<80
replace age_cat_rai_severe=45 if age>=75 & age<80 & cancer_rai_severe == 1

replace age_cat_rai_severe=29 if age>=80 & age<85
replace age_cat_rai_severe=45 if age>=80 & age<85 & cancer_rai_severe == 1

replace age_cat_rai_severe=31 if age>=85 & age<90
replace age_cat_rai_severe=46 if age>=85 & age<90 & cancer_rai_severe == 1

replace age_cat_rai_severe=34 if age>=90 & age<95
replace age_cat_rai_severe=46 if age>=90 & age<95 & cancer_rai_severe == 1

replace age_cat_rai_severe=36 if age>=95 & age<100
replace age_cat_rai_severe=46 if age>=95 & age<100 & cancer_rai_severe == 1

replace age_cat_rai_severe=38 if age>=100
replace age_cat_rai_severe=46 if age>=100 & cancer_rai_severe == 1

*Category 2 SEX

gen sex_score =.

replace sex_score = 0 // F is given 0
replace sex_score = 3 if female!=1 // Male is given 3


*Category 3 weight loss

generate weight_loss_rai = 0

foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace weight_loss_rai = 2 if (inlist(`var', "R634", "R636", "R64", "R627", "M6284") | inlist(`var', "M6250"))
}
}

*Category 4 poor appetite

generate poor_appetite_rai = 0

foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace poor_appetite_rai = 1 if (inlist(`var', "R630", "R6339", "R638", "R6330"))
}
}


*Category 5 renal failure

generate renal_failure_rai = 0

foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace renal_failure_rai = 3 if (inlist(`var', "N184", "N185", "N186", "I120", "I1311") | inlist(`var', "I132", "Z4901", "Z4902", "Z4931", "Z4932") | inlist(`var',"Z992", "Z9115"))
}
}


*Category 6 chf

generate chf_rai = 0

foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace chf_rai = 3 if (inlist(`var', "I501", "I5020", "I5021", "I5022", "I5023") | inlist(`var', "I5030", "I5031", "I5032", "I5033") | inlist(`var', "I5040", "I5041", "I5042", "I5043", "I50810") | inlist(`var', "I50811", "I50812", "I50813", "I50814", "I5082") | inlist(`var', "I5083", "I5084", "I5089", "I509") | inlist(`var', "I0981", "I110", "I130"))
}
}

*Category 7 shortness of breath

generate shortness_breath_rai = 0

foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace shortness_breath_rai = 2 if (inlist(`var', "R0600", "R0601", "R0602", "R0603", "R0609") | inlist(`var', "Z9981", "J9610", "J9611", "J9612"))
}
}

*Category 8 living status N/A - Excluded without adequate ICD codes available for crosswalk


*Category 9 ADL

generate cogn_decline_rai = 0

foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace cogn_decline_rai = 1 if (inlist(`var', "F0150", "F01511", "F01518", "F0280", "F02811") | inlist(`var', "F02818", "F0390", "F03911", "F03918") | inlist(`var', "F04", "G300", "G301", "G308", "G309") | inlist(`var', "G3101", "G3109", "G311", "G312", "G3181") | inlist(`var', "G3182", "G3183", "G3184", "G3185", "G3189") | inlist(`var', "G319", "R4181", "F1096", "F1027", "F1097") | inlist(`var', "F1327", "F1397", "F1897", "F1917", "F1927") | inlist(`var', "F1997"))
}
}


//Partially dependent 

generate partially_dependent_rai = 0

foreach num of numlist 1/40 { 
foreach var of varlist i10_dx`num' {
replace partially_dependent_rai = 1 if (inlist(`var', "G8100", "G8101", "G8102", "G8103", "G8104") | inlist(`var', "G8110", "G8111", "G8112", "G8113", "G8114") | inlist(`var', "G8190", "G8191", "G8192", "G8193", "G8194") | inlist(`var', "G8221", "G8222") | inlist(`var', "G8310", "G8311", "G8312", "G8313", "G8314") | inlist(`var', "G8320", "G8321", "G8322", "G8323", "G8324") | inlist(`var', "Z741", "Z742", "Z736", "Z9181", "R260") | inlist(`var', "R261", "R262", "R2681", "R269", "R54") | inlist(`var', "R531", "R5381", "R5382", "R5383", "R530") | inlist(`var', "M6281", "M623") | inlist(`var', "L89000", "L89001", "L89002", "L89003", "L89004") | inlist(`var', "L89006", "L89009", "L89010", "L89011", "L89012") | inlist(`var', "L89013", "L89014", "L89016", "L89019", "L89020") | inlist(`var', "L89021", "L89022", "L89023",  "L89024", "L89026") | inlist(`var', "L89029", "L89100", "L89101", "L89102", "L89103") | inlist(`var', "L89104", "L89106", "L89109", "L89110", "L89111") | inlist(`var', "L89112", "L89113", "L89114", "L89116", "L89119") | inlist(`var', "L89120", "L89121", "L89122", "L89123", "L89124") | inlist(`var', "L89126", "L89129", "L89130", "L89131", "L89132") | inlist(`var', "L89133", "L89134", "L89136", "L89139", "L89140") | inlist(`var', "L89141", "L89142", "L89143", "L89144", "L89146") | inlist(`var', "L89149", "L89150", "L89151", "L89152", "L89153") | inlist(`var', "L89154", "L89156", "L89159", "L89200", "L89201") | inlist(`var', "L89202", "L89203", "L89204", "L89206", "L89209") | inlist(`var', "L89210", "L89211", "L89212", "L89213", "L89214") | inlist(`var', "L89216", "L89219", "L89220", "L89221", "L89222") | inlist(`var', "L89223", "L89224", "L89226", "L89229", "L89300") | inlist(`var', "L89301", "L89302", "L89303", "L89304", "L89306") | inlist(`var', "L89309", "L89310", "L89311", "L89312", "L89313") | inlist(`var', "L89314", "L89316", "L89319", "L89320", "L89321") | inlist(`var', "L89322", "L89323", "L89324", "L89326", "L89329") | inlist(`var', "L8940", "L8941", "L8942", "L8943", "L8944") | inlist(`var', "L8945", "L8946", "L89500", "L89501", "L89502") | inlist(`var', "L89503", "L89504", "L89506", "L89509", "L89510") | inlist(`var', "L89511", "L89512", "L89513", "L89514", "L89516") | inlist(`var', "L89519", "L89520", "L89521", "L89522", "L89523") | inlist(`var', "L89524", "L89526", "L89529", "L89600", "L89601") | inlist(`var', "L89602", "L89603", "L89604", "L89606", "L89609") | inlist(`var', "L89610", "L89611", "L89612", "L89613", "L89614") | inlist(`var', "L89616", "L89619", "L89620", "L89621", "L89622") | inlist(`var', "L89623", "L89624", "L89626", "L89629", "L89810") | inlist(`var', "L89811", "L89812", "L89813", "L89814", "L89816") | inlist(`var', "L89819", "L89890", "L89891", "L89892", "L89893") | inlist(`var', "L89894", "L89896", "L89899", "L8990", "L8991") | inlist(`var', "L8992", "L8993", "L8994", "L8995", "L8996"))
}
}


//Totally dependent

generate totally_dependent_rai = 0

foreach num of numlist 1/40 {
foreach var of varlist i10_dx`num' { 
replace totally_dependent_rai = 1 if (inlist(`var', "Z7401", "Z7409", "Z743", "Z993", "R532") | inlist(`var', "Z9989", "G8250", "G8251", "G8252", "G8253") | inlist(`var', "G8254"))
}
}

//ADL

//without cogn decline
	
	generate adl_rai = 0
	replace adl_rai = 0 if cogn_decline_rai == 0
	replace adl_rai = 10 if cogn_decline_rai == 0 & partially_dependent_rai == 1
	replace adl_rai = 20 if cogn_decline_rai == 0 & totally_dependent_rai == 1


	//with cogn decline

	replace adl_rai = 9 if cogn_decline_rai == 1
	replace adl_rai = 15 if cogn_decline_rai == 1 & partially_dependent_rai == 1
	replace adl_rai = 21 if cogn_decline_rai == 1 & totally_dependent_rai == 1 

	
//Generate rai -- 
egen rai=rowtotal(age_cat_rai_severe sex_score weight_loss_rai poor_appetite_rai renal_failure_rai chf_rai shortness_breath_rai adl_rai)
sum rai
hist rai

//RAI categories
gen rai_cat = .
replace rai_cat=1 if rai<27 //Robust
replace rai_cat=2 if rai>=27 & rai<=35 //Normal
replace rai_cat=3 if rai>=36 & rai<=45 //Frail
replace rai_cat=4 if rai>45 //Very frail

label define rai_cat 1 "Robust" 2 "Normal" 3 "Frail" 4 "Very Frail", replace
label value rai_cat rai_cat
