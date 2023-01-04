#!/bin/bash

#~~~ Yetkinliklerin chmod ile değiştiği fonksiyon ~~~
Yetki () { 	# 1. parametre dosya ve ya dizin yolu. 2. parametre işlem 3. parametre kesin var u|g|o
    if [ $5 ] # YAlnızca bir sahip ve bir yetki değiştirildiğinde 5. parametre gelmiyor ve hata çıkartıyor. Bu hatadan kurtulmak için if yapısı kullanıldı
        then CONDITION1=`expr $5 == u "|" $5 == g "|" $5 == o`
        CONDITION2=`expr $4 == u "|" $4 == g "|" $4 == o`  # birden fazla OR işlemi yapıldığından koşulun doğruluğunu önceden bir değişkene atandı
    else CONDITION1=0; CONDITION2=`expr $4 == u "|" $4 == g "|" $4 == o`; fi
    
    if [ $CONDITION1 == 1 ] # ugo durumu doğruysa 6. parametere kesin var r|w|x
        then       
        if [ $8 ]; then chmod $3$4$5$2$6$7$8 $1 # rwx 8. parametre boş mu dolu mu
        elif [ $7 ]; then chmod $3$4$5$2$6$7 $1 # rw|rx|wx 7. parametre boş mu dolu mu
        else chmod $3$4$5$2$6 $1; fi            # u, g, o
              
    elif [ $CONDITION2 == 1 ] # ug|go|uo 3. parametre ugo dan biri mi
        then       
        if [ $7 ]; then chmod $3$4$2$5$6$7 $1 # rwx 7. parametre boş mu dolu mu
        elif [ $6 ]; then chmod $3$4$2$5$6 $1 # rw|rx|wx 6. parametre boş mu dolu mu
        else chmod $3$4$2$5 $1; fi            # u, g, o

    else # u, g, o     
        if [ $6 ]; then chmod $3$2$4$5$6 $1 # rwx 6. parametre boş mu dolu mu    	
        elif [ $5 ]; then chmod $3$2$4$5 $1 # rw|rx|wx 5. parametre boş mu dolu mu
        else chmod $3$2$4 $1; fi # u, g, o 
    fi }

#~~~ Seçim yapılıp yapılmadığını kontrol eden fonksiyon ~~~
Secim_Yok (){      # Bir değer girilip girilmediğimizi kontrol ederken yes no box a her halükarda parametre gireceğimizden onun parametresi ilk parametre
    if [ -z "$2" ] # Bu sayede ikinci parametrenin boş olup olmadığının kontrolünü yapmış oluruz
    then
        if (whiptail --title " ! Hiçbir Seçim Yapılmadı! " --defaultno --yesno "    $1 seçimi yapmadınız. Geri donmek için Hayır'a, uygulamayı sonlardırmak için Evet'e basınız..." 10 68) 
        then exit 0; fi                        
    fi }

#~~~ Değiştirilecek yetkinliklerin seçilip Yetki fonksiyonuna gönderildiği fonksiyon ~~~
Yetkiler (){
    while [ -z "$YETKILER" ]
    do
        YETKILER=$(whiptail --title " Yetki $1 " --separate-output --checklist "    Seçilen $2 istediğiniz yetkileri Yön tuşları ile seçenekler arası gezip ve Space tuşu ile seçiniz: \n    Tab tuşu ile de Tamam, İptal ve Seçenekler arası dolaşabilirsiniz..." 15 77 3 \
          "r" "= Okuma Yetkisi $3" OFF \
          "w" "= Yazma Yetkisi $3" OFF \
          "x" "= Çalıştırma Yetkisi $3" OFF 3>&1 1>&2 2>&3) # veriyi kullanıcının görüntülüyebilmesi için 3>&1 1>&2 2>&3 ifadesini kullanırız
        Secim_Yok "Yetki $4" $YETKILER
        if [ $1 = Ayarla ]; then chmod 000 $DOSYA_DIZIN_YOLU; fi # Eğer yetkileri 0 dan oluştur seçeneği seçilirse yetkileri ayarlmadan önce tüm yetkileri alır.
        Yetki $DOSYA_DIZIN_YOLU $5 $SAHIPLER $YETKILER
    done }
    
#~~~ Yetkileri Değiştirilecek Sahiplerin seçildiği kısım ~~~
Sahipler (){
    while [ -z "$SAHIPLER" ]
    do
        # üçüncü parametre liste uzunluğu
        # --separate-output parametresi sonucu aralarında bir boşluk olacak şekide tutmaya yarar
        SAHIPLER=$(whiptail --title " Yetkileri Değiştirilecek Sahiplerin Seçilmesi " --separate-output --checklist "    Hangi dosya ve ya dizin'in sahiplerinin yetkinlik ayarlarını değiştirmek istiyorsanız Yön tuşları ile seçenekler arası geziniz ve Space tuşu ile seçiniz: \n    Tab tuşu ile de Tamam, İptal ve Seçenekler arası dolaşabilirsiniz..." 15 77 3 \
          "u" "Sahibi" OFF \
          "g" "Grubu" OFF \
          "o" "Diğerleri" OFF 3>&1 1>&2 2>&3)
        Secim_Yok Sahip $SAHIPLER
    done }

