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
  Widget addButton;

  void fillTags() {
    tags = [
      ...(widget.categories
          .map((category) => TagField(category, () {
                widget.removeCategory(category);
                setState(() {});
              }))
          .toList()),
      addButton
    ];
  }

  @override
  void initState() {
    super.initState();
    addButton = AddTagButton(
      addTag: () async {
        print(widget.categories);
        var new_tag = await Modal.mainBottomSheet(
            context, Category.values.toSet().difference(widget.categories));
        if (new_tag != null) {
          widget.addCategory(new_tag);
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    fillTags();
    return Wrap(
      children: tags,
    );
  }
}

/*
Future<void> addDialog(BuildContext context, List<Category> data, void Function(Category) add)
{
  if(data.isEmpty)
    return null;
  return  showDialog(
    context: context,
    child: 
    Center(child:Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        // boxShadow: [
        //                   BoxShadow(
        //             color: Colors.grey,
        //             offset: Offset(1.0, 2.0),
        //             blurRadius: 3.0)
        // ]
      ),

    child:ListView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      itemExtent: 30.0,
      itemBuilder: (context, index) { 
        return RawMaterialButton(
          child: Text(data[index].asString),
          onPressed: () {
          add(data[index]);
          Navigator.of(context).pop();});
          }
        ),))
       );

}


*/
