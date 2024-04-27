part of 'contacts_screen_bloc.dart';

@immutable
abstract class ContactsScreenEvent {}

class ContactsScreenEventInitialize extends ContactsScreenEvent {
  final Map<String, List<ContactModel>> contacts;
  ContactsScreenEventInitialize(this.contacts);
}

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
