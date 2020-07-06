import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/shared/layout/base_back_button_page.dart';
import 'package:financialapp/shared/typography/subtitle_text.dart';
import 'package:flutter/material.dart';

class RecoveryPasswordPage extends StatelessWidget {
  goToAuthPage(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BaseBackButtonPage(
      titleKey: AuthPageTextKeys.pageForgotPasswordTitle,
      content: <Widget>[
        SubtitleText.key(
          AuthPageTextKeys.pageForgotPasswordSubtitleOne,
          overflow: TextOverflow.visible,
        ),
        SubtitleText.key(
          AuthPageTextKeys.pageForgotPasswordSubtitleSecond,
          overflow: TextOverflow.visible,
        ),
        SizedBox(
          height: 20,
        ),
        SubtitleText.key(
          AuthPageTextKeys.labelEmailInput,
          overflow: TextOverflow.visible,
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
      bottom: BaseButton(
        onPressed: () => goToAuthPage(context),
        textKey: AuthPageTextKeys.btnRecoveryPassword,
      ),
    );
  }
}
