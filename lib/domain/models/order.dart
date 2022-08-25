import 'package:cash_n_carry/domain/models/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {

  final List<Product> products;
  final String userId;

  const Order({required this.products,required this.userId});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

}

