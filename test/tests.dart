import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:htf_artesanos/domain/cart/cart.dart';
import 'package:htf_artesanos/domain/todo/todo.dart';
import 'package:htf_artesanos/utils/constants/urls.dart';
import 'package:htf_artesanos/domain/product/product.dart';
import 'package:htf_artesanos/domain/user/create_user_dto.dart';
import 'package:htf_artesanos/domain/product/product_cart_dto.dart';
import 'package:htf_artesanos/services/api/api_artisan_service.dart';
import 'package:htf_artesanos/domain/product/create_product_dto.dart';

final dio = Dio();

class MockService implements ApiArtisanService {
  @override
  Future<Cart> addProductToCart(ProductCartDTO product) {
    // TODO: implement addProductToCart
    throw UnimplementedError();
  }

  @override
  Future<void> addTodo(String todoDescription) {
    // TODO: implement addTodo
    throw UnimplementedError();
  }

  @override
  Future<bool> createArtisanProduct(CreateProductDTO newProduct) {
    // TODO: implement createArtisanProduct
    throw UnimplementedError();
  }

  @override
  Future<void> deleteArtisanTodo(int todoId) {
    // TODO: implement deleteArtisanTodo
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getArtisanProducts() {
    // TODO: implement getArtisanProducts
    throw UnimplementedError();
  }

  @override
  Future<List<Todo>> getArtisanTodos() {
    // TODO: implement getArtisanTodos
    throw UnimplementedError();
  }

  @override
  Future<Cart?> getCart() {
    // TODO: implement getCart
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductDetails(int productId) {
    // TODO: implement getProductDetails
    throw UnimplementedError();
  }

  @override
  Future<bool> login({
    required String username,
    required String password,
    required int userType,
  }) async {
    var response = await dio.post(
      apiUrlLogin,
      data: {
        'username': username,
        'password': password,
      },
    );
    if (response.data == null) {
      return false;
    }
    return true;
  }

  @override
  Future<void> removeCart(int cartId) {
    // TODO: implement removeCart
    throw UnimplementedError();
  }

  @override
  Future<bool> signup({required CreateUserDTO newUser}) {
    // TODO: implement signup
    throw UnimplementedError();
  }

  @override
  Future<bool> updateArtisanTodo(int todoId) {
    // TODO: implement updateArtisanTodo
    throw UnimplementedError();
  }
}

void main() {
  test('login success', () async {
    var response = await MockService().login(
      username: 'fokillq',
      password: 'xZnWSWnqH',
      userType: 0,
    );
    expect(
      response,
      isTrue,
    );
  });
}
