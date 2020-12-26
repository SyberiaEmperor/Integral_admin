import 'package:integral_admin/entities/dish.dart';

abstract class DishController {
  List<Dish> byCategory(Category category);
  List<Dish> search(String text);
  Future<void> updateDishes();
}
