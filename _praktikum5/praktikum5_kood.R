# --- Rakendustarkvara R
# --- V praktikum ----


# --- 1 Joonised paketiga ggplot2 ----


# --- 1.1 Graafika R-is. ggplot2 ja graafikute grammatika ----


# Baasgraafika näited
andmed <- read.table("https://github.com/Rkursus/2021/raw/master/data/mass.txt",
                     header = T, sep = "\t")

par(mfrow = c(1, 2), cex = 0.6) # see rida võimaldab kaks joonist kõrvuti panna
hist(andmed$AGE, xlab = "Vanus", ylab = "Isikuid", main = "")
plot(andmed$WKHP, andmed$WAGP, xlab = "Töötunde", ylab = "Aastapalk",
     col = (2:3)[factor(andmed$SEX)])
legend("topleft", pch = 19, col = 2:3, legend = levels(factor(andmed$SEX)))


# --- 1.2 ggplot2: hajuvusdiagramm; skaalad ----
library(ggplot2)

# andmed
mk <- read.table("https://github.com/Rkursus/2021/raw/master/data/maakonnad.txt",
                 sep = " ", 
                 header = T)
head(mk)

# joonise põhi + kujunduselement
ggplot(data = mk, mapping = aes(x = bachelor, y = per_capita_inc)) + geom_point()

# Käsu 'aes()' kasutamine
ggplot(data = mk, mapping = aes(x = bachelor, y = per_capita_inc)) +
  geom_point(aes(colour = Poverty_factor, shape = State, size = pop_estimate))



# --- ÜL 1.2.1 ----

# 1. loe sisse maakondade andmestik
link <- "https://github.com/Rkursus/2021/raw/master/data/"
mk <- read.table(paste0(link, "maakonnad.txt"), sep = " ", header=T)

# 2. hajuvusdiagramm: high_scl vs bachelor
ggplot(mk, aes(_____,______)) +
  geom_____()


# 3. täiendada + State (proovida erinevaid skaalasid siduda)
ggplot(mk, aes(_____,______)) +
  geom_____(aes(color = State))

ggplot(mk, aes(_____,______)) +
  geom_____(aes(shape = State))

ggplot(mk, aes(_____,______)) +
  geom_____(aes(fill = State))  # fill ei mõju kõigile kujunditele

ggplot(mk, aes(_____,______)) +
  geom_____(aes(fill = State), shape = 22, color = "black", size = 2)

ggplot(mk, aes(_____,______)) +
  geom_____(aes(size = State))  # see variant ei sobi: punktisuurus nõuab pideval skaalal muutuvat tunnust!


# 4. veel lisada pop_estimate
ggplot(mk, aes(_____,______)) +
  geom_____(aes(color = State, size = pop_estimate))


# Märkuseks: mis vahe on kui lisada fill, color jne ggplot() aes()-funktsioonile 
# või geom_<xxx> osa aes()-le? 
# Võrdle kahte järgmist joonist

mk$sooylekaal <- factor(mk$females_percent < 50, labels = c("naisi rohkem", "mehi rohkem"))

ggplot(mk, aes(x = high_scl, y = bachelor)) +
  geom_point(aes(color = sooylekaal)) +
  geom_smooth(method = "loess")

ggplot(mk, aes(x = high_scl, y = bachelor, color = sooylekaal)) +
  geom_point() +
  geom_smooth(method = "loess") 


# aes() argumendid ggplot() käsus 'päranduvad' edasi järgmistele kihtidele, 
# geom_<xxx> objekti aes() argumendid mõjuvad ainult selles kihis.



# --- 1.3 Tulpdiagramm; elementide asukoht ----

# Graafiku teljed võivad olla seotud ka diskreetse tunnusega
ggplot(data = mk, aes(x = State)) + geom_bar()

# Ühe tulba sees võivad olla erinevad värvid
ggplot(data = mk, aes(x = State)) + geom_bar(aes(fill = Poverty_factor))

# Kui on soov esitada andmetes esinevate sageduste asemel osakaalud, siis lisa 'position = "fill"'
ggplot(data = mk, aes(x = State)) +
  geom_bar(aes(fill = Poverty_factor), position = "fill") +
  ylab("osakaal")

# Tulbad horisontaalselt
ggplot(data = mk, aes(x = State)) + geom_bar() + coord_flip()

