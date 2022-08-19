import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_blog/controllers/fav_controller.dart';
import 'package:go_blog/views/post_screen/post_screen.dart';

class FavList extends StatefulWidget {
  const FavList({Key? key}) : super(key: key);

  @override
  State<FavList> createState() => _FavListState();
}

class _FavListState extends State<FavList> {
  FavoriteController favCont = Get.put(FavoriteController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Drawer(
          backgroundColor: Colors.blue,
          child: Container(
            padding: const EdgeInsets.only(top: 70, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.favorite,
                        color: Colors.white70,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Favorite Posts",
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  if (favCont.favPosts.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: favCont.favPosts.length,
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (BuildContext context, int i) {
                          return ListTile(
                            onTap: () {
                              Get.to(() =>
                                  PostScreen(slug: favCont.favPosts[i].slug!));
                            },
                            horizontalTitleGap: 0,
                            leading: const Icon(Icons.article_rounded),
                            iconColor: Colors.white70,
                            textColor: Colors.white70,
                            title: Text(favCont.favPosts[i].title!),
                            trailing: IconButton(
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () {
                                favCont
                                    .removeFromFav(favCont.favPosts[i].slug!);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "No favorite post added",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    );
                  }
                })
              ],
            ),
          )),
    );
  }
}
