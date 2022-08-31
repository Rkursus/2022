# --- Rakendustarkvara R
# --- IX praktikum ----



# --- 1. Programmeerimine R-is ----
  
# --- 1.1 Tsüklid ----

# for-tsükkel teeb ettemääratud arvu samme
for (i in 1:10) { # NB! siinne 'in' on ilma protsendimärkideta!
  print(i)
}
for (loom in c("kass", "kaamel", "kilpkonn", NA, "kaan")) {
  print(loom)
}

# while-tsüklit korratakse seni, kuni teatud tingimus saab täidetud
a <- 1
while(a < 10) {
  print(a)
  a <- a + 1 # kui seda rida poleks, jääks tsükkel lõpmatult korduma
}

#----  ÜL 1.1.1

# Loe sisse andmestik
mass <- read.table("https://github.com/Rkursus/2021/raw/master/data/mass.txt", sep = "\t", header =
                     TRUE)
library(stringr)

# 1 keskmise ja summarse töötundide tabel üle 15 aastastele
osa <- mass[_________ > 15 & 
              _________ != "UNE" & 
              !is.na(mass$OCCP),   ]
str(osa)

# tühi tabel tsüklis täitmiseks
tabel <- data.frame(grupp = NA, keskmine = NA, summa = NA)

rida <- 1
for (amet in unique(osa$OCCP)){
  tabel[_________, "grupp"] <- _________ # amet
  tabel[_________, "keskmine"] <- _________
  tabel[_________, "summa"] <- _________
  rida <- _________ + 1
}

head(tabel)
dim(tabel)


# 2
# sama tabel data.table-süntaksiga
library(data.table)
massdt  <- as.data.table(mass)

massdt[_________ & _________ & _________,
       .(keskmine = _________, summa = _________),
        by = _________]

# sama tabel dplyr-süntaksiga
library(dplyr)

massdp <- mass %>%
  _________(_________, _________, _________) %>% 
  _________(_________) %>% 
  _________(keskmine = _________, 
            summa = _________)


# -- kulunud aeg: tsükkel
system.time({
  _________  
})

# -- kulunud aeg: data.table
system.time({
  _________
})


# -- kulunud aeg: dplyr
system.time({
  _________
})


# --- 1.2 Tingimuslause if ----

# Tingimuslause if millega saab rakendada erinevaid tegevusi
väärtus <- 20

if (väärtus %% 2 == 0) {
  print(väärtus)
} else { # kui else-lauset kasutada, peab see olema if-lause suluga samal real
  print(väärtus * 10)
}

# if lause tingimuste hulka võib lisada ka väärtuse või tüübi kontrollimise
if (!is.na(väärtus) & is.numeric(väärtus) & väärtus %% 2 == 0) { print(väärtus) }

# Kasulik käsk ifelse: tingimuslause tulemuse järgi täidetakse üks kahest käsust
table(ifelse(is.na(mass$WAGP), "palgatu", "palgaga") )




# --- ÜL 1.2.1 ----
# 1

visiidid <- read.table("https://github.com/Rkursus/2021/raw/master/data/visiidid.txt", sep = "\t",
                       header = TRUE)
head(visiidid)


loenda <- 0
for(i in unique(visiidid$ik)){
  osa <- visiidid[visiidid$ik == i, ]
  osa <- osa[order(osa$visiidi_kp),]
  vahe <- _________ - _________
  if (abs(vahe) > 5) {
    print( paste(i, "vahe: ", vahe))
    loenda <- _________ + 1}
}

loenda




# --- 1.3 Funktsioonide defineerimine ----


minukäsk <- function(argument1, argument2 = "tere", argument3 = mean, ...) {
  # funktsiooni sisu
  tagastatav_objekt <- argument3(argument1, ...)
  return(tagastatav_objekt)
}


minukäsk(argument1 = 1:6, argument3 = mean, na.rm = T) # argument na.rm saadetakse käsule mean
minukäsk(1:6, , min)


# --- ÜL 1.3.1 ----

# 1

zskoor <- function(_________){
  z <- (_________ - _________)/sd(_________)
  return(z)
}

zskoor(1:10)
zskoor(c(NA, 1:10))
zskoor(c(NA, 1:10), na.rm = T)
zskoor(c("a", "b"))

# 2

visiidid <- read.table("https://github.com/Rkursus/2021/raw/master/data/visiidid.txt", sep = "\t", header = TRUE)
head(visiidid)


library(dplyr)

uusfun <- function(x){
  _________
}



tabel <- 
  visiidid %>% group_by(ik) %>%
  summarise("keskmine visiitide arv" = uusfun(visiidi_kp))

head(tabel)





# --- 2 Juhuarvud. Simuleerimine ----

# Näited ühtlase jaotusega
set.seed(1357) # kui seda rida poleks, tuleks järgmiste ridadega iga kord erinev tulemus
(x <- runif(n = 3, min = 0, max = 10)) # kolm arvu ühtlasest jaotusest U(0,10)

# jaotusfunktsioon vastaval kohal
punif(q = x, min = 0, max = 10) 

# 30. ja 75. protsentiil jaotusel U(0, 10)
qunif(p = c(0.3, 0.75), min = 0, max = 10) 




# --- ÜL 2.0.1 ----

# 1
maatriks <- function(_________, _________, lambda){
  x <- rpois(_________, lambda)
  m <- matrix(x, nrow = _________, ncol = _________)
  return(m)
}

set.seed(234)
maatriks(2, 4, 5)



# 2
test <- function(_________){
  veerusumma <- matrix(colSums(_________))
  reasumma <- matrix(rowSums(_________))
  oodatavad <- reasumma %*% t(veerusumma) /sum(_________)
  hiiruut <- sum((_________ - oodatavad)^2 / oodatavad)
  p.väärtus <-  1 - pchisq(hiiruut, df = prod(dim(_________) - 1)) 
  vastus <- list(test.statistik = hiiruut, p = p.väärtus)
  return(vastus)
}

# Testi oma funktsiooni
A <- maatriks(_________, _________, lambda = 20)
A

# Võrdle oma funktsiooni
test(A)
chisq.test(A, correct = F)




