// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String?,
      quantity: json['quantity'] as int?,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      inStock: json['in_stock'] as bool,
      price: (json['price'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'in_stock': instance.inStock,
      'price': instance.price,
      'quantity': instance.quantity,
      'discount': instance.discount,
      'category': instance.category?.toJson(),
    };
