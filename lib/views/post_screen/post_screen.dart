import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:go_blog/config/regexp_comps.dart';
import 'package:go_blog/controllers/blog_post_controller.dart';
import 'package:go_blog/controllers/fav_controller.dart';
import 'package:go_blog/views/post_screen/widgets/external_bottom_sheet.dart';
import 'package:go_blog/views/post_screen/widgets/post_hero_widget.dart';

class PostScreen extends StatefulWidget {
  final String slug;
  const PostScreen({Key? key, required this.slug}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late Dio _dio;
  final String _baseUrl = "https://go.dev/";
  late BlogPostController bpCont;

  FavoriteController favCont = Get.find();

  @override
  void initState() {
    super.initState();
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
    bpCont = BlogPostController(_dio);
    bpCont.fetchBlogContent(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Obx(() {
          if (bpCont.postItem.value.title != null) {
            return Text(bpCont.postItem.value.title!);
          }
          return const Text("Blog Post");
        }),
        actions: [
          Obx(() => favCont.isFaved(widget.slug)
              ? IconButton(
                  onPressed: () {
                    favCont.removeFromFav(widget.slug);
                  },
                  icon: const Icon(
                    Icons.favorite_rounded,
                    color: Colors.white,
                  ))
              : IconButton(
                  onPressed: () {
                    favCont.addToFav(widget.slug);
                  },
                  icon: const Icon(Icons.favorite_border_rounded))),
        ],
      ),
      body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Obx(() {
                  if (bpCont.isPostLoaded.value) {
                    return Column(
                      children: [
                        PostHeroWidget(
                            title: bpCont.postItem.value.title!,
                            author: bpCont.postItem.value.author!,
                            date: bpCont.postItem.value.date!),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Html(
                            data: bpCont.postItem.value.summary,
                            onLinkTap: inspectURL,
                          ),
                        ),
                      ],
                    );
                  }

                  return const Padding(
                    padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(),
                  );
                })
              ],
            ),
          )),
    );
  }

  void inspectURL(url, context, attributes, element) {
    if (url != null) {
      if (blogShortRegexpComp.hasMatch(url)) {
        var slug = url.replaceAll(blogShortText, "");
        Get.to(() => PostScreen(slug: slug), preventDuplicates: false);
      } else if (blogLongRegexpComp.hasMatch(url)) {
        var slug = url.replaceAll(blogLongText, "");
        Get.to(() => PostScreen(slug: slug), preventDuplicates: false);
      } else if (oldBlogLongRegexpComp.hasMatch(url)) {
        var slug = url.replaceAll(oldBlogLongText, "");
        Get.to(() => PostScreen(slug: slug), preventDuplicates: false);
      } else {
        Get.bottomSheet(ExternalBottomSheet(url: url));
      }
    }
  }
}
