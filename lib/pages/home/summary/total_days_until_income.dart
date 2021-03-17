import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/shared/typography/body2_text.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:financialapp/states/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalDaysUntilIncome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<DashboardState>();

    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        // buildTotalDaysUntilIncome(
        //   SummaryTabPageTextKeys.holidays,
        //   state.dashboard?.holidays,
        // ),
        buildTotalDaysUntilIncome(
          SummaryTabPageTextKeys.businessDays,
          state.dashboard?.weekdaysUntilPayment,
        ),
        buildTotalDaysUntilIncome(
          SummaryTabPageTextKeys.weekendDays,
          state.dashboard?.weekendUntilPayment,
        ),
      ],
    );
  }

  Widget buildTotalDaysUntilIncome(title, days) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(0xFF363D50),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.calendar_today,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Body2Text.key(
                  title,
                  textColor: Colors.white,
                ),
                SubtitleText(
                  days?.toString() ?? '',
                  textColor: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
