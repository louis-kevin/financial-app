import 'package:financialapp/states/account_state.dart';
import 'package:financialapp/states/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'account_cards.dart';
import 'days_until_income.dart';
import 'money_per_day_card.dart';
import 'total_days_until_income.dart';
import 'totals_cards.dart';

class SummaryTab extends StatelessWidget {
  Future<void> refresh(BuildContext context) async {
    context.read<DashboardState>().fetchDashboard();
    context.read<AccountState>().fetchAccounts();
    return;
  }

  @override
  Widget build(BuildContext context) {
    var dashboard = context.watch<DashboardState>().dashboard;
    if (dashboard == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return RefreshIndicator(
      onRefresh: () => refresh(context),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: 100,
                  child: AccountCards(),
                ),
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
      ),
    );
  }
}
