import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:googleapis/analytics/v3.dart';
import 'package:googleapis/streetviewpublish/v1.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vedio_project/model/profileModel.dart';
import 'package:vedio_project/pages/Profiles/profile.dart';
import 'package:vedio_project/pages/homePage.dart';
import 'package:get/get.dart';

class MyImagePicker extends StatefulWidget {
  String name, image, email, phone, place;

  MyImagePicker({
    required this.name,
    required this.place,
    required this.phone,
    required this.email,
    required this.image,
  });

  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  PickedFile? _image;
  void updateUserValue(String name, phone, email, place) {
    name = name;
    phone = phone;
    email = email;
    place = place;
  }

  @override
  void dispose() {
    NameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    Placecontroller.dispose();
    super.dispose();
  }

  //this is a code get image from Camera
  _imageFromCamera() async {
    PickedFile? image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = image!;
    });
  }

  //this is a code get image from Gallery
  _imageFromGallery() async {
    PickedFile? image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = image!;
    });
  }

  final NameController = TextEditingController();
  final phoneController = TextEditingController();
  final Placecontroller = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
      ),
      body: Container(
        child: ListView(
          children: [
            //this is a container that contain image
            //when user select image from Gallery or Camera
            Container(
              //  width: screenWidth / 7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              //                  borderRadius: BorderRadius.all(Radius.circular(20))
              // ),
              margin: EdgeInsets.only(top: 20),
              width: 300,
              height: 300,
              child: (_image != null)
                  ? Image.file(
                      File(_image!.path),
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.image,
                      size: 300,
                    ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              //this is used to provide space between icons
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //this widget is used to get image from
                //Camera
                IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    size: 50,
                  ),
                  onPressed: () {
                    _imageFromCamera();
                  },
                ),
                //this widget is used to get image from
                //Gallery
                IconButton(
                  icon: Icon(
                    Icons.image,
                    size: 50,
                  ),
                  onPressed: () {
                    _imageFromGallery();
                  },
                ),
              ],
            ),
            //this widget provide space in vertical
            SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                //  controller: NameController,
                initialValue: widget.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: widget.name,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                //controller: Placecontroller,
                initialValue: widget.place,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Place',
                  //hintText: widget.place,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                //controller: phoneController,
                initialValue: widget.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                  // hintText: widget.phone,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                initialValue: widget.email,
                // controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  // hintText: widget.email,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            //this is used to perform uploading task
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 30, right: 30),
              //this is a button that has event to perform action
              child: ElevatedButton(
                child: Text("Upload Me"),
                onPressed: () async {
                  setState(() {
                    NameController.text.isEmpty;
                    // ? _validateName = true
                    // : _validateName = false;
                    Placecontroller.text.isEmpty;
                    // ? _validateContact = true
                    // : _validateContact = false;
                    phoneController.text.isEmpty;
                    // ? _validateDescription = true
                    // : _validateDescription = false;
                    emailController.text.isEmpty;
                  });
                  // if (_validateName == false &&
                  //     _validateContact == false &&
                  //     _validateDescription == false) {
                  // print("Good Data Can Save");
                  // var _user = ProfileModel();
                  // _user.id = widget.user.id;
                  // NameController.text = name;
                  // Placecontroller.text = place;
                  // phoneController.text = phone;
                  // emailController.text = email;
                  // var result = await _userService.UpdateUser;
                  updateUserValue(NameController.text, phoneController.text,
                      emailController.text, Placecontroller.text);
                  Navigator.pop(context);
                  // }
                  //upload method calling from here
                  _upload(_image!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // this method is used to convert image into String
  // and you can write uploading code here
  void _upload(PickedFile file) {
    log("upload.....");
    final bytes = File(file.path).readAsBytesSync();
    log("ssssssssssss");
    String img64 = base64Encode(bytes);
    log("mmmmmmm");
    log("hhkjjh" + img64.toString());
    Get.to(profiled());
    print(img64.length);
  }
}
