import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/shared/typography/display1_text.dart';
import 'package:financialapp/states/account_state.dart';
import 'package:financialapp/states/bill_state.dart';
import 'package:financialapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'accounts_tab_bar.dart';
import 'bills_content.dart';

class BillsTab extends StatefulWidget {
  @override
  _BillsTabState createState() => _BillsTabState();
}

class _BillsTabState extends State<BillsTab>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  PageController pageController = PageController();

  bool get wantKeepAlive => false;

  changeTab(int index) {
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInCubic,
    );
  }

  goToAccountForm() async {
    Navigator.of(context).pushNamed(RouterManager.ACCOUNT);
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AccountState>();
    if (state.accounts.isEmpty) {
      return buildAccountsEmpty();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: AccountsTabBar(onChangeTab: changeTab),
        ),
        Expanded(
          child: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: state.accounts.map(buildAccount).toList(),
          ),
        )
      ],
    );
  }

  Widget buildAccount(AccountModel account) {
    var state = BillState(account);
    return ChangeNotifierProvider.value(
      value: state,
      child: BillsContent(),
    );
  }

  Widget buildAccountsEmpty() {
    return Center(
      child: RaisedButton(
        elevation: 0,
        onPressed: () => goToAccountForm(),
        color: DefaultColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Display1Text.key(BillsTabPageTextKeys.btnCreateAccount),
        ),
      ),
    );
  }
}
