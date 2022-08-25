// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'products': instance.products.map((e) => e.toJson()).toList(),
      'userId': instance.userId,
    };
