import 'package:easy_typography/easy_typography.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/states/bill_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillAccountSummary extends StatelessWidget {
  const BillAccountSummary({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var account = context.watch<BillState>().account;
    return Row(
      children: <Widget>[
        Expanded(
          child: buildSummaryAccount(
              context,
              BillsTabPageTextKeys.titleToPayCard,
              account.toPayMonetized,
              Colors.red),
        ),
        Expanded(
          child: buildSummaryAccount(
              context,
              BillsTabPageTextKeys.titleAccountMoneyCard,
              account.amountMonetized,
              Colors.green),
        ),
      ],
    );
  }

  Widget buildSummaryAccount(
      context, String titleKey, String amountMonetized, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Theme.of(context).colorScheme.secondary,
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BodyMediumText.key(
              titleKey,
              textColor: color,
            ),
            BodyMediumText(
              amountMonetized,
              textColor: color,
            ),
          ],
        ),
      ),
    );
  }
}
