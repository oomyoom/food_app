import 'package:flutter/material.dart';
import 'package:food_app/utils/constants.dart';

class DeliveryOption extends StatefulWidget {
  const DeliveryOption({Key? key}) : super(key: key);

  @override
  _DeliveryOptionState createState() => _DeliveryOptionState();
}

enum deliveryOption { dineIn, takeOut }

String deliveryTextOption = 'ทานที่ร้าน';

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
              'ตัวเลือก',
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
                  title: const Text('ทานที่ร้าน'),
                  value: deliveryOption.dineIn,
                  groupValue: _selectedOption,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (deliveryOption? value) {
                    setState(() {
                      _selectedOption = value!;
                      deliveryTextOption = 'ทานที่ร้าน';
                    });
                  }),
            ),
            Expanded(
              child: RadioListTile(
                  activeColor: kActiveColor,
                  title: const Text('กลับบ้าน'),
                  value: deliveryOption.takeOut,
                  groupValue: _selectedOption,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value!;
                      deliveryTextOption = 'กลับบ้าน';
                    });
                  }),
            )
          ],
        )
      ],
    );
  }
}
