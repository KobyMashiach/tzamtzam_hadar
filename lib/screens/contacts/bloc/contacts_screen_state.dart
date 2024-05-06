// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contacts_screen_bloc.dart';

@immutable
abstract class ContactsScreenState {
  final Map<String, List<ContactModel>> contacts;
  final bool searchOpen;
  final bool showAllContacts;
  final Map<String, List<ContactModel>> unTranslateContacts;

  ContactsScreenState({
    required this.contacts,
    required this.searchOpen,
    required this.showAllContacts,
    required this.unTranslateContacts,
  });
}

final class ContactsScreenLoading extends ContactsScreenState {
  ContactsScreenLoading(
      {required super.contacts,
      required super.searchOpen,
      required super.unTranslateContacts,
      required super.showAllContacts});
}

final class ContactsScreenInitial extends ContactsScreenState {
  ContactsScreenInitial(
      {required super.contacts,
      required super.searchOpen,
      required super.unTranslateContacts,
      required super.showAllContacts});
}

final class ContactsScreenRefreshUI extends ContactsScreenState {
  ContactsScreenRefreshUI(
      {required super.contacts,
      required super.searchOpen,
      required super.unTranslateContacts,
      required super.showAllContacts});
}

@immutable
abstract class ContactsScreenStateNavigator extends ContactsScreenState {
  ContactsScreenStateNavigator(
      {required super.contacts,
      required super.searchOpen,
      required super.unTranslateContacts,
      required super.showAllContacts});
}

final class ContactsScreenContactDialog extends ContactsScreenStateNavigator {
  ContactsScreenContactDialog(
      {required super.contacts,
      required super.searchOpen,
      required super.unTranslateContacts,
      required super.showAllContacts});
}

final class ContactsScreenContactEditDialog
    extends ContactsScreenStateNavigator {
  final String name;
  final String phoneNumber;
  final String group;

  ContactsScreenContactEditDialog(
      {required super.contacts,
      required super.searchOpen,
      required super.unTranslateContacts,
      required this.name,
      required this.phoneNumber,
      required this.group,
      required super.showAllContacts});
}
