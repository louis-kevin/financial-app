import 'package:easy_typography/easy_typography.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/shared/base_button.dart';
import 'package:financialapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  goToAuthPage(context) {
    Navigator.of(context).pushNamed(RouterManager.AUTH);
  }

  bool locale = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DisplayMediumText.key(
              WelcomePageTextKeys.title,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            HeadlineMediumText.key(
              WelcomePageTextKeys.subtitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            BodyMediumText.key(
              WelcomePageTextKeys.continueWith,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            BaseButton(
              color: DefaultColors.accentColor,
              onPressed: () => goToAuthPage(context),
              textKey: WelcomePageTextKeys.btnEmail,
            ),
            SizedBox(
              height: 10,
            ),
            BaseButton(
              type: ButtonType.secondary,
              onPressed: () => changeLocale(),
              textKey: WelcomePageTextKeys.btnFacebook,
            ),
          ],
        ),
      ),
    );
  }

  changeLocale() {
    locale = !locale;
    I18n.of(context).locale = Locale(locale ? ' pt-br' : 'en');
    setState(() {});
  }
}
