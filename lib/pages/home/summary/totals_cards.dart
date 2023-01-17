import 'package:easy_typography/easy_typography.dart';
import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/states/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalsCards extends StatefulWidget {
  @override
  _TotalsCardsState createState() => _TotalsCardsState();
}

class _TotalsCardsState extends State<TotalsCards> {
  int totalCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    var state = context.watch<DashboardState>();
    return Column(
      children: <Widget>[
        Expanded(
          child: PageView(
            onPageChanged: (page) => setState(() => totalCardIndex = page),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              TotalsCard(
                titleKey: SummaryTabPageTextKeys.titleTotalDebitCard,
                amount: state.dashboard.totalAmount ?? 0,
              ),
            ],
          ),
        ),
        buildIndicators()
      ],
    );
  }

  buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 150),
          margin: EdgeInsets.symmetric(horizontal: 8),
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            color: totalCardIndex == 0
                ? Colors.white
                : Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}

class TotalsCard extends StatelessWidget {
  final String titleKey;
  final double amount;

  const TotalsCard({Key key, this.titleKey, this.amount}) : super(key: key);

  void goToUpdateAccountMoney(context) {
    Navigator.of(context).pushNamed(RouterManager.ACCOUNT_MONEY_UPDATE);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(0xFF52AF5C),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                HeadlineMediumText.key(
                  titleKey,
                  textColor: Colors.white,
                ),
                IconButton(
                  onPressed: () => goToUpdateAccountMoney(context),
                  color: Colors.white,
                  icon: Icon(Icons.autorenew),
                )
              ],
            ),
            FittedBox(
              child: DisplayMediumText(
                amount.monetize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
