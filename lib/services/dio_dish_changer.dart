import 'package:integral_admin/controllers/dish_changer.dart';
import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/services/requests.dart';

class DioDishChanger implements DishChanger {
  final String dishId;

  DioDishChanger(this.dishId);

  @override
  Future<void> create(Dish dish) {
    return Requests.postDish(dish);
  }

  @override
  Future<void> delete() {
    return Requests.deleteDish(dishId);
  }

  @override
  Future<void> update(Dish dish) {
    return Requests.putDish(dish);
  }
}
