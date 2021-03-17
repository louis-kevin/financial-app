import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/bill_model.dart';
import 'package:financialapp/pages/home/bills/bill_account_summary.dart';
import 'package:financialapp/pages/home/bills/bill_card.dart';
import 'package:financialapp/pages/home/bills/checkable_bill_card.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/shared/typography/display1_text.dart';
import 'package:financialapp/states/bill_state.dart';
import 'package:financialapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:provider/provider.dart';

class BillsContent extends StatefulWidget {
  @override
  _BillsContentState createState() => _BillsContentState();
}

class _BillsContentState extends State<BillsContent> {
  List<BillModel> bills = [];

  Color color;

  sumBills() {
    double sum = 0;
    bills.forEach((item) => sum += item.amount);
    return sum;
  }

  void updateBill(BillModel bill, bool value) {
    var billInList = bills.firstWhere((item) => item.id == bill.id);

    billInList.payed = value;

    setState(() {});
  }

  void goToAddBill() {
    Navigator.of(context).pushNamed(RouterManager.BILL);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(fetchBills);
  }

  Future<List<BillModel>> fetchBills() {
    var state = Provider.of<BillState>(context, listen: false);
    color = state.account.color;

    return state.fetchBills();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BillState>(
      builder: (_, state, __) {
        bills = state.bills;

        if (bills == null) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        List<Widget> content = [
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 8,
                ),
                child: ChangeNotifierProvider.value(
                  value: state.account,
                  child: BillAccountSummary(),
                ),
              ),
            ]),
          ),
        ];

        if (this.bills.isEmpty) {
          content.add(buildEmptyBills());
        } else {
          content.addAll(buildBills());
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: RefreshIndicator(
            onRefresh: fetchBills,
            child: CustomScrollView(
              slivers: content,
            ),
          ),
        );
      },
    );
  }

  List<Widget> buildBills() {
    return [
      buildStickHeader(BillsTabPageTextKeys.titleOnceList, buildOnce),
      buildStickHeader(BillsTabPageTextKeys.titleDailyList, buildDaily),
      buildStickHeader(BillsTabPageTextKeys.titleMonthlyList, buildMonthly),
    ];
  }

  Widget buildTitle(String titleKey, Function onPress) {
    return Container(
      color: DefaultColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Display1Text.key(
              titleKey,
              textColor: DefaultColors.subtitleColor,
            ),
            IconButton(
              onPressed: () => goToAddBill,
              icon: Icon(
                Icons.add,
                color: DefaultColors.subtitleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmptyBills() {
    return SliverList(
      delegate: SliverChildListDelegate([
        Center(
          child: RaisedButton(
            elevation: 0,
            onPressed: goToAddBill,
            color: DefaultColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Display1Text.key(BillsTabPageTextKeys.btnCreateBill),
            ),
          ),
        )
      ]),
    );
  }

  buildOnce() {
    List<BillModel> onceBills =
        bills.where((item) => item.type == BillType.once).toList();
    return buildCheckableCards(onceBills);
  }

  Widget buildDaily() {
    List<BillModel> dailyBills =
        bills.where((item) => item.type == BillType.daily).toList();

    return SliverList(
      delegate: SliverChildListDelegate(
        dailyBills.map(buildDailyCard).toList(),
      ),
    );
  }

  Widget buildDailyCard(BillModel bill) {
    return ChangeNotifierProvider.value(
      value: bill,
      child: BillCard(color: color),
    );
  }

  Widget buildMonthly() {
    List<BillModel> monthlyBills =
        bills.where((item) => item.type == BillType.monthly).toList();

    return buildCheckableCards(monthlyBills);
  }

  Widget buildCheckableCards(List<BillModel> list) {
    return SliverList(
      delegate: SliverChildListDelegate(
        list.map(buildCheckableCard).toList(),
      ),
    );
  }

  Widget buildCheckableCard(BillModel bill) {
    return ChangeNotifierProvider.value(
      value: bill,
      child: CheckableBillCard(color: color),
    );
  }

  buildStickHeader(String titleKey, Function() buildChildren) {
    return SliverStickyHeader(
      header: buildTitle(titleKey, () => {}),
      sliver: buildChildren(),
    );
  }
}
