# --- Rakendustarkvara R
# --- II praktikum ----


# --- 1. Väärtuste tüübid ----

kaalud <- c(7, 3.5, 0.4, 2, 3.2, 20.2)
liik <- c("koer", "kass", "rott", "kass", "kass", "koer")
vanused <- c(7, NA, 3, 53, 53, 95)

# Kontrollimem väärtuste tüüpe
is.integer(kaalud)
is.numeric(kaalud)

class(liik)
class(vanused)
is.na(vanused)

# ---- ÜL 1.0.1 ----

# 1.  
month.name
x <- c(0:5, "tekst", "T", 234.5, "234,5")
x

# Kas on sõned?
is.character(____)
is.character(____)

# Proovi arvuks teisendada: as.numeric()
as.numeric(____) 
as.numeric(____)



# 2.
# Miks on tulemused erinevad?
is.integer(1:4)
is.integer(c(1, 2, 3))


# 3.
# Kas tulemus on oodatav?
z <- c("a", "NA", NA, 0)
is.na(z)


 
# --- 1.1 Tõeväärtused ja tõeväärtusvektorid ----

# Tõeväärtusvektori tekitamiseks piisab vektori kontrollimist mõne väärtusega
kaalud > 10
vanused == 53
liik == "kass"
vanused == kaalud
liik == "kass" | liik == "koer"

# Kui soovime mingit väärtust võrrelda NA-ga, siis järgnev kahjuks ei tööta
vanused == NA

# Puuduvaid väärtusi saab kontrollida funktsiooniga is.na()
is.na(vanused)

# Kui on vaja kontrollida kas ming väätus leidub etteantud hulgas:
1:4 %in% c(2, 5)

c(2, 5) %in% 1:4

# Tõeväärtusi saab kasutada arvutustel, sellisel juhul konverteeritakse tõeväärtused TRUE => 1, FALSE => 0.
is.na(vanused) * 1
sum(is.na(vanused))


# ---- ÜL 1.1.1 ----
# 1.
x <- c(__, __, __, __, __)
x
as.numeric(x)
# Mis sai NA-st?

# 2.
?as.logical
# Kontrolli
nr <- c(-3, -1/3, 0, 1, 2, Inf, -Inf, NA, NaN, 1:4)
as.logical(nr)


# 3.  
NA | FALSE
NA | TRUE

NA & FALSE
NA & TRUE

!NA 


# 4.
as.integer(c("tere", 0, 1, TRUE, FALSE)) 
as.integer(c(        0, 1, TRUE, FALSE))
# Miks on tulemused erinevad?


# LISA

# Mis tekst teisendub loogikaväärtuseks?
# vt  
?logical
#  c("T", "TRUE", "True", "true") are regarded as true,
#  c("F", "FALSE", "False", "false") as false
# Kontrolli
tekst <- c("T", "TRUE", "True", "true", "F", "FALSE", "False", "false", "skljgsdfj", "TRue", "truE", "fals", "FAlse")
as.logical(tekst)
 



# --- 2. Andmestik, andmete import ----

# --- 2.1 Andmete sisselugemine ja faili kirjutamine (tekstifail) ----

# Töökataloogi paika seadmine
# Windowsis kaustade struktuuri tähistamiseks kasutada tagurpidi kaldkriipsu "\" (backward slash),
# kuid R-is on sellel oma tähendus, seega tuleb kasutada "\\"
setwd("C:\\Users\\mina\\Rkursus\\")

# Aga võib kasutada ka tavalist kaldkriipsu "/" (forward slash)
setwd("C:/Users/mina/Rkursus/")

# RStudios saab töökataloogi ka automaatselt seada käesoleva skripti asukoha järgi
# vt. faili "RStudio snipetid"   

# Näide andmete sisselugemisest
näide1 <- read.table("https://github.com/Rkursus/2021/raw/master/data/esimene.txt",
                     header = T, sep = "\t", dec = ",")

# Tulemused saab kirjutada faili käsuga write.table()
write.table(näide1, "failinimi.txt", sep = "\t")



# --- ÜL 2.1.1 ----

# 1.
?read.table


# 2. 
tab1 <- read.table("https://github.com/Rkursus/2021/raw/master/data/____", ____)

tab2 <- read.table("https://github.com/Rkursus/2021/raw/master/data/____", ____)

tab3 <- read.table("https://github.com/Rkursus/2021/raw/master/data/____", ____)

tab4 <- read.table("https://github.com/Rkursus/2021/raw/master/data/____", ____)

tab1;tab2;tab3;tab4

 

# 3.
andmed <- read.table(____)

# ülevaate saamine andmstikust, kontroll
str(andmed)







# --- 2.2 Esmase ülevaate saamine andmetabelist ----
str(andmed)
summary(andmed)
dim(andmed)
ncol(andmed)
nrow(andmed)
names(andmed)
head(andmed)






# --- 2.3 Lisapakettide kasutamine ----
install.packages("readxl")
install.packages("haven")
# pakett  readxl -  MS Excel'i failide importimiseks
# pakett  haven -   SAS, SPSS, Stata failide impordiks(ka neisse formaatidesse salvestamiseks)

# lisapaketi aktiveerimine
library(readxl)



# --- 2.4 Andmete import programmide MS Excel, SAS, Stata, SPSS failidest ----

# --- 2.4.1 MS Excel failid (.xls, .xlsx) ----

# salvesta MS Exceli fail "tudengite-arv.xlsx" aadressilt https://github.com/Rkursus/2021/tree/master/data oma töökausta

list.files()   # vaata, mis nimega failid on töökaustas
excel_sheets("tudengite-arv.xlsx")   # töölehtede nimed MS Exceli failis
AY <- read_excel("tudengite-arv.xlsx", sheet = "avatud ylikool")   # importimine
# AY <- read_excel("tudengite-arv.xlsx", sheet = 2)  # sama, töölehe nime asemel järjekorranumber
str(AY)  # vaata tulemust


# MS Exceli andmetabel ei pruugi alata kohe esimesest tabelireast (argument 'skip'):
tabel <- read_excel("tudengite-arv.xlsx", sheet = "tabel", skip = 2)
str(tabel)




# ---  2.4.2 SAS, SPSS, Stata failide imoport ----

# salvesta aadressilt https://github.com/Rkursus/2021/tree/master/data oma töökausta failid:
# "effort.sas7bdat"  - SAS andmefail
# "effort.dta" - Stata fail
# "effort.sav" - SPSS fail  


# vajaliku lisapaketi aktiveerimine
library(haven)

# andmestike import
andmestik_SAS <- read_sas("effort.sas7bdat")
andmestik_Stata <-  read_stata("effort.dta")
andmestik_SPSS <- read_spss("effort.sav")

# imporditud andmestike ülevaatamine
str(andmestik_SAS)
str(andmestik_Stata)
str(andmestik_SPSS)

# nii SAS, SPSS kui ka Stata andmestikes saab tunnusenimedele lisada nn silte(ik label), 
# need on näha kui avada andmestikud RStudio tabelivaates, näiteks
View(andmestik_SAS)


# NB!
# antud paketis on olemas ka käsud R-i andmetabelite ekspordiks SAS, SPSS, Stata andmefailiks
# käsud write_<...> ei pruugi siiski olla 100% töökindlad!
# näiteks write_sas() käsu tulemust uuem SAS omaks ei tunnista 
 

# ---- ÜL 2.4.3 ----
# 1.
# vaata esmalt abifaili
?read_excel

# NB! imporditaval töölehel pole veergudel päist, kuidas need ette anda?
kokku <- read_excel(____)
str(kokku)



