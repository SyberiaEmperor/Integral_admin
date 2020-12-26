import 'dart:html';

import 'package:dio/dio.dart';
import 'package:integral_admin/entities/dish.dart';

class Requests {
  static const IP = '178.154.255.209:3777';
  static const BASE_URI = 'http://$IP/';

  static const _DISHES = 'dishes/';
  static const _USER = 'user/';

  static const TIMEOUT = 5000;

  static Dio _baseDio;

  void initReqs() {
    _baseDio = Dio();

    _baseDio.options.baseUrl = BASE_URI;
    _baseDio.options.connectTimeout = TIMEOUT;
    _baseDio.options.receiveTimeout = TIMEOUT;
    _baseDio.options.contentType = Headers.jsonContentType;
  }

  static Future<List<Dish>> getDishes() async {
    String path = buildPathForBaseUri([_DISHES]);

    Response response = await _baseDio.get(path);

    if (response.statusCode == 200) {
      List<Dish> dishes = [];
      List<dynamic> body = response.data;
      body.forEach((element) {
        dishes.add(Dish.fromData(element));
      });
      return dishes;
    } else {
      throw RequestException('Ошибка при запросе');
    }
  }

  static String buildPathForBaseUri(List<String> args) => args.join();
  static String buildPathWithUri(String url, List<String> args) =>
      url + args.join();
}

class RequestException implements Exception {
  final String message;

  RequestException(this.message);
}
