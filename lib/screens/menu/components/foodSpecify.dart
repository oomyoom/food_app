import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';

class FoodSpecify extends StatefulWidget {
  const FoodSpecify({Key? key}) : super(key: key);

  @override
  _FoodSpecifyState createState() => _FoodSpecifyState();
}

class _FoodSpecifyState extends State<FoodSpecify> {
  List<bool> isChecked = [false, false];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Please specify, maximum 1',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium!,
          ),
          Column(
            children: isChecked.asMap().entries.map((entry) {
              final index = entry.key;
              final value = entry.value;

              return CheckboxListTile(
                activeColor: Colors.green,
                checkColor: Colors.white,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Option ${index + 1}'),
                    Text(
                      'USD 0.0',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: kActiveColor,
                      ),
                    ),
                  ],
                ),
                controlAffinity: ListTileControlAffinity.leading,
                value: value,
                onChanged: (bool? newValue) {
                  setState(() {
                    isChecked[index] = newValue ?? false;
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
