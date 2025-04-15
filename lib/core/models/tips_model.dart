class Tips {
  String title;
  String titleDescription;
  String description;
  String steps;
  String imageAsset;

  Tips({
    required this.title,
    required this.titleDescription,
    required this.description,
    required this.steps,
    required this.imageAsset,
  });
}

var tipsList = [
  Tips(
    title: 'Waste Reduction Tips',
    titleDescription:
        'Reduce waste by transforming your unused items into practical solutions with these tips.',
    description: '''
Limbah adalah sisa hasil dari suatu kegiatan atau proses produksi, baik yang berasal dari aktivitas rumah tangga, industri, pertanian, maupun kegiatan lainnya, yang sudah tidak digunakan lagi dan dibuang. Limbah bisa berbentuk padat, cair, atau gas, dan dapat bersifat organik (mudah terurai) maupun anorganik (sulit terurai).
Mengurangi limbah penting untuk menjaga lingkungan dan mengurangi polusi. Dalam kehidupan sehari-hari, kita bisa mulai mengurangi limbah dengan cara yang sederhana seperti mengurangi konsumsi plastik sekali pakai dan mendaur ulang barang-barang yang bisa digunakan kembali.
''',
    steps: '''
Langkah-langkah mengurangi limbah:
1. Identifikasi barang yang jarang digunakan di rumah.
2. Gunakan kembali kemasan bekas seperti botol atau toples.
3. Beli produk dengan sedikit kemasan atau tanpa kemasan.
4. Gunakan tas belanja kain daripada kantong plastik.
5. Hindari barang sekali pakai jika memungkinkan.
''',
    imageAsset: 'assets/images/waste_reduction_tips_thumbnail.png',
  ),
  Tips(
    title: 'Recycling Tips',
    titleDescription:
        'Make your own produce bags to reduce single-use plastic waste.',
    description: '''
Daur ulang adalah proses mengubah material bekas menjadi produk baru yang dapat digunakan kembali. Daur ulang tidak hanya mengurangi sampah, tetapi juga membantu menghemat sumber daya alam. Berikut ini beberapa tips yang dapat Anda terapkan untuk mendaur ulang dengan efektif.
Daur ulang yang tepat akan mengurangi sampah yang masuk ke tempat pembuangan akhir dan mengurangi dampak negatif terhadap lingkungan.
''',
    steps: '''
Langkah-langkah mendaur ulang dengan efektif:
1. Pisahkan sampah organik dan anorganik di rumah.
2. Bilas kemasan plastik/kaleng sebelum dibuang.
3. Gunakan tempat sampah berbeda untuk kertas, plastik, dan kaca.
4. Cek simbol daur ulang di produk.
5. Gunakan ulang botol atau kaleng untuk keperluan lain.
''',
    imageAsset: 'assets/images/recycling_tips.png',
  ),
  Tips(
    title: 'Composting Tips',
    titleDescription:
        'Turn food scraps into nutrient-rich compost for your garden.',
    description: '''
Komposting adalah proses alami di mana bahan organik seperti sisa makanan diubah menjadi kompos yang dapat digunakan sebagai pupuk untuk tanaman. Proses ini tidak hanya mengurangi sampah, tetapi juga memberikan manfaat lingkungan dan mengurangi penggunaan pupuk kimia.
Komposting bisa dilakukan di rumah dengan menggunakan tempat kompos yang sederhana.
''',
    steps: '''
Langkah membuat kompos dari sisa makanan:
1. Siapkan tempat kompos atau pot besar dengan lubang udara.
2. Masukkan sisa sayur, buah, dan daun kering.
3. Aduk kompos setiap 2–3 hari agar proses lancar.
4. Jaga kelembaban dengan menambahkan sedikit air.
5. Kompos siap dalam 1–2 bulan dan bisa digunakan sebagai pupuk alami.
''',
    imageAsset: 'assets/images/composting_tips.png',
  ),
  Tips(
    title: 'Reusing and Upcycling Tips',
    titleDescription:
        'Upcycling tips that turn the ordinary into the extraordinary.',
    description: '''
Reusing dan upcycling adalah dua cara yang efektif untuk mengurangi limbah dan memberikan barang lama kehidupan baru. Upcycling mengubah barang-barang yang tidak terpakai menjadi sesuatu yang berguna dan kreatif.
Contohnya, Anda dapat mengubah pakaian lama menjadi tas atau membuat furnitur lama menjadi lebih modern.
''',
    steps: '''
Langkah-langkah untuk reuse dan upcycle:
1. Gunakan kembali wadah bekas untuk menyimpan alat kecil.
2. Ubah baju lama menjadi tas belanja.
3. Cat ulang atau modifikasi furnitur lama agar terlihat baru.
4. Gunakan koran bekas sebagai pembungkus kado.
5. Kreasikan kerajinan tangan dari bahan bekas.
''',
    imageAsset: 'assets/images/reusing_and_upcycling_tips.png',
  ),
  Tips(
    title: 'Waste Management Awareness Tips',
    titleDescription:
        'Tips about awareness and ideas with regards to waste management process',
    description: '''
Meningkatkan kesadaran tentang pengelolaan sampah sangat penting untuk menciptakan lingkungan yang lebih bersih dan lebih hijau. Pengelolaan sampah yang baik membantu mengurangi pencemaran dan meningkatkan kualitas hidup.
''',
    steps: '''
Langkah meningkatkan kesadaran tentang pengelolaan sampah:
1. Edukasi diri sendiri dan keluarga tentang jenis-jenis sampah.
2. Ikut serta dalam program daur ulang di lingkungan sekitar.
3. Kurangi pembelian barang yang tidak perlu.
4. Dukung produk ramah lingkungan.
5. Bagikan pengetahuan ini melalui media sosial atau kegiatan masyarakat.
''',
    imageAsset: 'assets/images/waste_management_awareness_tips.png',
  ),
];
