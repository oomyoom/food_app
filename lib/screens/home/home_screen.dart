// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/models/foodData.dart';
import 'package:food_app/screens/menu/menu_screen.dart';
import 'package:food_app/screens/home/components/cardInfo.dart';
import 'package:food_app/screens/home/components/imageCarousel.dart';
import 'package:food_app/screens/home/components/sectionTitle.dart';
import 'package:food_app/screens/sign/login_screen.dart';
import 'package:food_app/screens/sign/profilecreation_screen.dart';
import 'package:food_app/screens/sign/register_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(
        elevation: 0,
        children: [
          // รูปโปรไฟล์
          Container(
            color: Colors.blue,
            padding: EdgeInsets.all(16),
            child: CircleAvatar(
              radius: 72,
              foregroundImage: AssetImage('assets/images/profile_test.jpg'),
            ),
          ),
          // ทางลัด
          Container(
            padding: EdgeInsets.all(20),
            child: Wrap(
              runSpacing: 12,
              children: [
                ListTile(
                  leading: const Icon(Icons.home_outlined),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.favorite_border),
                  title: Text('Favorite'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.workspaces_outline),
                  title: Text('Workflow'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.update),
                  title: Text('Updates'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.account_tree_outlined),
                  title: Text('Plugins'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.notifications_outlined),
                  title: Text('Notifications'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          // แถบบนจอ
          SliverAppBar(
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 66, 118, 93),
            elevation: 0,
            floating: true,
            pinned: true,
            title: Column(
              children: [
                Text(
                  'PWO Restaurant'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          // ภาพใหญ่
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            sliver: SliverToBoxAdapter(
              child: imageCarousel(),
            ),
          ),
          // หัวข้อ
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 4),
            sliver: SliverToBoxAdapter(
              child: sectionTitle(
                title: 'Featured Partners',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuScreen()),
                  );
                },
              ),
            ),
          ),
          // รายการอาหาร
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
                              title: demoMediumCardData[index].title,
                              location: demoMediumCardData[index].location,
                              image: demoMediumCardData[index].image,
                              delivertTime:
                                  demoMediumCardData[index].delivertTime,
                              rating: demoMediumCardData[index].rating,
                              press: () {},
                            ),
                          ))),
            ),
          ),
          // ตั๋ว
          SliverPadding(
            padding: const EdgeInsets.all(defaultPadding),
            sliver: SliverToBoxAdapter(
              child: Image.asset('assets/images/Banner.png'),
            ),
          ),
        ],
      ),
      // Shortcut
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.black,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        spacing: 10,
        children: [
          SpeedDialChild(
            child: Icon(Icons.login_rounded),
            backgroundColor: Colors.blueAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.app_registration),
            backgroundColor: Colors.orange,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.add_shopping_cart),
            backgroundColor: Colors.green,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MenuScreen()),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.usb_rounded),
            backgroundColor: Colors.redAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfilecreationScreen()),
              );
            },
          )
        ],
      ),
    );
  }
}
