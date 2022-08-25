
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'category.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
@Entity(tableName: "products")
class Product{
  @PrimaryKey()
  String? id;
  final String name;
  final String description;
  final String image;
  @JsonKey(name: "in_stock") final bool inStock;
  final double price;
  int? quantity;
  final double discount;
  @ignore
  Category? category;

  Product({this.id,this.quantity,required this.name,required this.description,required this.image,required this.inStock,
  required this.price,required this.discount,this.category});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

}