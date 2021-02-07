import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final String caption;

  const LoadingPage({Key key, this.caption = 'Загрузка'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(caption),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
