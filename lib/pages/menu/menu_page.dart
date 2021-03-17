import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/shared/typography/display1_text.dart';
import 'package:financialapp/shared/typography/headline_text.dart';
import 'package:financialapp/shared/typography/subhead_text.dart';
import 'package:financialapp/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  void goToAccountsPage(context) {
    Navigator.of(context).pushNamed(RouterManager.ACCOUNTS);
  }

  void goToProfilePage(context) {
    Navigator.of(context).pushNamed(RouterManager.PROFILE);
  }

  void gotToSettingsPage(context) {
    Navigator.of(context).pushNamed(RouterManager.SETTINGS);
  }

  void goToWelcomePage(context) {
    Notifier()..fire(Logout());
  }

  @override
  Widget build(BuildContext context) {
    var authState = Provider.of<AuthState>(context);
    context.watch<AuthState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(),
                    ),
                    Display1Text(authState.user?.name ?? ''),
                    SubheadText(authState.user?.email ?? '')
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildMenuItem(
                      context,
                      MenuPageTextKeys.menuAccountsItem,
                      Icons.account_balance_wallet,
                      goToAccountsPage,
                    ),
                    buildMenuItem(
                      context,
                      MenuPageTextKeys.menuProfileItem,
                      Icons.person_outline,
                      goToProfilePage,
                    ),
                    buildMenuItem(
                      context,
                      MenuPageTextKeys.menuSettingsItem,
                      Icons.settings,
                      gotToSettingsPage,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SubheadText.key(MenuPageTextKeys.aboutUs),
                    SizedBox(
                      height: 10,
                    ),
                    SubheadText.key(MenuPageTextKeys.privacyPolicies),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () => goToWelcomePage(context),
                      child: SubheadText.key(MenuPageTextKeys.logout),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  iconSize: 32,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(
      context, String titleKey, IconData icon, Function onPressed) {
    return GestureDetector(
      onTap: () => onPressed(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          HeadlineText.key(
            titleKey,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
