import 'package:easy_typography/easy_typography.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/states/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoneyPerDayCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<DashboardState>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color(0xFF363D50),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.attach_money,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              BodyMediumText.key(
                SummaryTabPageTextKeys.titleMoneyPerDayCard,
                textColor: Colors.white,
              ),
              BodyMediumText(
                state.dashboard.overheadPerDayMonetized ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
