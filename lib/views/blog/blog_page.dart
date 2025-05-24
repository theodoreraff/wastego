import 'package:flutter/material.dart';
import 'package:wastego/core/models/blog_model.dart';
import 'package:wastego/views/blog/detail_blog.dart';
import 'package:wastego/views/blog/menu_blog.dart';
import 'package:wastego/widgets/custom_button.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.chevron_left, size: 24),
            ),
            const SizedBox(width: 5),
            const Text(
              "Blog",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: blogList.length + 2,
          itemBuilder: (context, index) {
            if (index <= 5) {
              final Blog blog = blogList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailBlogScreen(blogItem: blog),
                    ),
                  );
                },
                child: listItem(blog),
              );
            } else if (index == 6) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Lebih Banyak', // "More" button.
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MenuBlogScreen(),
                        ),
                      );
                    },
                    backgroundColor: const Color(0xFFAFEE00),
                    textColor: const Color(0xFF003539),
                  ),
                  const SizedBox(height: 30),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

Widget listItem(Blog blogItem) {
  return Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    elevation: 2,
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(blogItem.imageAsset),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blogItem.title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  blogItem.titleDescription,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
