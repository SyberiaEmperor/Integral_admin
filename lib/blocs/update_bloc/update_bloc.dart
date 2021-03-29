import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:integral_admin/models/order_controller.dart';
import 'package:integral_admin/models/updater.dart';
import 'package:integral_admin/services/requests.dart';
import 'package:meta/meta.dart';

part 'update_event.dart';
part 'update_state.dart';

///Runs [updater] every [updatePeriod]
class UpdateBloc<DataType> extends Bloc<UpdateEvent, UpdateState> {
  ///An implementation of updater interface. Need to update values
  final Updater<DataType> updater;

  late DataType _data;
  final OrderController? confirmer;

  ///Cycle time
  final Duration updatePeriod;

  late Timer _updaterTimer;

  UpdateBloc(
      {required this.updater, required this.updatePeriod, this.confirmer})
      : super(ShowLoader()) {
    _init();
  }

  void _init() {
    update();
    _updaterTimer = Timer.periodic(updatePeriod, (timer) {
      update();
    });
  }

  void setData() {
    add(SetData());
  }

  void confirm() async {
    try {
      _data = await confirmer?.updateStatus() as DataType;
      setData();
    } on RequestException catch (e) {
      print(e.message);
    }
  }

  void delete() async {
    try {
      await confirmer?.deleteOrder();
    } on RequestException catch (e) {
      print(e.message);
    }
  }

  @override
  Future<void> close() {
    _updaterTimer.cancel();
    return super.close();
  }

  ///Runs update function of updater.
  void update() {
    add(RunUpdate._());
  }

  @override
  Stream<UpdateState> mapEventToState(
    UpdateEvent event,
  ) async* {
    if (event is RunUpdate) {
      _data = await updater.update();
      yield UpdateMainState(_data);
    }
    if (event is SetData) {
      yield UpdateMainState(_data);
    }
  }
}
