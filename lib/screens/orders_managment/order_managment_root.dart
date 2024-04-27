import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kh_easy_dev/kh_easy_dev.dart';
import 'package:kh_easy_dev/widgets/navigate_page.dart';
import 'package:tzamtzam_hadar/core/colors.dart';
import 'package:tzamtzam_hadar/core/text_styles.dart';

import 'package:tzamtzam_hadar/core/translates/get_tran.dart';
import 'package:tzamtzam_hadar/screens/orders_managment/bloc/order_managment_root_bloc.dart';
import 'package:tzamtzam_hadar/services/general_lists.dart';
import 'package:tzamtzam_hadar/widgets/general/appbar.dart';
import 'package:tzamtzam_hadar/widgets/general/side_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderManagmentRoot extends StatelessWidget {
  static const routeName = '/homePage';
  OrderManagmentRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final cardHeight = screenHeight * 0.05;
    final mainCategoriesPages = globalMainCategoriesTranslated;
    return BlocProvider(
      create: (context) =>
          OrderManagmentRootBloc()..add(HomePageEventInitial()),
      child: BlocConsumer<OrderManagmentRootBloc, OrderManagmentRootState>(
        listenWhen: (previous, current) => current is HomePageNavigationState,
        buildWhen: (previous, current) => current is! HomePageNavigationState,
        listener: (context, state) async {
          if (state is HomePageCategoryNavigation) {
            //TODO: add settings to kheasydev
            KheasydevNavigatePage().push(context,
                mainCategoriesPages.entries.elementAt(state.page).value);
            // Navigator.of(context).push(MaterialPageRoute(
            //     settings: RouteSettings(name: HomePage.routeName),
            //     builder: (context) =>
            //         mainCategoriesPages.entries.elementAt(state.page).value));
          }
        },
        builder: (context, state) {
          final bloc = context.read<OrderManagmentRootBloc>();
          return PopScope(
            canPop: false,
            child: Scaffold(
              appBar: appAppBar(title: appTranslate('orders_managment')),
              drawer: appSideMenu(context, index: 1),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 24),
                      Image.asset(
                        "assets/logo.png",
                        height: screenHeight * 0.2,
                      ),
                      Text(
                        appTranslate("orders_managment"),
                        style: AppTextStyle().title,
                      ),
                      kheasydevDivider(black: true, height: 2),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.separated(
                          itemCount: mainCategoriesPages.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final category =
                                mainCategoriesPages.entries.elementAt(index);
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                log("Move to page: ${category.value.toString()}");
                                bloc.add(HomePageEventNavigateToPage(
                                    pageIndex: index));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Card(
                                  elevation: 8.0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: AppColor.primaryColor),
                                    child: ListTile(
                                        leading: Container(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  right: BorderSide(
                                                      width: 1.0,
                                                      color: Colors.black26))),
                                          child: const Icon(Icons.store,
                                              color: Colors.black),
                                        ),
                                        title: RowBranchText(
                                            cardHeight: cardHeight,
                                            category: category.key),
                                        trailing: const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black,
                                            size: 30.0)),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RowBranchText extends StatelessWidget {
  const RowBranchText({
    super.key,
    required this.cardHeight,
    required this.category,
  });

  final double cardHeight;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      height: cardHeight,
      child: Text(
        category,
        style: AppTextStyle().mainListValues,
        textAlign: TextAlign.center,
      ),
    );
  }
}
