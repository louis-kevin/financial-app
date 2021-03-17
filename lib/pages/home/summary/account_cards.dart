import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/shared/typography/display1_text.dart';
import 'package:financialapp/shared/typography/subhead_text.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:financialapp/states/dashboard_state.dart';
import 'package:financialapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountCards extends StatelessWidget {
  goToAccountForm(context) {
    Navigator.of(context).pushNamed(RouterManager.ACCOUNT);
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<DashboardState>();
    var accounts = state.dashboard.accounts;

    if (accounts == null || accounts.isEmpty) {
      return buildEmptyAccounts(context);
    }

    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: accounts.length,
        itemBuilder: (context, index) => buildAccountCard(accounts[index]),
      ),
    );
  }

  Widget buildAccountCard(AccountModel account) {
    return AccountCard(account);
  }

  Widget buildEmptyAccounts(context) {
    return Center(
      child: RaisedButton(
        elevation: 0,
        onPressed: () => goToAccountForm(context),
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

class AccountCard extends StatelessWidget {
  final AccountModel account;

  AccountCard(this.account);

  void goToUpdateAccountMoney(context) {
    Navigator.of(context).pushNamed(RouterManager.ACCOUNT_MONEY_UPDATE);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width / 2.35;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: account.color,
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FittedBox(
                  child: SubheadText(
                    account.name,
                    textColor: Colors.white,
                  ),
                ),
                FittedBox(
                  child: SubtitleText(
                    account.amountMonetized,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () => goToUpdateAccountMoney(context),
              icon: Icon(Icons.autorenew),
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
