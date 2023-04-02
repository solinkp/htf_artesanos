import 'package:json_annotation/json_annotation.dart';

part 'product_cart.g.dart';

@JsonSerializable()
class ProductCart {
  final int id;
  final String title;
  final double price;
  final int quantity;
  final double total;
  final double discountedPercentage;
  final double discountedPrice;

  ProductCart({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountedPercentage,
    required this.discountedPrice,
  });

  factory ProductCart.fromJson(Map<String, dynamic> json) =>
      _$ProductCartFromJson(json);
}
