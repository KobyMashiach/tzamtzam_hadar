import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:meta/meta.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/models/contact_model.dart';
import 'package:tzamtzam_hadar/repos/contacts_repo.dart';
import 'package:tzamtzam_hadar/services/general_functions.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';

part 'contacts_screen_event.dart';
part 'contacts_screen_state.dart';

class ContactsScreenBloc
    extends Bloc<ContactsScreenEvent, ContactsScreenState> {
  final ContactsRepo contactsRepo;
  final Map<String, List<ContactModel>> unTranslateContacts = {};
  final Map<String, List<ContactModel>> contacts = {};
  Map<String, List<ContactModel>> filteredContacts = {};
  bool searchOpen = false;
  ContactsScreenBloc(this.contactsRepo)
      : super(ContactsScreenLoading(
            contacts: {}, searchOpen: false, unTranslateContacts: {})) {
    on<ContactsScreenEventInitialize>(_contactsScreenEventInitialize);
    on<ContactsScreenEventOnPhonePress>(_contactsScreenEventOnPhonePress);
    on<ContactsScreenEventOnWhatsappPress>(_contactsScreenEventOnWhatsappPress);
    on<ContactsScreenEventOnSearchContact>(_contactsScreenEventOnSearchContact);
    on<ContactsScreenEventOnSearchToggleChange>(
        _contactsScreenEventOnSearchToggleChange);
    on<ContactsScreenEventOnCloseCategory>(_contactsScreenEventOnCloseCategory);
    on<ContactsScreenEventOnOpenCategory>(_contactsScreenEventOnOpenCategory);
    on<ContactsScreenEventOnNewContactClicked>(
        _contactsScreenEventOnNewContactClicked);
    on<ContactsScreenEventOnAddNewContactClicked>(
        _contactsScreenEventOnAddNewContactClicked);
    on<ContactsScreenEventOnDeleteContact>(_contactsScreenEventOnDeleteContact);
  }

  FutureOr<void> _contactsScreenEventInitialize(
      ContactsScreenEventInitialize event, Emitter<ContactsScreenState> emit) {
    globalContactsList.forEach(
      (key, value) {
        List<ContactModel> contacts = [];
        value.forEach((map) {
          String name = map['name'] ?? '';
          String phoneNumber = map['phoneNumber'] ?? '';
          contacts.add(ContactModel(name: name, phoneNumber: phoneNumber));
        });
        unTranslateContacts[key] = contacts;
      },
    );

    contacts.addAll(globalContactsListTranslated);
    contacts.keys.forEach((key) {
      filteredContacts[key] = [];
    });
    emit(buildRefreshUI());
  }

  FutureOr<void> _contactsScreenEventOnPhonePress(
      ContactsScreenEventOnPhonePress event,
      Emitter<ContactsScreenState> emit) async {
    // final phoneNumber = fixPhoneNumber(event.phoneNumber);
    await GeneralFunctions().openWeb('tel:${event.phoneNumber}');
    // await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  FutureOr<void> _contactsScreenEventOnWhatsappPress(
      ContactsScreenEventOnWhatsappPress event,
      Emitter<ContactsScreenState> emit) async {
    // final phoneNumber = fixPhoneNumber(event.phoneNumber);
    await GeneralFunctions()
        .openWeb('https://api.whatsapp.com/send?phone=${event.phoneNumber}');
  }

  // String fixPhoneNumber(String phoneNumber) =>
  //     '+972' +
  //     phoneNumber.replaceAll('-', '').substring(1, 4) +
  //     phoneNumber.replaceAll('-', '').substring(4);

  FutureOr<void> _contactsScreenEventOnSearchContact(
      ContactsScreenEventOnSearchContact event,
      Emitter<ContactsScreenState> emit) {
    final searchInput = event.nameOrPhone;
    filteredContacts = contacts.map((key, value) {
      final filteredList = value.where((contact) =>
          contact.name.toLowerCase().contains(searchInput.toLowerCase()) ||
          contact.phoneNumber.replaceAll('-', '').contains(searchInput));
      return MapEntry(key, filteredList.toList());
    });
    emit(buildRefreshUI());
  }

  ContactsScreenRefreshUI buildRefreshUI() => ContactsScreenRefreshUI(
      contacts: filteredContacts,
      searchOpen: searchOpen,
      unTranslateContacts: unTranslateContacts);

  FutureOr<void> _contactsScreenEventOnSearchToggleChange(
      ContactsScreenEventOnSearchToggleChange event,
      Emitter<ContactsScreenState> emit) {
    searchOpen = !searchOpen;
    if (!searchOpen) {
      contacts.keys.forEach((key) {
        filteredContacts[key] = [];
      });
    } else {
      filteredContacts.addAll(contacts);
    }
    emit(buildRefreshUI());
  }

  FutureOr<void> _contactsScreenEventOnCloseCategory(
      ContactsScreenEventOnCloseCategory event,
      Emitter<ContactsScreenState> emit) {
    if (filteredContacts.containsKey(event.category)) {
      filteredContacts[event.category] = [];
    }
    emit(buildRefreshUI());
  }

  FutureOr<void> _contactsScreenEventOnOpenCategory(
      ContactsScreenEventOnOpenCategory event,
      Emitter<ContactsScreenState> emit) {
    if (contacts[event.category]!.isEmpty) {
      kheasydevAppToast(appTranslate('dontcontactsincategory'));
    } else if (filteredContacts.containsKey(event.category)) {
      filteredContacts[event.category]!.addAll(contacts[event.category]!);
      emit(buildRefreshUI());
    }
  }

  FutureOr<void> _contactsScreenEventOnNewContactClicked(
      ContactsScreenEventOnNewContactClicked event,
      Emitter<ContactsScreenState> emit) {
    emit(ContactsScreenContactDialog(
        contacts: contacts,
        searchOpen: false,
        unTranslateContacts: unTranslateContacts));
  }

  FutureOr<void> _contactsScreenEventOnAddNewContactClicked(
      ContactsScreenEventOnAddNewContactClicked event,
      Emitter<ContactsScreenState> emit) async {
    emit(ContactsScreenLoading(
        contacts: contacts,
        searchOpen: searchOpen,
        unTranslateContacts: unTranslateContacts));
    await contactsRepo.uploadNewContact(
        name: event.name, phoneNumber: event.phoneNumber, group: event.group);
    contacts.clear();
    contacts.addAll(globalContactsListTranslated);
    contacts.keys.forEach((key) {
      filteredContacts[key] = [];
    });
    emit(buildRefreshUI());
    kheasydevAppToast(
        appTranslate("contact_uploaded", arguments: {"name": event.name}));
  }

  FutureOr<void> _contactsScreenEventOnDeleteContact(
      ContactsScreenEventOnDeleteContact event,
      Emitter<ContactsScreenState> emit) async {
    emit(ContactsScreenLoading(
        contacts: contacts,
        searchOpen: searchOpen,
        unTranslateContacts: unTranslateContacts));
    await contactsRepo.removeContact(name: event.name, group: event.group);
    globalContactsList.forEach(
      (key, value) {
        List<ContactModel> contacts = [];
        value.forEach((map) {
          String name = map['name'] ?? '';
          String phoneNumber = map['phoneNumber'] ?? '';
          contacts.add(ContactModel(name: name, phoneNumber: phoneNumber));
        });
        unTranslateContacts[key] = contacts;
      },
    );
    contacts.clear();
    contacts.addAll(globalContactsListTranslated);
    filteredContacts.addAll(contacts);
    emit(buildRefreshUI());
  }
}
