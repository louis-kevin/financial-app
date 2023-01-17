import 'package:easy_typography/easy_typography.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/states/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalDebitAppBarHome extends StatelessWidget {
  void goToUpdateAccountMoney(context) {
    Navigator.of(context).pushNamed(RouterManager.ACCOUNT_MONEY_UPDATE);
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<DashboardState>();
    return GestureDetector(
      onTap: () => goToUpdateAccountMoney(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: HeadlineMediumText(
            state.dashboard?.totalRemainingDebitMonetized ?? '',
            textColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
