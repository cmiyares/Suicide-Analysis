* Suicide Project;
*importing data;
proc import datafile= '/folders/myfolders/sas programs/suicide.csv'
	out = suicide
	dbms= csv
	replace;
	run;
	
*making new data set;


data male35t54;
drop HDI_for_year generation population country_year;
	set suicide;
	if(age = "35-54 years"& sex="male") then output;
run;


data female35t54;
drop HDI_for_year generation population country_year;
	set suicide;
	if(age = "35-54 years" & sex = "female")then output;
run;

data maleFemaleUs;
set male35t54 female35t54;
run;


proc corr data = male35t54 pearson;
var suicides_no year;
run;

proc reg data = male35t54;
model suicides_100k_pop = year;
run;

proc corr data = female35t54 pearson;
var suicides_no year;
run;

proc reg data = female35t54;
model suicides_100k_pop = year;
run;

* - - - - - - - - - - - - - - - - - - - - - - - - - - - - -;
*END US DATA;

*----------------------------------------------------------;

* start of with pearson for each country;
*importing whole data set;


proc import datafile= '/folders/myfolders/sas programs/suicidecomplete.csv'
	out = data 
	dbms= csv
	replace;
	run;
proc import datafile= '/folders/myfolders/sas programs/suicideuk.csv'
	out = uk 
	dbms= csv
	replace;
	run;
	
data UK;
set uk;
if(age = "35-54 years");
drop HDI_for_year generation population country_year;
run;

data fullData1;
length country $ 14;
set data;
drop HDI_for_year generation population country_year;
if((country ="Austria" | country ="Belgium" |
country ="Czech R" | country ="France" | country ="Germany" |
country ="Ireland" | country ="Luxembo" |
country ="Netherl" | country ="Switzer"| country ="Denmark"
|country ="Finland"| country ="Iceland"| country ="Norway"
|country ="Sweden") & age = "35-54 years") then output;
run;


data fullData2;
set fullData1 UK;
run;

* Data did not include Liechtenstein or Monaco;

*SIMPLE REGRESSION;



*UNITED STATES;
proc corr data = male35t54 pearson;
var suicides_no year;
run;

*strong positive linear correlation between time and suicide;
proc reg data = male35t54;
model suicides_100k_pop = year;
run;
* a bit less strong but strong nonetheless;
proc reg data = female35t54;
model suicides_100k_pop = year;
run;

proc corr data = female35t54 pearson;
var suicides_no year;
run;

*strong positive linear correlation between time and suicide;
proc reg data = female35t54;
model suicides_no = year;
run;
* not as strong which means there is a strong correlation but not in masses like men;
proc reg data = female35t54;
model suicides_100k_pop = year;
run;

* WESTERN AND NOTHERN EUROPE;
* female groups;
data austriafem;
set fullData2;
if(country = "Austria" & sex ="female" & year <2016) then output;
run;

data belfem;
set fullData2;
if(country = "Belgium" & sex ="female" & year <2016) then output;
run;

data czechfem;
set fullData2;
if(country = "Czech R" & sex ="female" & year <2016) then output;
run;
data frenchfem;
set fullData2;
if(country = "France" & sex ="female" & year <2016) then output;
run;
data germfem;
set fullData2;
if(country = "Germany" & sex ="female" & year <2016) then output;
run;

data irefem;
set fullData2;
if(country = "Ireland" & sex ="female" & year <2016) then output;
run;

data luxfem;
set fullData2;
if(country = "Luxembo" & sex ="female" & year <2016) then output;
run;

data netherfem;
set fullData2;
if(country = "Netherl" & sex ="female" & year <2016) then output;
run;

data switzfem;
set fullData2;
if(country = "Switzer" & sex ="female" & year <2016) then output;
run;

data denfem;
set fullData2;
if(country = "Denmark" & sex ="female" & year <2016) then output;
run;

data finfem;
set fullData2;
if(country = "Finland" & sex ="female" & year <2016) then output;
run;

data icefem;
set fullData2;
if(country = "Iceland" & sex ="female" & year <2016) then output;
run;

data norfem;
set fullData2;
if(country = "Norway" & sex ="female" & year <2016) then output;
run;

data swedfem;
set fullData2;
if(country = "Sweden" & sex ="female" & year <2016) then output;
run;

data britfem;
set fullData2;
if(country = "UK" & sex ="female" & year <2016) then output;
run;
* ------------------------------------------------------------------------;
*SIMPLE LIN FEMALE IN EUROPE;

