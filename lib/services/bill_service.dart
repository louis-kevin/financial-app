import 'package:dio/dio.dart';
import 'package:financialapp/services/base_service.dart';

class BillService extends BaseService {
  Future<Response> fetchBillsByAccount(int accountId) {
    var query = {'account_id': accountId};

    return get('bills', query: query);
  }

  Future<Response> saveBill(Map<String, dynamic> data, {int id}) {
    String url = '/bill';

    return save(url, data, id: id?.toString());
  }

  Future<Response> removeBill(id) {
    String url = "/bill/$id";

    return delete(url);
  }
}
