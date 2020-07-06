import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/routes/router.dart';
import 'package:financialapp/routes/router_arguments.dart';
import 'package:financialapp/shared/dialogs/account_removal_dialog.dart';
import 'package:financialapp/shared/typography/display1_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountItemList extends StatelessWidget {
  void goToFormAccount(BuildContext context, AccountModel account) {
    Navigator.of(context).pushNamed(
      Router.ACCOUNT,
      arguments: RouteArguments(model: account),
    );
  }

  deleteAccount(BuildContext context, AccountModel account) {
    showDialog(
      context: context,
      child: AccountRemovalDialog(
        account: account,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountModel>(
      builder: (_, account, __) {
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Display1Text(
                    account.name,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () => goToFormAccount(context, account),
                      icon: Icon(Icons.edit),
                      color: Colors.white,
                    ),
                    IconButton(
                      onPressed: () => deleteAccount(context, account),
                      icon: Icon(Icons.delete),
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
            Divider(
              color: account.color,
              thickness: 1,
            ),
          ],
        );
      },
    );
  }
}
