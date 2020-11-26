import 'package:flutter/material.dart';
import 'package:integral_admin/UI/widgets/tag_controller/widgets/add_tag_button.dart';
import 'package:integral_admin/UI/widgets/tag_controller/widgets/tag_field.dart';
import 'package:integral_admin/UI/widgets/tag_controller/widgets/tag_wheel.dart';
import 'package:integral_admin/models/dish.dart';

class TagController extends StatefulWidget {
  Set<Category> categories;

  TagController({this.categories});

  void removeCategory(Category e) {
    categories.remove(e);
  }

  void addCategory(Category e) {
    categories.add(e);
  }

  @override
  _TagControllerState createState() => _TagControllerState();
}

class _TagControllerState extends State<TagController> {
  List<Widget> tags;

  @override
  void initState() {
    tags = [
      ...(widget.categories
          .map((e) => TagField(e, () {
                tags.removeWhere((element) {
                  if (element is TagField)
                    return element.tag == e;
                  else
                    return false;
                });
                widget.removeCategory(e);
                setState(() {});
                print("hasdlg[");
              }))
          .toList()),
      AddTagButton(
        addTag: () async {
          print(widget.categories);
          var new_tag = await Modal.mainBottomSheet(
              context, Category.values.toSet().difference(widget.categories));
          if (new_tag != null) {
            tags.insert(
                tags.length - 1,
                TagField(new_tag, () {
                  tags.removeWhere((element) {
                    if (element is TagField)
                      return element.tag == new_tag;
                    else
                      return false;
                  });
                  widget.removeCategory(new_tag);
                  setState(() {});
                  print("ahg");
                }));
            widget.addCategory(new_tag);
            setState(() {});
            print("ahg");
          }
        },
      )
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: tags,
    );
  }
}
