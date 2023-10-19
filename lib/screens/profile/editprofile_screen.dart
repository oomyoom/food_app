import 'package:flutter/material.dart';
import 'package:food_app/models/users.dart';
import 'package:food_app/screens/home/components/imageProfile.dart';
import 'package:food_app/utils/buttomTab.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:food_app/utils/constants.dart';
import 'package:food_app/utils/tapButton.dart';
import 'package:image_cropper/image_cropper.dart';

class EditprofileScreen extends StatefulWidget {
  const EditprofileScreen(
      {Key? key,
      required this.image,
      required this.firstname,
      required this.lastname,
      required this.username})
      : super(key: key);
  final List<int> image;
  final String firstname, lastname, username;

  @override
  _EditprofileScreenState createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  File? tempFile;
  File? _image;
  bool _hasImage = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernametextController = TextEditingController();
  final TextEditingController _firstnametextController =
      TextEditingController();
  final TextEditingController _lastnametextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // นี่คือส่วนที่คุณสามารถใช้ในการรีเฟรช state หรือโหลดข้อมูลใหม่
    _usernametextController.text = widget.username;
    _firstnametextController.text = widget.firstname;
    _lastnametextController.text = widget.lastname;
  }

  Future<File> convertBlobToFile(Uint8List blob) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempFilePath = '${tempDir.path}/temp_image.png';
    File tempFile = File(tempFilePath);

    // เขียนข้อมูล blob ลงในแฟ้มชั่วคราว
    tempFile.writeAsBytesSync(blob);

    return tempFile;
  }

  Future<List<int>> convertFileToBytes(File file) async {
    final Uint8List uint8list = await file.readAsBytes();
    return uint8list.toList();
  }

  Future<void> userUpdate(
    File imageFile,
    String username,
    String firstname,
    String lastname,
  ) async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('http://192.168.1.84:3333/user/update');
      final request = http.MultipartRequest('PUT', url);
      request.fields['username'] = username;
      request.fields['firstname'] = firstname;
      request.fields['lastname'] = lastname;

      request.files.add(http.MultipartFile(
        'image',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: 'image.jpg',
      ));

      final response = await request.send();

      if (response.statusCode == 200) {
        await tempFile!.delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('อัปเดตโปรไฟล์สำเร็จ'),
            duration: Duration(seconds: 3), // ระยะเวลาที่แจ้งเตือนแสดง
          ),
        );
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ButtomTab(
                      initialIndex: 3,
                    )));
      } else {
        // เกิดข้อผิดพลาดในการสร้างโปรไฟล์
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('อัพเดตโปรไฟล์ล้มเหลว'),
            duration: Duration(seconds: 3), // ระยะเวลาที่แจ้งเตือนแสดง
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kMainColor,
        elevation: 0,
        title: Text(
          'แก้ไขโปรไฟล์'.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.03),
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    onTap: () async {
                      final imagefile = await ImageProfileHelper().pickImage();
                      if (imagefile != null) {
                        final croppedFile = await ImageProfileHelper()
                            .crop(file: imagefile, cropStyle: CropStyle.circle);
                        if (croppedFile != null) {
                          setState(() {
                            _image = File(croppedFile.path);
                            _hasImage = true;
                          });
                        }
                      }
                    },
                    child: CircleAvatar(
                      radius: 72,
                      backgroundImage:
                          MemoryImage(Uint8List.fromList(widget.image)),
                      backgroundColor: Colors.grey[300],
                      foregroundImage:
                          _hasImage == true ? FileImage(_image!) : null,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'ชื่อผู้ใช้',
                          labelStyle: TextStyle(fontSize: 16)),
                      controller: _usernametextController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'โปรดกรอกชื่อผู้ใช้';
                        }
                        return null;
                      },
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'ชื่อ', labelStyle: TextStyle(fontSize: 16)),
                    controller: _firstnametextController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'โปรดกรอกชื่อของคุณ';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'นามสกุล',
                          labelStyle: TextStyle(fontSize: 16)),
                      controller: _lastnametextController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'โปรดกรอกนามสกุลของคุณ';
                        }
                        return null;
                      },
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03),
                    child: TapButton(
                      press: () async {
                        if (_formKey.currentState!.validate()) {
                          Uint8List blobData = Uint8List.fromList(widget.image);
                          tempFile = await convertBlobToFile(blobData);
                          profile[0]['image'] = _hasImage == true
                              ? await convertFileToBytes(_image!)
                              : widget.image;
                          profile[0]['username'] = _usernametextController.text;
                          profile[0]['firstname'] =
                              _firstnametextController.text;
                          profile[0]['lastname'] = _lastnametextController.text;
                          userUpdate(
                              _hasImage == true ? _image! : tempFile!,
                              _usernametextController.text,
                              _firstnametextController.text,
                              _lastnametextController.text);
                        }
                      },
                      title: 'บันทึก',
                      color: kMainColor,
                    )),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
