

import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class Category{
  final int id;
  final String name;
  final String icon;
  final int itemsCount;
  const Category({required this.name,required this.icon,required this.id,required this.itemsCount});


  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

}