# Kui toorandmete asemel on juba valmis sagedustabel
(sagedustabel <- as.data.frame(table(mk$State)))
ggplot(sagedustabel, aes(x = Var1, y = Freq)) + geom_bar(stat = "identity")
ggplot(sagedustabel, aes(x = Var1, y = Freq)) + geom_col()



# --- ÜL 1.3.1 ----

# 1.
# Reastame faktori tasemed ümber
mk$Birth_factor <- factor(mk$Birth_factor, levels = c("High", "Medium", "Low"))

ggplot(mk, aes(_____,______)) + 
  geom_bar(_______) + 
  ylab("osakaal")


# Kui NA välja jätta
tingimus <- complete.cases(mk[, c("Birth_factor", "Poverty_factor")])
ggplot(mk[tingimus, ], aes(_____,______)) + 
  geom_bar(_______) + 
  ylab("osakaal")



# 2.
ggplot(mk, aes(_____,______)) +
  geom_bar(stat = ______, fun = _____ )

# tulbad ümberjärjestada
ggplot(mk, aes(x = reorder(State, _____, FUN = _____), y = ________)) +
  geom_bar(stat = ______, fun = _____ )



#--- 1.4 Veel graafikute tüüpe ----


# Histogramm
ggplot(mk, aes(x = per_capita_inc)) + geom_histogram()

# Karpdiagramm ehk boxplot
ggplot(data = mk, aes(x = State, y = per_capita_inc)) + geom_boxplot()

# Tihedusfunktsioon
ggplot(data = mk, aes(x = per_capita_inc, fill = State)) + geom_density(alpha = 0.5)

# Joondiagramm
aeg <- 1:12
tulem <- c(9, 4, 3, 5, 6, 8, 8, 15, 26, 29, 24, 23)
andmed <- data.frame(aeg, tulem )
ggplot(andmed, aes(x = aeg, y = tulem)) + geom_line( ) + geom_point()

# Joondiagramm mitme joonega
tulem <- c(tulem, c(9:20))
andmed2 <- data.frame(aeg = c(aeg, aeg), tulem, grupp = rep(c("platseebo", "ravim"), each = 12))
ggplot(data = andmed2, aes(x = aeg,y = tulem, colour = grupp)) +
  geom_line() + geom_point()



# --- ÜL 1.4.1 ----

# 1. bachelor histogramm
ggplot(mk, aes(_______)) + geom________(bins = 20)
ggplot(mk, aes(_______)) + geom________(breaks = seq(0, 60, 2.5))

# y teljel 'tihedus' st tulpade pindala = 1
ggplot(mk, aes(_______)) + geom________(bins = 20, aes(y = ..density..))

# värvilisemaks
ggplot(mk, aes(_______)) + 
  geom________(bins = 20, color = "salmon4", fill = "lightsalmon2", size = 1)


# 2. high_scl osariigiti karpdiagramm
ggplot(mk, aes(_______,_______)) + geom________()

# kui veel mingi grupeeriv tunnus vaja kaasata võib värvid appi võtta
mk$sooylekaal <- factor(mk$females_percent < 50, labels = c("naisi rohkem", "mehi rohkem"))
ggplot(mk, aes(_______,_______)) + geom________(aes(color = sooylekaal))



# 3. joondiagramm vererõhkudele (isikukaupa) värv soo põhjal
link <- "https://github.com/Rkursus/2021/raw/master/data/"
visiidid <- read.table(paste0(link, "visiidid.txt"), sep = "\t", header = TRUE)
inimesed <- read.table(paste0(link, "isikud.txt"), sep = "\t", header = TRUE)

head(visiidid)
head(inimesed)

yhenda <- merge(_______)
head(yhenda)

# ! kuupäev
ggplot(yhenda, aes(x = _______, y = _______, color = _______, group = _______)) +  geom_line()





# --- 1.5 Joonise tahkudeks jagamine ----

# Käsuga 'facet_wrap'
ggplot(data = mk, aes(x = bachelor, y = perc_poverty)) + geom_point() +
  facet_wrap(facets = ~State)

# Teine sarnane käsk on facet_grid:
ggplot(data = mk, aes(x = bachelor, y = perc_poverty)) + geom_point() +
  facet_grid(facets = females_percent > 50 ~ State)



