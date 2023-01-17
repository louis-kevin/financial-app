import 'package:easy_typography/easy_typography.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/routes/router_manager.dart';
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
    with AutomaticKeepAliveClientMixin {
  PageController pageController = PageController();
  List<BillState> bills = [];

  bool get wantKeepAlive => true;

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
    return ChangeNotifierProvider.value(
      value: account.billState,
      child: BillsContent(),
    );
  }

  Widget buildAccountsEmpty() {
    return Center(
      child: TextButton(
        onPressed: () => goToAccountForm(),
        style: TextButton.styleFrom(
          backgroundColor: DefaultColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DisplaySmallText.key(BillsTabPageTextKeys.btnCreateAccount),
        ),
      ),
    );
  }
}
