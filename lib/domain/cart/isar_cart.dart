import 'package:isar/isar.dart';

part 'isar_cart.g.dart';

@collection
class IsarCart {
  Id isarId = Isar.autoIncrement;
  late int id;
  late int userId;
  late int totalProducts;
  late int totalQuantity;
  late double total;
  late double discountedTotal;
  late List<IsarProductCart> products;

  Map<String, dynamic> toMap(IsarCart isarCart) {
    List<Map<String, dynamic>> products = [];
    for (var product in isarCart.products) {
      products.add({
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'quantity': product.quantity,
        'total': product.total,
        'discountPercentage': product.discountPercentage,
        'discountedPrice': product.discountedPrice,
      });
    }
    return {
      'id': isarCart.id,
      'userId': isarCart.userId,
      'totalProducts': isarCart.totalProducts,
      'totalQuantity': isarCart.totalQuantity,
      'total': isarCart.total,
      'discountedTotal': isarCart.discountedTotal,
      'products': products,
    };
  }
}

@embedded
class IsarProductCart {
  late int id;
  late String title;
  late double price;
  late int quantity;
  late double total;
  late double discountPercentage;
  late double discountedPrice;
}
