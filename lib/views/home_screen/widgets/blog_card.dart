import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_blog/views/post_screen/post_screen.dart';

class BlogCardWidget extends StatelessWidget {
  final String title;
  final String author;
  final String slug;
  final String date;
  final String summary;
  const BlogCardWidget({
    Key? key,
    required this.title,
    required this.author,
    required this.slug,
    required this.date,
    required this.summary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PostScreen(
              slug: slug,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        fit: FlexFit.tight,
                        child: Text(author,
                            style: const TextStyle(color: Colors.grey))),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      textAlign: TextAlign.right,
                      date,
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ],
            ),
            const Divider(),
            Text(summary)
          ],
        ),
      ),
    );
  }
}
