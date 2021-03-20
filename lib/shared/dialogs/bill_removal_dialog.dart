import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/bill_model.dart';
import 'package:financialapp/shared/typography/body2_text.dart';
import 'package:financialapp/shared/typography/display1_text.dart';
import 'package:financialapp/states/bill_state.dart';
import 'package:financialapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillRemovalDialog extends StatelessWidget {
  final BillModel bill;

  const BillRemovalDialog({Key key, this.bill}) : super(key: key);

  removeBill(BuildContext context) {
    Navigator.of(context).pop(true);

    var state = context.read<BillState>();

    state.deleteBill(bill);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: DefaultColors.backgroundColor,
      title: Display1Text.key(DialogsTextKeys.billRemovalTitle),
      actions: <Widget>[
        TextButton(
          child: Body2Text.key(
            DialogsTextKeys.btnCancel,
          ),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: Body2Text.key(
            DialogsTextKeys.btnYes,
            style: TextStyle(color: Colors.redAccent),
          ),
          onPressed: () => removeBill(context),
        ),
      ],
    );
  }
}
