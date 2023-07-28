import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/demoData.dart';

class dotSlide extends StatelessWidget {
  const dotSlide({Key? key, required this.isActive}) : super(key: key);
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white38,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}

class imageCarousel extends StatefulWidget {
  const imageCarousel({Key? key}) : super(key: key);

  @override
  _imageCarouselState createState() => _imageCarouselState();
}

class _imageCarouselState extends State<imageCarousel> {
  int _cPage = 0;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.81,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PageView.builder(
              itemCount: demoBigImages.length,
              onPageChanged: (value) {
                setState(() {
                  _cPage = value;
                });
              },
              itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Image.asset(
                      demoBigImages[index],
                    ),
                  )),
          Positioned(
              bottom: defaultPadding,
              right: defaultPadding,
              child: Row(
                  children: List.generate(
                      demoBigImages.length,
                      (index) => Padding(
                            padding:
                                const EdgeInsets.only(left: defaultPadding / 4),
                            child: dotSlide(isActive: index == _cPage),
                          ))))
        ],
      ),
    );
  }
}
