# --- Rakendustarkvara R
# --- VI praktikum ----


# --- 1. Pakett ggplot2. Skaalade muutmine ----

library(ggplot2)

# Maakondade andmestik
mk <- read.table("https://github.com/Rkursus/2021/raw/master/data/maakonnad.txt", sep = " ", header=T)
head(mk)

# Skaleerimisfunktsiooni rakendamiseks tuleb see lisada joonisele
p2 <- ggplot(mk, aes(per_capita_inc, unemployment_rate, colour = State)) + geom_point()
p2
p2 + scale_x_continuous(trans = "log10", breaks = c(1/2, 1:4) * 10^4)

# Teljepiiride määramine 
rotid <- nlme::BodyWeight
rotid <- rotid[rotid$Diet != 1, ]
p <- ggplot(rotid, aes(factor(Time), weight)) + geom_point(color = "gray") +
  stat_summary(geom = "errorbar", fun.data = mean_se, fun.args = list(mult = 1.96)) +
  stat_summary(geom = "point", fun = mean)
p

p + ylim(390, 600)





# --- 1.1 Pidevate/arvuliste skaalade muutmine ----


# Argumendi limits mõju: võrdle regressioonsirgeid
p2 + geom_smooth(method = lm) + scale_x_continuous(limits = 1:2*10^4) +
  labs(title = "x-teljel kasutame ja näeme\npunkte vahemikus 10000-20000")
p2 + geom_smooth(method = lm) + coord_cartesian(xlim = 1:2*10^4) +
  labs(title = "kasutame kõiki punkte, tulemust\nnäeme vahemikus 10000-20000")




# --- 1.2 Diskreetsete skaalade muutmine ----

# Oluline on ka väärtuste etteandmise järjekord:
b <- ggplot(data = mk, aes(State, unemployment_rate)) + geom_boxplot()
b
b + scale_x_discrete(limits = c("Texas", "Maryland", "Alaska"))

#Võrdle, mis mõju on argumendil `breaks`:
# b + scale_x_discrete(breaks = c("Texas", "Maryland", "Alaska"))

# Diskreetsel skaala puhul saab limits argumendiga määrata millisete väärtusklasside elemendid värvitakse
# ja millised jäetakse värvimata (vaikimisi jäävad halliks):
b1 <- ggplot(data = mk, aes(bachelor, unemployment_rate, color = State)) + geom_point()
b1
b1 + scale_color_discrete(limits = c("Texas", "Maryland", "Alaska"))
# NA väärtuse värvi saa ka muuta
b1 + scale_color_discrete(limits = c("Texas", "Maryland", "Alaska"), na.value = "white")



# --- ÜL 1.2.1 ----

# olemas joonis, mida vaja täiendada 
joonis <- ggplot(data = mk, aes(x = high_scl, y = bachelor)) + geom_point()
joonis


# 1. y telg
joonis1 <- joonis + 
  scale_y_________(________)
joonis1

# 2. punktid värvida + legendi nimetus muuta  (värvile arvuline tunnus: gradientskaala)
joonis1 + geom_________(aes(color = ________)) + labs(________)


# 3. uus tunnus tekitada
mk$income_class <- cut(________, 
                       breaks = quantile(________,________),
                       labels = ________)


# 4. lisada uus tunnus joonisele
joonis4 <- joonis1 + geom_point(data = mk, aes(color = income_class)) #! siin peab geom_point()-le uuesti andmestiku ette andma, sest oleme seda muutnud! oluline on ka argumendi nime 'data' väljakirjutamine
joonis4

# värv ainult minimaalsele ja maksimaalsele
joonis4 + scale_color_________(limits =________)



# 5. mis juhtub kui lisada guide = FALSE argument? (legendi eemaldamine)
joonis4 + scale_color_________(limits =________, guide = FALSE)





# --- 1.3 Värviskaalade muutmine ----

# Näited gradientskaala kasutamisest
p3 <- ggplot(data = mk, aes(per_capita_inc, unemployment_rate)) +
  geom_point(aes(colour = bachelor ))
p3

nimi = "% w/ higher \n education"
p3 + scale_colour_gradient(name = nimi, low = "yellow", high = "red")
p3 + scale_colour_gradient2(name = nimi, low = "blue", high = "red", midpoint = 30)

# diskreetse värviskaala muutmine
p4 <- ggplot(mk, aes(per_capita_inc, unemployment_rate)) + geom_point(aes(colour = State ))
p4
p4 + scale_colour_hue(c = 150) # tugevus suuremaks, vaikimisi 100
#p4 + scale_colour_hue(l = 20) # heledus madalamaks, vaikimisi 65
#p4 + scale_colour_hue(h = c(10, 190)) # kaks värvitooni, skaala algus- ja lõpptoon

# Värvi paleti muutmine
p4 + scale_colour_brewer(type = "div", palette = 2)
p4 + scale_colour_brewer(type = "qual", palette = 2)




# --- ÜL 1.3.1 ----
# Eelmise ülesande joonise diskreetse värviskaala muutus
joonis4 + 
  scale_colour_________(type = "div", palette = "________")







# --- 2. Joonise viimistlemine ----

# valime valmis teemakomplekti, lisame joonisele
joonis4 + theme_dark()
joonis4 + theme_bw()
joonis4 + theme_void()  # 'tühi' 


# vaikimisi kujundus on   theme_gray()
joonis4 + theme_gray()



# kehtivas teemas mingi elemendi väljavahetamine
joonis4   # esmalt vaatame joonist vaikimisi kujundusega

# kasutame elemendi vahetamiseks theme_replace(), argumendis kirjas muudatus. 
# mida teeb omistamine: muutujasse 'vana' jääb kirja seni kehtinud kujundus, selle saab hiljem taastada
vana <- theme_replace(
  panel.background = element_rect(fill = "lightgreen"),
  panel.grid.major = element_line(size = 2, color = "white"))

# pärast eelmist käsku on joonise taustad rohelised
joonis4

# taastame vana teema
theme_set(vana)

# nüüd järgnevad joonised jälle 'tavalise' halli taustaga
joonis4


# valmis teemakomplekti kehtestamine
theme_set(theme_dark())

# edaspidi kehtib 'dark'-teema 
joonis4



# selleks, et vaadata mingi teema parameetreid
theme_bw()
# selleks, et näha kehtiva teema parameetreid
theme_get()




# --- ÜL 2.0.1 ----
# 1.  legendi paigutus, x-telje siltide kohendamine, joonise pealkiri
joonis5 <- 
  joonis4 + ggtitle("Pealkiri") + 
  theme(________, # pealkirja suurus
        ________, # x telje siltide pööramine 45 kraadi
        ________  # legendi asukoht
        )
joonis5 


# Selleks, et muuta joonise teksti tüüpi, fondiperet
library(extrafont)
font_import()  # NB! fontide import võtab aega!! sel ajal ei saa Ri kasutada!
loadfonts(device = "win")

# mis fonte saab valida?
fonts()

# lisame joonisele, üldise teksti-elemendi muutus, peaks mõjuma kõikidele tekstidele joonisel
joonis5 + theme(text = element_text(size = 12, family = "Papyrus"))


 