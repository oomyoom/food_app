import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageProfileHelper {
  ImageProfileHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  Future<XFile?> pickImage({
    ImageSource source = ImageSource.gallery,
    int imageQuality = 100,
  }) async {
    final file = await _imagePicker.pickImage(
      source: source,
      imageQuality: imageQuality,
    );
    if (file != null) return file;
    return null;
  }

  Future<CroppedFile?> crop({
    required XFile file,
    CropStyle cropStyle = CropStyle.rectangle,
  }) async =>
      await _imageCropper.cropImage(
        sourcePath: file.path,
        cropStyle: cropStyle,
      );
}

class ImageProfile extends StatefulWidget {
  const ImageProfile({Key? key}) : super(key: key);

  @override
  _ImageProfileState createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      onTap: () async {
        final imagefile = await ImageProfileHelper().pickImage();
        if (imagefile != null) {
          final croppedFile = await ImageProfileHelper()
              .crop(file: imagefile, cropStyle: CropStyle.circle);
          if (croppedFile != null) {
            setState(() => image = File(croppedFile.path));
          }
        }
      },
      child: CircleAvatar(
        radius: 72,
        backgroundImage: const AssetImage('assets/images/take_a_photo.png'),
        backgroundColor: Colors.grey[300],
        foregroundImage: image != null ? FileImage(image!) : null,
      ),
    );
  }
}
