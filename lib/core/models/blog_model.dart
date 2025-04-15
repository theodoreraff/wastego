class Blog {
  String title;
  String titleDescription;
  String materials;
  String steps;
  String author;
  String uploadDate;
  String imageAsset;

  Blog({
    required this.title,
    required this.titleDescription,
    required this.materials,
    required this.steps,
    required this.author,
    required this.uploadDate,
    required this.imageAsset,
  });
}

var blogList = [
  Blog(
    title: '5 DIY to do at Home',
    titleDescription:
        'Turn old items into something useful with these fun DIY ideas.',
    materials: '''
1. Barang bekas di rumah (botol, kaleng, baju lama)
2. Alat kerajinan (gunting, lem tembak)
3. Aksesori tambahan (pita, cat akrilik, stiker)
''',
    steps: '''
1. Kumpulkan barang bekas yang bisa digunakan ulang.
2. Pilih DIY yang sesuai: seperti pot tanaman dari botol, organizer dari kaleng, dll.
3. Hias dan kreasikan sesuai imajinasi.
4. Letakkan di rumah untuk tampilan baru yang ramah lingkungan!
''',
    author: 'Anisa Larasati',
    uploadDate: '09/5/2025',
    imageAsset: 'assets/images/image1.png',
  ),

  Blog(
    title: 'Repurpose old jars into candle holders',
    titleDescription:
        'Why did the old jar apply for a job? Because it wanted to be a part of a DIY project!',
    materials: '''
1. Old glass jars
2. Tealight candles or small pillar candles
3. Acrylic paint or spray paint
4. Paintbrushes or sponges
5. Decorative items: twine, lace, beads, ribbons, stickers, or dried flowers
6. Hot glue gun or craft glue
7. Sandpaper
8. Scissors
9. Rubbing alcohol
''',
    steps: '''
1. Clean the Jar:
   Wash with soap, remove labels, and clean with rubbing alcohol.
2. Decorate (Optional):
   • Paint the jar or wrap it with twine or ribbon.
   • Add beads, lace, or flowers with glue.
3. Add Support (Optional):
   Fill the base with sand, pebbles, or beans to stabilize the candle.
4. Insert Candle:
   Place a tealight or small pillar candle inside the jar.
5. Light & Enjoy:
   Ensure the jar is on a heat-resistant surface, and enjoy the glow!

Tip: Use LED candles for a safer option.
''',
    author: 'Wahyu Prasetyo',
    uploadDate: '10/5/2025',
    imageAsset: 'assets/images/image2.png',
  ),

  Blog(
    title: 'Create a gallery wall with old frames',
    titleDescription:
        'Transform your old frames into a stunning gallery wall with these creative ideas.',
    materials: '''
1. Bingkai foto bekas
2. Cat semprot atau akrilik
3. Kertas seni atau cetakan foto
4. Palu dan paku atau double tape
5. Penggaris dan pensil
''',
    steps: '''
1. Bersihkan bingkai bekas dari debu atau noda.
2. Cat ulang jika diperlukan untuk memberikan warna baru.
3. Pilih gambar, kutipan, atau foto yang akan dimasukkan.
4. Susun di lantai terlebih dahulu untuk menentukan komposisi.
5. Pasang di dinding sesuai layout yang diinginkan.
''',
    author: 'Galuh Septiani',
    uploadDate: '08/5/2025',
    imageAsset: 'assets/images/image3.png',
  ),

  Blog(
    title: 'Upcycle old t-shirts into a colorful rug',
    titleDescription:
        'Transform your old t-shirts into cozy rugs with these creative DIY projects.',
    materials: '''
1. Kaos bekas berbagai warna
2. Gunting kain
3. Jarum besar atau alat rajut
4. Benang kuat (opsional)
''',
    steps: '''
1. Potong kaos menjadi strip panjang berukuran sekitar 2-3 cm.
2. Gabungkan strip menjadi tali panjang dengan mengikat ujungnya.
3. Pilih teknik: rajut, anyam, atau kepang (braided).
4. Gulung atau susun menjadi bentuk lingkaran atau oval.
5. Jahit atau rekatkan bagian bawah agar tidak lepas.
''',
    author: 'Dimas Riyanto',
    uploadDate: '07/5/2025',
    imageAsset: 'assets/images/image4.png',
  ),

  Blog(
    title: 'Build a bird feeder out of recycled tin',
    titleDescription:
        'Why did the bird feeder break up with the tree? It found someone more supportive!',
    materials: '''
1. Kaleng bekas (sarden, susu kental, dll.)
2. Cat ramah lingkungan (opsional)
3. Tali atau kawat gantungan
4. Lem tembak atau bor kecil
5. Biji-bijian untuk burung
6. Kayu kecil atau stik es krim
''',
    steps: '''
1. Bersihkan kaleng dan buang labelnya.
2. Hias kaleng dengan cat atau stiker jika ingin.
3. Lubangi dua sisi untuk tali gantung atau pasang kayu sebagai tempat bertengger.
4. Isi dengan biji-bijian.
5. Gantung di pohon atau tiang luar ruangan.
''',
    author: 'Nina Rahayu',
    uploadDate: '06/5/2025',
    imageAsset: 'assets/images/image5.png',
  ),

  Blog(
    title: 'Make planters from empty cans',
    titleDescription:
        'Why did the empty can go to school? Because it wanted to be a little more "can-do"!',
    materials: '''
1. Kaleng bekas
2. Cat semprot / akrilik
3. Tanah dan tanaman kecil (succulent, herbal)
4. Paku dan palu (untuk lubang drainase)
5. Hiasan seperti tali goni atau pita
''',
    steps: '''
1. Cuci dan bersihkan kaleng bekas.
2. Lubangi bagian bawah sebagai drainase.
3. Cat sesuai warna favorit dan tunggu hingga kering.
4. Tambahkan dekorasi di luar kaleng.
5. Isi dengan tanah dan tanam tanaman kecil.
6. Letakkan di jendela atau meja.
''',
    author: 'Raka Dwi Putra',
    uploadDate: '05/5/2025',
    imageAsset: 'assets/images/image6.png',
  ),
];
