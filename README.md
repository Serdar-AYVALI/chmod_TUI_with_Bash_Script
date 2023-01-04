# Linux Araçları ve Kabuk Programlama Dersi Dönem Projesi - chmod Komutu için TUI
* Linux Araçları ve Kabuk Programlama dersinin dönem projesi için chmod komutuna Linux bash script diliyle kodlanmış olduğum ve bir yer hariç Whiptail Kütüphanesi kullandığım metin tabanlı kullanıcı arayüzü (TUI) uygulamasıdır.
## ~ Youtube Linki
* Uygulamanın ve kodun Youtube'daki detaylı anlatımı için [ buraya tıklayınız]().

## ~ Uygulamalanın Özellikleri 
* Uygulamanın yetki ekleme, yetki çıkarma, herkese tüm yetkileri verme, herkesin tüm yetkilerini alma ve yetkileri 0'dan oluşturma şeklinde 5 özelliği vardır.

<div align="center">
  <img src="http://serdarayvali.eu5.org/resimler/linux_resimler/menu.png" width="60%"/>
</div>
<hr>

* Uygulama, giriş menüsünden sonra dosya ve ya dizinin yolunu almak için iki tane seçenek sunar. Görsel arayüz kullanabilen kişiler için görsel arayüzden seçme imkanı tanır. Eğer Görsel Arayüzünüz yok ise Uç Birimden mutlak yolu yazarak dosya ya da dizin seçilebilir.<br/>

<div align="center">
  <img src="http://serdarayvali.eu5.org/resimler/linux_resimler/dosya_yolu_secenegi.png" width="60%"/>
</div><br>
 
<div align="center">
  - Şu an Görsel Arayüz kullanıyor musunuz? Sorusuna eğer Evet denilirse aşağıdaki GUI penceresi açılır.<br/><br/>
  <img src="http://serdarayvali.eu5.org/resimler/linux_resimler/gorsel_arayuzle_secim.png" width="45%"/>
</div><br/>

<div align="center">
  - Soruya eğer Hayır denilirse Uç Birimden whiptail kütüphanesinin inputbux'ını kullanarak dosya ve ya dizinin yolunu bizden ister.<br/><br/>
  <img src="http://serdarayvali.eu5.org/resimler/linux_resimler/uc_birimden_secim.png" width="70%"/>
</div><br>

<div align="center">
  ! Eğer girilen Mutlak yola sahip dosya ve ya dizin yok ise aşağıdaki uyarıyı verir ve yeniden Mutlak yolu girecek miyiz yoksa uygulamadan mı ayrılacağımızı bize sorar.<br/><br/>
  <img src="http://serdarayvali.eu5.org/resimler/linux_resimler/path_bulunamadi.png" width="70%"/>
</div><br/>
<hr>

* Yetkilerini değiştirmek istediğiniz Sahiplerin seçildiği kısım
<div align="center">
  <img src="http://serdarayvali.eu5.org/resimler/linux_resimler/sahiplerin_secilmesi.png" width="60%"/>
</div><br/>
<hr>

* Değiştirmek istediğiniz yetkilerin seçildiği kısım. Burada menüden 1.Yetki Ekle seçeneği seçildikten sonra gelen TUI penceresi
<div align="center">
  <img src="http://serdarayvali.eu5.org/resimler/linux_resimler/yetki_ekleme.png" width="60%"/>
</div><br/>
<hr>

* Yetkilerde değişiklik yapıldıktan sonra işlemin başarıyla gerçekliştiğini bildiren ve bir ayarlama yapmak isteyip istemediğimizi bize soran TUI penceresi açılır.
<div align="center">
  <img src="http://serdarayvali.eu5.org/resimler/linux_resimler/islem_basarili.png" width="60%"/>
</div><br/>
<hr>

* Tüm pencerelerde hiçbir şey seçilmemesi durumunda uyarı penceresine gider. Her biri için parametrelerle ayarlanmış ufak farklılıklar olsada aynı fonksiyonun çiktısı olduğundan Seçim Yapılmadı pencereleri benzerdir.
<br/>
<div align="center">
  <img src="http://serdarayvali.eu5.org/resimler/linux_resimler/secim_yapilmadi.png" width="60%"/>
</div><br/>
