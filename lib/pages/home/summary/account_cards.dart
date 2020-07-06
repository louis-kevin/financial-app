import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/routes/router.dart';
import 'package:financialapp/shared/typography/subhead_text.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:financialapp/states/account_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountState>(
      builder: (_, state, __) {
        return SliverGrid.count(
          crossAxisCount: 2,
          childAspectRatio: 16 / 8,
          children: state.accounts.map(buildAccountCard).toList(),
        );
      },
    );
  }

  Widget buildAccountCard(AccountModel account) {
    return ChangeNotifierProvider.value(
      value: account,
      child: AccountCard(),
    );
  }
}

class AccountCard extends StatelessWidget {
  void goToUpdateAccountMoney(context) {
    Navigator.of(context).pushNamed(Router.ACCOUNT_MONEY_UPDATE);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountModel>(
      builder: (_, account, __) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
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
                    SubtitleText(
                      account.amount.monetize,
                      textColor: Colors.white,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => goToUpdateAccountMoney(context),
                  icon: account.busy
                      ? CircularProgressIndicator()
                      : Icon(Icons.autorenew),
                  color: Colors.white,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
