import 'dart:typed_data';

import 'package:flutter/material.dart';

class FoodImage extends StatelessWidget {
  const FoodImage({Key? key, required this.image}) : super(key: key);
  final List<int> image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
            width: 1,
          ),
        ),
        child: Image.memory(
          Uint8List.fromList(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
