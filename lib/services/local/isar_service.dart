import 'package:isar/isar.dart';

import 'package:htf_artesanos/domain/cart/cart.dart';
import 'package:htf_artesanos/domain/user/user.dart';
import 'package:htf_artesanos/domain/cart/isar_cart.dart';
import 'package:htf_artesanos/domain/user/isar_user.dart';

class IsarService {
  factory IsarService() => _getInstance();

  static IsarService get instance => _getInstance();
  static IsarService? _instance;

  IsarService._internal();

  static IsarService _getInstance() {
    _instance ??= IsarService._internal();
    return _instance!;
  }

  Future<void> openIsarSchemas() async {
    await Isar.open([IsarUserSchema, IsarCartSchema], name: 'isarArtisan');
  }

  /// get ops
  ///

  Future<IsarUser?> getIsarUser() async {
    await Future.delayed(const Duration(milliseconds: 300));
    Isar isar = Isar.getInstance('isarArtisan')!;
    return (await isar.isarUsers.where().findFirst());
  }

  Future<IsarCart?> getIsarCart() async {
    Isar isar = Isar.getInstance('isarArtisan')!;
    return (await isar.isarCarts.where().findFirst());
  }

  /// save ops
  ///

  Future<void> saveIsarUser(User user, int userType) async {
    var isarUser = IsarUser()
      ..id = user.id
      ..userType = userType
      ..username = user.username
      ..firstName = user.firstName
      ..lastName = user.lastName
      ..picture = user.picture
      ..token = user.token;
    Isar? isar = Isar.getInstance('isarArtisan');
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.isarUsers.where().deleteFirst().then((_) async {
          await isar.isarUsers.put(isarUser);
        });
      });
    }
  }

  Future<void> saveIsarCart(Cart cart) async {
    IsarCart isarCart;
    var existingCart = await getIsarCart();

    // convert products to local structure
    List<IsarProductCart> isarProds = [];
    for (var product in cart.products) {
      isarProds.add(
        IsarProductCart()
          ..id = product.id
          ..title = product.title
          ..price = product.price
          ..quantity = product.quantity
          ..total = product.total
          ..discountPercentage = product.discountPercentage
          ..discountedPrice = product.discountedPrice,
      );
    }

    if (existingCart != null) {
      isarCart = existingCart;
      // verify if product already exists
      var existingElement = isarCart.products.where(
        (element) => element.id == isarProds[0].id,
      );
      if (existingElement.isNotEmpty) {
        List<IsarProductCart> editedProds = [];
        for (var product in isarCart.products) {
          if (product.id == isarProds[0].id) {
            editedProds.add(
              IsarProductCart()
                ..id = product.id
                ..title = product.title
                ..price = product.price
                ..quantity = product.quantity + isarProds[0].quantity
                ..total = product.total + isarProds[0].total
                ..discountPercentage = product.discountPercentage
                ..discountedPrice =
                    product.discountedPrice + isarProds[0].discountedPrice,
            );
          } else {
            editedProds.add(product);
          }
          isarCart.products = [...editedProds];
        }
      } else {
        // add new products to existing
        isarCart.products = [...isarCart.products, ...isarProds];
      }

      // calculate new totals
      isarCart.total = isarCart.total + cart.total;
      isarCart.discountedTotal =
          isarCart.discountedTotal + cart.discountedTotal;
      isarCart.totalProducts = isarCart.products.length;
      isarCart.totalQuantity = isarCart.totalQuantity + cart.totalQuantity;
    } else {
      isarCart = IsarCart()
        ..id = cart.id
        ..userId = cart.userId
        ..totalProducts = cart.totalProducts
        ..totalQuantity = cart.totalQuantity
        ..total = cart.total
        ..discountedTotal = cart.discountedTotal
        ..products = isarProds;
    }

    Isar? isar = Isar.getInstance('isarArtisan');
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.isarCarts.put(isarCart);
      });
    }
  }

  /// delete ops
  ///

  Future<void> clearIsarUser() async {
    Isar? isar = Isar.getInstance('isarArtisan');
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.isarUsers.clear();
      });
    }
  }

  Future<void> removeProductFromCart(int productId) async {
    Isar? isar = Isar.getInstance('isarArtisan');
    if (isar != null) {
      var cart = await isar.isarCarts.where().findFirst();
      List<IsarProductCart> products = [];
      IsarProductCart removedProduct = IsarProductCart();
      for (var product in cart!.products) {
        if (product.id != productId) {
          products.add(product);
        } else {
          removedProduct = product;
        }
      }

      cart.products = [...products];
      // calculate new totals
      cart.total = cart.total - removedProduct.total;
      cart.discountedTotal =
          cart.discountedTotal - removedProduct.discountedPrice;
      cart.totalProducts = cart.products.length;
      cart.totalQuantity = cart.totalQuantity - removedProduct.quantity;

      await isar.writeTxn(() async {
        await isar.isarCarts.put(cart);
      });
    }
  }

  Future<void> clearIsarCart() async {
    Isar? isar = Isar.getInstance('isarArtisan');
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.isarCarts.clear();
      });
    }
  }
}
