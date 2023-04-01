import 'package:auto_route/auto_route.dart';

import 'package:htf_artesanos/ui/login/login_screen.dart';
import 'package:htf_artesanos/ui/router/guards/auth_guard.dart';
import 'package:htf_artesanos/ui/dashboard/dashboard_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route,Screen',
  routes: [
    CustomRoute<void>(
      name: 'login',
      path: '/login',
      page: LoginScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: 300,
    ),
    CustomRoute<void>(
      initial: true,
      name: 'dashboard',
      path: '/dashboard',
      page: DashboardScreen,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: 300,
      guards: [
        CheckIfUserIsAuthenticated,
      ],
    ),
  ],
)
class $AppRouter {}
