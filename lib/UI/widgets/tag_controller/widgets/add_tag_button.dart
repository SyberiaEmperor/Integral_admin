import 'package:flutter/material.dart';

class AddTagButton extends StatelessWidget {
  final Function? addTag;

  const AddTagButton({Key? key, this.addTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: addTag as void Function()?, //Add tag function
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.add,size: 15, color: Colors.white,),
      ),
    );
  }
}
