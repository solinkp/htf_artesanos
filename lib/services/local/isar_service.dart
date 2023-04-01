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
    Isar.open([IsarUserSchema], name: 'isarArtisan');
  }

  /// get ops
  ///

  Future<IsarUser?> getIsarUser() async {
    Isar isar = Isar.getInstance('isarArtisan')!;
    return (await isar.isarUsers.where().findFirst());
  }

  /// save ops
  ///

  Future<void> saveIsarUser(IsarUser isarUser) async {
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
