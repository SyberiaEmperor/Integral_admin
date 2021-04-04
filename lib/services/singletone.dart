class Singletone {
  void Function() update = () {};
  static Singletone _instanse = Singletone._();

  factory Singletone() {
    return Singletone._instanse;
  }

  Singletone._();
}
