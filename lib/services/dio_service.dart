import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioService {
  static BaseOptions _options = BaseOptions();
  static Dio _dio = Dio();
  static const Duration connectionTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const String baseUrl = "https://655deee79f1e1093c59a2ff7.mockapi.io";
  static const String apiGetAllData = "/first_dart_pro";
  static const Map<String, String> headers = {
    "Content-Type": "application/json",
  };
  static Map<String, dynamic> paramGetWeather(String city) {
    return {
      "username": "username1",
      "password": "password1",
    };
  }

  static Dio init() {
    _options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectionTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers,
      responseType: ResponseType.json,
      validateStatus: (statusCode) => statusCode! <= 205,
    );
    _dio = Dio(_options);
    return _dio;
  }

  static Future<String?> get(BuildContext context, String api,
      [Map<String, dynamic> params = const <String, dynamic>{}]) async {
    try {
      final Response response = await init().get(api, queryParameters: params);
      return jsonEncode(response.data);
    } on DioException catch (e) {
      Future.delayed(Duration.zero).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
      log(e.message.toString());
      return null;
    }
  }

  static Future<String?> post(
      BuildContext context, String api, Map<String, dynamic> data,
      [Map<String, dynamic> params = const <String, dynamic>{}]) async {
    try {
      final Response response =
          await init().post(api, queryParameters: params, data: data);
      return jsonEncode(response.data);
    } on DioException catch (e) {
      Future.delayed(Duration.zero).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
      log(e.message.toString());
      return null;
    }
  }

  static Future<String?> put(
      BuildContext context, String api, Map<String, dynamic> data) async {
    try {
      final Response response = await init().put(api, data: data);
      return jsonEncode(response.data);
    } on DioException catch (e) {
      log('Dio exception on PUT: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error on PUT request: $e")));
    } catch (e) {
      log('Error on PUT request: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error on PUT request: $e")));
    }
    return null;
  }

  static Future<String?> delete(BuildContext context, String api,
      [Map<String, dynamic> data = const <String, dynamic>{},
      Map<String, dynamic> params = const <String, dynamic>{}]) async {
    try {
      final Response response =
          await init().delete(api, queryParameters: params, data: data);
      return jsonEncode(response.data);
    } on DioException catch (e) {
      Future.delayed(Duration.zero).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
      log(e.message.toString());
      return null;
    }
  }
}
