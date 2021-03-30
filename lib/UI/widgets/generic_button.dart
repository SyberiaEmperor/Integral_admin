import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integral_admin/services/responsive_size.dart';

class GenericButton extends StatelessWidget {
  final VoidCallback action;
  final String text;
  final Color color;

  const GenericButton({
    Key? key,
    required this.action,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.height),
      child: GestureDetector(
        onTap: action,
        child: Container(
          alignment: Alignment.center,
          height: 50.height,
          width: 150.width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.circular((10)),
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context)
                .accentTextTheme
                .bodyText2!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
