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
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../dashboard/dashboard_screen.dart' as _i3;
import '../login/login_screen.dart' as _i1;
import '../signup/signup_screen.dart' as _i2;
import '../tourist_dashboard/tourist_dashboard_screen.dart' as _i4;
import 'guards/auth_guard.dart' as _i7;

class AppRouter extends _i5.RootStackRouter {
  AppRouter({
    _i6.GlobalKey<_i6.NavigatorState>? navigatorKey,
    required this.checkIfUserIsAuthenticated,
  }) : super(navigatorKey);

  final _i7.CheckIfUserIsAuthenticated checkIfUserIsAuthenticated;

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    Login.name: (routeData) {
      return _i5.CustomPage<void>(
        routeData: routeData,
        child: const _i1.LoginScreen(),
        transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Signup.name: (routeData) {
      return _i5.CustomPage<void>(
        routeData: routeData,
        child: const _i2.SignupScreen(),
        transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    Dashboard.name: (routeData) {
      return _i5.CustomPage<void>(
        routeData: routeData,
        child: const _i3.DashboardScreen(),
        transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TouristDashboard.name: (routeData) {
      return _i5.CustomPage<void>(
        routeData: routeData,
        child: const _i4.TouristDashboardScreen(),
        transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 300,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/dashboard',
          fullMatch: true,
        ),
        _i5.RouteConfig(
          Login.name,
          path: '/login',
        ),
        _i5.RouteConfig(
          Signup.name,
          path: '/signup',
        ),
        _i5.RouteConfig(
          Dashboard.name,
          path: '/dashboard',
          guards: [checkIfUserIsAuthenticated],
        ),
        _i5.RouteConfig(
          TouristDashboard.name,
          path: '/touristDashboard',
        ),
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class Login extends _i5.PageRouteInfo<void> {
  const Login()
      : super(
          Login.name,
          path: '/login',
        );

  static const String name = 'Login';
}

/// generated route for
/// [_i2.SignupScreen]
class Signup extends _i5.PageRouteInfo<void> {
  const Signup()
      : super(
          Signup.name,
          path: '/signup',
        );

  static const String name = 'Signup';
}

/// generated route for
/// [_i3.DashboardScreen]
class Dashboard extends _i5.PageRouteInfo<void> {
  const Dashboard()
      : super(
          Dashboard.name,
          path: '/dashboard',
        );

  static const String name = 'Dashboard';
}

/// generated route for
/// [_i4.TouristDashboardScreen]
class TouristDashboard extends _i5.PageRouteInfo<void> {
  const TouristDashboard()
      : super(
          TouristDashboard.name,
          path: '/touristDashboard',
        );

  static const String name = 'TouristDashboard';
}
