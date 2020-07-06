import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/routes/router.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:flutter/material.dart';

class SettingsLastStepPage extends StatelessWidget {
  nextPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Router.HOME);
  }

  @override
  Widget build(BuildContext context) {
    return BaseBackButtonPage(
      titleKey: SettingsPageTextKeys.fourthTitle,
      content: <Widget>[
        SubtitleText.key(SettingsPageTextKeys.fourthSubtitle),
      ],
      bottom: Column(
        children: <Widget>[
          BaseButton(
            textKey: SettingsPageTextKeys.btnYes,
            onPressed: () => nextPage(context),
          ),
          SizedBox(
            height: 20,
          ),
          BaseButton(
            type: ButtonType.secondary,
            textKey: SettingsPageTextKeys.btnNo,
            onPressed: () => nextPage(context),
          )
        ],
      ),
    );
  }
}
