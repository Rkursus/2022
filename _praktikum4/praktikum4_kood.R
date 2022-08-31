# --- Rakendustarkvara R
# --- IV praktikum ----



# --- 1. Toimingud andmestikuga - jätk ----

# Andmestik
mk <- read.table("https://github.com/Rkursus/2021/raw/master/data/maakonnad.txt", sep = " ", header = TRUE)



# --- 1.1 Andmestike täiendamine ja ühendamine ----

# Teeme kaks uut tunnust

suurus <- cut(mk$pop_estimate, c(0, 1000, 10000, 1000000, Inf),
              labels = c("mikro", "väike", "keskmine", "suur"), include.lowest = T)
sooylekaal <- ifelse(mk$fem > 50, "F", "M")

# Lisame need vektorid andmestiku lõppu veergudeks:
mk <- cbind(mk, suurus, sooylekaal)
# või
lisatabel<- data.frame(suurus, sooylekaal)
mk <- cbind(mk, lisatabel)

# ridade lisamine, praegu tekitame sellega dubleeritud vaatlusi!
lisa <- rep(seq(1, nrow(mk), by = 60),c(1:3, 1:3, 1, 1))
mktopelt <- rbind(mk, mk[lisa, ])


# Käsu 'merge()' testimiseks andmed
isikud <- data.frame(nimi = c("Peeter", "Mari", "Tiina", "Laine"),
                     sugu = c("M", "N", "N", "N"), vanus = c(30, 22, 25, 20))
tulemused <- data.frame(nimi = c("Mari", "Peeter", "Tiina", "Peeter", "Toomas"),
                        tulemus = c(30.1, 22.5, 18.4, 25.3, 20.4),
                        voistlus = c("jooks1", "jooks1", "jooks2", "jooks2", "jooks2"))
isikud
tulemused

# Nime kaudu andmestike liitmine
(kokku <- merge(isikud, tulemused, by = "nimi", all = TRUE))

#---- ÜL 1.1.1 ----
# 1 
# Kuidas peaks merge käsu kirja panema, kui isikud ja tulemused andmestikes on võtmetunnusel erinev nimi?
?merge


# 2
# Proovi, mis muutub merge käsu tulemuses, kui kasutada all = TRUE argumendi asemel all.x = TRUE või all.y = TRUE
(kokku_x <- merge(isikud, tulemused, by = "nimi", all.x = TRUE))
(kokku_y <- merge(isikud, tulemused, by = "nimi", all.y = TRUE))

# Mis oli erinev?



# --- 1.2 Sorteerimine ----

# Katseta
x <- c(8, 1, NA, 7, 7)
order(x)

sort(x, na.last = TRUE)

x[order(x)]

kokku[order(kokku$vanus, kokku$tulemus, decreasing = TRUE), ]

# --- ÜL 1.2.1 ----
# 1. Loe sisse andmestikud ja tutvu nendega:
link <- "https://github.com/Rkursus/2021/raw/master/data/"
visiidid <- read.table(paste0(link, "visiidid.txt"), sep = "\t", header = TRUE)
inimesed <- read.table(paste0(link, "isikud.txt"), sep = "\t", header = TRUE)
dim(visiidid)
str(visiidid)

dim(inimesed)
str(inimesed)


# 2. Järjesta visiitide andmestik kasvavalt isikukoodi ja arstivisiidi kuupäeva järgi.
sort_visiidid <- visiidid[_____,_____]

# 3. Ühenda andmestikud, ühendatud andmestik peab sisaldama kõik inimesed mõlemast andmestikust. 
# Mitu vaatlust on ühendatud andmestikus? Mis tunnuste osas esineb puuduvaid väärtusi?

yhendatud <- merge(visiidid, inimesed, ______)
dim(yhendatud)
summary(yhendatud)



# --- 1.3 Unikaalsed ja mitmekordsed elemendid. Hulgatehted. ----

# Vaatame andmestikku 'kokku', andmestike ühendamise alapunktist
kokku$nimi

unique(kokku$nimi) # unikaalsed nimed

