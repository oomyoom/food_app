import 'package:flutter/material.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/utils/orderQueue.dart';

class QueueScreen extends StatelessWidget {
  const QueueScreen({Key? key, required this.order}) : super(key: key);
  final List<OrderQueue> order;

  @override
  Widget build(BuildContext context) {
    int totalQueue = 0;
    for (var item in order) {
      print('Order ID: ${item.OrderId}');
      if (item.isCompleted == false) totalQueue++;
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        const Text(
                          'Number of queues',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 36),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black26, width: 1))),
                          child: Column(
                            children: [
                              Text(
                                '$totalQueue',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: kActiveColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Container(
                          padding: EdgeInsets.all(defaultPadding),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black26, width: 1),
                              color: kMainColor),
                          child: Column(
                            children: [
                              Text(
                                'Queue ID',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: order.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final value = entry.value;
                                    if (value.isCompleted == false) {
                                      return Column(
                                        children: [
                                          Text(
                                            'ORD ${value.OrderId}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(color: Colors.white),
                                          )
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('AAA')],
              ),
            ),
          )
        ],
      ),
    );
  }
}
