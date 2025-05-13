class Donate {
  String imageAsset;
  String title;
  String titleDescription;
  String description;
  int targetDonate;
  String updateInfo;
  String updateInfoDate;
  String status;
  List<DonationHistory> donationHistory;

  Donate({
    required this.imageAsset,
    required this.title,
    required this.titleDescription,
    required this.description,
    required this.targetDonate,
    required this.updateInfo,
    required this.updateInfoDate,
    required this.status,
    required this.donationHistory,
  });

  int get totalDonate {
    return donationHistory.fold(0, (sum, history) {
      final amount =
          int.tryParse(history.amount.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
      return sum + amount;
    });
  }

  double get donationPercentage {
    if (targetDonate == 0) return 0;
    return totalDonate / targetDonate;
  }

  String get formattedTotalDonate {
    return formatCurrency(totalDonate);
  }

  String get formattedPercentage {
    return '${(donationPercentage * 100).toStringAsFixed(0)}%';
  }

  String formatCurrency(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count % 3 == 0 && i != 0) {
        buffer.write('.');
      }
    }
    return 'Rp ${buffer.toString().split('').reversed.join()}';
  }

  int get totalDonors {
    return donationHistory.length;
  }

  int get totalUniqueDonors {
    final uniqueNames = donationHistory.map((e) => e.name).toSet();
    return uniqueNames.length;
  }
}

class DonationHistory {
  String name;
  String amount;
  String donationDate;

  DonationHistory({
    required this.name,
    required this.amount,
    required this.donationDate,
  });
}

