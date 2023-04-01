import 'package:auto_route/auto_route.dart';

import 'package:htf_artesanos/utils/jwt.dart';
import 'package:htf_artesanos/ui/router/router.gr.dart';
import 'package:htf_artesanos/services/local/isar_service.dart';

class CheckIfUserIsAuthenticated extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final isarUser = await IsarService.instance.getIsarUser();

    if (isarUser != null && !JwtUtils.isExpired(isarUser.token)) {
      resolver.next(true);
    } else {
      router.push(const Login());
    }
  }
}
