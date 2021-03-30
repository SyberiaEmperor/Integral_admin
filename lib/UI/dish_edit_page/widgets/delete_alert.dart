import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integral_admin/UI/widgets/generic_button.dart';
import 'package:integral_admin/services/responsive_size.dart';

class DeleteAlert {
  static Future showDeleteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Вы уверены, что хотите удалить это блюдо?',
              style: Theme.of(context).primaryTextTheme.bodyText2,
            ),
            actions: [],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenericButton(
                    action: () {
                      //TODO: make implementation
                    },
                    text: 'Удалить',
                    color: Theme.of(context).accentColor),
                GenericButton(
                    action: () {
                      Navigator.pop(context);
                    },
                    text: 'Отмена',
                    color: Colors.black),
              ],
            ),
          );
        });
  }
}
