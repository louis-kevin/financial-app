import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BaseState extends ChangeNotifier {
  Map<String, dynamic> errors = {};

  bool _busy = false;

  bool get hasErrors => errors.isNotEmpty;

  bool get busy => _busy;

  set busy(bool busy) {
    _busy = busy;
    notifyListeners();
  }

  String getErrorByField(String field) {
    if (!errors.containsKey(field)) return null;

    return errors[field];
  }

  Future<T> handleAsync<T>(Function asyncRequest, {Function runAlways}) async {
    errors = {};
    notifyListeners();
    try {
      return await asyncRequest();
    } on DioError catch (error) {
      if (error?.type != DioErrorType.response) throw error;
      if (error?.response?.statusCode != 422) throw error;

      errors = error.response?.data;
      notifyListeners();
    } finally {
      if (runAlways != null) {
        runAlways();
      }
    }
    return null;
  }
}