var donateList = [
  Donate(
    imageAsset: 'assets/images/gift_a_tree.png',
    title: 'Gift A Tree',
    titleDescription: 'Tree planted on behalf of you or a loved one',
    description:
        'Setiap pohon yang Anda bantu tanam adalah langkah kecil menuju bumi yang lebih hijau dan sehat. Dengan berdonasi di program ini, Anda berkontribusi langsung dalam rehabilitasi hutan dan penghijauan di berbagai wilayah yang membutuhkan. Pohon-pohon ini tidak hanya membantu mengurangi jejak karbon, tetapi juga menyediakan rumah bagi satwa liar dan sumber daya alam bagi masyarakat sekitar. Jadikan donasi Anda sebagai hadiah bermakna untuk orang tercinta, atau bentuk cinta Anda pada bumi.',
    targetDonate: 100000,
    updateInfo:
        'Exciting update! With the ongoing efforts, we’ve successfully planted over 500 trees in the past month alone, contributing to reforestation in multiple regions. Our teams are actively working to expand the green cover in the local communities, and your donations have been vital in driving this initiative forward. Together, we are making a lasting difference!',
    updateInfoDate: '8 October 2025',
    status: 'Ongoing',
    donationHistory: [
      DonationHistory(
        name: 'Wahyu',
        amount: 'Rp 12,000',
        donationDate: '1 October 2025',
      ),
      DonationHistory(
        name: 'Budi',
        amount: 'Rp 15,000',
        donationDate: '3 October 2025',
      ),
      DonationHistory(
        name: 'Adi',
        amount: 'Rp 18,000',
        donationDate: '5 October 2025',
      ),
      DonationHistory(
        name: 'Agus',
        amount: 'Rp 4,000',
        donationDate: '6 October 2025',
      ),
      DonationHistory(
        name: 'Siti',
        amount: 'Rp 10,000',
        donationDate: '7 October 2025',
      ),
      DonationHistory(
        name: 'Fajar',
        amount: 'Rp 8,000',
        donationDate: '8 October 2025',
      ),
      DonationHistory(
        name: 'Rina',
        amount: 'Rp 13,000',
        donationDate: '9 October 2025',
      ),
    ],
  ),
  Donate(
    imageAsset: 'assets/images/nepali_school.png',
    title: 'Green School Project',
    titleDescription: 'Help us bring sustainability education to schools',
    description:
        'Pendidikan adalah kunci perubahan, dan kami percaya bahwa anak-anak di daerah pedesaan juga layak mendapatkan edukasi berwawasan lingkungan. Melalui Green School Project, kami membangun kurikulum berbasis keberlanjutan, menyediakan fasilitas ramah lingkungan, dan melatih guru agar dapat mengajarkan pentingnya menjaga bumi sejak dini. Donasi Anda akan mendukung pembangunan sekolah hijau, perpustakaan mini, hingga program daur ulang di sekolah-sekolah terpencil.',
    targetDonate: 150000,
    updateInfo:
        'Exciting update! With the Rs.50,000 raised for the Green School Project, we’ve provided eco-friendly learning kits to 5 schools, hosted 3 interactive workshops on recycling, and set up composting stations for students to practice sustainable waste management. The response has been overwhelmingly positive, and we are now expanding our reach to additional schools, aiming to impact even more students with practical sustainability knowledge.',
    updateInfoDate: '8 October 2025',
    status: 'Ongoing',
    donationHistory: [
      DonationHistory(
        name: 'John',
        amount: 'Rp 25,000',
        donationDate: '2 October 2025',
      ),
      DonationHistory(
        name: 'Maria',
        amount: 'Rp 30,000',
        donationDate: '4 October 2025',
      ),
      DonationHistory(
        name: 'Diana',
        amount: 'Rp 10,000',
        donationDate: '5 October 2025',
      ),
      DonationHistory(
        name: 'Michael',
        amount: 'Rp 10,000',
        donationDate: '7 October 2025',
      ),
      DonationHistory(
        name: 'Sarah',
        amount: 'Rp 5,000',
        donationDate: '8 October 2025',
      ),
      DonationHistory(
        name: 'Mika',
        amount: 'Rp 15,000',
        donationDate: '9 October 2025',
      ),
      DonationHistory(
        name: 'Siti',
        amount: 'Rp 21,000',
        donationDate: '10 October 2025',
      ),
    ],
  ),
  Donate(
    imageAsset: 'assets/images/art_promoting_sustainability.png',
    title: 'Sustainable Through Art',
    titleDescription: 'Exploring sustainability and creativity in art',
    description:
        'Seni memiliki kekuatan untuk menginspirasi perubahan. Program ini mendukung seniman lokal yang mempromosikan pesan keberlanjutan melalui karya seni mereka. Dari pameran daur ulang hingga mural bertema lingkungan, setiap karya yang didukung akan menyuarakan pentingnya menjaga bumi melalui cara yang kreatif dan menyentuh. Donasi Anda akan membantu mencetak katalog seni hijau, mendukung komunitas seniman muda, hingga menyediakan ruang galeri ramah lingkungan.',
    targetDonate: 200000,
    updateInfo:
        'Program kami semakin berkembang, dengan semakin banyak seniman yang terlibat dalam mendukung keberlanjutan melalui seni. Kami telah meluncurkan pameran yang menarik perhatian banyak orang, dan beberapa karya seni kami telah dipamerkan di acara-acara besar. Teruskan dukungan Anda, dan bersama-sama kita akan mempromosikan kesadaran lingkungan melalui karya seni yang menginspirasi!',
    updateInfoDate: '9 October 2025',
    status: 'Ongoing',
    donationHistory: [
      DonationHistory(
        name: 'Tina',
        amount: 'Rp 40,000',
        donationDate: '6 October 2025',
      ),
      DonationHistory(
        name: 'Rina',
        amount: 'Rp 30,000',
        donationDate: '7 October 2025',
      ),
      DonationHistory(
        name: 'Ali',
        amount: 'Rp 25,000',
        donationDate: '8 October 2025',
      ),
      DonationHistory(
        name: 'Dani',
        amount: 'Rp 15,000',
        donationDate: '9 October 2025',
      ),
      DonationHistory(
        name: 'Citra',
        amount: 'Rp 25,000',
        donationDate: '10 October 2025',
      ),
      DonationHistory(
        name: 'Oki',
        amount: 'Rp 15,000',
        donationDate: '11 October 2025',
      ),
      DonationHistory(
        name: 'Sari',
        amount: 'Rp 10,000',
        donationDate: '12 October 2025',
      ),
    ],
  ),
  Donate(
    imageAsset: 'assets/images/diverse_people_hugging.png',
    title: 'Volunteer Support Fund',
    titleDescription: 'Empower our amazing volunteers to do more!',
    description:
        'Para relawan kami adalah pahlawan di balik layar yang tanpa lelah bekerja demi perubahan positif. Mereka membantu penanaman pohon, mengedukasi masyarakat, hingga mendistribusikan bantuan ke daerah terpencil. Lewat Volunteer Support Fund, Anda membantu menyediakan pelatihan, perlengkapan lapangan, hingga logistik transportasi bagi mereka. Donasi Anda sangat berarti untuk memastikan para relawan tetap semangat dan terlindungi saat menjalankan misi sosial dan lingkungan.',
    targetDonate: 300000,
    updateInfo:
        'Kami baru saja mengadakan sesi pelatihan untuk 100 relawan yang akan bekerja di area-area terpencil. Dukungan Anda memungkinkan kami untuk memberikan perlengkapan lapangan yang sangat dibutuhkan dan transportasi yang aman untuk relawan kami. Misi kami untuk menciptakan perubahan positif semakin kuat berkat komitmen Anda.',
    updateInfoDate: '12 October 2025',
    status: 'Ongoing',
    donationHistory: [
      DonationHistory(
        name: 'Tono',
        amount: 'Rp 40,000',
        donationDate: '2 October 2025',
      ),
      DonationHistory(
        name: 'Sarah',
        amount: 'Rp 35,000',
        donationDate: '3 October 2025',
      ),
      DonationHistory(
        name: 'Lia',
        amount: 'Rp 5,000',
        donationDate: '4 October 2025',
      ),
      DonationHistory(
        name: 'Ika',
        amount: 'Rp 8,000',
        donationDate: '5 October 2025',
      ),
      DonationHistory(
        name: 'Rani',
        amount: 'Rp 25,000',
        donationDate: '6 October 2025',
      ),
      DonationHistory(
        name: 'Beni',
        amount: 'Rp 35,000',
        donationDate: '7 October 2025',
      ),
      DonationHistory(
        name: 'Tina',
        amount: 'Rp 50,000',
        donationDate: '8 October 2025',
      ),
    ],
  ),
];
