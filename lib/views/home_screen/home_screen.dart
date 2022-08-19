import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_blog/controllers/blog_list_controller.dart';
import 'package:go_blog/controllers/fav_controller.dart';
import 'package:go_blog/views/home_screen/widgets/blog_card.dart';
import 'package:go_blog/views/home_screen/widgets/fav_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _baseURL = "https://go.dev";
  late Dio dio;

  late BlogListController blCont;
  FavoriteController favCont = Get.put(FavoriteController());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    dio = Dio(BaseOptions(baseUrl: _baseURL));
    blCont = Get.put(BlogListController(dio));

    blCont.fetchBlogList();

    favCont.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const FavList(),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("The Go Blog"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (blCont.blogList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return RefreshIndicator(
          onRefresh: blCont.fetchBlogList,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: blCont.blogList.length,
              itemBuilder: ((context, i) {
                return BlogCardWidget(
                    title: blCont.blogList[i].title!,
                    author: blCont.blogList[i].author!,
                    slug: blCont.blogList[i].slug!,
                    date: blCont.blogList[i].date!,
                    summary: blCont.blogList[i].summary!);
              })),
        );
      }),
    );
  }
}
