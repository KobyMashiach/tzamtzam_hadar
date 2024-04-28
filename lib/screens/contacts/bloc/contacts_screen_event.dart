part of 'contacts_screen_bloc.dart';

@immutable
abstract class ContactsScreenEvent {}

class ContactsScreenEventInitialize extends ContactsScreenEvent {}

class ContactsScreenEventOnPhonePress extends ContactsScreenEvent {
  final String phoneNumber;
  ContactsScreenEventOnPhonePress(this.phoneNumber);
}

class ContactsScreenEventOnWhatsappPress extends ContactsScreenEvent {
  final String phoneNumber;
  ContactsScreenEventOnWhatsappPress(this.phoneNumber);
}

class ContactsScreenEventOnSearchToggleChange extends ContactsScreenEvent {}

class ContactsScreenEventOnSearchContact extends ContactsScreenEvent {
  final String nameOrPhone;
  ContactsScreenEventOnSearchContact(this.nameOrPhone);
}

class ContactsScreenEventOnCloseCategory extends ContactsScreenEvent {
  final String category;
  ContactsScreenEventOnCloseCategory(this.category);
}

class ContactsScreenEventOnOpenCategory extends ContactsScreenEvent {
  final String category;
  ContactsScreenEventOnOpenCategory(this.category);
}

class ContactsScreenEventOnNewContactClicked extends ContactsScreenEvent {}

class ContactsScreenEventOnAddNewContactClicked extends ContactsScreenEvent {
  final String name;
  final String phoneNumber;
  final String group;

  ContactsScreenEventOnAddNewContactClicked(
      {required this.name, required this.phoneNumber, required this.group});
}

class ContactsScreenEventOnDeleteContact extends ContactsScreenEvent {
  final String name;
  final String group;
  ContactsScreenEventOnDeleteContact({required this.name, required this.group});
}
