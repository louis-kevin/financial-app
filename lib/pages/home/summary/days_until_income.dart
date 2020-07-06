import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/routes/router.dart';
import 'package:financialapp/shared/typography/body2_text.dart';
import 'package:financialapp/shared/typography/subhead_text.dart';
import 'package:financialapp/states/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DaysUntilIncome extends StatefulWidget {
  @override
  _DaysUntilIncomeState createState() => _DaysUntilIncomeState();
}

class _DaysUntilIncomeState extends State<DaysUntilIncome> {
  double daysPercent = 0.8;

  void goToSettings(context) {
    Navigator.of(context).pushNamed(Router.SETTINGS);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardState>(
      builder: (_, state, __) {
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
                  Body2Text.key(
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
                  widthFactor: state.dashboard?.percentageUntilIncome,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SubheadText(
                        state.dashboard?.todayFormatted ?? '',
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
                    widthFactor: state.dashboard?.percentageUntilIncome,
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
                    Body2Text(
                      state.dashboard?.lastPaymentFormatted ?? '',
                    ),
                    Body2Text(
                      state.dashboard?.nextPaymentFormatted ?? '',
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
