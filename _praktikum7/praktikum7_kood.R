# --- Rakendustarkvara R
# --- VII praktikum ----


# --- 1. Andmetöötlus paketiga dplyr ----

#install.packages(dplyr) # vajadusel installeerida pakett
library(dplyr)

#--- 1.1 Paketi dplyr käskude kasutamine ----

# Andmestik
mass <- read.table("https://github.com/Rkursus/2020/raw/master/data/mass.txt", sep = "\t", header = T)


# Käsk 'mutate()': arvutame kaks uut tunnust, kustutame ühe vana
mass1 <- mutate(mass,
                kuus = WAGP/12,
                kuus_euro = kuus * 0.8,
                MIG = NULL)

# Käsk 'filter()': rakendame filtrit (ekraanile paari esimese veeru väärtused neil vaatlustel)
filter(mass, AGEP > 70, WAGP > 100000)[,1:3]

# Käsk 'select()': rakendame filtrit ja selekteerime tunnuseid
select(filter(mass, AGEP > 70, WAGP > 100000), contains("G"))

# Käsud 'summarise()' ja 'group_by()':
summarise(group_by(mass, CIT),
          keskpalk = mean(WAGP, na.rm = T),
          n = n(),
          notNA = sum(!is.na(WAGP)))


# Käsk 'arrange()': andmestike sorteerimine
osa <- filter(select(mass, id, SEX, AGEP, WKHP, WAGP), WAGP > 300000, AGEP < 55)
arrange(osa, SEX, desc(AGEP), WKHP)


# Toruoperaator (piping) '%>%': 
mass %>%
  group_by(SEX, MAR) %>%
  summarise(keskpalk = mean(WAGP, na.rm = T), n = n()) %>%
  head()

# versus samad operatsioonid ilma toru operaatorita
head(summarise(group_by(mass, SEX, MAR), keskpalk = mean(WAGP, na.rm = T), n = n()))

# Kumba varianti on lihtsam lugeda?



# --- ÜL 1.1.1 ----

# 1

# variant A, aheldamist kasutades
mass %>% 
  filter(______) %>% 
  mutate(vanusgrupp = ______) %>%
  group_by(______) %>%
  summarise(kesk = ______, 
            max = ______,
            "gruppide maht" = ______,
            "pole NA" = ______)


# variant B, aheldamiseta
tabel <- 
summarise(group_by(mutate(filter(______,______), 
         vanusgrupp = ______,
          kesk = ______, 
          max = ______,
          "gruppide maht" = ______,
          "pole NA" = ______)))

tabel

# Kumba varianti on lihtsam koostada? Kumba hiljem lugeda?

# 2. joonis


# andemstiku võiks esmalt pikaks teha, et keskmised ja maksimumid oleks ühes veerus, 
# lisaks veerg milles on indikaator
# Mis käsk muutis andmetabeli laiast pikaks?
library(reshape2)
pikk <- ______(tabel, ______ = c("kesk", "max"))
pikk


ggplot(______, aes(x = ______, y = ______, 
           color = ______, linetype = ______, 
           group = interaction(______, ______))) + 
  geom_______() + 
  scale_color_discrete(name = "Sugu", labels = c("Naine", "Mees"))+
  scale_linetype_discrete("Töötunnid", labels = c("keskmine", "maksimaalne"))

 



# 3. ühendada kaks eelmist ülesannet kasutades aheldamist
mass %>% 
  ______ %>% 
  ______ %>% 
  ______ ....



# --- 2. Pakett data.table ----
 
#install.packages("data.table") # vajadusel installeerida
library(data.table)


# --- 2.1 Näited data.table süntaksi kasutamisest ----

# data.table tüüpi objekti moodustamine
DT <- data.table(a = 1:10,
                 b = rep(1:3, c(3, 3, 4)),
                 c = rep(LETTERS[5:7], c(4, 3, 3)))
DT
str(DT)

# Ridade ja veergude valik (alamosa andmetabelist)
DT[1:2, ]
DT[b > 1.5, ]
DT[, 3]
DT[, a]
DT[,"a"]
DT[b > 1.5, 3]
DT[c(1, 3:4), .(a, b)]
DT[.N,]

#Uue tabeli moodustamine, arvkarakteristikud, loendamine, uued tunnused:
DT[, .(kv = mean(a), s = sd(a), mitu = .N), by = c]
DT[a > 3, .N]
DT[, .N, by = c]
DT[, .(d = a + 50)]


# Olemasoleva tabeli sees muudatuste tegemine:
# ühe uue tunnuse lisamine
DT[, d := a + 5][]
# mitme uue tunnuse lisamine
DT[, c("uus1", "uus2") := .(a + 5, b - 2) ][]
# mitme uue tunnuse lisamine, variant 2
DT[, `:=` (uus3 = a + 50,
           uus4 = b - 2,
           b = -b)][]
# väärtuste muudatus valitud ridades
DT[c(2, 4), a := a*10L][]
# uus tunnus, aga mitte igas reas
DT[c(2, 4), uus5 := a*10L][]
# tunnuste kustutamine
DT[, uus5 := NULL][]
DT[, c("uus1", "uus2") := NULL][]



# --- ÜL 2.1.1 ----


mass <- read.table("https://github.com/Rkursus/2020/raw/master/data/mass.txt",  sep = "\t", header = T)


# 1. tabeli teisendamine data.table-tüübiks
dt <- as.data.table(_____)
str(dt)


# 2. sageduse leidmine: kasuta tunnuseid AGEP ja SEX
dt[_____,______,______]


# 3. abieluseisu sagedustabel: kasuta tunnuset MAR
dt[_____,______,______]


# 4. järjestada
dt[_____,______,______][order(_____)]


# 5. osakaalu lisamine
tab1[_____, osakaal := _____]
tab1


# 6 tabeli täiustamine: kasuta tunnuseid AGEP, SCHL, MAR
dt[_____, .(kesk = _____,
          sd = _____, 
          "levinum haridus" = _____), 
          by = _____]


names(dt)

