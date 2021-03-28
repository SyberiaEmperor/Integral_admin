import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:integral_admin/entities/dish.dart';

class Requests {
  static const IP = '178.154.255.209:3777';
  static const BASE_URI = 'http://$IP';

  static const _DISHES = '/dishes';
  static const _USER = '/user';

  static const TIMEOUT = 5000;

  static late Dio _baseDio;

  static void initReqs() {
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
        dishes.add(Dish.fromJson(element));
      });
      return dishes;
    } else {
      throw RequestException('Ошибка при запросе');
    }
  }

  static Future<void> postDish(Dish dish) async {
    String path = buildPathForBaseUri([_DISHES]);
    print(dish.toJson());
    //FormData formData = FormData.fromMap({'dish': dish.toJson()});

    Response response =
        await _baseDio.post(path, data: jsonEncode({'dish': dish.toJson()}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return;
    } else {
      throw RequestException(response.statusCode.toString());
    }
  }

  static Future<void> putDish(Dish dish) async {
    String path = buildPathForBaseUri([_DISHES, '/', dish.id.toString()]);

    Response response =
        await _baseDio.put(path, data: jsonEncode({'dish': dish.toJson()}));

    print(response.statusCode);
    if (response.statusCode == 200) {
      return;
    } else {
      throw RequestException(response.statusCode.toString());
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
