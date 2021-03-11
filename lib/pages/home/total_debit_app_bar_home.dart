import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/shared/typography/headline_text.dart';
import 'package:financialapp/states/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalDebitAppBarHome extends StatelessWidget {
  void goToUpdateAccountMoney(context) {
    Navigator.of(context).pushNamed(RouterManager.ACCOUNT_MONEY_UPDATE);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardState>(
      builder: (_, state, __) {
        return GestureDetector(
          onTap: () => goToUpdateAccountMoney(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: HeadlineText(
                state.dashboard?.totalRemainingDebitMonetized ?? '',
                textColor: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
