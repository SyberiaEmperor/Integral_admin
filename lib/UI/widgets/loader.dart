import 'package:flutter/material.dart';
import 'package:integral_admin/resources/app_strings.dart';
import 'package:integral_admin/services/responsive_size.dart';

///Shows circled loader.
class LoaderWidget extends StatelessWidget {
  ///Color of spinning circle
  final Color? color;
  final Color? backgroundColor;
  const LoaderWidget({Key? key, this.color, this.backgroundColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;
        var circleSize =
            (width > height ? height : width) * 0.1; // 0.3 of the smallest
        return Theme(
          data: themeData,
          child: Container(
            height: height,
            width: width,
            color: backgroundColor ?? themeData.backgroundColor,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(
                    ResponsiveSize.width(15),
                  ),
                  child: Text(
                    AppLabelStrings.LOADER_LABEL,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: themeData.textTheme.bodyText2,
                  ),
                ),
                SizedBox(
                  height: circleSize,
                  width: circleSize,
                  child: CircularProgressIndicator(
                    strokeWidth: 5.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
