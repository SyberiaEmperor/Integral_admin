import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integral_admin/UI/widgets/loader.dart';
import 'package:integral_admin/blocs/update_bloc/update_bloc.dart';
import 'package:integral_admin/models/order_updater.dart';
import 'package:integral_admin/models/updater.dart';

class ScreenWithUpdater<DataType> extends StatefulWidget {
  final Updater<DataType> updater;
  final Widget Function(BuildContext, DataType, VoidCallback) bodyBuilder;
  final Duration updatePeriod;
  final OrderConfirmer? confirmer;

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
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBloc, UpdateState>(
      bloc: _bloc,
      builder: (
        context,
        state,
      ) {
        if (state is ShowLoader) {
          return LoaderWidget();
        } else if (state is UpdateMainState) {
          return widget.bodyBuilder(context, state.data, confirm);
        } else {
          return Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}
