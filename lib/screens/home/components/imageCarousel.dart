import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/models/foodData.dart';

class ImageCarouselWithDots extends StatefulWidget {
  @override
  _ImageCarouselWithDotsState createState() => _ImageCarouselWithDotsState();
}

class _ImageCarouselWithDotsState extends State<ImageCarouselWithDots> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.81,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CarouselSlider(
            items: demoBigImages.map((image) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(image),
              );
            }).toList(),
            options: CarouselOptions(
              autoPlayAnimationDuration:
                  Duration(milliseconds: 500), // ปรับความเร็วในการเลื่อน
              autoPlayCurve: Curves.fastOutSlowIn, // ปรับลักษณะการเลื่อน
              autoPlay: true, // ให้มันเล่นอัตโนมัติหรือไม่
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              aspectRatio: 1.81,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          Positioned(
            bottom: defaultPadding,
            right: defaultPadding,
            child: Row(
              children: List.generate(
                demoBigImages.length,
                (index) => Padding(
                  padding: EdgeInsets.only(left: defaultPadding / 4),
                  child: Container(
                    width: 8,
                    height: 4,
                    decoration: BoxDecoration(
                      color:
                          index == _currentPage ? Colors.white : Colors.white38,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
