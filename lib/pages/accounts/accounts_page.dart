import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/pages/accounts/account_item_list.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/states/account_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  goToFormAccount(BuildContext context) {
    Navigator.of(context).pushNamed(RouterManager.ACCOUNT);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AccountState>().fetchAccounts());
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AccountState>();

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
