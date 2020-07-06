import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/pages/accounts/account_item_list.dart';
import 'package:financialapp/routes/router.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/states/account_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountsPage extends StatelessWidget {
  goToFormAccount(BuildContext context) {
    Navigator.of(context).pushNamed(Router.ACCOUNT);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountState>(builder: (_, state, __) {
      return BaseBackButtonPage(
        titleKey: AccountsPageTextKeys.title,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => goToFormAccount(context),
            color: Colors.white,
          ),
        ],
        content: buildAccounts(state.accounts),
      );
    });
  }

  List<Widget> buildAccounts(List<AccountModel> accounts) {
    return accounts.map(buildAccount).toList();
  }

  Widget buildAccount(AccountModel account) {
    return ChangeNotifierProvider.value(
      value: account,
      child: AccountItemList(),
    );
  }
}
