import 'package:flutter/material.dart';
import 'dart:typed_data';

Widget displayImageFromBytes(List<int> imageBytes) {
  return Image.memory(Uint8List.fromList(imageBytes));
}
