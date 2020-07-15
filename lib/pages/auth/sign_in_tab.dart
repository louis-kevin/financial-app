import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/pages/auth/recovery_password_page.dart';
import 'package:financialapp/routes/router.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/shared/inputs/email_input.dart';
import 'package:financialapp/shared/inputs/password_input.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/shared/typography/body2_text.dart';
import 'package:financialapp/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class SignInTab extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();

  save(context, authState) async {
    if (!formKey.currentState.saveAndValidate()) return;

    await authState.login(formKey.currentState.value);

    if (authState.hasErrors) return;

    var navigator = Navigator.of(context);

    if (authState.user.needsConfig) {
      return navigator.pushNamedAndRemoveUntil(
        Router.SETTINGS,
        (Route<dynamic> route) => false,
      );
    }

    navigator.pushNamedAndRemoveUntil(
      Router.HOME,
      (Route<dynamic> route) => false,
    );
  }

  goToRecoveryPasswordPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecoveryPasswordPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);

    return FormBuilder(
      key: formKey,
      initialValue: {
        'email': 'kevinlouis.dev@gmail.com',
        'password': '12345678'
      },
      child: BaseBackButtonPage(
        hasAppBar: false,
        content: <Widget>[
          EmailInput(
            errorMessage: authState.getErrorByField('email'),
            required: true,
          ),
          SizedBox(
            height: 20,
          ),
          PasswordInput(
            errorMessage: authState.getErrorByField('password'),
            required: true,
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => goToRecoveryPasswordPage(context),
              child: Body2Text.key(AuthPageTextKeys.forgotPassword),
            ),
          )
        ],
        bottom: BaseButton(
          onPressed: () => save(context, authState),
          textKey: AuthPageTextKeys.btnEnter,
        ),
      ),
    );
  }
}
