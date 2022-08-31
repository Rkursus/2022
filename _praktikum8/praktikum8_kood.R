# --- Rakendustarkvara R
# --- VIII praktikum ----


# --- 1. Sõnetöötlus paketiga stringr ----

#install.packages("stringr")  
library(stringr)

# --- 1.1 Sõne pikkus, sõnede kokkukleepimine ja eraldamine, alamsõne eraldamine ----
sõnad <- c("Õun", "Apelsin", "Porrulauk", NA, "")
str_length(sõnad)

str_c(sõnad, 1:5, sep = "=")
(x <- str_c(sõnad, 1:5, sep = "=", collapse = ". "))
(x <- str_c(str_replace_na(sõnad), 1:5, sep = "=", collapse = ". "))
str_split(x, ". ")
unlist(str_split(x, ". "))
str_split(sõnad, "")


lause1 <- "see ja teine ja kolmas ja neljas"; lause2 <- "üks või kaks või kolm"
str_split(c(lause1, lause2), c("ja", "või"))

str_sub(sõnad, 1:5, 3:7)
str_sub(sõnad, end = -3)

# --- Ül 1.1.1 ----

# 1. Loe sisse Massatchusettsi andmestik
link <- "https://github.com/Rkursus/2020/raw/master/data/"
mass <- read.table(str_c(link, "mass.txt"), sep = "\t", header = T)

mass$OCCP[1:4]

# Palju valdkondi on kui kaasta ka töötud (UNEMPLOYED -> UNE)?
valdkonnad <- str_sub(________________)
table(valdkonnad)
dim(table(valdkonnad))
length(unique(valdkonnad[!is.na(valdkonnad)]))  # NA tase välja jätta



# 2. Lisa andmestikku uus veerg OCCP1, mille väärtused oleks samad kui OCCP-l, kuid töötutel oleks tunnuse väärtus kujul

mass$OCCP1 <- as.character(mass$OCCP)  # kui jätta faktoriks, siis ei saa uut väärtust lisada

# NB - puuduvad väärtused!
mass$OCCP1[________ & ________] <- 
  str_c(________,________) 

        



# --- 1.2 Alamsõne otsimine ja muutmine ----


# Vaatame üle oma vektori
sõnad

str_detect(sõnad, "r")
str_count(sõnad, "r")

str_extract(sõnad, "r")
str_extract_all(sõnad, "r")

str_locate(sõnad, "r")
str_locate_all(sõnad, "r")

# Tühikute eemaldamine algusest ja lõpust; sümbolite lisamine kindla pikkuse saamiseks
str_trim(" siin on palju tühjust ")
str_pad(sõnad, width = 9, side = "both", pad = "_")

# Sõnedes asenduste tegemine
str_replace(sõnad, "r", "l")
str_replace_all(sõnad, "r", "l")



# --- ÜL 1.2.1 ----
# 1
mass <- read.table("https://github.com/Rkursus/2020/raw/master/data/mass.txt", sep = "\t", header = TRUE)
str(mass)

table(mass$COW)

palgaline <- ________(mass$COW, ________)
table(palgaline)

________(mass$WAGP[palgaline], na.rm = T)



# 2
link <- "https://github.com/Rkursus/2020/raw/master/data/"
isikukoodid <- read.table(str_c(link, "isikukoodid.txt"))[1,]
str(isikukoodid)

# Midagi on vist valesti, proovi käsku str_split(.)
ik <- unlist(str_split(________,________))


# Eralda sugu
# millised algusnumbreid esineb
sugu <- ifelse(______________)

isikud <- data.frame(ik, sugu)
head(isikud)








# --- 2. Kuupäevadega töötamine ----


# Date andmetüüp
d1 <- as.Date("22.04.2009", "%d.%m.%Y")
d2 <- as.Date("30.04.2009", "%d.%m.%Y")
d2 - d1

as.numeric(d2 - d1)

# Kuupäeva formaadis objektidega saab teha operatsioone, näiteks leida miinimum, keskmine, võrrelda hulki:
d3 <- Sys.Date()
paevad <- c(d1, d2, d3)
mean(paevad)

d2 %in% paevad

# Kuupäevast ei saa leida logaritmi või ruutjuurt, sest R talletab kuupäevi päevade arvuna alates nullpunktist. 
# Nullpunktiks loetakse vaikimisi 1970-01-01.

d1:d2
## [1] 14356 14357 14358 14359 14360 14361 14362 14363 14364
as.numeric(as.Date("1970-01-02"))
## [1] 1
as.numeric(as.Date("1969-12-30"))


# Date-tüüpi muutuja väärtuse saab sobival kujul sõneks teisendada:
format(Sys.Date(), "Kuupäev: %d. %B, (aastal %Y). Nädal nr %V.")




# --- ÜL 2.0.1 ----

# 1 
 
skp <- as.Date(________, format = "%Y%m%d")

isikud$skp <- skp
head(isikud)

# 2
vanus <- ________
isikud$vanus <- vanus
head(isikud)

#3 Millal on 10 000 päeva tänasest möödunud: 
________ + 10000
# oma 10000 päeva sünnipäeva leidmiseks asenda tänane kuupäev oma sünnipäevaga






