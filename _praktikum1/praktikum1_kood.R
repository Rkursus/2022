# --- Rakendustarkvara R
# --- I praktikum ----


# Palun loe siintoodud koodi kõrvale ka praktikumimaterjalide tekst läbi.



# --- 1. Sissejuhatus ----

# --- 1.1 Kasutajaliidesed ----

# --- 1.1.1 Programm R ise ----
# Tutvu programmi R graafilise kasutajaliidesega

# --- 1.1.2 R-i kasutamine RStudio kaudu
# Tutvu RStudio kasutajaliidesega, kuhu kirjutada kood, kuhu ilmuvad vastused?
# Kust saab ülevaate hetkel R-i mälus toimuvast?
# Kuhu saab otsida abi? Kuhu ilmuvad pildid?


# --- proovi läbi mõned tehted 
4 * 6
3 + 5  + (23 - 67)*4
4 * (1:40)
5*6 ; 7 + 8  # kaks käsku ühel rael eraldada semikooloniga
log(5.9)  # kümnendmurru eraldamiseks kasutatakse R-is punkti 




# --- 1.2 Näited alapunktist: Lihtsam aritmeetika
1 + (2 - 3) * 4/5
2 ^ 3 - 2 ** 3
5 %% 3
log(exp(1)) * cos(-pi) * sqrt(9) + factorial(4) - choose(4, 2) * min(4, 5, 2)
1 / 0
0/0  # NaN ehk Not a Number, määramatus
-Inf 

## --- ÜL 1.2.1 KMI arvutamine ----





# --- 1.3 Käsud ja abi saamine ----
choose(4, 2)
choose(n = 4, k = 2)  
choose(k = 2, n = 4)
choose(2, 4)   # kui argumentide nimesid mitte kasutada, siis on oluline argumentide järjekord

# käskudel võivad olla vaikimisi väärtustega argumente
log(5)            # funktsioonil on vaikimisi määratud logaritmi alus 2.718...(Euleri arv), leitakse naturaallogaritm
log(8, base = 2)  # kui vaja leida logaritm alusel 2, peab argumendi 'base' väärtust muutma


?choose
help(choose)

??"logarithm"

# NB!  R teeb vahet suurtel ja väiksetel tähtedel, proovi:
Log(5)
log(5)

log(8, BASE = 2)
log(8, base = 2)


# ---- ÜL 1.3.1 ----
# 1 abiakna avamine


# 2  aritmeetilised tehted, tehtesümboli kohta abi küsimuseks panna see jutumärkidesse
?"*"

# 3 siinuse leidmiseks funktsioon: sin







# --- 2. Muutujad ----

# --- 2.1 väärtuse omistamine muutujale ----
kaal <- 80  
pikkus <- 1.72

kaal # muutuja väärtuse vaatamine

kaal/pikkus ^ 2  # muutujate kasutamine tehtes

ls()  # millised muutujanimed on juba kasutusse võetud?

rm(kaal, pikkus)  # eemaldame muuutujad kaal ja pikkus 
ls()  # nüüd peaks töölaud tühi olema








# --- 2.2 Vektorid ----
kaalud <- c(7, 3.5, 0.4, 2, 3.2, 20.2)
liik <- c("koer", "kass", "rott", "kass", "kass", "koer")


# vektori elemendid peavad olema sama tüüpi, arve ja teksti miksides saame tulemuseks tekstivektori
c(987, -Inf, "tekst", kaalud)

kaalud*1000  # tehted vektoriga tehakse elemendiviisi
c(987, -Inf, "tekst", kaalud)*3  #  aga tekstidega ei saa arvutusi teha



# kindla mustriga vektorite moodustamine

# jada täisarvudest sammuga 1, kasvav või kahanev
1:5 
2:-6

# Üldisem jada, ette anda algus ja lõpp ning samm või vektori pikkus
seq(from = 2, to = 30, by = 2)
seq(from = 20, to = 4, by = 0.2)
seq(3, 40, length.out = 10)

# korduvate elementidega jadad
rep(x = 1:4, times = 3)
rep(x = 1:4, each = 3)
rep(x = 1:4, times = c(2, 1, 1, 5))


# tehted tehakse elemendiviisi
1:5 + c(3, 4, 5, 2, 6)

# ettevaatust: lühemat vektorit 'taaskasutatakse'
1:4 + 1:2
1:4 + c(1:2, 1:2)

# 'taaskasutus',  kui pikema vektori elementide arv ei ole lühema vektori elementide arvu täisarv kordne
1:5 + 1:2



# elementide valik vektorist
kaalud[1:3]           # esimesed 3 elementi vektorist
kaalud[seq(1, 6, 2)]  # iga teine element alates esimesest
(1:10)[-c(2, 4)]      # negatiivne indeks jätab vastavad vaatlused välja





# ---- Ül 2.2.1 ----
# 1
y <- rep(____)
y

# 2
z <- ____
z
y + z

# 3 
length(z) # mitu elementi on vektoris z? 
z[___] 

#4  Tehte järjekord! 
u <- 8
1:u - 1 
1:(u - 1)


 




# --- 2.3 Puuduvad väärtused ----
vanused <- c(7,  , 3, 53, 53, 95) # veateade: vektorisse ei saa jätta täitmata kohta


vanused <- c(7, NA, 3, 53, 53, 95) # puuduva väärtuse tähis NA
vanused

# kui tehtes tulevad mängu puuduvad väärtused on tulemuseks: puuduv väärtus
123 + NA

round(vanused/12, 1)


# erinevatel funktsioonidel erinevad võimalused puuduvate väärtustega toimetulekuks
mean(vanused)
mean(vanused, na.rm = TRUE)

table(vanused)
table(vanused)
table(vanused, useNA = "ifany")
table(vanused, useNA = "always")
table(liik, useNA = "always")

summary(vanused)



# ---- ÜL 2.3.1 ----
#1 
sum(____)


#2 
?which.min 


# --- LISA: Kasutajaliidesest veel ---

# Seadistame RStudio-t:
## Pane paika kodeerimine (ingl. k. encoding), et RStudio ka täpitähte (õäöü) tunnistaks.
## Tools -> Global Options -> Code -> Savings -> Default text encoding (vali "UTF-8" kui seal on midagi muud)
## 
## Lisaks saab seadistada värve ja väljanägemist
## Tools -> Global Options -> Appearence

# Kas sul tekkis korraks küsimus, miks on kogu eelnev kood just nii kirjutatud?
# Kuidas on kommentaarid kirjutatud? Miks on mõnede kommentaaride ridade ees ja järel '---'?
# Proovi RStudios vajutada alla suunatud kolmnurka, mis on mõne kommentaarirea ees. Mis juhtus?
# R script akna paremal üleval nurgas on üks nupp (näeb välja nagu sisukorra read), vajuta seda. Mida näed?

# Veel mõned soovitused:

# Tihedamini kasutatavad koodijupid tasuks seadistada 'snippet'-ks
# Tools -> Global Options -> Code -> Editing -> Edit snippets
#
# Näide: Hakka script aknasse kirjutama 'function' ja vajuta Tab klahvi. Mis juhtus?
#
# Selekteeri alumised 3 rida ja vajuta Ctrl+Shift+A. Mis juhtus?
if(!exists("x")){
  x=c(3,5)
  y=x[2]}


