import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/shared/inputs/email_input.dart';
import 'package:financialapp/shared/inputs/name_input.dart';
import 'package:financialapp/shared/inputs/password_input.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  final formKey = GlobalKey<FormBuilderState>();

  void save() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthState>(
      builder: (_, state, __) {
        return FormBuilder(
          key: formKey,
          initialValue: state.user?.toJson() ?? {},
          child: BaseBackButtonPage(
            titleKey: ProfilePageTextKeys.title,
            content: <Widget>[
              SizedBox(
                height: 20,
              ),
              NameInput(),
              SizedBox(
                height: 20,
              ),
              EmailInput(),
              SizedBox(
                height: 20,
              ),
              PasswordInput(),
            ],
            bottom: BaseButton(
              onPressed: save,
              textKey: ProfilePageTextKeys.btnSave,
            ),
          ),
        );
      },
    );
  }
}
