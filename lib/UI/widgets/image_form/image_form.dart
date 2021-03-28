import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:integral_admin/models/image_controller.dart';
import 'package:integral_admin/services/responsive_size.dart';

class ImageForm extends StatefulWidget {
  final ImageController controller;
  final String? picUrl;

  ImageForm({required this.controller, this.picUrl});

  @override
  _ImageFormState createState() => _ImageFormState();
}

class _ImageFormState extends State<ImageForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () async {
          await widget.controller.getImage();
          setState(() {});
        },
        child: Container(
          width: double.infinity,
          height: ResponsiveSize.height(281),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: widget.controller.image == null
                  ? (widget.picUrl == null
                          ? AssetImage('assets/no_image.jpg')
                          : CachedNetworkImageProvider(widget.picUrl!))
                      as ImageProvider<Object>
                  : MemoryImage(widget.controller.image),
            ),
          ),
        ),
      ),
    );
  }
}
