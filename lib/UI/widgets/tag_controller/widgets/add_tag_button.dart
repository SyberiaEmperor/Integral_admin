import 'package:flutter/material.dart';
import 'package:integral_admin/services/responsive_size.dart';

class AddTagButton extends StatelessWidget {
  final Function? addTag;

  const AddTagButton({Key? key, this.addTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: addTag as void Function()?, //Add tag function
      child: Container(
        width: 150,
        height: 25,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Добавить категорию',
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyText2!
                    .copyWith(fontSize: 10.height, color: Colors.white)),
            Icon(
              Icons.add,
              size: 15,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
