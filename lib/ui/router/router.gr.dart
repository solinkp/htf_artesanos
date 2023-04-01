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
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../dashboard/dashboard_screen.dart' as _i2;
import '../login/login_screen.dart' as _i1;
import 'guards/auth_guard.dart' as _i5;

class AppRouter extends _i3.RootStackRouter {
  AppRouter({
    _i4.GlobalKey<_i4.NavigatorState>? navigatorKey,
    required this.checkIfUserIsAuthenticated,
  }) : super(navigatorKey);

  final _i5.CheckIfUserIsAuthenticated checkIfUserIsAuthenticated;

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    Login.name: (routeData) {
      return _i3.CustomPage<void>(
        routeData: routeData,
        child: const _i1.LoginScreen(),
        transitionsBuilder: _i3.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Dashboard.name: (routeData) {
      return _i3.CustomPage<void>(
        routeData: routeData,
        child: const _i2.DashboardScreen(),
        transitionsBuilder: _i3.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/dashboard',
          fullMatch: true,
        ),
        _i3.RouteConfig(
          Login.name,
          path: '/login',
        ),
        _i3.RouteConfig(
          Dashboard.name,
          path: '/dashboard',
          guards: [checkIfUserIsAuthenticated],
        ),
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class Login extends _i3.PageRouteInfo<void> {
  const Login()
      : super(
          Login.name,
          path: '/login',
        );

  static const String name = 'Login';
}

/// generated route for
/// [_i2.DashboardScreen]
class Dashboard extends _i3.PageRouteInfo<void> {
  const Dashboard()
      : super(
          Dashboard.name,
          path: '/dashboard',
        );

  static const String name = 'Dashboard';
}
