import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/shared/inputs/email_input.dart';
import 'package:financialapp/shared/inputs/name_input.dart';
import 'package:financialapp/shared/inputs/password_input.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class SignUpTab extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();

  save(context, authState) async {
    if (!formKey.currentState.saveAndValidate()) return;

    await authState.register(formKey.currentState.value);

    if (authState.hasErrors) return;

    Navigator.of(context).pushNamedAndRemoveUntil(
      RouterManager.SETTINGS,
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    return FormBuilder(
      key: formKey,
      child: BaseBackButtonPage(
        hasAppBar: false,
        content: <Widget>[
          NameInput(
            context,
            errorMessage: authState.getErrorByField('name'),
            required: true,
          ),
          SizedBox(
            height: 20,
          ),
          EmailInput(
            context,
            errorMessage: authState.getErrorByField('email'),
            required: true,
          ),
          SizedBox(
            height: 20,
          ),
          PasswordInput(
            context,
            errorMessage: authState.getErrorByField('password'),
            required: true,
          ),
        ],
        bottom: BaseButton(
          onPressed: () => save(context, authState),
          textKey: AuthPageTextKeys.btnSignUp,
        ),
      ),
    );
  }
}
