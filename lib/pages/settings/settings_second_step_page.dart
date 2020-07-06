import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:financialapp/theme.dart';
import 'package:flutter/material.dart';

import 'settings_third_step_page.dart';

class SettingsSecondStepPage extends StatefulWidget {
  final int day;
  final int dayType;

  const SettingsSecondStepPage({Key key, this.day, this.dayType})
      : super(key: key);

  @override
  _SettingsSecondStepPageState createState() => _SettingsSecondStepPageState();
}

class _SettingsSecondStepPageState extends State<SettingsSecondStepPage> {
  int option = 0;

  nextPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SettingsThirdStepPage(),
      ),
    );
  }

  void selectOption(int value) {
    setState(() {
      option = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseBackButtonPage(
      titleKey: SettingsPageTextKeys.secondTitle,
      content: <Widget>[
        SubtitleText(
          getSubtitleText(),
        ),
        buildOption(SettingsPageTextKeys.selectionDayAfter, 0),
        buildOption(SettingsPageTextKeys.selectionDayBefore, 1),
      ],
      bottom: BaseButton(
        textKey: SettingsPageTextKeys.btnNext,
        onPressed: nextPage,
      ),
    );
  }

  Widget buildOption(String titleKey, int value) {
    return RadioListTile(
      title: SubtitleText.key(
        titleKey,
        textColor: Colors.white,
      ),
      activeColor: DefaultColors.primaryColor,
      value: value,
      groupValue: option,
      onChanged: selectOption,
    );
  }

  String getSubtitleText() {
    return SettingsPageTextKeys.secondSubtitle.i18n.fill([
      widget.day,
      widget.dayType == 0
          ? SettingsPageTextKeys.businessDay.i18n
          : SettingsPageTextKeys.calendarDay.i18n
    ]);
  }
}
