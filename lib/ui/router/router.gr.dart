// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../../domain/product/product.dart' as _i9;
import '../dashboard/dashboard_screen.dart' as _i3;
import '../login/login_screen.dart' as _i1;
import '../product_detail/product_detail_screen.dart' as _i5;
import '../signup/signup_screen.dart' as _i2;
import '../tourist_dashboard/tourist_dashboard_screen.dart' as _i4;
import 'guards/auth_guard.dart' as _i8;

class AppRouter extends _i6.RootStackRouter {
  AppRouter({
    _i7.GlobalKey<_i7.NavigatorState>? navigatorKey,
    required this.checkIfUserIsAuthenticated,
  }) : super(navigatorKey);

  final _i8.CheckIfUserIsAuthenticated checkIfUserIsAuthenticated;

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    Login.name: (routeData) {
      return _i6.CustomPage<void>(
        routeData: routeData,
        child: const _i1.LoginScreen(),
        transitionsBuilder: _i6.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Signup.name: (routeData) {
      return _i6.CustomPage<void>(
        routeData: routeData,
        child: const _i2.SignupScreen(),
        transitionsBuilder: _i6.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Dashboard.name: (routeData) {
      return _i6.CustomPage<void>(
        routeData: routeData,
        child: const _i3.DashboardScreen(),
        transitionsBuilder: _i6.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TouristDashboard.name: (routeData) {
      return _i6.CustomPage<void>(
        routeData: routeData,
        child: const _i4.TouristDashboardScreen(),
        transitionsBuilder: _i6.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProductDetail.name: (routeData) {
      final args = routeData.argsAs<ProductDetailArgs>();
      return _i6.CustomPage<void>(
        routeData: routeData,
        child: _i5.ProductDetailScrenn(
          key: args.key,
          product: args.product,
          userType: args.userType,
        ),
        transitionsBuilder: _i6.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/dashboard',
          fullMatch: true,
        ),
        _i6.RouteConfig(
          Login.name,
          path: '/login',
        ),
        _i6.RouteConfig(
          Signup.name,
          path: '/signup',
        ),
        _i6.RouteConfig(
          Dashboard.name,
          path: '/dashboard',
          guards: [checkIfUserIsAuthenticated],
        ),
        _i6.RouteConfig(
          TouristDashboard.name,
          path: '/touristDashboard',
        ),
        _i6.RouteConfig(
          ProductDetail.name,
          path: '/productDetail',
        ),
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class Login extends _i6.PageRouteInfo<void> {
  const Login()
      : super(
          Login.name,
          path: '/login',
        );

  static const String name = 'Login';
}

/// generated route for
/// [_i2.SignupScreen]
class Signup extends _i6.PageRouteInfo<void> {
  const Signup()
      : super(
          Signup.name,
          path: '/signup',
        );

  static const String name = 'Signup';
}

/// generated route for
/// [_i3.DashboardScreen]
class Dashboard extends _i6.PageRouteInfo<void> {
  const Dashboard()
      : super(
          Dashboard.name,
          path: '/dashboard',
        );

  static const String name = 'Dashboard';
}

/// generated route for
/// [_i4.TouristDashboardScreen]
class TouristDashboard extends _i6.PageRouteInfo<void> {
  const TouristDashboard()
      : super(
          TouristDashboard.name,
          path: '/touristDashboard',
        );

  static const String name = 'TouristDashboard';
}

/// generated route for
/// [_i5.ProductDetailScrenn]
class ProductDetail extends _i6.PageRouteInfo<ProductDetailArgs> {
  ProductDetail({
    _i7.Key? key,
    required _i9.Product product,
    required int userType,
  }) : super(
          ProductDetail.name,
          path: '/productDetail',
          args: ProductDetailArgs(
            key: key,
            product: product,
            userType: userType,
          ),
        );

  static const String name = 'ProductDetail';
}

class ProductDetailArgs {
  const ProductDetailArgs({
    this.key,
    required this.product,
    required this.userType,
  });

  final _i7.Key? key;

  final _i9.Product product;

  final int userType;

  @override
  String toString() {
    return 'ProductDetailArgs{key: $key, product: $product, userType: $userType}';
  }
}
