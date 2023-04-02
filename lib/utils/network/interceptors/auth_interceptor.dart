import 'package:dio/dio.dart';

import 'package:htf_artesanos/utils/jwt.dart';
import 'package:htf_artesanos/ui/router/router.gr.dart';
import 'package:htf_artesanos/ui/artisan_main.dart' as main;
import 'package:htf_artesanos/services/local/isar_service.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isarUser = await IsarService.instance.getIsarUser();

    options.headers['Authorization'] =
        isarUser != null && !JwtUtils.isExpired(isarUser.token)
            ? 'Bearer ${isarUser.token}'
            : '';

    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      await IsarService.instance.clearIsarUser();
      main.appRouter.popUntilRoot();
      await main.appRouter.replace(const Login());
    }
    handler.reject(err);
  }
}
