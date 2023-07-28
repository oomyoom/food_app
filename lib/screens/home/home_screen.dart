// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/demoData.dart';
import 'package:food_app/screens/home/components/cardInfo.dart';
import 'package:food_app/screens/home/components/imageCarousel.dart';
import 'package:food_app/screens/home/components/sectionTitle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color.fromARGB(255, 66, 118, 93),
            elevation: 0,
            floating: true,
            title: Column(
              children: [
                Text(
                  'Delivery to'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                ),
                Text(
                  'Bangkok',
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Filter',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            sliver: SliverToBoxAdapter(
              child: imageCarousel(),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 4),
            sliver: SliverToBoxAdapter(
              child: sectionTitle(
                title: 'Featured Partners',
                press: () {},
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(
                      demoMediumCardData.length,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2),
                            child: cardInfo(
                              title: demoMediumCardData[index]['name'],
                              location: demoMediumCardData[index]['location'],
                              image: demoMediumCardData[index]['image'],
                              delivertTime: demoMediumCardData[index]
                                  ['delivertTime'],
                              rating: demoMediumCardData[index]['rating'],
                              press: () {},
                            ),
                          ))),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(defaultPadding),
            sliver: SliverToBoxAdapter(
              child: Image.asset('assets/images/Banner.png'),
            ),
          ),
                    SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 4),
            sliver: SliverToBoxAdapter(
              child: sectionTitle(
                title: 'Best Picks',
                press: () {},
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(
                      demoMediumCardData.length,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2),
                            child: cardInfo(
                              title: demoMediumCardData[index]['name'],
                              location: demoMediumCardData[index]['location'],
                              image: demoMediumCardData[index]['image'],
                              delivertTime: demoMediumCardData[index]
                                  ['delivertTime'],
                              rating: demoMediumCardData[index]['rating'],
                              press: () {},
                            ),
                          ))),
            ),
          ),
        ],
      ),
    );
  }
}
