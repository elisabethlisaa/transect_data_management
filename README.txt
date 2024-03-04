README

Survei Transek
Survei transek merupakan salah satu metode utama dalam penelitian satwa liar, digunakan untuk estimasi kepadatan dan distribusi spesies. Survei transek menjadi salah satu metode andalan untuk melakukan pemantauan okupansi satwa kriptik seperti harimau sumatera, yang sulit dideteksi secara langsung di habitat hutan tropis. Dalam survei, pengamat tidak harus mendeteksi harimau secara langsung dan dapat mencatat temuan tidak langsung seperti tapak, kotoran, dan cakaran harimau. Tentunya survei transek ini juga dapat digunakan untuk pengamatan spesies lainnya, yang dapat ditemukan di habitat yang sama dengan harimau seperti primata, karnivora dan herbivora besar.
Panduan ini akan memuat langkah-langkah perapihan dan pengelolaan data survei transek okupansi satwa liar, meliputi:
1.	Menggabungkan data temuan
2.	Manajemen bukti dokumentasi.
3.	Data cleaning untuk titik temuan (pengecekan data di dataset, mengecek titik temuan).

Pengelolaan data akan dilakukan dengan menggunakan software R yang dapat diunduh pada link https://cran.r-project.org/bin/windows/base/ dan perapihan titik koordinat outlier akan dilakukan menggunakan software ArcMap atau QGIS.


Persiapan Data
Tahap persiapan data mencakup proses pengumpulan, penggabungan, penataan, dan pengorganisasian data. Penyamaan format dan standar data perlu dilakukan pada tahap ini untuk menyiapkan data agar dapat dianalisis lebih lanjut. Data survei transek terdiri atas tallysheet tabel temuan, treklog, dan dokumentasi temuan.

Verifikasi dapat dilakukan menyesuaikan kebutuhan analisis. Pada bagian ini akan dibahas mengenai verifikasi lokasi titik temuan dan kesesuaiannya dengan nama grid, posisinya dengan area hutan, persiapan data untuk verifikasi foto, dan verifikasi data tabel temuan dengan feses terkonfirmasi satwa.
Pengorganisasian data sebaiknya dilakukan dengan rapi dalam folder yang tersistematis untuk memudahkan dalam perapihan maupun analisis data. Survei transek yang melibatkan banyak organisasi dapat dipisah berdasarkan nama organisasi untuk memudahkan kontrol pada saat pengumpulan data. Sebagai informasi, seluruh data yang akan digunakan adalah dummy data yang tidak ada hubungannya sama sekali dengan titik temuan satwa.

Keterangan Folder:
1. Database	: Berisikan file-file berupa tabel temuan format excel.
2. Treklog	: Berisikan data jalur survei format .shp.
3. Dokumentasi	: Berisikan data dokumentasi temuan format .jpg.
4. Additional Data : Berisikan data pendukung (grid, hutan, dan feses harimau).
5. Hasil	: Berisikan file-file hasil perapihan data.
6. R Script	: Berisikan skrip R.

Format penamaan tabel temuan dan treklog: Organisasi_Lanskap_IDPetak

Sebelum memulai, pastikan untuk membuat project pada program R dengan cara klik File - New Project - Existing Directory - Pilih direktori tempat menyimpan file.