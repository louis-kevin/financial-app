import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/models/user_model.dart';
import 'package:financialapp/pages/settings/settings_last_step_page.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/shared/inputs/amount_input.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:financialapp/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class SettingsThirdStepPage extends StatefulWidget {
  final UserConfig userConfig;

  const SettingsThirdStepPage({Key key, this.userConfig}) : super(key: key);

  @override
  _SettingsThirdStepPageState createState() => _SettingsThirdStepPageState();
}

class _SettingsThirdStepPageState extends State<SettingsThirdStepPage> {
  final formKey = GlobalKey<FormBuilderState>();

  nextPage() {
    if (!formKey.currentState.saveAndValidate()) return;

    widget.userConfig.income = formKey.currentState.value['amount'];

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SettingsLastStepPage(
          userConfig: widget.userConfig,
        ),
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
            context,
            style: Theme.of(context).textTheme.display2,
            decoration: InputDecoration(),
            value: Provider.of<AuthState>(context)
                    .user
                    ?.config
                    ?.income
                    ?.toDouble() ??
                0,
          )
        ],
        bottom: BaseButton(
          textKey: SettingsPageTextKeys.btnNext,
          onPressed: nextPage,
        ),
      ),
    );
  }
}
