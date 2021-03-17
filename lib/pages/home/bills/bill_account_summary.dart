import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/account_model.dart';
import 'package:financialapp/shared/typography/body2_text.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillAccountSummary extends StatelessWidget {
  const BillAccountSummary({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountModel>(
      builder: (_, account, __) => Row(
        children: <Widget>[
          Expanded(
            child: buildSummaryAccount(
              context,
              BillsTabPageTextKeys.titleToPayCard,
              0, // TODO Fix amount to pay
            ),
          ),
          Expanded(
            child: buildSummaryAccount(
              context,
              BillsTabPageTextKeys.titleAccountMoneyCard,
              account.amount,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSummaryAccount(context, String titleKey, double amount) {
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
            Body2Text.key(
              titleKey,
              textColor: Colors.white,
            ),
            SubtitleText(
              amount.monetize,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
