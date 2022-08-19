import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:go_blog/models/blog_list_item_model.dart';
import 'package:html/parser.dart' show parse;

class BlogListController extends GetxController {
  late Dio _dio;
  final String _url_path = "/blog/all";

  var blogList = <BlogItemModel>[].obs;

  BlogListController(this._dio);
  Future<void> fetchBlogList() async {
    List<BlogItemModel> blogListItems = [];
    var response = await _dio.get(_url_path);

    var document = parse(response.data);

    var blogListElement = document.querySelectorAll(".blogtitle");
    var blogSummaryElement = document.querySelectorAll(".blogsummary");
    var index = 0;
    for (var element in blogListElement) {
      var titleLinkElement = element.querySelector("a");
      String blogTitle = titleLinkElement!.text;
      String blogSlug =
          titleLinkElement.attributes["href"]!.replaceAll("/blog/", "");

      var titleDateElement = element.querySelector(".date");
      String blogDate = titleDateElement!.text;

      var titleAuthorElement = element.querySelector(".author");
      String blogAuthor = titleAuthorElement!.text;

      String blogSummary = blogSummaryElement[index].text.trim();

      blogListItems.add(BlogItemModel(
          slug: blogSlug,
          title: blogTitle,
          date: blogDate,
          author: blogAuthor,
          summary: blogSummary));
      index++;
    }

    blogList.value = blogListItems;
  }
}
