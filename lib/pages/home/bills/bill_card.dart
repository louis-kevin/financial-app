import 'package:easy_typography/easy_typography.dart';
import 'package:financialapp/models/bill_model.dart';
import 'package:financialapp/routes/router_arguments.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/states/bill_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillCard extends StatelessWidget {
  final Color color;
  final BillModel bill;

  const BillCard({Key key, this.color, this.bill}) : super(key: key);

  void goToAddBill(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      RouterManager.BILL,
      arguments: RouteArguments(
        model: bill,
        state: (page) => ChangeNotifierProvider.value(
          value: context.read<BillState>(),
          child: page,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onLongPress: () => goToAddBill(context),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LabelLargeText(
                bill.name,
                textColor: color,
              ),
              BodyMediumText(
                bill.amountMonetized,
                textColor: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
