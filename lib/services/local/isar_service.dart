import 'package:htf_artesanos/domain/user/user.dart';
import 'package:isar/isar.dart';

import 'package:htf_artesanos/domain/user/isar_user.dart';

class IsarService {
  factory IsarService() => _getInstance();

  static IsarService get instance => _getInstance();
  static IsarService? _instance;

  IsarService._internal();

  static IsarService _getInstance() {
    _instance ??= IsarService._internal();
    return _instance!;
  }

  Future<void> openIsarSchemas() async {
    await Isar.open([IsarUserSchema], name: 'isarArtisan');
  }

  /// get ops
  ///

  Future<IsarUser?> getIsarUser() async {
    await Future.delayed(const Duration(milliseconds: 300));
    Isar isar = Isar.getInstance('isarArtisan')!;
    return (await isar.isarUsers.where().findFirst());
  }

  /// save ops
  ///

  Future<void> saveIsarUser(User user, int userType) async {
    var isarUser = IsarUser()
      ..id = user.id
      ..userType = userType
      ..username = user.username
      ..firstName = user.firstName
      ..lastName = user.lastName
      ..picture = user.picture
      ..token = user.token;
    Isar? isar = Isar.getInstance('isarArtisan');
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.isarUsers.where().deleteFirst().then((_) async {
          await isar.isarUsers.put(isarUser);
        });
      });
    }
  }

  /// delete ops
  ///

  Future<void> clearIsarUser() async {
    Isar? isar = Isar.getInstance('isarArtisan');
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.isarUsers.clear();
      });
    }
  }
}
