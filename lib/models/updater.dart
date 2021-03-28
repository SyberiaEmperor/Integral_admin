///Interface for any updating functions, like getting a list of orders
abstract class Updater<DataType> {
  Future<DataType> update();
}
