import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:financialapp/models/dashboard_model.dart';
import 'package:financialapp/services/user_service.dart';
import 'package:flutter/cupertino.dart';

class DashboardState extends ChangeNotifier {
  DashboardModel dashboard;

  UserService service = UserService();

  DashboardState() {
    Notifier()..listen<TotalAmountUpdate>(updateTotalAmount);
  }

  updateTotalAmount(TotalAmountUpdate event) {
    if (event.oldAmount != null) dashboard.totalAmountCents -= event.oldAmount;
    dashboard.totalAmountCents += event.newAmount;
    notifyListeners();
  }

  Future<void> fetchDashboard() async {
    var response = await service.fetchDashboard();

    Map data = response.data;

    dashboard = DashboardModel.fromJson(data);

    notifyListeners();
  }
}
