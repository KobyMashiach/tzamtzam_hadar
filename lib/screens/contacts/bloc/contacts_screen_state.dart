// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contacts_screen_bloc.dart';

@immutable
abstract class ContactsScreenState {
  final Map<String, List<ContactModel>> contacts;
  final bool searchOpen;
  final Map<String, List<ContactModel>> unTranslateContacts;

  ContactsScreenState({
    required this.contacts,
    required this.searchOpen,
    required this.unTranslateContacts,
  });
}

final class ContactsScreenLoading extends ContactsScreenState {
  ContactsScreenLoading(
      {required super.contacts,
      required super.searchOpen,
      required super.unTranslateContacts});
}

final class ContactsScreenInitial extends ContactsScreenState {
  ContactsScreenInitial(
      {required super.contacts,
      required super.searchOpen,
      required super.unTranslateContacts});
}

final class ContactsScreenRefreshUI extends ContactsScreenState {
  ContactsScreenRefreshUI(
      {required super.contacts,
      required super.searchOpen,
      required super.unTranslateContacts});
}

@immutable
abstract class ContactsScreenStateNavigator extends ContactsScreenState {
  ContactsScreenStateNavigator(
      {required super.contacts,
      required super.searchOpen,
      required super.unTranslateContacts});
}

final class ContactsScreenContactDialog extends ContactsScreenStateNavigator {
  ContactsScreenContactDialog(
      {required super.contacts,
      required super.searchOpen,
      required super.unTranslateContacts});
}
