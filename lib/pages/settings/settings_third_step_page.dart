import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/pages/settings/settings_last_step_page.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/shared/inputs/amount_input.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SettingsThirdStepPage extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();

  nextPage(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SettingsLastStepPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: BaseBackButtonPage(
        titleKey: SettingsPageTextKeys.thirdTitle,
        content: <Widget>[
          SubtitleText.key(
            SettingsPageTextKeys.thirdSubtitle,
          ),
          SizedBox(
            height: 20,
          ),
          AmountInput(
            style: Theme.of(context).textTheme.display2,
            decoration: InputDecoration(),
          )
        ],
        bottom: BaseButton(
          textKey: SettingsPageTextKeys.btnNext,
          onPressed: () => nextPage(context),
        ),
      ),
    );
  }
}
