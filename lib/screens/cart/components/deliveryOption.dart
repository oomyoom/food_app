import 'package:flutter/material.dart';
import 'package:food_app/utils/constants.dart';

class DeliveryOption extends StatefulWidget {
  const DeliveryOption({Key? key}) : super(key: key);

  @override
  _DeliveryOptionState createState() => _DeliveryOptionState();
}

enum deliveryOption { dineIn, takeOut }

String deliveryTextOption = '';

class _DeliveryOptionState extends State<DeliveryOption> {
  deliveryOption _selectedOption = deliveryOption.dineIn;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Selected-Option',
              style: Theme.of(context).textTheme.titleLarge!,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RadioListTile(
                  activeColor: kActiveColor,
                  title: Text('Dine-In'),
                  value: deliveryOption.dineIn,
                  groupValue: _selectedOption,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (deliveryOption? value) {
                    setState(() {
                      _selectedOption = value!;
                      deliveryTextOption = 'Dine-In';
                    });
                  }),
            ),
            Expanded(
              child: RadioListTile(
                  activeColor: kActiveColor,
                  title: Text('Take-Away'),
                  value: deliveryOption.takeOut,
                  groupValue: _selectedOption,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value!;
                      deliveryTextOption = 'Take-Away';
                    });
                  }),
            )
          ],
        )
      ],
    );
  }
}
