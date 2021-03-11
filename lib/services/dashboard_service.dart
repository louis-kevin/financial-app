import 'package:dio/dio.dart';
import 'package:financialapp/services/base_service.dart';

var dashboard = {
  'additional_per_day': 8.88,
  'total_remaining_debit': 1234.56,
  'last_payment': '2020-04-15',
  'next_payment': '2020-05-15',
  'holidays': 1,
  'business_days': 24,
  'weekend_days': 8
};

class DashboardService extends BaseService {
  Future<Response> fetchDashboard() {
    return Future.delayed(
      Duration(milliseconds: 300),
      () => Response(
          data: dashboard,
          statusCode: 200,
          request: RequestOptions(path: 'test')),
    );
  }
}
