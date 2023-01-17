import 'package:easy_typography/easy_typography.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/states/account_state.dart';
import 'package:financialapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountRemovalDialog extends StatelessWidget {
  final AccountModel account;

  const AccountRemovalDialog({Key key, this.account}) : super(key: key);

  removeAccount(BuildContext context) {
    Navigator.of(context).pop(true);

    var state = context.read<AccountState>();

    state.deleteAccount(account);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: DefaultColors.backgroundColor,
      title: DisplaySmallText.key(DialogsTextKeys.accountRemovalTitle),
      actions: <Widget>[
        TextButton(
          child: BodyMediumText.key(
            DialogsTextKeys.btnCancel,
          ),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: BodyMediumText.key(
            DialogsTextKeys.btnYes,
            style: TextStyle(color: Colors.redAccent),
          ),
          onPressed: () => removeAccount(context),
        ),
      ],
    );
  }
}
