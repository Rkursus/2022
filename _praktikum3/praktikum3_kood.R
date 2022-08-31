# --- Rakendustarkvara R
# --- III praktikum ----



# --- 1. Toimingud andmestikuga ----

# Andmestik
andmed <- read.table("https://github.com/Rkursus/2021/raw/master/data/mass.txt",
                     header = T, sep = "\t")
str(andmed)
head(andmed)


# --- 1.1 Veergude ja ridade eraldamine andmestikust: indeksi ja nime järgi ----

# Andmestikus ainult ühe veeru uurimiseks kasutame dollari-sümbolit
vanused <- andmed$AGEP
median(andmed$AGEP)
median(vanused)

# data.frame on kahemõõtmeline tabel, seega iga elemendi asukoht on määratud rea ja veeru numbriga
# Rea- ja veerunumbrite abil andmestikust infot eraldades tuleb kasutada kantsulgusid:

andmed[3, 2] # kolmas rida, teine veerg
andmed[ , 2] # kogu teine veerg
andmed[3, ] # kogu kolmas rida

# Korraga on võimalik eraldada ka mitut rida või veergu, kasutades selleks käsku c(.):

andmed[, c(2, 4)] # teine ja neljas veerg
valik <- c(2, 4) # tekitame objekti, milles on kirjas huvipakkuvate veergude numbrid
andmed[, valik] # kasutame seda objekti andmestikust veergude eraldamiseks
andmed[c(5, 3, 9), ] # viies, kolmas ja üheksas rida

# Tihti on veeruindeksite asemel mugavam kasutada veergude nimesid (peavad olema jutumärkides):
andmed[, c("AGEP", "WAGP")] # eraldame veerud "AGEP" ja "WAGP"

# Kui andmestikus on ka ridadel nimed, siis saab neid sama moodi kasutada ridade eraldamisel
# Esmalt lisame oma andmestikule reanimed:

rownames(andmed) <- paste("rida", rownames(andmed), sep = "-") # paneme ise nimed kujul 'rida-jrk'
head(andmed[, 5:9]) # vaatame milline on tulemus
andmed[c("rida-23", "rida-62"), 5:9] # eraldame read 23 ja 62


# --- 1.1.1 Uue tunnuse lisamine ----

# Uue tunnuse lisamiseks tuleb valida uus tunnuse nimi ja omistada väärtused
andmed$kuusissetulek <- andmed$WAGP/12
# või
andmed[, "kuusissetulek"] <- andmed$WAGP/12
str(andmed)

# --- 1.2 Veergude ja ridade eraldamine andmestikust: tõeväärtusvektori abil ----

# Eraldame kõik read, kus SEX == "Male" ning salvestame selle uueks objektiks
mehed <- andmed[andmed$SEX == "Male", ]

# Moodustame kaks filtritunnust ja kombineerime need alagrupi valikuks
filter_kod <- andmed$CIT == "Not a citizen of the U.S." # mittekodanikud
filter_vanus <- andmed$AGEP >= 80 # vähemalt 80 aastased
alamandmestik <- andmed[filter_kod & filter_vanus, ] # Ära unusta: [read, veerud]

# Tõeväärtusvektoreid saab kasutada ka veergude eraldamiseks
onMAR <- startsWith(names(andmed), "MAR")
# või
#onMAR <- substr(names(andmed), 1, 3) == "MAR"
abielu <- andmed[, onMAR]
str(abielu)



# --- ÜL 1.2.1 ----

# 1. iga viies rida valida
valik5 <- andmed[_____,_____]

# 2. valida välja need, kel MIG-tunnuse väärtus pole teada
table(andmed$MIG)
osa <- andmed[____,____]
str(osa)
summary(osa)


# --- 1.3 Lihtsam kirjeldav statistika ----

# vt. loetelu praktikumi materjalidest

# Sagedustabeli saab käsu table() abil:
sagedustabel <- table(andmed$SEX, andmed$LANX)
sagedustabel / rowSums(sagedustabel) #proovi, mis juhtub, kui kasutada /colSums(.)

# Sagedustabeli põhjal protsentide arvutamiseks (jaotustabeli arvutamiseks) saab kasutada käsku prop.table(.):
prop.table(sagedustabel) # ühisjaotus
prop.table(sagedustabel, margin = 1) # iga rida kokku 1 (ehk 100%)
prop.table(sagedustabel, margin = 2) # iga veerg kokku 1 (ehk 100%)



# --- ÜL 1.3.1 ----

# 1. mehed %


# 2. aastapalga 0.8 kvantiil
quantile(_____)


# 3. lahutatute oskaal, mehed vs naised
table(andmed$MAR)

prop.table(____)


# 4. mitu üle 74-aastast naist on doktorikraadiga
table(andmed$SCHL)



# 5. mitmel doktori, magistri, baka kraad



# 6. keskmine aastapalk mehed vs naised



# 7. sama arvutus, aga valikandmestikus (valik5)





# --- 1.4 Faktortunnus ----
# loeme andmestiku uuesti sisse, tekitades faktor-tunnused
andmed1 <- read.table("https://github.com/Rkursus/2021/raw/master/data/mass.txt", 
                      header = T, sep = "\t", stringsAsFactors = T)
# tekitame uuesti alamandmestiku
mehed1 <- andmed1[andmed1$SEX == "Male",]  

# Faktortunnuse tasemete teada saamiseks kasutatakse käsku levels(.).
levels(mehed1$SEX)

# Sealjuures ei pruugi kõiki faktori väärtustasemeid antud andmetes üldse esineda:
table(mehed1$SEX)

# Faktortunnuse tekitamiseks saab kasutada käsku factor(.):
table(andmed$MARHT) # Mitu korda abielus olnud?

# Faktori tasemete järjekorda saab muuta käsu factor(.) argumenti 'levels' kasutades:
andmed$MARHT <- factor(andmed$MARHT, levels = c("One time", "Two times", "Three or more times"))
table(andmed$MARHT)


# Kui faktortunnust proovida as.numeric(.) käsuga arvuliseks teisendada, tekib segadus: 
# Factor-tüüpi tunnus on juba täisarvude tunnus (kuigi neil on sildid juures)
(x <- factor(c("1", "8", "ei vastanud", "12"))) # välimised sulud tingivad väljatrüki
as.numeric(x)
as.numeric(as.character(x))

# Arvulist tunnust aitab lõikudeks tükeldada käsk cut(.):
palgad <- cut(andmed$WAGP, breaks = c(0, 999, 4999, Inf), include.lowest = T,
              labels = c("0-999", "1000-4999", ">= 5000"))
table(palgad)



# --- ÜL 1.4.1 ----

# 1. vanusgrupi tunnuse tekitamine
andmed$vanusgrupp <- cut(_____)
table(andmed$vanusgrupp)


# 2. USA kodakondsuseta vastajad: kas vanusgruppide jaotus meestel-naistel erinev

# Mittkodanike alamandmestik
table(andmed$CIT)
mitte <- andmed[____,____]

tab <- table(mitte[___,___])
tab

# vanusgruppide jaotus soo kaupa
tab1 <- prop.table(tab, 1);tab1


