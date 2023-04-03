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
