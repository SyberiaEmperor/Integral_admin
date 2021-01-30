import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectionErrorPage extends StatelessWidget {
  final String errorCaption;
  final Function onUpdateAction;

  const ConnectionErrorPage({Key key, this.errorCaption, this.onUpdateAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(errorCaption),
            FlatButton(onPressed: onUpdateAction, child: Text('Обновить')),
          ],
        ),
      ),
    );
  }
}
