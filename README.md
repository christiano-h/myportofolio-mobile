# Ano - Portfolio Mobile

Aplikasi portofolio pribadi berbasis **Flutter** untuk keperluan tugas Pemrograman Berbasis Platform (PBP).

---

Nama : Christiano Hosea Imannuel

NPM : 2506615280

Kelas : PBP B

---

## Cara Menjalankan

Saya menggunakan Flutter SDK dengan versi Dart yang sesuai `pubspec.yaml`, yaitu `^3.13.7`. Setelah Flutter terpasang, langkah menjalankan proyek ini adalah sebagai berikut.

1. Clone repositori dan masuk ke folder proyek.

   ```bash
   git clone https://github.com/christiano-h/myportofolio-mobile-.git
   cd myportofolio-mobile-
   ```

2. Pasang dependency dan periksa kode.

   ```bash
   flutter pub get
   flutter analyze
   ```

3. Siapkan emulator atau perangkat, lalu jalankan aplikasinya.

   ```bash
   flutter devices
   flutter run
   ```

## Progres Mingguan

- **Tutorial 08** — Membuat proyek Flutter, memisahkan halaman utama ke `lib/menu.dart`, menggunakan `StatelessWidget`, serta menyusun `InfoCard` dan `ItemCard`.
- **Tugas 7** — Mengisi identitas pribadi dan membuat tombol Lihat Proyek, Tambah Proyek, serta Logout dengan warna biru, hijau, dan merah. Setiap tombol menampilkan SnackBar sesuai nama tombol yang ditekan.

---

### Tugas 7

1. **Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!**

   Widget tree itu susunan widget yang membentuk tampilan aplikasi, mulai dari widget paling atas sampai komponen kecil seperti teks dan ikon. Di Flutter, saya menyusun halaman dengan memasukkan widget ke dalam widget lain, sehingga bentuknya bercabang seperti pohon.

   Contohnya pada proyek saya, `MyApp` mengembalikan `MaterialApp`, lalu properti `home` berisi `MyHomePage`. Di dalam halaman itu ada `Scaffold` yang menampung AppBar dan isi halaman.

   Hubungan **parent-child** terlihat dari properti `child` dan `children`. `Padding` menerima satu `child`, sedangkan `Column` dan `Row` menerima beberapa widget melalui `children`. Parent memberi batas ukuran (*constraints*) ke child, lalu child menentukan ukuran sesuai batas tersebut, dan parent menempatkannya.

   Pada proyek saya, `Row` menyusun tiga InfoCard secara horizontal, sementara `Column` menyusun bagian profil dan menu secara vertikal. Jadi posisi dan ukuran komponen ikut dipengaruhi susunan parent-nya.

2. **Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!**

   Widget yang saya gunakan langsung pada kode aplikasi di `main.dart` dan `menu.dart` adalah sebagai berikut.

   | Widget | Fungsi pada proyek saya |
   | --- | --- |
   | `MyApp` | Widget buatan saya yang dipanggil melalui `runApp` dan membangun konfigurasi aplikasi. |
   | `MaterialApp` | Mengatur tema Material Design dan halaman awal melalui `home`. |
   | `MyHomePage` | Widget halaman utama yang menyusun profil dan menu portofolio. |
   | `Scaffold` | Menyediakan struktur halaman, termasuk tempat AppBar dan body. |
   | `AppBar` | Menampilkan judul `MyPortfolio` di bagian atas halaman. |
   | `Text` | Menampilkan judul, identitas, sambutan, nama tombol, dan pesan SnackBar. |
   | `Padding` | Memberi jarak di sekitar konten, termasuk body dan teks sambutan. |
   | `Column` | Menyusun beberapa widget secara vertikal. |
   | `Row` | Menyusun tiga InfoCard secara horizontal. |
   | `SizedBox` | Memberi jarak vertikal, misalnya antara profil dan menu. |
   | `Center` | Menempatkan child di tengah ruang yang tersedia. |
   | `GridView.count` | Menyusun tombol menu menjadi kisi tiga kolom melalui `crossAxisCount: 3`. |
   | `InfoCard` | Widget buatan saya untuk menampilkan pasangan judul dan isi identitas. |
   | `Card` | Memberi bentuk kartu pada InfoCard dengan `elevation: 2`. |
   | `Container` | Mengatur lebar dan padding pada isi kartu. |
   | `ItemCard` | Widget buatan saya yang membentuk satu tombol menu dari data `ItemHomepage`. |
   | `Material` | Memberi permukaan berwarna pada tombol dan mendukung efek sentuhan Material. |
   | `InkWell` | Mendeteksi ketukan melalui `onTap` dan memberi efek sentuhan pada kartu. |
   | `Icon` | Menampilkan ikon folder, tambah, dan logout sesuai menu. |
   | `SnackBar` | Menampilkan pesan singkat setelah pengguna menekan tombol. |

   `MyApp`, `MyHomePage`, `InfoCard`, dan `ItemCard` memakai `StatelessWidget` sebagai kelas dasarnya. Saya memisahkan komponen supaya tampilan kartu cukup ditulis sekali dan bisa dipakai berulang dengan data yang berbeda.

   Ada juga widget pendukung yang saya akses melalui `.of(context)`. `Theme` menyediakan tema AppBar, `MediaQuery` menyediakan ukuran layar untuk lebar InfoCard, dan `ScaffoldMessenger` mengelola SnackBar. Ketiganya tersedia dari susunan aplikasi Flutter di atas widget saya.

   `ItemHomepage` menyimpan nama, ikon, dan warna setiap menu. Sementara itu `ThemeData`, `ColorScheme`, `TextStyle`, `EdgeInsets`, `BorderRadius`, dan `IconData` merupakan objek konfigurasi atau data yang dipakai widget.

