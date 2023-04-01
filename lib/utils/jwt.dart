import 'package:jwt_decoder/jwt_decoder.dart';

class JwtUtils {
  static Map<String, dynamic> decodeJwt(String token) =>
      JwtDecoder.decode(token);
  static bool isExpired(String token) {
    final expValue = decodeJwt(token)['exp'];
    return expValue != null ? JwtDecoder.isExpired(token) : false;
  }

  static DateTime getExpirationData(String token) =>
      JwtDecoder.getExpirationDate(token);
  static Duration getTokenTime(String token) => JwtDecoder.getTokenTime(token);
}
