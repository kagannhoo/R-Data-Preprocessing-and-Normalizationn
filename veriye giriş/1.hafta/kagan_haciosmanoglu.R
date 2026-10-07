# 1. Kütüphane ve Veri Yükleme
library(readxl)
setwd("/home/kaganhoo/İndirilenler")
veri <- read_excel("BALTEX_temizlenmis.xlsx")
attach(veri)

# --- 1. YÜKSEKLİK ---
min_yuk <- min(station_elevation)
max_yuk <- max(station_elevation)
ort_yuk <- mean(station_elevation)
sap_yuk <- sd(station_elevation)

minmaks_yuk <- (station_elevation - min_yuk) / (max_yuk - min_yuk)
z_yuk <- (station_elevation - ort_yuk) / sap_yuk

# --- 2. HAVZA BÜYÜKLÜĞÜ ---
min_hav <- min(CATCHMENT_SIZE)
max_hav <- max(CATCHMENT_SIZE)
ort_hav <- mean(CATCHMENT_SIZE)
sap_hav <- sd(CATCHMENT_SIZE)

minmaks_hav <- (CATCHMENT_SIZE - min_hav) / (max_hav - min_hav)
z_hav <- (CATCHMENT_SIZE - ort_hav) / sap_hav

# --- 3. ENLEM ---
min_enl <- min(station_latitude)
max_enl <- max(station_latitude)
ort_enl <- mean(station_latitude)
sap_enl <- sd(station_latitude)

minmaks_enl <- (station_latitude - min_enl) / (max_enl - min_enl)
z_enl <- (station_latitude - ort_enl) / sap_enl

# --- TABLO ---
sonuclar <- data.frame(
  yukseklik = station_elevation, 
  z_yuk = z_yuk,
  havza = CATCHMENT_SIZE,
  z_hav = z_hav,
  enlem = station_latitude,
  z_enl = z_enl
)

print(head(sonuclar))
#Bildiğim bir komutuda eklemek istedim bu kadar formül yazmadanda yapabileceğimizi göstermek istiyorum."scale"
# Sadece bu 3 satır önceki o uzun z-skoru hesaplamalarının tamamını yapıyor
z_yuk <- scale(station_elevation)
z_hav <- scale(CATCHMENT_SIZE)
z_enl <- scale(station_latitude)

# Veri setindeki tüm sütunların Min, Medyan, Ortalama ve Max değerlerini tek seferde listeler
#summary
summary(veri)
