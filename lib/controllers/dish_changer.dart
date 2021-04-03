import 'package:integral_admin/entities/dish.dart';

abstract class DishChanger {
  Future<void> update(Dish dish);
  Future<void> create(Dish dish);
  Future<void> delete();
}
