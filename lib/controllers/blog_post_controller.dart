import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:go_blog/config/regexp_comps.dart';
import 'package:go_blog/models/blog_list_item_model.dart';
import 'package:html/parser.dart' show parse;

class BlogPostController extends GetxController {
  Rx<BlogItemModel> postItem = BlogItemModel().obs;
  late Dio _dio;
  final String _url_path = "/blog/";
  var isPostLoaded = false.obs;

  BlogPostController(this._dio);

  fetchBlogContent(String slug) async {
    String titleValue = "";
    String authorValue = "";
    String dateValue = "";
    String contentValue = "";
    isPostLoaded.value = false;
    var response = await _dio.get(_url_path + slug);
    if (response.statusCode == 200) {
      var document = parse(response.data);

      //Get title value
      var titleElement = document.querySelectorAll(".Article h1")[1];
      titleValue = titleElement.text;

      //Get author and  date value
      var authorElement = document.querySelector(".author");
      authorValue = authorElement!.text.trim().split("\n")[0].trim();
      dateValue = authorElement.text.trim().split("\n")[1].trim();

      //Get content value
      var contentElement = document.querySelector(".Article");

      contentElement!.querySelectorAll("img").forEach((element) {
        if (!startsWithHTTP.hasMatch(element.attributes["src"]!)) {
          element.attributes["src"] =
              "https://go.dev/blog/${element.attributes["src"]}";
        }
      });
      contentElement.querySelectorAll("h1").forEach((element) {
        element.remove();
      });
      contentElement.querySelector(".author")!.remove();
      postItem.value = BlogItemModel(
          slug: slug,
          author: authorValue,
          date: dateValue,
          title: titleValue,
          summary: contentElement.outerHtml);
    }
    isPostLoaded.value = true;
  }
}
