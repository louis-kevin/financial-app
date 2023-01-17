import 'package:easy_typography/easy_typography.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/routes/router_arguments.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/shared/dialogs/account_removal_dialog.dart';
import 'package:flutter/material.dart';

class AccountItemList extends StatelessWidget {
  final AccountModel account;

  const AccountItemList({Key key, this.account}) : super(key: key);

  void goToFormAccount(BuildContext context, AccountModel account) {
    Navigator.of(context).pushNamed(
      RouterManager.ACCOUNT,
      arguments: RouteArguments(model: account),
    );
  }

  deleteAccount(BuildContext context, AccountModel account) {
    showDialog(
      context: context,
      builder: (_) => AccountRemovalDialog(account: account),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: DisplaySmallText(
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
  }
}
