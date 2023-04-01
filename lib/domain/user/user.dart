import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  @JsonKey(name: 'image')
  final String picture;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.picture,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
