import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/shared/inputs/amount_input.dart';
import 'package:financialapp/shared/typography/display1_text.dart';
import 'package:flutter/material.dart';

class AccountAmountField extends StatelessWidget {
  final AccountModel account;

  const AccountAmountField({Key key, this.account}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Display1Text(
                account.name,
              ),
            ),
            Expanded(
              child: AmountInput(
                context,
                value: account.amount,
                name: account.id.toString(),
                decoration: InputDecoration(),
              ),
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
