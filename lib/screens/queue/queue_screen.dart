import 'package:flutter/material.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/utils/orderQueue.dart';

class QueueScreen extends StatelessWidget {
  const QueueScreen({Key? key, required this.order}) : super(key: key);
  final List<OrderQueue> order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kMainColor,
        centerTitle: true,
        title: Text(
          'Queue'.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Text(
                    'Number of queues',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Text(
                    '0',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: kActiveColor,
                    ),
                  ),
                  Column(
                    children: [],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
