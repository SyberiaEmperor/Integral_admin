import 'package:flutter/material.dart';
import 'package:integral_admin/services/responsive_size.dart';

class BottomButtonBar extends StatelessWidget {
  //TODO: Add work with visibility
  final void Function() leftFieldCallback;
  final void Function() rightFieldCallback;
  final bool? trashVisibility;

  const BottomButtonBar(
      {required this.leftFieldCallback,
      required this.rightFieldCallback,
      this.trashVisibility});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: trashVisibility!,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
            child: GestureDetector(
              onTap: leftFieldCallback,
              child: Container(
                  height: ResponsiveSize.height(70),
                  width: ResponsiveSize.width(60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff0C2944),
                  ),
                  child: Icon(
                    Icons.delete,
                    size: 20,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
        Container(
          width: 200,
          child: GestureDetector(
            onTap: rightFieldCallback,
            child: Container(
                height: ResponsiveSize.height(70),
                width: ResponsiveSize.width(60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: Theme.of(context).accentColor,
                ),
                child: Icon(
                  Icons.check,
                  size: 20,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }
}
