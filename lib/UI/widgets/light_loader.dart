import 'package:flutter/material.dart';

class LightLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          Text('Пожалуйста, подождите...')
        ],
      ),
    );
  }
}
