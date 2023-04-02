import 'package:json_annotation/json_annotation.dart';

import 'package:htf_artesanos/domain/product/product_cart.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  final int id;
  final int userId;
  final int totalProducts;
  final int totalQuantity;
  final double total;
  final double discountedTotal;
  final List<ProductCart> products;

  Cart({
    required this.id,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
    required this.total,
    required this.discountedTotal,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}
