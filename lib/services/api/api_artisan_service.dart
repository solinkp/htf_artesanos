import 'package:dio/dio.dart';

import 'package:htf_artesanos/domain/user/user.dart';
import 'package:htf_artesanos/domain/todo/todo.dart';
import 'package:htf_artesanos/domain/cart/cart.dart';
import 'package:htf_artesanos/utils/constants/urls.dart';
import 'package:htf_artesanos/domain/product/product.dart';
import 'package:htf_artesanos/services/local/isar_service.dart';
import 'package:htf_artesanos/domain/user/create_user_dto.dart';
import 'package:htf_artesanos/domain/product/product_cart_dto.dart';
import 'package:htf_artesanos/domain/product/create_product_dto.dart';
import 'package:htf_artesanos/utils/network/interceptors/interceptors.dart';

class ApiArtisanService {
  factory ApiArtisanService() => _getInstance();

  static ApiArtisanService get instance => _getInstance();
  static ApiArtisanService? _instance;
  static Dio get client => _getDioClient();
  static Dio? _dioClient;

  ApiArtisanService._internal();

  static ApiArtisanService _getInstance() {
    _instance ??= ApiArtisanService._internal();
    return _instance!;
  }

  static Dio _getDioClient() {
    _dioClient ??= Dio()..addInterceptors();
    return _dioClient!;
  }

  Future<int> _getUserId() async {
    var user = await IsarService.instance.getIsarUser();
    return user!.id;
  }

  /// Auth endpoints
  Future<bool> login({
    required String username,
    required String password,
    required int userType,
  }) async {
    var response = await client.post(
      apiUrlLogin,
      data: {
        'username': username,
        'password': password,
      },
    );

    if (response.data == null) {
      return false;
    }

    var user = User.fromJson(response.data);
    await IsarService.instance.saveIsarUser(user, userType);

    return true;
  }

  Future<bool> signup({required CreateUserDTO newUser}) async {
    var response = await client.post(
      apiUrlRegister,
      data: {
        'firstName': newUser.firstName,
        'lastName': newUser.lastName,
        'age': newUser.age,
        'email': newUser.email,
        'username': newUser.username,
        'password': newUser.password,
        'gender': newUser.gender,
      },
    );

    return response.data != null;
  }

  /// Artisan endpoints
  Future<List<Product>> getArtisanProducts() async {
    var response = await client.get('$apiUrlArtisanProducts/smartphones');

    final List<Product> products = [];
    for (final product in response.data['products']) {
      products.add(Product.fromJson(product));
    }
    return products;
  }

  Future<bool> createArtisanProduct(CreateProductDTO newProduct) async {
    var response = await client.post(
      apiUrlAddArtisanProduct,
      data: {
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'discountPercentage': newProduct.discountPercentage,
        'stock': 1,
        'category': "handcraft"
      },
    );
    return response.data != null;
  }

  Future<List<Todo>> getArtisanTodos() async {
    var response = await client.get(apiUrlArtisanTodo);

    final List<Todo> todos = [];
    for (final todo in response.data['todos']) {
      if (!todo['completed']) {
        todos.add(Todo.fromJson(todo));
      }
    }
    return todos;
  }

  Future<bool> updateArtisanTodo(int todoId) async {
    var response = await client.put(
      '$apiUrlArtisanTodo/$todoId',
      data: {'completed': true},
    );

    await deleteArtisanTodo(todoId);

    return response.data != null;
  }

  Future<void> deleteArtisanTodo(int todoId) async {
    await client.delete('$apiUrlArtisanTodo/$todoId');
  }

  /// Tourist endpoints
  Future<Product> getProductDetails(int productId) async {
    var response = await client.get('$apiUrlProductDetails/$productId');

    return Product.fromJson(response.data);
  }

  Future<Cart> addProductToCart(ProductCartDTO product) async {
    var userId = await _getUserId();
    var response = await client.post(
      apiUrlAddProductsToCart,
      data: {
        'userId': userId,
        'products': [
          {'id': product.id, 'quantity': product.quantity}
        ],
      },
    );
    return Cart.fromJson(response.data);
  }

  Future<Cart?> getCart() async {
    var userId = await _getUserId();
    var response = await client.get('$apiUrlGetCart/$userId');

    if (response.data['carts'].isEmpty) {
      return null;
    }
    return Cart.fromJson(response.data['carts'][0]);
  }

  Future<void> addTodo(
    String todoDescription,
  ) async {
    var userId = await _getUserId();
    await client.post(
      apiUrlAddTodo,
      data: {
        'userId': userId,
        'todo': todoDescription,
        'completed': false,
      },
    );
  }

  Future<void> removeCart(int cartId) async {
    try {
      await client.delete('$apiUrlRemoveCart/$cartId');
    } catch (e) {
      return;
    }
  }
}
