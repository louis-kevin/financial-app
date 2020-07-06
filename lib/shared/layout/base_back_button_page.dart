import 'package:financialapp/shared/layout/flexible_screen.dart';
import 'package:financialapp/shared/typography/display3_text.dart';
import 'package:flutter/material.dart';

class BaseBackButtonPage extends StatelessWidget {
  final List<Widget> content;
  final String title;
  final String titleKey;
  final List<Widget> actions;
  final Widget bottom;

  final Widget appBarTitle;

  final bool hasAppBar;

  const BaseBackButtonPage({
    Key key,
    this.content,
    this.title,
    this.titleKey,
    this.actions,
    this.bottom,
    this.appBarTitle,
    this.hasAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hasAppBar
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: actions ?? [],
              title: appBarTitle,
            )
          : null,
      body: FlexibleScreen(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildContent(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildContent() {
    List<Widget> content = [];

    if (title != null || titleKey != null) {
      content.add(Container(
        child: FittedBox(
          child: Display3Text.key(
            titleKey,
            text: title,
          ),
        ),
      ));
    }

    content.addAll(this.content);

    if (bottom != null) {
      content.addAll([
        Expanded(
          child: Container(),
        ),
        bottom
      ]);
    }

    return content;
  }
}
