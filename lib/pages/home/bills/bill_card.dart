import 'package:financialapp/models/bill_model.dart';
import 'package:financialapp/routes/router.dart';
import 'package:financialapp/routes/router_arguments.dart';
import 'package:financialapp/shared/typography/subhead_text.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:financialapp/states/bill_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillCard extends StatelessWidget {
  final Color color;

  const BillCard({Key key, this.color}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Consumer<BillModel>(
      builder: (_, bill, __) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onLongPress: () => goToAddBill(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                color: Colors.white,
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SubheadText(
                    bill.name,
                    textColor: color,
                  ),
                  SubtitleText(
                    bill.amountMonetized,
                    textColor: color,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
