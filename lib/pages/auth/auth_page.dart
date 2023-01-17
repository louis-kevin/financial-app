import 'package:easy_typography/easy_typography.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:flutter/material.dart';

import 'sign_in_tab.dart';
import 'sign_up_tab.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFF202233),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: TabBar(
            indicator: BoxDecoration(
              color: Color(0xFF4558FE),
              borderRadius: BorderRadius.circular(10),
            ),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Tab(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: BodyMediumText.key(
                    AuthPageTextKeys.tabSignInTitle,
                    textColor: Colors.white,
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BodyMediumText.key(
                    AuthPageTextKeys.tabSignUpTitle,
                    textColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SignInTab(),
            SignUpTab(),
          ],
        ),
      ),
    );
  }
}
