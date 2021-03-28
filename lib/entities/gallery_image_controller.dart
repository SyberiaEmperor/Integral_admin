import 'dart:convert';
import 'dart:typed_data';

import 'package:integral_admin/models/image_controller.dart';
import 'package:integral_admin/services/images.dart';

class GalleryImageController extends ImageController<Uint8List?> {
  Uint8List? _image;

  @override
  Uint8List? get image => _image;

  String get base64 => base64Encode(_image!);

  @override
  Future<void> getImage() async {
    _image = await Images.getImage();
  }
}
