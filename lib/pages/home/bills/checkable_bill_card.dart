import 'package:financialapp/models/bill_model.dart';
import 'package:financialapp/routes/router_arguments.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:financialapp/states/bill_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckableBillCard extends StatelessWidget {
  final Color color;

  CheckableBillCard({Key key, this.color}) : super(key: key);

  void goToEditBill(BuildContext context) {
    Navigator.of(context).pushNamed(
      RouterManager.BILL,
      arguments: RouteArguments(
        model: context.read<BillModel>(),
        state: (page) => ChangeNotifierProvider.value(
          value: context.read<BillState>(),
          child: page,
        ),
      ),
    );
  }

  void onChange(BuildContext context, value) {
    var bill = context.read<BillModel>();
    bill.payed = value;

    var state = context.read<BillState>();
    state.updatePayed(bill, value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onLongPress: () => goToEditBill(context),
        child: buildCard(context),
      ),
    );
  }

  buildCard(BuildContext context) {
    var bill = context.watch<BillModel>();

    Color backgroundColor = bill.payed ? Color(0xFF272B3F) : color;

    Color textColor = bill.payed ? color : Colors.white;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SubtitleText(
                bill.name,
                textColor: textColor,
              ),
              SubtitleText(
                bill.amountMonetized,
                textColor: textColor,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
          Checkbox(
            tristate: false,
            value: bill.payed,
            onChanged: (value) => onChange(context, value),
            checkColor: backgroundColor,
            activeColor: textColor,
            focusColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
