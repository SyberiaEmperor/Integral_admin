import 'dart:typed_data';

import 'package:integral_admin/models/image_controller.dart';
import 'package:integral_admin/services/images.dart';

class GalleryImageController extends ImageController<Uint8List>
{
  Uint8List _image;

  @override
  Uint8List get image => _image;

  @override
  void getImage() async {
    _image = await Images.getImage();
  }
}