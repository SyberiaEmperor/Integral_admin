import 'package:flutter/material.dart';

class TagField extends StatelessWidget {
  final String tag;

  const TagField(this.tag);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 8),
      child: Container(
        height: 25,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tag,
              style: TextStyle(fontSize: 12, color: Colors.white),
              textWidthBasis: TextWidthBasis.parent,
            ),
            SizedBox(
              width: 5,
            ),
            Container(
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
          ],
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}
