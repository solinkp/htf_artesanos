import 'package:dio/dio.dart';

import 'package:htf_artesanos/utils/constants/urls.dart';

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
    _dioClient ??= Dio();
    return _dioClient!;
  }

  /// GET REQUESTS
  ///

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    var response = await client.post(
      apiUrlLogin,
      data: {
        'username': username,
        'password': password,
      },
    );
    return true;
  }
}
