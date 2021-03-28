import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:integral_admin/entities/auth_data.dart';
import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/entities/user.dart';
import 'package:integral_admin/resources/app_strings.dart';
import 'package:integral_admin/utils/exceptions/auth_exceptions.dart';

class Requests {
  static const IP = '178.154.255.209:3777';
  static const BASE_URI = 'http://$IP';

  static const _DISHES = '/dishes';
  static const _USER = '/user';

  static const _TOKEN = '/user_token';

  static const TIMEOUT = 5000;

  static late Dio _baseDio;
  static late Dio _jwtDio;

  static String buildPathForBaseUri(List<String> args) => args.join();
  static String buildPathWithUri(String url, List<String> args) =>
      url + args.join();

  static void initReqs() {
    _baseDio = Dio();

    _baseDio.options.baseUrl = BASE_URI;
    _baseDio.options.connectTimeout = TIMEOUT;
    _baseDio.options.receiveTimeout = TIMEOUT;
    _baseDio.options.contentType = Headers.jsonContentType;
  }

  static Future<void> logIn(AuthData data) async {
    try {
      Response response =
          await _baseDio.post(_TOKEN, data: {'auth': data.toJson()});
      print(response.data);
      if (response.statusCode == HttpStatus.created) {
        //TODO: Remove _jwt ?
        var jwt = response.data[AppUserStrings.TOKEN];
        initJwt(jwt);
        return;
      }
    } on DioError catch (error) {
      throw AuthException(error.message);
    }
  }

  static void initJwt(String jwt) {
    _jwtDio = Dio(
      BaseOptions(
        baseUrl: BASE_URI,
        connectTimeout: TIMEOUT,
        receiveTimeout: TIMEOUT,
        contentType: Headers.jsonContentType,
        headers: {
          DioStrings.AUTH_HEADER: DioStrings.BEARER + jwt,
        },
      ),
    );
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
    try {
      String path = buildPathForBaseUri([_DISHES, '/', dish.id.toString()]);

      Response response =
          await _baseDio.put(path, data: jsonEncode({'dish': dish.toJson()}));

      print(response.statusCode);
      if (response.statusCode == 200) {
        return;
      } else {
        throw RequestException(response.statusCode.toString());
      }
    } on DioError catch (error) {
      throw RequestException(error.message);
    }
  }
}

class RequestException implements Exception {
  final String message;

  RequestException(this.message);
}
