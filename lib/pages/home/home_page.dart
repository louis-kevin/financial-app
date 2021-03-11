import 'package:financialapp/locale/locale_i18n.dart';
import 'package:financialapp/locale/locale_keys.dart';
import 'package:financialapp/pages/home/bills/bills_tab.dart';
import 'package:financialapp/pages/home/summary/summary_tab.dart';
import 'package:financialapp/pages/home/total_debit_app_bar_home.dart';
import 'package:financialapp/routes/router_arguments.dart';
import 'package:financialapp/routes/router_manager.dart';
import 'package:financialapp/states/account_state.dart';
import 'package:financialapp/states/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  openMenu(BuildContext context) {
    Navigator.of(context).pushNamed(
      RouterManager.MENU,
      arguments: RouteArguments(transitions: RouterTransitions.fade),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<DashboardState>(context, listen: false).fetchDashboard();
      Provider.of<AccountState>(context, listen: false).fetchAccounts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => openMenu(context),
          ),
          actions: <Widget>[
            TotalDebitAppBarHome(),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, __) => [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              title: PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: Container(
                  height: 48.0,
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    labelStyle: Theme.of(context).textTheme.display2,
                    isScrollable: true,
                    indicatorWeight: 0.000000001,
                    tabs: <Widget>[
                      Tab(text: HomePageTextKeys.tabTotals.i18n),
                      Tab(text: HomePageTextKeys.tabBills.i18n),
                    ],
                  ),
                ),
              ),
            )
          ],
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              SummaryTab(),
              BillsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
