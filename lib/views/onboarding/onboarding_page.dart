import 'package:flutter/material.dart';
import 'package:wastego/widgets/custom_button.dart';
import 'package:wastego/views/onboarding/controller/onboarding_controller.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final OnboardingController _controller = OnboardingController();

  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      image: 'assets/images/reuse.png',
      title: 'REUSE',
      description: 'Jadikan barang lama kamu lebih berguna, temukan cara baru untuk menggunakannya!',
    ),
    OnboardingItem(
      image: 'assets/images/reduce.png',
      title: 'REDUCE',
      description: 'Kurangi sampah, lindungi bumi, mulai dari langkah kecil yang besar dampaknya',
    ),
    OnboardingItem(
      image: 'assets/images/recycling.png',
      title: 'RECYCLE',
      description: 'Ubahlah sampah menjadi sumber daya berharga, saatnya memberi kehidupan baru untuk barang bekas!',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller.startAutoSlide(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller.pageController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() => _controller.currentPage = index);
                    },
                    itemCount: onboardingItems.length,
                    itemBuilder: (context, index) {
                      final item = onboardingItems[index];
                      return OnboardingContent(
                        image: item.image,
                        title: item.title,
                        description: item.description,
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingItems.length,
                        (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _controller.currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _controller.currentPage == index
                            ? const Color(0xFF00897B)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (_controller.currentPage == onboardingItems.length - 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: CustomButton(
                      text: 'Ayo, Mulai Perubahan!',
                      onPressed: () => _controller.completeOnboarding(context),
                    ),
                  ),
              ],
            ),
            Positioned(
              top: 16,
              right: 20,
              child: TextButton(
                onPressed: () => _controller.completeOnboarding(context),
                child: const Text(
                  'Lanjutkan',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingItem {
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
