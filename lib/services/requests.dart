import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:integral_admin/entities/api/order_from_api.dart';
import 'package:integral_admin/entities/auth_data.dart';
import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/resources/app_strings.dart';
import 'package:integral_admin/utils/exceptions/auth_exceptions.dart';

class Requests {
  static const IP = '178.154.255.209:3777';
  static const BASE_URI = 'http://$IP';

  static const _DISHES = '/dishes';
  static const _ORDERS = '/orders';
  static const _CONFIRM = 'confirm';

  static const _TOKEN = '/superuser_token';

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

  static void _initJwt(String jwt) {
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

  static Future<void> logIn(AuthData data) async {
    try {
      Response response =
          await _baseDio.post(_TOKEN, data: {'auth': data.toJson()});
      print(response.data);
      if (response.statusCode == HttpStatus.created) {
        //TODO: Remove _jwt ?
        var jwt = response.data[AppUserStrings.TOKEN];
        _initJwt(jwt);
        return;
      }
    } on DioError catch (error) {
      throw AuthException(error.message);
    }
  }

  static Future<List<Dish>> getDishes() async {
    try {
      String path = buildPathForBaseUri([_DISHES]);

      Response response = await _baseDio.get(path);

      if (response.statusCode == HttpStatus.ok) {
        List<Dish> dishes = [];
        List<dynamic> body = response.data;
        body.forEach((element) {
          dishes.add(Dish.fromData(element));
        });
        return dishes;
      } else {
        throw RequestException('Ошибка при запросе');
      }
    } on DioError catch (e) {
      throw RequestException(e.message);
    }
  }

  static Future<void> postDish(Dish dish) async {
    try {
      String path = buildPathForBaseUri([_DISHES]);
      print(dish.toJson());
      Response response =
          await _baseDio.post(path, data: jsonEncode({'dish': dish.toJson()}));
      print(response.statusCode);
      if (response.statusCode == HttpStatus.ok) {
        return;
      } else {
        throw RequestException(response.statusCode.toString());
      }
    } on DioError catch (e) {
      throw RequestException(e.message);
    }
  }

  static Future<void> putDish(Dish dish) async {
    try {
      String path = buildPathForBaseUri([_DISHES, '/', dish.id.toString()]);

      Response response =
          await _baseDio.put(path, data: jsonEncode({'dish': dish.toJson()}));

      print(response.statusCode);
      if (response.statusCode == HttpStatus.ok) {
        return;
      } else {
        throw RequestException(response.statusCode.toString());
      }
    } on DioError catch (error) {
      throw RequestException(error.message);
    }
  }

  static Future<List<OrderFromApi>> getAllOrders() async {
    try {
      Response response = await _jwtDio.get(_ORDERS);
      if (response.statusCode == HttpStatus.ok) {
        List<OrderFromApi> orders = (response.data as List<dynamic>)
            .map((data) => OrderFromApi.fromJson(data))
            .toList();
        print(orders);
        return orders;
      }
      throw RequestException('Ошибка во время получения заказов');
    } on DioError catch (e) {
      throw RequestException(e.message);
    }
  }

  static Future<FullOrder> getOrderById(int id) async {
    try {
      String path = buildPathForBaseUri([_ORDERS, '/', id.toString()]);

      print(path);
      Response response = await _jwtDio.get(path);

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> body = response.data;
        print(body);
        return FullOrder.fromJson(body);
      } else {
        throw RequestException('Такого заказа не существует');
      }
    } on DioError catch (e) {
      throw RequestException(e.message);
    }
  }

  static Future<FullOrder> confirmOrder(int orderId) async {
    try {
      String path = buildPathForBaseUri(
          [_ORDERS, '/', orderId.toString(), '/', _CONFIRM]);

      Response response = await _jwtDio.put(path);

      if (response.statusCode != HttpStatus.ok) {
        return FullOrder.fromJson(response.data);
      } else {
        throw RequestException('Ошибка во время выполнения запроса');
      }
    } on DioError catch (e) {
      throw RequestException(e.message);
    }
  }
}

class RequestException implements Exception {
  final String message;

  RequestException(this.message);
}
