import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BaseState extends ChangeNotifier {
  Map<String, dynamic> errors = {};

  bool get hasErrors => errors.isNotEmpty;

  String getErrorByField(String field) {
    if (!errors.containsKey(field)) return null;

    return errors[field];
  }

  handleAsync(Function asyncRequest) async {
    errors = {};
    notifyListeners();
    try {
      return await asyncRequest();
    } on DioError catch (error) {
      if (error?.type != DioErrorType.RESPONSE) throw error;
      if (error?.response?.statusCode != 422) throw error;

      errors = error.response?.data;
      notifyListeners();
    }
  }
}
