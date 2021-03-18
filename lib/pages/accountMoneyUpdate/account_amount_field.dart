import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/shared/inputs/amount_input.dart';
import 'package:financialapp/shared/typography/display1_text.dart';
import 'package:flutter/material.dart';

class AccountAmountField extends StatefulWidget {
  final AccountModel account;

  AccountAmountField({Key key, this.account}) : super(key: key);

  @override
  _AccountAmountFieldState createState() => _AccountAmountFieldState();
}

class _AccountAmountFieldState extends State<AccountAmountField> {
  MoneyMaskedTextController controller;

  @override
  void initState() {
    controller = new MoneyMaskedTextController(
        decimalSeparator: MoneyTextKeys.decimalSeparator.i18n,
        thousandSeparator: MoneyTextKeys.thousandSeparator.i18n,
        leftSymbol: MoneyTextKeys.leftSymbol.i18n,
        initialValue: widget.account.amount);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Display1Text(
                widget.account.name,
              ),
            ),
            Expanded(
              child: AmountInput(
                context,
                controller,
                value: widget.account.amount,
                name: widget.account.id.toString(),
                decoration: InputDecoration(),
              ),
            )
          ],
        ),
        Divider(
          color: widget.account.color,
          thickness: 1,
        ),
      ],
    );
  }
}
