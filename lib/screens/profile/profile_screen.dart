import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_app/models/users.dart';
import 'package:food_app/screens/profile/editprofile_screen.dart';
import 'package:food_app/utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF73C088),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kMainColor,
        elevation: 0,
        title: Text(
          'โปรไฟล์'.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                  children: profile.asMap().entries.map((e) {
                final value = e.value;

                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.4,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.35,
                          decoration: const BoxDecoration(
                            color: kMainColor, // สีพื้นหลังของ Container
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black, // สีเงา
                                offset: Offset(0, 2), // ตำแหน่งเงาในแกน x และ y
                                blurRadius: 4, // ความเครียดของเงา
                                spreadRadius: 0, // การขยายของเงา
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.2,
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.2,
                          foregroundImage:
                              MemoryImage(Uint8List.fromList(value['image'])),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.63,
                        child: Column(
                          children: [
                            Text(
                              "${value['firstname']} ${value['lastname']}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.white),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              value['username'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.width * 0.8,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditprofileScreen(
                                          image: value['image'],
                                          firstname: value['firstname'],
                                          lastname: value['lastname'],
                                          username: value['username'])));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                fixedSize: MaterialStateProperty.all(Size(
                                    MediaQuery.of(context).size.width * 0.2,
                                    MediaQuery.of(context).size.height *
                                        0.01))),
                            child: Text(
                              'แก้ไข',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: kMainColor),
                            ),
                          )),
                      Positioned(
                        top: MediaQuery.of(context).size.width * 1,
                        child: Text(
                          value['birthday'].toString().split('T')[0],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList()),
            ),
          ),
        ),
      ),
    );
  }
}
