# Stenografi-Bul


* lena.pgm dosyası görüntünün orijinal halini içermektedir. Bununla birlikte verilen steganografik.pgm dosyası ise içerisinde şifreyi barındıran resimdir. Şifre bir metindir (Örn: “Hello World !”). 

***

Karakter dizisi olarak temsil edilebilecek bu metin artan sütün ve satır indislerine karşılık karakterleri soldan sağa doğru sıralı bir şekilde yerleştirilmiştir. Yani; steganografik.pgm resminin içerisine yerleştirilen şifre bir önceki cümlede söylenilen kural göz önünde bulundurularak rastgele noktalara yerleştirilmiştir. Bu noktalar yerleştirilirken şu şekilde bir yöntem izlenmiştir:

Örneğin; orijinal resimde bir pikselin değeri 45 olsun. Bu pikselin olduğu yere “H” harfi yerleştirilirken; bu harfin ASCII karşılığı olan 72 sayısı, piksek değeri ile toplanmış (45+72) ve çıkan sonuç (117), o pikselin yeni değeri olacak şekilde ayarlanmıştır. 

* Bu program, bu şifreli metni steganografik.pgm ve lena.pgm dosyalarını kullanarak bulur ve char* tipindeki dizinin içerisine yerleştirir. 

* Inline assembly program parçacığı main.cpp içerisinde yer almaktadır.
