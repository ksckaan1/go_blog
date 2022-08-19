import 'dart:developer';

import 'package:get/get.dart';
import 'package:go_blog/controllers/blog_list_controller.dart';
import 'package:go_blog/models/blog_list_item_model.dart';
import 'package:hive/hive.dart';

class FavoriteController extends GetxController {
  var favPosts = <BlogItemModel>[].obs;
  late BlogListController blCont;
  late Box<BlogItemModel> dbBox = Hive.box("favlist");

  init() {
    favPosts.value = dbBox.values.toList().reversed.toList();
    blCont = Get.find();
  }

  @override
  void dispose() {
    super.dispose();
    dbBox.close();
  }

  bool isFaved(String slug) {
    bool isContains = false;
    for (var post in favPosts) {
      if (post.slug == slug) {
        isContains = true;
        break;
      }
    }
    return isContains;
  }

  addToFav(String slug) {
    late BlogItemModel postItem;
    for (var post in blCont.blogList) {
      if (post.slug == slug) {
        postItem = post;
        break;
      }
    }

    favPosts.value = [postItem, ...favPosts];

    dbBox.add(postItem);
  }

  removeFromFav(String slug) {
    List<BlogItemModel> newList = [];
    for (var post in favPosts) {
      if (post.slug != slug) {
        newList.add(post);
      }
    }
    favPosts.value = newList;
    var mappedBox = dbBox.toMap();

    mappedBox.forEach((key, value) async {
      if (slug == value.slug) {
        await dbBox.delete(key);
        return;
      }
    });
  }
}
