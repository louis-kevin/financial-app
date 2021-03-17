import 'package:carousel_slider/carousel_slider.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/routes/router_arguments.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/shared/typography/display2_text.dart';
import 'package:financialapp/states/account_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountsTabBar extends StatefulWidget {
  final TabController controller;
  final Function(int index) onChangeTab;

  AccountsTabBar({Key key, this.controller, this.onChangeTab})
      : super(key: key);

  @override
  _AccountsTabBarState createState() => _AccountsTabBarState();
}

class _AccountsTabBarState extends State<AccountsTabBar> {
  CarouselController carouselController = CarouselController();
  int accountsIndex = 0;

  void changeTab(index, _) {
    setState(() => accountsIndex = index);

    widget.onChangeTab(index);
  }

  goToAccountForm(AccountModel account) {
    Navigator.of(context).pushNamed(
      RouterManager.ACCOUNT,
      arguments: RouteArguments(model: account),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountState>(
      builder: (_, state, __) {
        return CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            height: 60.0,
            enableInfiniteScroll: false,
            viewportFraction: 0.4,
            onPageChanged: changeTab,
          ),
          items: buildAccounts(state.accounts),
        );
      },
    );
  }

  List<Widget> buildAccounts(List<AccountModel> accounts) {
    return accounts.asMap().entries.map(buildAccountCard).toList();
  }

  Widget buildAccountCard(MapEntry item) {
    AccountModel account = item.value;
    int index = item.key;

    return GestureDetector(
      onTap: () => carouselController.animateToPage(
        index,
        duration: Duration(milliseconds: 100),
        curve: Curves.fastOutSlowIn,
      ),
      onLongPress: () => goToAccountForm(account),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: accountsIndex == index ? 1 : 0.8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: FittedBox(
                child: Display2Text(
                  account.name,
                  textColor: account.color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
