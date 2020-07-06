import 'package:financialapp/events/notifier.dart';
import 'package:financialapp/events/notifier_events.dart';
import 'package:financialapp/models/dashboard_model.dart';
import 'package:financialapp/services/dashboard_service.dart';
import 'package:flutter/cupertino.dart';

class DashboardState extends ChangeNotifier {
  DashboardModel dashboard;

  DashboardService service = DashboardService();

  DashboardState() {
    Notifier()..listen<TotalAmountUpdate>(updateTotalAmount);
  }

  updateTotalAmount(TotalAmountUpdate event) {
    if (event.oldAmount != null)
      dashboard.totalRemainingDebit -= event.oldAmount;
    dashboard.totalRemainingDebit += event.newAmount;
    notifyListeners();
  }

  fetchDashboard() async {
    var response = await service.fetchDashboard();

    Map data = response.data;

    dashboard = DashboardModel.fromJson(data);
  }
}