while true
do
	YETKILER=""; SECENEKLER=""; DOSYA_DIZIN_YOLU=""; SAHIPLER=""; CONDITION1=""; CONDITION2="" # Kullanıcı başka bir işlem yapamak isteyebileceğinden bellekteki değişkenlerin değerleri sorun çıkarmasın diye boşaltıldı

	#~~~ Yetkinlik ayarı türü seçme kısmı ~~~
	while [ -z "$SECENEKLER" ] # -z parametresiyle değer girilip girilmediğinin kontrol ediyor
	do
		SECENEKLER=$(whiptail --title " Yetki Ayarları " --menu "    Yetki Ayarı seçme uygulamasına hoşgeldizi. Seçilecek Dosya ya da Dizin'in hangi tür yetkinlik ayarı yapmak istiyorsanız Yön tuşlarıyla seçiniz:" 15 82 6 \
		  "1" "= Yetki Ekle" \
		  "2" "= Yetki Çıkar" \
		  "3" "= Herkese Tüm Yetkileri Ver" \
		  "4" "= Herkesin Tüm Yetkilerini Al" \
		  "5" "= Yetkileri 0'dan Oluştur" \
		  "6" "= Uygulamadan Çık" 3>&1 1>&2 2>&3)
		Secim_Yok Sahip $SECENEKLER 	
	done
	if [ $SECENEKLER == 6 ]; then exit 0; fi

	#~~~ Dosya ve ya Dizin yolunun alındığı kısım ~~~
	while [ ! -e "$DOSYA_DIZIN_YOLU" ] # -e dosya ve ya dizin'in var olup olmadığını kontrol eder
	do
		if whiptail --title " Görsel arayüzden mi, Uç birimden mi seçim? " --yesno "                Şu an Görsel Arayüz kullanıyor musunuz?" 10 77 
		then
		    DOSYA_DIZIN_YOLU=`zenity --title=" Yetkilerini  Değiştireçeğiniz Dosya Ya Da Dizini Seçiniz " --file-selection`
		else
		    DOSYA_DIZIN_YOLU=$(whiptail --title=" Dosya Ya Da Dizinin Mutlak Yolunu Giriniz " --inputbox "    Yetkilerini  değiştireçeğiniz Dosya ya da Dizin'in Mutlak yolunu giriniz: " 10 100 3>&1 1>&2 2>&3)
            if [ ! -e "$DOSYA_DIZIN_YOLU" ];
            then
                if (whiptail --title " ! Dosya Ve Ya Dizin Bulunamadı ! " --defaultno --yesno "     Bu mutlak yola sahip dosya ve ya dizin bulunamadı. Tekrar Mutlak yolu girmek için Hayır'a, uygulamayı sonlardırmak için Evet'e basınız..." 10 78) 
                    then exit 0; fi                        
            fi
		fi
		Secim_Yok "Dosya ve ya klasör" $DOSYA_DIZIN_YOLU
	done

	#~~~ Seçilen yetkinlik ayarı türüne göre işlemlerin katagorize edilildiği kısım ~~~
	case "$SECENEKLER" in  
	"1") Sahipler; Yetkiler Ekle "sahiplere eklemek" Verin ekleme + ;;     # Yetki ekleme işlemi kısmı 
	"2") Sahipler; Yetkiler Çıkar "sahiplerden çıkarmak" Alın çıkarma - ;; # Yetki çıkarma işlemi kısmı
	"3") chmod 777 $DOSYA_DIZIN_YOLU ;;  # Herkese tüm yetkileri ver kısmı
	"4") chmod 000 $DOSYA_DIZIN_YOLU ;; # Herkesin tüm yetkileri alma kısmı
	"5") Sahipler; Yetkiler Ayarla "sahiplere vermek" Olsun ayarlama + ;;  # Yetkileri 0 dan ayarlama kısmı 
	esac
	
	#~~~Başka işlem yapılıp yapılmayacağının kontrolü~~~
	if (whiptail --title " İşlem Başarılı " --defaultno --yes-button "Sonlandır" --no-button "Ana Menü" --yesno "    Yetki ayarı başarıyla değiştirildi. Başka bir ayar yapmak için Ana Menü'ye, uygulamayı sonlardırmak için Sonlandır'a basınız..." 10 68) 
		then exit 0; fi
done
