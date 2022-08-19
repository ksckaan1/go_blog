import 'package:hive/hive.dart';
part 'blog_list_item_model.g.dart';

@HiveType(typeId: 0)
class BlogItemModel {
  @HiveField(0)
  String? slug;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? date;
  @HiveField(3)
  String? author;
  String? summary;
  BlogItemModel({this.slug, this.title, this.date, this.author, this.summary});
}
