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

  save(context) async {
    if (!formKey.currentState.saveAndValidate()) return;

    var authState = Provider.of<AuthState>(context, listen: false);

    await authState.login(formKey.currentState.value);

    Navigator.of(context).pushNamed(Router.HOME);
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
    return FormBuilder(
      key: formKey,
      child: BaseBackButtonPage(
        hasAppBar: false,
        content: <Widget>[
          EmailInput(),
          SizedBox(
            height: 20,
          ),
          PasswordInput(),
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
          onPressed: () => save(context),
          textKey: AuthPageTextKeys.btnEnter,
        ),
      ),
    );
  }
}
