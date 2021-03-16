import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/shared/typography/body2_text.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:financialapp/states/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoneyPerDayCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              Body2Text.key(
                SummaryTabPageTextKeys.titleMoneyPerDayCard,
                textColor: Colors.white,
              ),
              Consumer<DashboardState>(
                builder: (_, state, __) {
                  return SubtitleText(
                    state.dashboard?.overheadPerDayMonetized ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