# --- ÜL 1.5.1 ----

# 1. hajuvusdiagramm tahkudeks
mk$syndivus <- factor(mk$Birth_factor, levels = c("Low", "Medium", "High"), labels = c("madal", "keskmine", "kõrge"))

ggplot(data = mk, aes(_______,_______)) + 
  geom________() + 
  facet_wrap(facets = ~_______, labeller = label_both) + 
  labs(x = "keskkooli lõpetanute %", y = "kõrgkooli lõpetanute %")

# Kui tahta puuduvad väärtused välja jätta
ggplot(data = mk[complete.cases(mk$syndivus),], aes(_______,_______)) + 
  geom________() + 
  facet_wrap(facets = ~_______, labeller = label_both) + 
  labs(x = "keskkooli lõpetanute %", y = "kõrgkooli lõpetanute %")


# 2. joondiagramm tahkudeks

# uus tunnus
yhenda$sygis <- substr(yhenda$skp, 6, 7) %in% 9:11


ggplot(yhenda, aes(x = _______, y = _______, color = _______, group = _______)) + 
  geom________() + 
  facet_wrap(facets = ~_______, labeller = label_both) +
  labs(color = "Sünnipäev\n sügisel", x = "kuupäev", y = "vererõhk")


# Tahkude siltide muutmiseks kasuta argumenti
#labeller = labeller(Sugu = c("M" = "Mehed", "N" = "Naised"))





# --- 1.6 Veel joonisele kihtide lisamisest ----

# Salvestame joonise märksõna 'p' alla
p <- ggplot(data = mk, aes(x = per_capita_inc, y = unemployment_rate)) +
  geom_point()# tekitatakse joonise objekt, ei kuvata
p # kuvatakse joonis
p + geom_point(mapping = aes(colour = State)) # lisame punktidele värvi

p + geom_point(colour = State) # objekti State otsitakse töökeskkonnast ja ei leita

p + geom_smooth(method = lm) + # lisatakse siluja (praegu lineaarne regressioon)
  geom_text(data = mk[c(34, 48, 65), ], mapping = aes(label = County), size = 3,
            colour = "red", hjust = 1, vjust = 0)

# Lisaelementide ja tekstide lisamine
p +
  annotate("rect", xmin = 2*10^4, xmax = 4*10^4, ymin = 15, ymax = 25,
           fill = "lightblue", alpha = 0.3, colour = "blue") +
  annotate("segment", x = 3.5*10^4, xend = 3*10^4, y = 12, yend = 20,
           arrow = arrow(ends = "last", angle = 10)) +
  annotate("text", x = 3.5*10^4, y = 12, label = "vaata\n siia", hjust = 0, vjust = 1)

# Võrdle järgmisi tulemusi
p + geom_point(color = "blue")
p + geom_point(aes(colour = "blue"))

# --- ÜL 1.6.1 ----

# 1.  põhijoonis 
p <- ggplot(data = mk, aes(_______, _______)) + geom________()
p



# 2. joonisele mõned maakonnanimed lisada
p1 <- p + geom_text(data = mk[_______,_______], aes(label = _______), col = "red", size = 3)
p1

# +  need punktid üle värvida + teksti nihutada
p2 <- p + 
  geom_text(
    data = mk[_______,_______], 
    aes(label = _______), 
    col = "red", 
    size = 3, 
    vjust = 0, 
    hjust = c(0, 0, 1, 0, 1, 0, 1, 1), 
    angle = 45) + 
  geom_point(
    data= mk[_______,_______],  
    col = "blue", 
    size = 3)
p2


# 3.  + verikaaljoon  
p3 <- p2 + 
  geom________(
    xintercept = _______, 
    col = "green", 
    size = 2, 
    alpha = 0.5) 



# 4. lisada joonisele oma valitud kohta mingi komentaaritekst
p3 + _______("text", x = _______, y = _______, label = "Selgituseks võib öelda, et ...", size = 3, hjust = 0)


# --- 1.7 Joonise salvestamine ----

# ggplot2-ga tehtud jooniseid saab salvestada käsuga ggsave(.)
ggsave("joonis.pdf")

# NB! Kui argumente widht ja height ei kasuta, siis joonise mõõtmed võetakse joonise akna järgi.