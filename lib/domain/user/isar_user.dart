import 'package:isar/isar.dart';

part 'isar_user.g.dart';

@collection
class IsarUser {
  Id isarId = Isar.autoIncrement;
  late int id;
  late int userType;
  late String username;
  late String firstName;
  late String lastName;
  late String picture;
  late String token;
}
