import 'package:easy_typography/easy_typography.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/shared/inputs/amount_input.dart';
import 'package:flutter/material.dart';

class AccountAmountField extends StatefulWidget {
  final AccountModel account;

  AccountAmountField({Key key, this.account}) : super(key: key);

  @override
  _AccountAmountFieldState createState() => _AccountAmountFieldState();
}

class _AccountAmountFieldState extends State<AccountAmountField> {
  final controller = MoneyMaskedTextController(
    decimalSeparator: MoneyTextKeys.decimalSeparator.i18n,
    thousandSeparator: MoneyTextKeys.thousandSeparator.i18n,
    leftSymbol: MoneyTextKeys.leftSymbol.i18n,
  );

  @override
  void initState() {
    controller.updateValue(widget.account.amount);

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
              child: DisplaySmallText(
                widget.account.name,
              ),
            ),
            Expanded(
              child: AmountInput(
                context,
                controller,
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
