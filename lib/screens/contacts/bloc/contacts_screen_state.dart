part of 'contacts_screen_bloc.dart';

@immutable
abstract class ContactsScreenState {
  final Map<String, List<ContactModel>> contacts;
  final bool searchOpen;

  ContactsScreenState({required this.contacts, required this.searchOpen});
}

final class ContactsScreenLoading extends ContactsScreenState {
  ContactsScreenLoading({required super.contacts, required super.searchOpen});
}

final class ContactsScreenInitial extends ContactsScreenState {
  ContactsScreenInitial({required super.contacts, required super.searchOpen});
}

final class ContactsScreenRefreshUI extends ContactsScreenState {
  ContactsScreenRefreshUI({required super.contacts, required super.searchOpen});
}
