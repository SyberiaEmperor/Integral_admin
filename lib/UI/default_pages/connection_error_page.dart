import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectionErrorPage extends StatelessWidget {
  final String errorCaption;
  final Function onUpdateAction;

  const ConnectionErrorPage({Key? key, required this.errorCaption, required this.onUpdateAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(errorCaption),
            TextButton(onPressed: onUpdateAction as void Function()?, child: Text('Обновить')),
          ],
        ),
      ),
    );
  }
}
