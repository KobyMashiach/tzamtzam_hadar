import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:meta/meta.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/models/contact_model.dart';
import 'package:tzamtzam_hadar/services/general_functions.dart';

part 'contacts_screen_event.dart';
part 'contacts_screen_state.dart';

class ContactsScreenBloc
    extends Bloc<ContactsScreenEvent, ContactsScreenState> {
  final Map<String, List<ContactModel>> contacts = {};
  Map<String, List<ContactModel>> filteredContacts = {};
  bool searchOpen = false;
  ContactsScreenBloc()
      : super(ContactsScreenLoading(contacts: {}, searchOpen: false)) {
    on<ContactsScreenEventInitialize>(_contactsScreenEventInitialize);
    on<ContactsScreenEventOnPhonePress>(_contactsScreenEventOnPhonePress);
    on<ContactsScreenEventOnWhatsappPress>(_contactsScreenEventOnWhatsappPress);
    on<ContactsScreenEventOnSearchContact>(_contactsScreenEventOnSearchContact);
    on<ContactsScreenEventOnSearchToggleChange>(
        _contactsScreenEventOnSearchToggleChange);
    on<ContactsScreenEventOnCloseCategory>(_contactsScreenEventOnCloseCategory);
    on<ContactsScreenEventOnOpenCategory>(_contactsScreenEventOnOpenCategory);
  }

  FutureOr<void> _contactsScreenEventInitialize(
      ContactsScreenEventInitialize event, Emitter<ContactsScreenState> emit) {
    contacts.addAll(event.contacts);
    contacts.keys.forEach((key) {
      filteredContacts[key] = [];
    });
    emit(buildRefreshUI());
  }

  FutureOr<void> _contactsScreenEventOnPhonePress(
      ContactsScreenEventOnPhonePress event,
      Emitter<ContactsScreenState> emit) async {
    final phoneNumber = fixPhoneNumber(event.phoneNumber);
    await GeneralFunctions().openWeb('tel:$phoneNumber');
    // await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  FutureOr<void> _contactsScreenEventOnWhatsappPress(
      ContactsScreenEventOnWhatsappPress event,
      Emitter<ContactsScreenState> emit) async {
    final phoneNumber = fixPhoneNumber(event.phoneNumber);
    await GeneralFunctions()
        .openWeb('https://api.whatsapp.com/send?phone=$phoneNumber');
  }

  String fixPhoneNumber(String phoneNumber) =>
      '+972' +
      phoneNumber.replaceAll('-', '').substring(1, 4) +
      phoneNumber.replaceAll('-', '').substring(4);

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
      contacts: filteredContacts, searchOpen: searchOpen);

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
}
