import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:vedio_project/coreFile/api.dart';
import 'package:vedio_project/pages/Profiles/profile.dart';
import 'package:get/get.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:vedio_project/pages/homePage.dart';

class UpdateProfile extends StatefulWidget {
  String name, email, phone, place, image, username;
  UpdateProfile({
    required this.name,
    required this.place,
    required this.phone,
    required this.email,
    required this.username,
    required this.image,
  });
  // String username;
  // UpdateProfile({@required this.username});
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late String email, place, phone, name;
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String uploadStatus = "";
  //SharedPreferences logindata;
  late String username = "1234";

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    //  initial();
  }

  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  Future<Map<String, dynamic>> updateProfile(String username, String name,
      String place, PickedFile imagefile, String phone, String email) async {
    var res;
    var request = http.MultipartRequest(
        "POST", Uri.parse(urll().mainurl + "imageposting"));
    //log("url.....${urll().mainurl}imageposting");
    var pic = await http.MultipartFile.fromPath("profilePic", imagefile.path);
    request.files.add(pic);
    request.fields['username'] = username;
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['place'] = place;
    request.fields['phone'] = phone;
    // request.fields['examtitle'] = examtitle;

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print("aks" + responseString.toString());
    Map<String, dynamic> result;
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (responseString.contains("success")) {
        log("responseImagepostingggg===========" + responseString.toString());
        Get.to(HomePage());
        setState(() {
          uploadStatus = "File Uploaded Succesfully";
        });
      } else {
        setState(() {
          uploadStatus = "Failed...........";
        });
      }
    }
    return res;
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pop();
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => const profiled()));
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.name;
    placeController.text = widget.place;
    phoneController.text = widget.phone;
    emailcontroller.text = widget.email;
    log("url.....${urll().mainurl}imageposting");

    log("widget.place${widget.place}");

//    MyViewModel Vm = Provider.of<MyViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(children: [
        Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                child: Stack(children: <Widget>[
                  CircleAvatar(
                    radius: 80.0,
                    backgroundImage: _imageFile == null
                        ? AssetImage("assets/head.png")
                        : FileImage(File(_imageFile!.path)) as ImageProvider,
                  ),
                  Positioned(
                      bottom: 7,
                      left: 115,
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white),
                      )),
                  Positioned(
                    bottom: 10,
                    left: 120,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey[200]),
                    ),
                  ),
                  Positioned(
                    bottom: 17.0,
                    left: 126,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: ((builder) => bottomSheet()),
                        );
                        print('CLICKEDDDDDD>>>>>>>>>>>>>>>>>>>>>>>');
                      },
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.purple,
                        size: 28.0,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 50, bottom: 10),
              child: TextFormField(
                controller: nameController,
                // initialValue: widget.name,
                // onChanged: (value) {
                //   setState(() {
                //     name = value;
                //   });
                // },
                // initialValue: 'Input text',
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: "Full Name",
                    //  ' Name',

                    labelText:
                        //  "abc",
                        "Full Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 10),
              child: TextFormField(
                controller: placeController,
                // initialValue: widget.place,
                // onChanged: (value) {
                //   setState(() {
                //     place = value;
                //   });
                // },
                // initialValue: 'Input text',
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: "Place",
                    //  ' Name',

                    labelText:
                        //  "abc",
                        "Place"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: TextFormField(
                //initialValue: widget.email,
                controller: emailcontroller,
                // onChanged: (value) {
                //   setState(() {
                //     email = value;
                //   });
                // },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: ' Email',
                    labelText: "Email"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: TextFormField(
                //  initialValue: widget.phone,
                controller: phoneController,
                // onChanged: (value) {
                //   setState(() {
                //     phone = value;
                //   });
                // },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  hintText: "Phone Number",
                  labelText: 'Phone Number',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Container(
                height: 50,
                width: 500,
                child: ElevatedButton(
                  onPressed: () {
                    print("name >>>>>>>>>>>>>>>>>>>>" + nameController.text);
                    print("email >>>>>>>>>>>>>>>" + emailcontroller.text);
                    print("place>>>>>>>>>>>>>>>" + placeController.text);
                    print("phone >>>>>>>>>>>>>>>" + phoneController.text);

                    print("image>>>>>>>>>>>>>>>>>>>>>>>" + _imageFile!.path);
                    print("username >>>>>>>>>>>>>>>>>>>>>>>>>>" + username);
                    // email = email;
                    // place = place;
                    // phone = phone;
                    // name = name;
                    // username = username;

                    updateProfile(
                        username,
                        nameController.text,
                        placeController.text,
                        _imageFile!,
                        phoneController.text,
                        emailcontroller.text);
                    // updateProfile(
                    //     username, name, place, password, _imageFile, phonenumber);
                    //  if (response['status']) {

                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => profiled(),
                    //   ),
                    // );
                    //                 print(response);
                    //                 Search user = response['user'];
                    //               }
                  },
                  child: Text('SUBMIT'),
                  style: ElevatedButton.styleFrom(
                      // elevation: 10,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.purple),
                      ),
                      primary: Colors.purple),
                  // child: Text(' Login'.toUpperCase())
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile!;
      print("<<<<<<<<<<<<<<<<<<< IMAGE >>>>>>>>>>>>>>>>>>>>>>>" +
          _imageFile!.path);
    });
  }
}
