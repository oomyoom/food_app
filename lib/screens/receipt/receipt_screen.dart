import 'package:flutter/material.dart';
import 'package:food_app/models/order.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({Key? key}) : super(key: key);

  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  int lastorderId = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    int lastorderId = await getlastId(); // รอให้ Future ทำงานเสร็จ

    if (mounted) {
      // Check if the widget is still mounted before updating state
      setState(() {
        this.lastorderId = lastorderId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close), // รูปไอคอน X หรือสิ่งที่คุณต้องการ
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: lastorderId == 0
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ขอบคุณที่ใช้บริการ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 36),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        'หมายเลขออเดอร์ ${lastorderId}',
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
