import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/models/contact_model.dart';
import 'package:tzamtzam_hadar/services/firestore_data.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';

class ContactsRepo {
  final collection =
      FirebaseFirestore.instance.collection('all_lists_and_maps');
  final String docName = 'maps';
  final String mapName = 'contactsList';

  Future<void> uploadNewContact({
    required String name,
    required String phoneNumber,
    required String group,
  }) async {
    firestoreUpdateDoc(collection,
        docName: 'last_update',
        values: {"lastUpdate": Timestamp.fromDate(DateTime.now())});

    globalContactsList.addAll({
      group: [
        ...globalContactsList[group],
        {
          "name": name,
          "phoneNumber": phoneNumber,
        }
      ]
    });

    firestoreUpdateDoc(
      collection,
      docName: docName,
      values: {
        mapName: globalContactsList,
      },
    );

    globalContactsListTranslated.clear();
    globalContactsList.forEach(
      (key, value) {
        List<ContactModel> contacts = [];
        value.forEach((map) {
          String name = map['name'] ?? '';
          String phoneNumber = map['phoneNumber'] ?? '';
          contacts.add(ContactModel(name: name, phoneNumber: phoneNumber));
        });
        globalContactsListTranslated[appTranslate(key)] = contacts;
      },
    );
  }

  Future<void> removeContact(
      {required String name, required String group}) async {
    globalContactsList.forEach((key, value) {
      if (key == group) {
        globalContactsList[key] =
            value.where((entry) => entry['name'] != name).toList();
      }
    });
    globalContactsListTranslated.clear();
    globalContactsList.forEach(
      (key, value) {
        List<ContactModel> contacts = [];
        value.forEach((map) {
          String name = map['name'] ?? '';
          String phoneNumber = map['phoneNumber'] ?? '';
          contacts.add(ContactModel(name: name, phoneNumber: phoneNumber));
        });
        globalContactsListTranslated[appTranslate(key)] = contacts;
      },
    );

    firestoreUpdateDoc(
      collection,
      docName: docName,
      values: {
        mapName: globalContactsList,
      },
    );
    firestoreUpdateDoc(collection,
        docName: 'last_update',
        values: {"lastUpdate": Timestamp.fromDate(DateTime.now())});
  }
}