*austria;
proc corr data = austriafem pearson;
var suicides_100k_pop year;
run;

proc reg data = austriafem;
model suicides_100k_pop = year;
run;

*belgium not a good model;
proc corr data = belfem pearson;
var suicides_100k_pop year;
run;

proc reg data = belfem;
model suicides_100k_pop = year;
run;

*czech republic;
proc corr data = czechfem pearson;
var suicides_100k_pop year;
run;

proc reg data = czechfem;
model suicides_100k_pop = year;
run;

* france;
proc corr data = frenchfem pearson;
var suicides_100k_pop year;
run;

proc reg data = frenchfem;
model suicides_100k_pop = year;
run;

*germany;
proc corr data = germfem pearson;
var suicides_100k_pop year;
run;

proc reg data = germfem;
model suicides_100k_pop = year;
run;

*Ireland r square too small not good;
proc corr data = irefem pearson;
var suicides_100k_pop year;
run;

proc reg data = irefem;
model suicides_100k_pop = year;
run;
*Luxembourg not a good model;
proc corr data = luxfem pearson;
var suicides_100k_pop year;
run;

proc reg data = luxfem;
model suicides_100k_pop = year;
run;
*netherland not a good model;
proc corr data = netherfem pearson;
var suicides_100k_pop year;
run;

proc reg data = netherfem;
model suicides_100k_pop = year;
run;
*switzerland;
proc corr data = switzfem pearson;
var suicides_100k_pop year;
run;

proc reg data = switzfem;
model suicides_100k_pop = year;
run;
*denmark;
proc corr data = denfem pearson;
var suicides_100k_pop year;
run;

proc reg data = denfem;
model suicides_100k_pop = year;
run;
*Finland;
proc corr data = finfem pearson;
var suicides_100k_pop year;
run;

proc reg data = finfem;
model suicides_100k_pop = year;
run;
*Iceland not a good model;
proc corr data = icefem pearson;
var suicides_100k_pop year;
run;

proc reg data = icefem;
model suicides_100k_pop = year;
run;
*Norway not a good model;
proc corr data = norfem pearson;
var suicides_100k_pop year;
run;

proc reg data = norfem;
model suicides_100k_pop = year;
run;
*sweden;
proc corr data = swedfem pearson;
var suicides_100k_pop year;
run;

proc reg data = swedfem;
model suicides_100k_pop = year;
run;
*UK not a good model;
proc corr data = britfem pearson;
var suicides_100k_pop year;
run;

proc reg data = britfem;
model suicides_100k_pop = year;
run;

* MALE GROUPS;
data austriamale;
set fullData2;
if(country = "Austria" & sex ="male" & year <2016) then output;
run;

data belmale;
set fullData2;
if(country = "Belgium" & sex ="male" & year <2016) then output;
run;

data czechmale;
set fullData2;
if(country = "Czech R" & sex ="male" & year <2016) then output;
run;
data frenchmale;
set fullData2;
if(country = "France" & sex ="male" & year <2016) then output;
run;
data germmale;
set fullData2;
if(country = "Germany" & sex ="male" & year <2016) then output;
run;

data iremale;
set fullData2;
if(country = "Ireland" & sex ="male" & year <2016) then output;
run;

data luxmale;
set fullData2;
if(country = "Luxembo" & sex ="male" & year <2016) then output;
run;

data nethermale;
set fullData2;
if(country = "Netherl" & sex ="male" & year <2016) then output;
run;

data switzmale;
set fullData2;
if(country = "Switzer" & sex ="male" & year <2016) then output;
run;

data denmale;
set fullData2;
if(country = "Denmark" & sex ="male" & year <2016) then output;
run;

data finmale;
set fullData2;
if(country = "Finland" & sex ="male" & year <2016) then output;
run;

data icemale;
set fullData2;
if(country = "Iceland" & sex ="male" & year <2016) then output;
run;

data normale;
set fullData2;
if(country = "Norway" & sex ="male" & year <2016) then output;
run;

data swedmale;
set fullData2;
if(country = "Sweden" & sex ="male" & year <2016) then output;
run;

data britmale;
length country $14;
set fullData2;
if(country = "UK" & sex ="male" & year <2016) then output;
run;

*SIMPLE LIN MALE IN EUROPE;

*austria;
proc corr data = austriamale pearson;
var suicides_100k_pop year;
run;

