import 'package:hive_flutter/hive_flutter.dart';
import 'package:tzamtzam_hadar/models/user_permissions.dart';

class GeneralDataSource {
  static const _generalBox = 'general';

  static Future initialise() async {
    if (!Hive.isBoxOpen(_generalBox)) {
      await Hive.openBox(_generalBox);
    }
  }

  static Future generalSave(
      {required String field, required dynamic key}) async {
    final box = Hive.box(_generalBox);
    await box.put(field, key);
  }

  static String generalGet({required String field}) {
    final box = Hive.box(_generalBox);
    return box.get(field);
  }

  static Future savePermissions({required dynamic key}) async {
    final box = Hive.box(_generalBox);
    await box.put('permissions', key);
  }

  static UserPermissions getPermissions() {
    final box = Hive.box(_generalBox);

    return box.get('permissions') ?? UserPermissions.customer;
  }

  static Future hiveClearBox() async {
    final box = Hive.box(_generalBox);
    await box.clear();
  }
}

enum GeneralBoxFields {
  language,
  employee,
}

extension GeneralBoxFieldsX on GeneralBoxFields {
  String getString() {
    return switch (this) {
      GeneralBoxFields.language => "language",
      GeneralBoxFields.employee => "employee",
    };
  }
}