3. **Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!**

   `MaterialApp` mengatur konfigurasi aplikasi Material Design, seperti tema, halaman awal, navigasi, dan lokalisasi. Widget ini biasanya ditempatkan di bagian atas widget tree supaya konfigurasi tersebut bisa digunakan oleh halaman-halaman di bawahnya.

   Pada proyek saya, `MyApp` mengembalikan `MaterialApp` yang mengatur tema melalui `ThemeData` dan membuka halaman utama lewat `home: MyHomePage()`. Jadi pengaturan aplikasi terkumpul di satu tempat dan lebih mudah di-maintain.

4. **Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?**

   `StatelessWidget` digunakan saat komponen tidak perlu menyimpan state lokal yang berubah. Saya memakainya untuk `InfoCard` dan `ItemCard` karena tampilannya mengikuti data yang diberikan. Widget ini tetap bisa di-build ulang ketika konfigurasi dari parent atau data ancestor berubah.

   `StatefulWidget` digunakan saat komponen perlu menyimpan state yang berubah selama aplikasi berjalan, misalnya status tombol favorit atau indikator sedang menyimpan. Nilainya disimpan pada objek `State`, lalu `setState()` dipakai untuk menjadwalkan build ulang saat perubahan memengaruhi tampilan.

5. **Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?**

   `BuildContext` itu penunjuk posisi widget di widget tree. Context penting karena dipakai untuk mengakses data atau layanan dari ancestor, seperti tema, ukuran layar, dan navigasi.

   Di metode `build(BuildContext context)`, saya menggunakan `Theme.of(context)` untuk mengambil tema, `MediaQuery.of(context)` untuk membaca ukuran layar, dan `ScaffoldMessenger.of(context)` untuk menampilkan SnackBar. Context yang digunakan harus berada di bawah penyedia layanan tersebut agar bisa ditemukan.

6. **Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?**

   **Hot reload** menerapkan perubahan kode sambil mempertahankan state aplikasi, tanpa menjalankan ulang `main()` dan `initState()`. Saya bisa memakainya saat mengubah teks, warna, atau tata letak.

   **Hot restart** menjalankan ulang aplikasi Dart dan menghapus state sebelumnya. Ini diperlukan ketika perubahan perlu mengulang inisialisasi di `main()` atau `initState()`, atau saat perubahan struktur tipe tertentu ditolak oleh hot reload.

   **Full restart** menghentikan lalu menjalankan aplikasi kembali, termasuk membangun ulang kode native. Ini diperlukan setelah mengubah kode Kotlin, Java, Swift, atau Objective-C, serta menambah plugin yang membawa kode native.

> AI disclosure : [ristek.link/AI-DISCLOSURE-PBP](https://ristek.link/AI-DISCLOSURE-PBP)