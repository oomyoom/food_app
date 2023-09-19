import 'package:flutter/material.dart';
import 'package:food_app/models/foodData.dart';
import 'package:food_app/screens/menu/food_details_screen.dart';
import 'package:food_app/utils/constants.dart';

class FoodSpecify extends StatefulWidget {
  const FoodSpecify({Key? key, required this.food}) : super(key: key);
  final Menu food;

  @override
  _FoodSpecifyState createState() => _FoodSpecifyState();
}

class _FoodSpecifyState extends State<FoodSpecify> {
  List<List<bool>> isCheckedList = [];

  @override
  void initState() {
    super.initState();
    for (final category in widget.food.specifytitle) {
      isCheckedList.add(List.filled(category.specifytitle.length, false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: widget.food.specifytitle.asMap().entries.map((entry) {
              final categoryIndex = entry.key;
              final value = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              value.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: kActiveColor,
                              ),
                            ),
                            Text(
                              ' specify',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium!,
                            ),
                          ],
                        ),
                        Column(
                          children: value.specifytitle
                              .asMap()
                              .entries
                              .map((specifyEntry) {
                            final specifyIndex = specifyEntry.key;
                            final specifyTitle = specifyEntry.value;
                            final specifyPrice = value.price[specifyIndex];

                            return CheckboxListTile(
                              activeColor: Colors.green,
                              checkColor: Colors.white,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('$specifyTitle'),
                                  Text(
                                    '฿ $specifyPrice',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: kActiveColor,
                                    ),
                                  ),
                                ],
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              value: isCheckedList[categoryIndex][specifyIndex],
                              onChanged: (bool? newValue) {
                                setState(() {
                                  isCheckedList[categoryIndex][specifyIndex] =
                                      newValue ?? false;
                                  if (newValue == true) {
                                    if (specifyText.isNotEmpty) {
                                      specifyText += '+';
                                    }
                                    specifyText += specifyTitle;
                                    specifyperPrice += specifyPrice;
                                  } else {
                                    if (specifyText.isNotEmpty)
                                      specifyText = specifyText.replaceAll(
                                          '+$specifyTitle', '');
                                    specifyText = specifyText.replaceAll(
                                        specifyTitle, '');
                                    specifyperPrice -= specifyPrice;
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
