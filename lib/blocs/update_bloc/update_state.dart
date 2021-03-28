part of 'update_bloc.dart';

@immutable
abstract class UpdateState<DataType> {}

class UpdateMainState<DataType> extends UpdateState<DataType> {
  final DataType data;

  UpdateMainState(this.data);
}

class ShowLoader extends UpdateState {}
