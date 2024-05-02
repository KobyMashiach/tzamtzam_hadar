import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tzamtzam_hadar/hive/lists_maps_data_source.dart';
import 'package:tzamtzam_hadar/services/firestore_data.dart';

class ListsMapsRepo {
  ListsMapsRepo(this.localDB);
  final collection =
      FirebaseFirestore.instance.collection('all_lists_and_maps');
  final ListsMapsDataSource localDB;

  Future<List<dynamic>> getAllData() async {
    final lastUpdateDB = localDB.getLastUpdate();
    final lastUpdateFS =
        (await firestoreGetDataFromDoc(collection, 'last_update', "lastUpdate"))
            .toDate();
    if (lastUpdateDB == null || !lastUpdateDB.isAtSameMomentAs(lastUpdateFS)) {
      QuerySnapshot querySnapshot = await collection.get();
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      localDB.saveAllData(allData);

      return allData;
    } else {
      return localDB.getAllData();
    }
  }
}
