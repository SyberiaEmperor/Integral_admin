import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void bottomWarningBar(BuildContext context, String caption) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 8),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.announcement_rounded),
          Text(
            caption,
            style: Theme.of(context).primaryTextTheme.bodyText1,
          ),
        ],
      ),
    ),
  );
}
