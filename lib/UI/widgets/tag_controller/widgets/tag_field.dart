import 'package:flutter/material.dart';
import 'package:integral_admin/entities/dish.dart';
import 'package:integral_admin/services/responsive_size.dart';

class TagField extends StatelessWidget {
  final Category tag;

  final void Function() removeTag;

  const TagField(this.tag, this.removeTag);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 8),
      child: Container(
        height: 25,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tag.asString,
              style: TextStyle(
                  fontSize: ResponsiveSize.height(10), color: Colors.white),
              textWidthBasis: TextWidthBasis.parent,
            ),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: removeTag,
              child: Container(
                width: 14,
                height: 25,
                decoration: BoxDecoration(
                  color: Color(0xff0c2977),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
