import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';
import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/repos/contacts_repo.dart';
import 'package:tzamtzam_hadar/screens/contacts/bloc/contacts_screen_bloc.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';
import 'package:tzamtzam_hadar/widgets/cards/contact_card.dart';
import 'package:tzamtzam_hadar/widgets/dialogs/add_edit_contact_dialog.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ContactsRepo>(
      create: (context) => ContactsRepo(),
      child: BlocProvider(
        create: (context) => ContactsScreenBloc(context.read<ContactsRepo>())
          ..add(ContactsScreenEventInitialize()),
        child: BlocConsumer<ContactsScreenBloc, ContactsScreenState>(
          listenWhen: (previous, current) =>
              current is ContactsScreenStateNavigator,
          buildWhen: (previous, current) =>
              current is! ContactsScreenStateNavigator,
          listener: (context, state) async {
            final bloc = context.read<ContactsScreenBloc>();
            switch (state.runtimeType) {
              case const (ContactsScreenContactDialog):
                final contactData = await showDialog(
                  context: context,
                  builder: (context) => AddEditContactDialog(),
                );
                if (contactData != null) {
                  bloc.add(ContactsScreenEventOnAddNewContactClicked(
                    name: contactData.$1,
                    phoneNumber: contactData.$2,
                    group: contactData.$3,
                  ));
                }
            }
          },
          builder: (context, state) {
            final bloc = context.read<ContactsScreenBloc>();
            return Scaffold(
              appBar: appAppBar(
                  title: appTranslate('contacts'),
                  searchAppBar: state.searchOpen
                      ? (
                          appTranslate('search_contact'),
                          (searchInput) {
                            log(searchInput);
                            bloc.add(ContactsScreenEventOnSearchContact(
                                searchInput));
                          },
                        )
                      : null),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () =>
                    bloc.add(ContactsScreenEventOnNewContactClicked()),
                label: Text(appTranslate("add_contact")),
                icon: Icon(Icons.person_add_alt),
              ),
              body: state is ContactsScreenLoading
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox.shrink(),
                                Text(
                                  appTranslate('contacts'),
                                  style: AppTextStyle().title,
                                ),
                                IconButton(
                                    onPressed: () => bloc.add(
                                        ContactsScreenEventOnSearchToggleChange()),
                                    icon: Icon(state.searchOpen
                                        ? Icons.cancel_outlined
                                        : Icons.search))
                              ],
                            ),
                            kheasydevDivider(black: true),
                            SizedBox(height: 24),
                            ListView.separated(
                              shrinkWrap: true,
                              itemCount: state.contacts.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 32),
                              itemBuilder: (context, categoryIndex) {
                                final category =
                                    state.contacts.keys.toList()[categoryIndex];
                                final unTranslatedCategory = state
                                    .unTranslateContacts.keys
                                    .toList()[categoryIndex];
                                final contactsInCategory =
                                    state.contacts[category]!;

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: GestureDetector(
                                        onTap: () => bloc.add(contactsInCategory
                                                .isEmpty
                                            ? ContactsScreenEventOnOpenCategory(
                                                category)
                                            : ContactsScreenEventOnCloseCategory(
                                                category)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              category,
                                              style: AppTextStyle().cardTitle,
                                            ),
                                            SizedBox(width: 12),
                                            Icon(contactsInCategory.isEmpty
                                                ? Icons.arrow_downward
                                                : Icons.arrow_upward)
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: contactsInCategory.length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 16),
                                      itemBuilder: (context, index) {
                                        final contact =
                                            contactsInCategory[index];
                                        return ContactCard(
                                          name: contact.name,
                                          phoneNumber: contact.phoneNumber,
                                          onPhonePress: () => bloc.add(
                                              ContactsScreenEventOnPhonePress(
                                                  contact.phoneNumber)),
                                          onWhatsappPress: () => bloc.add(
                                              ContactsScreenEventOnWhatsappPress(
                                                  contact.phoneNumber)),
                                          onDelete: (context) => bloc.add(
                                              ContactsScreenEventOnDeleteContact(
                                                  name: contact.name,
                                                  group: unTranslatedCategory)),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
