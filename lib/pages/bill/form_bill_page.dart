import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/bill_model.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/shared/inputs/amount_input.dart';
import 'package:financialapp/shared/inputs/name_input.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/shared/typography/display1_text.dart';
import 'package:financialapp/states/bill_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import 'bill_types_selector.dart';

class FormBillPage extends StatefulWidget {
  final BillModel model;

  const FormBillPage({Key key, this.model}) : super(key: key);

  @override
  _FormBillPageState createState() => _FormBillPageState();
}

class _FormBillPageState extends State<FormBillPage> {
  var formKey;
  MoneyMaskedTextController controller;

  int selectedDay = 1;
  BillType billType = BillType.once;

  onChangeBillType(BillType billType) {
    this.billType = billType;
    setState(() => {});
  }

  void save() async {
    if (!formKey.currentState.saveAndValidate()) return;

    var state = context.read<BillState>();

    Map<String, dynamic> data = Map.from(formKey.currentState.value);

    Map<String, dynamic> dataToAdd = {
      'repetition_type': billType.toString().replaceAll('BillType.', ''),
      'payment_day': selectedDay,
      'account_id': state.account.id,
      'payed': false,
      'amount_cents': data.remove('amount')
    };

    data.addAll(dataToAdd);

    var model = widget.model ?? BillModel();

    model.fill(data);

    await state.saveBill(model);

    Navigator.pop(context);
  }

  @override
  void initState() {
    formKey = GlobalKey<FormBuilderState>();
    controller = MoneyMaskedTextController(
      decimalSeparator: MoneyTextKeys.decimalSeparator.i18n,
      thousandSeparator: MoneyTextKeys.thousandSeparator.i18n,
      leftSymbol: MoneyTextKeys.leftSymbol.i18n,
    );

    if (widget.model != null) {
      selectedDay = widget.model.paymentDay;
      billType = widget.model.repetitionType;
      controller.updateValue(widget.model.amount);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      initialValue: widget.model?.toJson() ?? {},
      child: BaseBackButtonPage(
        titleKey: widget.model != null
            ? BillFormPageTextKeys.editTitle
            : BillFormPageTextKeys.addTitle,
        content: <Widget>[
          NameInput(context),
          SizedBox(
            height: 20,
          ),
          BillTypesSelector(
            onChange: onChangeBillType,
            initialValue: widget.model?.repetitionType,
          ),
          SizedBox(
            height: 20,
          ),
          if (billType != BillType.daily) buildPaymentDate(),
          SizedBox(
            height: 20,
          ),
          AmountInput(
            context,
            controller,
          ),
          SizedBox(
            height: 20,
          ),
        ],
        bottom: BaseButton(
          onPressed: save,
          textKey: BillFormPageTextKeys.btnSave,
        ),
      ),
    );
  }

  Widget buildPaymentDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Display1Text.key(BillFormPageTextKeys.labelPaymentDay,
              fit: BoxFit.fitWidth),
          Expanded(
            child: Container(),
          ),
          Expanded(
            child: DropdownButtonFormField(
              elevation: 0,
              value: selectedDay,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                fillColor: Color(0xFF353D50),
                border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
              onChanged: (value) => setState(() => selectedDay = value),
              items: Iterable<int>.generate(30).map(
                (day) {
                  day++;
                  return DropdownMenuItem(
                    child: Text(
                      day.toString(),
                    ),
                    value: day,
                  );
                },
              ).toList(),
            ),
          )
        ],
      ),
    );
  }
}
