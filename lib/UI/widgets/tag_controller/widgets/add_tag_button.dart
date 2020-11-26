import 'package:flutter/material.dart';

class AddTagButton extends StatelessWidget {
  final Function addTag;

  const AddTagButton({Key key, this.addTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: addTag, //Add tag function
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
