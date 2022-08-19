import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_blog/models/blog_list_item_model.dart';
import 'package:go_blog/views/home_screen/home_screen.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BlogItemModelAdapter());
  await Hive.openBox<BlogItemModel>("favlist");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      defaultTransition: Transition.cupertino,
      debugShowCheckedModeBanner: false,
      title: 'Go Blog Posts',
      home: HomeScreen(),
    );
  }
}
