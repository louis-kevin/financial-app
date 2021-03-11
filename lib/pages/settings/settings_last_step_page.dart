import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/user_model.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:financialapp/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsLastStepPage extends StatelessWidget {
  final UserConfig userConfig;

  const SettingsLastStepPage({Key key, this.userConfig}) : super(key: key);

  nextPage(BuildContext context, bool workInWHolidays) {
    userConfig.workInHolidays = workInWHolidays;
    var state = Provider.of<AuthState>(context, listen: false);
    print(state.user);
    state.updateSettings(userConfig);

    if (state.hasErrors) return;

    Navigator.of(context).pushReplacementNamed(RouterManager.HOME);
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
            onPressed: () => nextPage(context, true),
          ),
          SizedBox(
            height: 20,
          ),
          BaseButton(
            type: ButtonType.secondary,
            textKey: SettingsPageTextKeys.btnNo,
            onPressed: () => nextPage(context, false),
          )
        ],
      ),
    );
  }
}