proc reg data = austriamale;
model suicides_100k_pop = year;
run;

*belgium not a good model;
proc corr data = belmale pearson;
var suicides_100k_pop year;
run;

proc reg data = belmale;
model suicides_100k_pop = year;
run;

*czech republic;
proc corr data = czechmale pearson;
var suicides_100k_pop year;
run;

proc reg data = czechmale;
model suicides_100k_pop = year;
run;

* france;
proc corr data = frenchmale pearson;
var suicides_100k_pop year;
run;

proc reg data = frenchmale;
model suicides_100k_pop = year;
run;

*germany;
proc corr data = germmale pearson;
var suicides_100k_pop year;
run;

proc reg data = germmale;
model suicides_100k_pop = year;
run;

*Ireland;
proc corr data = iremale pearson;
var suicides_100k_pop year;
run;

proc reg data = iremale;
model suicides_100k_pop = year;
run;
*Luxembourg not a good model;
proc corr data = luxmale pearson;
var suicides_100k_pop year;
run;

proc reg data = luxmale;
model suicides_100k_pop = year;
run;
*netherland;
proc corr data = nethermale pearson;
var suicides_100k_pop year;
run;

proc reg data = nethermale;
model suicides_100k_pop = year;
run;
*switzerland;
proc corr data = switzmale pearson;
var suicides_100k_pop year;
run;

proc reg data = switzmale;
model suicides_100k_pop = year;
run;
*denmark;
proc corr data = denmale pearson;
var suicides_100k_pop year;
run;

proc reg data = denmale;
model suicides_100k_pop = year;
run;
*Finland;
proc corr data = finmale pearson;
var suicides_100k_pop year;
run;

proc reg data = finmale;
model suicides_100k_pop = year;
run;
*Iceland not a good model;
proc corr data = icemale pearson;
var suicides_100k_pop year;
run;

proc reg data = icemale;
model suicides_100k_pop = year;
run;
*Norway;
proc corr data = normale pearson;
var suicides_no year;
run;

proc reg data = normale;
model suicides_100k_pop = year;
run;
*sweden;
proc corr data = swedmale pearson;
var suicides_100k_pop year;
run;

proc reg data = swedmale;
model suicides_100k_pop = year;
run;
*UK not a good model;
proc corr data = britmale pearson;
var suicides_100k_pop year;
run;

proc reg data = britmale;
model suicides_100k_pop = year;
run;

*MULTIPLE REGRESSION;

* combing all of the variables for both male and female and then dividing by country and age and year;

data comboAllCountries;
length country $ 15;
set austriafem belfem czechfem frenchfem germfem
irefem luxfem netherfem switzfem denfem finfem icefem norfem
swedfem austriamale belmale czechmale frenchmale germmale
iremale luxmale nethermale switzmale denmale finmale icemale normale
swedmale britmale britfem male35t54 female35t54;
run;


proc glmselect data=comboAllCountries;
class country;
model suicides_100k_pop= country year / selection=stepwise showpvalues;
run;

* new model keeping significant variables;

data combo1;
set austriafem austriamale belfem belmale czechfem czechmale finfem
finmale frenchfem frenchmale;
run;

proc glm data=combo1;
class country;
model suicides_100k_pop= country year;
run;

* new model that adds sex as a factor;

proc glmselect data=comboAllCountries;
class country sex;
model suicides_100k_pop = country year sex / selection= stepwise showpvalues;
run;

* new model with different variables male variable was taken out but I will include it 
seprately;

data combo2;
set austriafem belfem czechfem finfem
 frenchfem luxfem netherfem swedfem switzfem ;
run;

* strongest model so far. Female suicide has been dropping in western and nothern europe.;
proc glm data=combo2;
class country;
model suicides_100k_pop = country year;
run;

*now an all male model;

data combo3;
length country $ 15;
set  austriamale belmale czechmale frenchmale germmale
iremale luxmale nethermale switzmale denmale finmale icemale normale
swedmale britmale male35t54;
run;

proc glmselect data=combo3;
class country;
model suicides_100k_pop = country year / selection= stepwise showpvalues;
run;

data combo4;
length country $ 15;
set  austriamale belmale czechmale frenchmale;
run;


proc glmselect data = combo4;
class country;
model suicides_100k_pop = country year /selection=stepwise showpvalues;
run;

* this model is decent but not great;
proc glm data = combo4;
class country;
model suicides_100k_pop = country year;
run;






