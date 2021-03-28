import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integral_admin/UI/widgets/loader.dart';
import 'package:integral_admin/blocs/update_bloc/update_bloc.dart';
import 'package:integral_admin/models/updater.dart';

class ScreenWithUpdater<DataType> extends StatefulWidget {
  final Updater<DataType> updater;
  final Widget Function(BuildContext, DataType) bodyBuilder;
  final Duration updatePeriod;

  const ScreenWithUpdater({
    Key? key,
    required this.updater,
    required this.bodyBuilder,
    required this.updatePeriod,
  }) : super(key: key);
  @override
  _ScreenWithUpdaterState createState() => _ScreenWithUpdaterState<DataType>();
}

class _ScreenWithUpdaterState<DataType>
    extends State<ScreenWithUpdater<DataType>> {
  late final UpdateBloc<DataType> _bloc;

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
    );
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
          return widget.bodyBuilder(context, state.data);
        } else {
          return Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}
