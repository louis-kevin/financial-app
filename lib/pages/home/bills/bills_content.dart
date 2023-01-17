import 'package:easy_typography/easy_typography.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/bill_model.dart';
import 'package:financialapp/pages/home/bills/bill_account_summary.dart';
import 'package:financialapp/pages/home/bills/bill_card.dart';
import 'package:financialapp/pages/home/bills/checkable_bill_card.dart';
import 'package:financialapp/routes/router_arguments.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/states/bill_state.dart';
import 'package:financialapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:provider/provider.dart';

class BillsContent extends StatefulWidget {
  @override
  _BillsContentState createState() => _BillsContentState();
}

class _BillsContentState extends State<BillsContent>
    with AutomaticKeepAliveClientMixin {
  Color color;

  @override
  bool get wantKeepAlive => true;

  void goToAddBill() {
    var state = context.read<BillState>();

    Navigator.of(context).pushNamed(
      RouterManager.BILL,
      arguments: RouteArguments(
        state: (page) => ChangeNotifierProvider.value(
          value: state,
          child: page,
        ),
      ),
    );
  }

  Future<List<BillModel>> fetchBills() {
    var state = context.read<BillState>();
    color = state.account.color;

    return state.fetchBills();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(fetchBills);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var state = context.watch<BillState>();
    var bills = state.bills;

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
            child: BillAccountSummary(),
          ),
        ]),
      ),
    ];

    if (state.bills.isEmpty) {
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
            DisplaySmallText.key(
              titleKey,
              textColor: DefaultColors.subtitleColor,
            ),
            IconButton(
              onPressed: onPress,
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
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: DefaultColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: goToAddBill,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DisplaySmallText.key(BillsTabPageTextKeys.btnCreateBill),
            ),
          ),
        )
      ]),
    );
  }

  Widget buildOnce() {
    var bills = context.read<BillState>().bills;

    List<BillModel> onceBills =
        bills.where((item) => item.repetitionType == BillType.once).toList();
    return buildCheckableCards(onceBills);
  }

  Widget buildDaily() {
    var bills = context.read<BillState>().bills;
    List<BillModel> dailyBills =
        bills.where((item) => item.repetitionType == BillType.daily).toList();

    return SliverList(
      delegate: SliverChildListDelegate(
        dailyBills.map(buildDailyCard).toList(),
      ),
    );
  }

  Widget buildDailyCard(BillModel bill) {
    return BillCard(bill: bill, color: color);
  }

  Widget buildMonthly() {
    var bills = context.read<BillState>().bills;
    List<BillModel> monthlyBills =
        bills.where((item) => item.repetitionType == BillType.monthly).toList();

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
    return Provider.value(
      value: bill,
      child: CheckableBillCard(color: color),
    );
  }

  buildStickHeader(String titleKey, Function() buildChildren) {
    return SliverStickyHeader(
      header: buildTitle(titleKey, goToAddBill),
      sliver: buildChildren(),
    );
  }
}
