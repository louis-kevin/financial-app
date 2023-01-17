import 'package:easy_typography/easy_typography.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/states/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DaysUntilIncome extends StatefulWidget {
  @override
  _DaysUntilIncomeState createState() => _DaysUntilIncomeState();
}

class _DaysUntilIncomeState extends State<DaysUntilIncome> {
  void goToSettings(context) {
    Navigator.of(context).pushNamed(RouterManager.SETTINGS);
  }

  @override
  Widget build(BuildContext context) {
    var dashboard = context.watch<DashboardState>().dashboard;
    if (dashboard == null) return Container();

    var percentageBar = dashboard.percentageUntilIncome;
    var percentageText = percentageBar < 0.1 ? 0.1 : percentageBar;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              BodyMediumText.key(
                SummaryTabPageTextKeys.titleDaysUntilNextIncomeCard,
                textColor: Theme.of(context).primaryColorDark,
              ),
              IconButton(
                onPressed: () => goToSettings(context),
                color: Color(0xFF202233),
                icon: Icon(Icons.settings),
                iconSize: 20,
              )
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: percentageText,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  LabelLargeText(
                    dashboard.todayFormatted ?? '',
                    textColor: Theme.of(context).primaryColorDark,
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFFEDEFF3),
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentageBar,
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Color(0xFF5240FF),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                BodyMediumText(
                  dashboard.lastPaymentFormatted ?? '',
                ),
                BodyMediumText(
                  dashboard.nextPaymentFormatted ?? '',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
