import 'package:flutter/material.dart';
import 'package:food_app/screens/queue/components/statusContainer.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/models/order.dart';

class QueueScreen extends StatelessWidget {
  const QueueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalQueue = 0;
    Color color = Colors.black;
    for (var item in order) {
      //print(item.creatDateTime.toString().substring(0, 16));
      if (item.isCompleted == false) totalQueue++;
    }
    switch (totalQueue) {
      case 0:
        color = Colors.black26;
        break;
      default:
        if (totalQueue <= 10) {
          color = Colors.green;
        }
        if (totalQueue > 10) {
          color = Colors.red;
        }
    }

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
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Text(
                            'Number of queues',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 1))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StatusContainer.colorContainer(context, color),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                Text('$totalQueue',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: kActiveColor)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.5,
                            color: Colors.black38,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Text(
                                    'Queue ID',
                                    style:
                                        Theme.of(context).textTheme.titleLarge!,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  Column(
                                    children:
                                        order.asMap().entries.map((entry) {
                                      final value = entry.value;
                                      if (value.isCompleted == false) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.01),
                                              child: Text(
                                                'ORD ${value.orderId}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!,
                                              ),
                                            )
                                          ],
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(defaultPadding),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StatusContainer(color: Colors.black26, title: '0'),
                    StatusContainer(color: Colors.green, title: '<= 10'),
                    StatusContainer(color: Colors.red, title: '> 10'),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
