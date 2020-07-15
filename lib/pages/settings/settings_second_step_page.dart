import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/user_model.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:financialapp/theme.dart';
import 'package:flutter/material.dart';

import 'settings_third_step_page.dart';

class SettingsSecondStepPage extends StatefulWidget {
  final UserConfig userConfig;

  const SettingsSecondStepPage({Key key, this.userConfig}) : super(key: key);

  @override
  _SettingsSecondStepPageState createState() => _SettingsSecondStepPageState();
}

class _SettingsSecondStepPageState extends State<SettingsSecondStepPage> {
  nextPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SettingsThirdStepPage(
          userConfig: widget.userConfig,
        ),
      ),
    );
  }

  void selectOption(IncomeOption value) {
    setState(() {
      widget.userConfig.incomeOption = value;
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
        buildOption(
            SettingsPageTextKeys.selectionDayAfter, IncomeOption.nextWorkDay),
        buildOption(
            SettingsPageTextKeys.selectionDayBefore, IncomeOption.previousDay),
      ],
      bottom: BaseButton(
        textKey: SettingsPageTextKeys.btnNext,
        onPressed: nextPage,
      ),
    );
  }

  Widget buildOption(String titleKey, IncomeOption value) {
    return RadioListTile<IncomeOption>(
      title: SubtitleText.key(
        titleKey,
        textColor: Colors.white,
      ),
      activeColor: DefaultColors.primaryColor,
      value: value,
      groupValue: widget.userConfig.incomeOption,
      onChanged: selectOption,
    );
  }

  String getSubtitleText() {
    return SettingsPageTextKeys.secondSubtitle.i18n.fill([
      widget.userConfig.day,
      widget.userConfig.dayType == DayType.workDay
          ? SettingsPageTextKeys.businessDay.i18n
          : SettingsPageTextKeys.calendarDay.i18n
    ]);
  }
}
