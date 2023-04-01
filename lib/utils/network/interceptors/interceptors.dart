import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:htf_artesanos/utils/network/interceptors/auth_interceptor.dart';

extension DioInterceptors on Dio {
  void addInterceptors() {
    final loggerInterceptor = PrettyDioLogger(responseBody: false);
    final authInterceptor = AuthInterceptor();
    interceptors.addAll([loggerInterceptor, authInterceptor]);
  }
}
