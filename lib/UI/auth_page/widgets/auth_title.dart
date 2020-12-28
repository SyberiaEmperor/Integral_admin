import 'package:flutter/material.dart';
import 'package:integral_admin/services/responsive_size.dart';

class AuthTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: ResponsiveSize.height(70),
          backgroundImage: AssetImage('assets/integral.jpg'),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(ResponsiveSize.height(20)),
          child: Text(
            'Авторизация',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
