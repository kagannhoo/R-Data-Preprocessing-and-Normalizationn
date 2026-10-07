# R ile İleri Seviye Veri Ön İşleme ve İstatistiksel Normalizasyon

Bu proje, ham ve tutarsız sensör verilerinin (BALTEX veri seti) makine öğrenmesi modellerine entegre edilmeden önce nasıl temizlendiğini ve istatistiksel olarak nasıl ölçeklendirildiğini göstermektedir. Veri ön işleme adımları, hazır paketlere (black-box) bağlı kalmadan, arka plandaki matematiksel formüllerin R dilinde sıfırdan fonksiyonlaştırılmasıyla gerçekleştirilmiştir.

##  Teorik Yaklaşım: DIKW Hiyerarşisi
Yönetim Bilişim Sistemleri (YBS) perspektifiyle ham veri, doğru işlenmediği sürece yanıltıcıdır. Bu projede veri analitiği döngüsü DIKW (Data, Information, Knowledge, Wisdom) piramidi üzerinden kurgulanmıştır:
* **Veri (Data):** İçerisinde `-999` hatalı ölçümleri ve eksik/hatalı ID'ler (`-`) barındıran ham Excel satırları.
* **Enformasyon (Information):** Hatalı sensör verilerinin istatistiksel güvenilirliği bozmamak adına tespit edilip temizlenmesiyle elde edilen yapısal veri seti.
* **Bilgi (Knowledge):** Yükseklik, Havza Büyüklüğü ve Enlem gibi birimleri tamamen farklı değişkenlerin (metre, derece, metrekare) istatistiksel algoritmalarla (Min-Max ve Z-Score) aynı ölçeğe çevrilmesi.
* **Bilgelik (Wisdom):** Hazırlanan bu şablonun, makine öğrenmesi (örn. KNN, Lineer Regresyon) modellerinin "büyük sayıları daha önemli sanma" yanılgısını kırarak algoritmaların en yüksek doğrulukla çalışmasına zemin hazırlaması.

##  Proje Adımları ve Metodoloji

### 1. Veri Temizliği ve Eksik Değer Yönetimi
* Sensör okuma hatalarını temsil eden `-999` değerleri tespit edildi. Toplam veri setinin %34'üne denk gelen bu devasa boşluk; KNN gibi algoritmalarla sentetik olarak doldurulmak yerine, verinin orijinal varyansını korumak ve yapay bir yığılmayı önlemek amacıyla istatistiksel olarak temizlendi.
* İstasyon kimliği (NAT_STA_ID) hatalı/eksik girilen (`-`) satırlar filtrelendi. Toplamda 718 satırlık ham veri, 332 satırlık temiz ve analize hazır bir tabloya indirgendi.

### 2. Özellik Ölçeklendirme (Feature Scaling)
`scale()` gibi hazır R fonksiyonları kullanmak yerine, istatistiksel mimari kendi yazdığımız fonksiyonlarla koda döküldü:

* **Min-Max Normalizasyonu:** Birimleri farklı olan değişkenleri 0 ile 1 arasına sıkıştırmak ve kıyaslanabilir hale getirmek için modüler bir fonksiyon oluşturuldu.
  ```R
  min_max_yap <- function(x) {
    (x - min(x)) / (max(x) - min(x))
  }
Z-Score (Standartlaştırma): Aykırı değer (outlier) analizine olanak tanıyan, verinin grup ortalamasından kaç standart sapma uzakta olduğunu hesaplayan standartlaştırma formülü uygulandı.
z_score <- (x - mean(x)) / sd(x)