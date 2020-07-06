import 'dart:async';

import 'package:financialapp/models/bill_model.dart';
import 'package:financialapp/routes/router.dart';
import 'package:financialapp/routes/router_arguments.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:financialapp/states/bill_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckableBillCard extends StatefulWidget {
  final Color color;

  const CheckableBillCard({Key key, this.color}) : super(key: key);

  @override
  _CheckableBillCardState createState() => _CheckableBillCardState();
}

class _CheckableBillCardState extends State<CheckableBillCard> {
  Timer _debounce;

  void goToAddBill(context) {
    Navigator.of(context).pushNamed(
      Router.BILL,
      arguments: RouteArguments(
        model: Provider.of<BillModel>(context, listen: false),
        transitionBuilder: (page) {
          return MaterialPageRoute(
            builder: (_) {
              return ChangeNotifierProvider.value(
                value: Provider.of<BillState>(context, listen: false),
                child: page,
              );
            },
          );
        },
      ),
    );
  }

  onChange(BillModel bill, value) {
    if (bill.busy) return;

    bill.payed = value;

    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      updateBill(bill);
    });
  }

  updateBill(BillModel bill) {
    var state = Provider.of<BillState>(context, listen: false);
    state.saveBill(bill);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BillModel>(
      builder: (_, bill, __) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onLongPress: () => goToAddBill(context),
            child: buildCard(bill),
          ),
        );
      },
    );
  }

  buildCard(BillModel bill) {
    Color backgroundColor = bill.payed ? Color(0xFF272B3F) : widget.color;

    Color textColor = bill.payed ? widget.color : Colors.white;

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
            onChanged: (value) => onChange(bill, value),
            checkColor: backgroundColor,
            activeColor: textColor,
            focusColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