duplicated(kokku$nimi) # mitmes element nimede vektoris on dubleeriv

duplicated(kokku) # mitmes rida andmestikus on dubleeriv (sellist pole!)

# Hulgatehted
x <- c(1:5, 1:5)
y <- 3:7

union(x, y)
intersect(x, y)
setdiff(x, y)


# --- ÜL 1.3.1 ----
# 1 Mitu objekti on andmestikus 'mktopelt' korduvad? 



# Kas mõni maakond on rohkem kui 2 korda korratud? Millised?



# 2 Kas arsti mitte külastanud isikute osakaal (protsentuaalselt) on suurem meeste või naiste hulgas?






#--- 2. Pikk ja lai andmetabel ----

# --- 2.1 Pikk ja lai andmetabel. Pakett reshape2 ----

#install.packages("reshape2") # kui arvutis pole paketti reshape2, siis esmalt installida
library(reshape2)
vr <- data.frame(nimi = c("Mari", "Jaan", "Jyri"),
                 kaal = c(68, 65, 100),
                 pikkus = c(170, 180, 190),
                 sugu = c(2, 1, 1),
                 pulss0m = c(70, 80, 80),
                 pulss10m = c(130, 120, 190), pulss30m = c(150, 120, NA))
(m <- melt(vr, measure.vars = 5:7)) # välimised sulud tingivad ekraanile trükkimise


# Pikast formaadist laia teisendamine
dcast(m, formula = nimi ~ variable)

dcast(m, nimi + kaal ~ variable + sugu)

dcast(m, nimi ~ . , fun.aggregate = mean, na.rm = TRUE, value.var = "value")



# --- ÜL 2.1.1 ----

# 1 
link <- "https://github.com/Rkursus/2021/raw/master/data/"
valik <- read.table(paste0(link, "valik.txt"), sep = "\t", header = TRUE)
head(valik)


# laiale kujule: igale inimesele ritta ik, sugu , skp,  vanus , vr1 ja vr2
dcast(valik, ______)




# laiale kujule: igale inimesele ritta ik, sugu , skp,  vanus , CRV1 ja CRV2 ning vr1 ja vr2
# enne tuleks viia veel pikemalt kujule: mõlemad mõõtmistunnused ühte veergu

abi <- melt(valik, _______)
head(abi)

dcast(abi, _______)



# 2. igale inimesele keskmine VR ja CRV
visiidid <- read.table(paste0(link, "visiidid.txt"), sep = "\t", header = TRUE)
head(visiidid)

abi <- melt(visiidid, ______)
head(abi)


tabel1 <- dcast(abi, _______,
                fun.aggregate = _____,  
                value.var = _______)
head(tabel1)



# --- 3. Veel andmestruktuure ----


# Maatriksi tekitamine
(m <- matrix(1:12, nrow = 3, byrow = F))

# Teine variant
cbind(1:3, 5:7, 11:13)

# Maatriksist andmete saamine
m[1:2, 2:3]


# 'List' näited
(minulist <- list(esimene = "üksainus sõne", matrix(1:12, 3), funktsioon = min))

# elementide valik listist
minulist$esimene
minulist[[2]]

# elementide lisamine listi
minulist$neljas <- c(5, 7) # lisame uue elemendi
minulist[[5]] <- letters[1:10] # lisame veel ühe uue elemendi
# muudetud listi struktuuri vaatamine
str(minulist)



# Andmetabel (data.frame)
df <- data.frame(esimene = 1:5,
                 "2. veerg" = 11:15,
                 nimed = c("Peeter", "Mari", "Kaur", NA, "Tiiu"))

class(df)
is.list(df)


# --- ÜL 3.0.1 ----
#1 Tekita list:
sõnad <- list(
  a = c("aabits", "aade", "aadel", "aader", "aadlik"),
  b = c("baar", "baas", "baat"),
  c = c("c-vitamiin", "ca", "circa", "cafe"))

#2 Eralda listist teine element, kasutades elemendi nime.



#3 Eralda listist teine element, kasutades elemendi indeksit.



#4 Eralda listist esimese elemendi kolmas element.



