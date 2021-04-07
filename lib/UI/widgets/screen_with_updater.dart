import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integral_admin/UI/widgets/loader.dart';
import 'package:integral_admin/blocs/update_bloc/update_bloc.dart';
import 'package:integral_admin/models/order_controller.dart';
import 'package:integral_admin/models/updater.dart';
import 'package:integral_admin/services/singletone.dart';

class ScreenWithUpdater<DataType> extends StatefulWidget {
  final Updater<DataType> updater;
  final Widget Function(
      BuildContext context,
      DataType type,
      VoidCallback confirm,
      VoidCallback delete,
      VoidCallback update) bodyBuilder;
  final Duration updatePeriod;
  final OrderController? confirmer;

  const ScreenWithUpdater({
    Key? key,
    required this.updater,
    required this.bodyBuilder,
    required this.updatePeriod,
    this.confirmer,
  }) : super(key: key);
  @override
  _ScreenWithUpdaterState createState() => _ScreenWithUpdaterState<DataType>();
}

class _ScreenWithUpdaterState<DataType>
    extends State<ScreenWithUpdater<DataType>> {
  late final UpdateBloc<DataType> _bloc;
  late final VoidCallback confirm;
  late final VoidCallback delete;
  late final VoidCallback update;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = UpdateBloc(
        updatePeriod: widget.updatePeriod,
        updater: widget.updater,
        confirmer: widget.confirmer);
    confirm = _bloc.confirm;
    delete = _bloc.delete;
    update = _bloc.update;
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateBloc, UpdateState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is LeavePage) {
          Singletone().update();
          Navigator.of(context).pop();
        }
      },
      builder: (
        context,
        state,
      ) {
        if (state is LeavePage) {
          return Scaffold();
        }
        if (state is ShowLoader) {
          return LoaderWidget();
        } else if (state is UpdateMainState) {
          return widget.bodyBuilder(
              context, state.data, confirm, delete, update);
        } else {
          return Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}
