import excel "C:\Users\Hunter\Documents\CapstoneRawData503.xlsx", sheet("Sheet0") firstrow

drop StartDate EndDate Status IPAddress Durationinseconds Finished RecordedDate RecipientLastName RecipientFirstName RecipientEmail ExternalReference LocationLatitude LocationLongitude DistributionChannel UserLanguage Response
drop Q25

keep if Progress==100
keep if Consent==1

drop if AY==.
rename S White
rename _1 Income
rename T Gender
rename Q6 Age
rename Q12 Senior
rename AY Eckel
rename Q32 PolPar


*White = 1, not White = 0
replace White = 0 if White == 1 | White == 2 | White == 3 | White == 4 | White == .
replace White = 1 if White == 5

*Male = 1, not Male = 0
replace Gender = 0 if Gender == 2

*Senior = 1, Not Senior = 0
replace Senior = 0 if Senior == 1 | Senior == 2 | Senior == 3
replace Senior = 1 if Senior == 4

*Political Party Spectrum.  1 = Democrat 2 = Republican 3 = Neither
replace PolPar = 1 if Q41 == 1
replace PolPar = 2 if Q41 == 2

gen Republican = PolPar ==2
gen Democrat = PolPar ==1



*Replacing Correct Answers with 1, 0 for Incorrect
replace Q34 = 0 if Q34 == 2 | Q34 == 3 | Q34 == 4 | Q34 == .
replace Q35 = 0 if Q35 == 2 | Q35 == 3 | Q35 == 4 | Q35 == .
replace Q36 = 0 if Q36 == 1 | Q36 == 2 | Q36 == 4 | Q36 == .
	replace Q36 = 1 if Q36 == 3
replace Q37 = 0 if Q37 == 2 | Q37 == 3 | Q37 == 4 | Q37 == .
replace Q38 = 0 if Q38 == 1 | Q38 == 3 | Q38 == 4
	replace Q38 = 1 if Q38 == 2
replace Q11 = 0 if Q11 == 1 | Q11 == 2 | Q11 == 4 | Q11 == 5 | Q11 == .
	replace Q11 = 1 if Q11 == 3
replace Q13 = 0 if Q13 == 2 | Q13 == 3 | Q13 == 4 | Q13 == 5 | Q13 == .
replace Q14 = 0 if Q14 == 1 | Q14 == 3 | Q14 == 4 | Q14 == 5 | Q14 == .
	replace Q14 = 1 if Q14 == 2
replace Q15 = 0 if Q15 == 1 | Q15 == 3 | Q15 == 4 | Q15 == 5 | Q15 == .
	replace Q15 = 1 if Q15 == 2
replace Q16 = 0 if Q16 == 1 | Q16 == 2 | Q16 == 4 | Q16 == .
	replace Q16 = 1 if Q16 == 3
replace Q17 = 0 if Q17 == 1 | Q17 == 2 | Q17 == 4 | Q17 == .
	replace Q17 = 1 if Q17 == 3
replace Q18 = 0 if Q18 == 1 | Q18 == 3 | Q18 == 4 | Q18 == .
	replace Q18 = 1 if Q18 == 2
replace Q19 = 0 if Q19 == 1 | Q19 == 3 | Q19 == .
	replace Q19 = 1 if Q19 == 2
replace Q20 = 0 if Q20 == 2 | Q20 == 3 | Q20 == .
replace Q21 = 0 if Q21 == 1 | Q21 == 3 | Q21 == .
	replace Q21 = 1 if Q21 == 2
replace Q22 = 0 if Q22 == 2 | Q22 == 3 | Q22 == 4 | Q22 == .
replace Q23 = 0 if Q23 == 1 | Q23 == 3 | Q23 == 4 | Q23 == 5 | Q23 == .
	replace Q23 = 1 if Q23 == 2
replace Q24 = 0 if Q24 == 1 | Q24 == 2 | Q24 == 3 | Q24 == 4 | Q24 == .
	replace Q24 = 1 if Q24 == 5
replace Q26 = 0 if Q26 == 2 | Q26 == 3 | Q26 == 4 | Q26 == .
replace Q27 = 0 if Q27 == 1 | Q27 == 3 | Q27 == 4 | Q27 == 5 | Q27 == .
	replace Q27 = 1 if Q27 == 2
replace Q28 = 0 if Q28 == 1 | Q28 == 2 | Q28 == 3 | Q28 == 5 | Q28 == .
	replace Q28 = 1 if Q28 == 4
	
gen Score = Q34 + Q35 + Q36 + Q37 + Q38 + Q11 + Q13 + Q14 + Q15 + Q16 + Q17 + Q18 + Q19 + Q20 + Q21 + Q22 + Q23 + Q24 + Q26 + Q27 + Q28
gen Percentage = Score/21

regress Eckel Score, r
regress Score White Gender Income Age Senior Democrat Republican, r
*should i try ln income?
*Does PolPar make sense?
regress Eckel Score White Gender Income Age Senior Democrat Republican, r
regress Eckel White Gender Income Age Senior Democrat Republican, r

rename Gender Male
