import 'package:dio/dio.dart';
import 'package:financialapp/config.dart';

class BaseService {
  String host;
  Dio client;

  BaseService() {
    var config = Config();
    host = config.host;

    BaseOptions options = BaseOptions(baseUrl: host);

    client = new Dio(options);
  }

  get(String path, {Map query, Map headers}) {
    return _request('get', path, query: query, headers: headers);
  }

  post(String path, Map data, {Map query, Map headers}) {
    return _request('post', path, data: data, query: query, headers: headers);
  }

  put(String path, Map data, {Map query, Map headers}) {
    return _request('put', path, data: data, query: query, headers: headers);
  }

  delete(String path, {Map query, Map headers}) {
    return _request('delete', path, query: query, headers: headers);
  }

  Future<Response> _request(String method, String path,
      {Map data, Map query, Map headers}) {
    String url = _buildUrl(path);
    Map baseHeaders = _buildHeaders(headers);

    return client.request(
      url,
      data: data,
      queryParameters: query,
      options: Options(
        headers: baseHeaders,
        method: method,
      ),
    );
  }

  String _buildUrl(String path) {
    return "$host/$path";
  }

  Map _buildHeaders(Map headers) {
    Map baseHeaders = {};

    baseHeaders.addAll(headers);

    return headers;
  }
}
