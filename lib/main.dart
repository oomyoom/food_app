// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Application",
      home: Homepage(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int num = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plus Number'),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                width: 300,
                height: 500,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://i1.sndcdn.com/avatars-SL0rqR7Ewm4xSHHE-nkFDLA-t500x500.jpg'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    width: 8
                  )
                ),
              child: null),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      'Astolfo',
                      style: TextStyle(color: Colors.black,fontSize: 25),
                      ),
                  )
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Fate/GO',
                      style: TextStyle(color: Colors.purple,fontSize: 25),
                      ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: increaseNum,
        child: Icon(Icons.add),
      ),
    );
  }

  void increaseNum() {
    setState(() {
      num++;
    });
  }
}
