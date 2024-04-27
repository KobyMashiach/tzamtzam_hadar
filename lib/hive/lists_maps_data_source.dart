import 'package:hive_flutter/hive_flutter.dart';

class ListsMapsDataSource {
  static const _lastUpdateBox = 'firestoreLastUpdate';
  static const _listsBox = 'firestoreLists';
  static const _mapsBox = 'firestoreMaps';

  static Future initialise() async {
    if (!Hive.isBoxOpen(_lastUpdateBox)) {
      await Hive.openBox(_lastUpdateBox);
    }
    if (!Hive.isBoxOpen(_listsBox)) {
      await Hive.openBox(_listsBox);
    }
    if (!Hive.isBoxOpen(_mapsBox)) {
      await Hive.openBox(_mapsBox);
    }
  }

  DateTime? getLastUpdate() {
    final box = Hive.box(_lastUpdateBox);
    final lastUpdate = box.values.map((e) => e).toList();
    return lastUpdate.isEmpty ? null : lastUpdate.first;
  }

  List<dynamic> getAllData() {
    final listsBox = Hive.box(_listsBox);
    final mapsBox = Hive.box(_mapsBox);
    final allData = listsBox.values.map((e) => e).toList();
    allData.addAll(mapsBox.values.map((e) => e).toList());
    return allData;
  }

  void saveAllData(List<Object?> allData) {
    final lastUpdateBox = Hive.box(_lastUpdateBox);
    final listsBox = Hive.box(_listsBox);
    final mapsBox = Hive.box(_mapsBox);

    // clean boxes
    lastUpdateBox.clear();
    listsBox.clear();
    mapsBox.clear();

    // add data
    lastUpdateBox
        .add(((allData[0] as Map<String, dynamic>)).values.first.toDate());
    listsBox.add(allData[1] as Map<String, dynamic>);
    mapsBox.add(allData[2] as Map<String, dynamic>);
  }
}
