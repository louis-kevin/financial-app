import 'package:financialapp/pages/home/summary/days_until_income.dart';
import 'package:financialapp/pages/home/summary/money_per_day_card.dart';
import 'package:financialapp/pages/home/summary/total_days_until_income.dart';
import 'package:financialapp/pages/home/summary/totals_cards.dart';
import 'package:flutter/material.dart';

import 'account_cards.dart';

class SummaryTab extends StatefulWidget {
  @override
  _SummaryTabState createState() => _SummaryTabState();
}

class _SummaryTabState extends State<SummaryTab> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        AccountCards(),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MoneyPerDayCard(),
              ),
              Container(
                height: 170,
                child: TotalsCards(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DaysUntilIncome(),
              ),
              Container(
                height: 80,
                child: TotalDaysUntilIncome(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
