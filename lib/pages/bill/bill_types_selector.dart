import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/bill_model.dart';
import 'package:financialapp/pages/bill/bill_type_card.dart';
import 'package:flutter/material.dart';

class BillTypesSelector extends StatefulWidget {
  final Function(BillType billType) onChange;
  final BillType initialValue;

  const BillTypesSelector({
    Key key,
    this.onChange,
    this.initialValue,
  }) : super(key: key);
  @override
  _BillTypesSelectorState createState() => _BillTypesSelectorState();
}

class _BillTypesSelectorState extends State<BillTypesSelector> {
  List<BillTypeSelector> options = [
    BillTypeSelector(
      titleKey: BillFormPageTextKeys.selectionOnce,
      icon: Icons.plus_one,
      type: BillType.once,
      selected: true,
    ),
    BillTypeSelector(
      titleKey: BillFormPageTextKeys.selectionDaily,
      icon: Icons.today,
      type: BillType.daily,
    ),
    BillTypeSelector(
      titleKey: BillFormPageTextKeys.selectionMonthly,
      icon: Icons.date_range,
      type: BillType.monthly,
    ),
  ];

  void selectOption(BillTypeSelector billTypeSelector) {
    options.map((item) {
      item.selected = false;
      return item;
    }).toList();

    billTypeSelector.selected = true;

    setState(() {});
    widget.onChange(billTypeSelector.type);
  }

  @override
  void initState() {
    if (widget.initialValue != null) {
      options = options.map((item) {
        item.selected = widget.initialValue == item.type;
        return item;
      }).toList();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: options.map(buildBillTypeCard).toList(),
    );
  }

  Widget buildBillTypeCard(BillTypeSelector billTypeSelector) {
    return Expanded(
      child: GestureDetector(
        onTap: () => selectOption(billTypeSelector),
        child: BillTypeCard(
          billTypeSelector: billTypeSelector,
        ),
      ),
    );
  }
}

class BillTypeSelector {
  final String titleKey;
  final BillType type;
  final IconData icon;
  bool selected;

  BillTypeSelector({
    this.titleKey,
    this.type,
    this.icon,
    this.selected = false,
  });
}
