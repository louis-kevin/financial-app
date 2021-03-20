import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:financialapp/models/dashboard_model.dart';
import 'package:financialapp/services/user_service.dart';
import 'package:flutter/cupertino.dart';

class DashboardState extends ChangeNotifier {
  DashboardModel dashboard;

  UserService service = UserService();

  DashboardState() {
    Notifier()
      ..listen<AccountsUpdated>((AccountsUpdated event) {
        if (event.hasAccounts) {
          dashboard.calculateTotalAmountCents(event.accounts);
          notifyListeners();
          return null;
        }

        return fetchDashboard();
      });
  }

  Future<void> fetchDashboard() async {
    var response = await service.fetchDashboard();

    Map data = response.data;

    dashboard = DashboardModel.fromJson(data);

    notifyListeners();
  }
}
