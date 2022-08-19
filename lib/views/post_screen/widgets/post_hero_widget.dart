import 'package:flutter/material.dart';
import 'package:go_blog/utils/random_view_image.dart';

class PostHeroWidget extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  const PostHeroWidget(
      {Key? key, required this.title, required this.author, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: Container(
        height: 200,
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        // margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            image: DecorationImage(
                image: AssetImage(getRandomViewImage()), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  shadows: const [
                    Shadow(color: Colors.black, blurRadius: 20),
                    Shadow(color: Colors.black, blurRadius: 20),
                    Shadow(color: Colors.black, blurRadius: 20),
                  ],
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    fit: FlexFit.tight,
                    child: Text(author,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            shadows: const [
                              Shadow(color: Colors.black, blurRadius: 20),
                              Shadow(color: Colors.black, blurRadius: 20),
                              Shadow(color: Colors.black, blurRadius: 20),
                            ]))),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  textAlign: TextAlign.right,
                  date,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      shadows: const [
                        Shadow(color: Colors.black, blurRadius: 20),
                        Shadow(color: Colors.black, blurRadius: 20),
                        Shadow(color: Colors.black, blurRadius: 20),
                      ]),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
