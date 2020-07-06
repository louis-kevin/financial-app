import 'package:financialapp/pages/bill/bill_types_selector.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:flutter/material.dart';

class BillTypeCard extends StatelessWidget {
  final BillTypeSelector billTypeSelector;

  const BillTypeCard({Key key, this.billTypeSelector}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color lightColor = Colors.white;
    Color darkColor = Color(0xff363D50);
    Color textColor = billTypeSelector.selected ? darkColor : lightColor;
    Color backgroundColor = billTypeSelector.selected ? lightColor : darkColor;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        height: 76.00,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.00),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              billTypeSelector.icon,
              color: textColor,
            ),
            SubtitleText.key(
              billTypeSelector.titleKey,
              textColor: textColor,
            )
          ],
        ),
      ),
    );
  }
}
