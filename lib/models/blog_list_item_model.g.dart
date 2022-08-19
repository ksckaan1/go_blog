// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_list_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BlogItemModelAdapter extends TypeAdapter<BlogItemModel> {
  @override
  final int typeId = 0;

  @override
  BlogItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BlogItemModel(
      slug: fields[0] as String?,
      title: fields[1] as String?,
      date: fields[2] as String?,
      author: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BlogItemModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.slug)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.author);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlogItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
