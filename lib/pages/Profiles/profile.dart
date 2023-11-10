import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:googleapis/streetviewpublish/v1.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vedio_project/coreFile/api.dart';
import 'package:vedio_project/model/profileModel.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:vedio_project/pages/Profiles/editProfile.dart';
import 'package:vedio_project/pages/homePage.dart';

import 'package:vedio_project/pages/profile.dart';
import 'package:vedio_project/viewmodel/commonViewModel.dart';

class profiled extends StatefulWidget {
  const profiled({super.key});

  @override
  State<profiled> createState() => _profiledState();
}

class _profiledState extends State<profiled> {
  late Future<ProfileModel> futureprofile;
  // final controller = Get.put(Maincontroller());
  late viewmodel vmodel;
  String username = "";
  late ProfileModel users;
  PickedFile? _imageFile;
  @override
  void initState() {
    vmodel = Provider.of<viewmodel>(context, listen: false);
    super.initState();
    vmodel.fetchprofile();
    getdata();
    BackButtonInterceptor.add(myInterceptor);

    // futureprofile = controller.fetchData(Username);
  }

  getdata() async {
    log("username===" + username);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    late String username = "";
    late String image = 'assets/head.png';
    late String name = "";
    late String phone = "";

    late String email = "";
    late String place = "";

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(UpdateProfile(
            name: users.name,
            place: users.place,
            phone: users.phone,
            email: users.email,
            image: users.image,
            username: users.username,
          ));
          log("username===$username");
          log("profile===$image");
          log("name===${users.name}");
          log("place===${users.place}");
          log("phone===${users.phone}");
          log("email===${users.email}");
        },
      ),
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        margin:
            EdgeInsets.only(left: 10.0, top: 15.0, right: 10.0, bottom: 15.0),
        child: FutureBuilder(
          future: vmodel.fetchprofile(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                {
                  print("object<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
                  print("snap________________" + snapshot.data.toString());
                  Map<String, dynamic>? data = snapshot.data;
                  users = data!['user'];
                  log("imageeeeeeeeeeeeeeeeeeeeeeeee========" +
                      users.image.toString());

                  return Center(
                    child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                        CircleAvatar(
                          radius: 64,
                          backgroundImage: users.image != "0"
                              ? NetworkImage(urll().baseurl_image + users.image)
                              : AssetImage('assets/head.png') as ImageProvider,
                        ),
                        Row(
                          children: [
                            SizedBox(height: 45),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                            ),
                            Text(
                              "Name        :",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black),
                            ),
                            Padding(padding: EdgeInsets.only(left: 30.0)),
                            Text(
                              users.name.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(height: 45),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                            ),
                            Text(
                              "Place         :",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black),
                            ),
                            Padding(padding: EdgeInsets.only(left: 30.0)),
                            Text(
                              users.place.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(height: 45),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                            ),
                            Text(
                              "Phone        :",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black),
                            ),
                            Padding(padding: EdgeInsets.only(left: 30.0)),
                            Text(
                              users.phone.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(height: 45),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                            ),
                            Text(
                              "Email          :",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black),
                            ),
                            Padding(padding: EdgeInsets.only(left: 30.0)),
                            Container(
                              //color: Colors.amber,
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                users.email.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(height: 45),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                            ),
                            Text(
                              "Username  :",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black),
                            ),
                            Padding(padding: EdgeInsets.only(left: 25.0)),
                            Text(
                              users.username.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  );
                }
            }
            if (snapshot.hasData) {
              // username = snapshot.data!.username;
              // name = snapshot.data!.name;
              // phone = snapshot.data!.phone;
              // place = snapshot.data!.place;

              // email = snapshot.data!.email;
              // image = snapshot.data!.image;
              log("profilepic===" + image);
              log("nameeeeeeeeeeeeeeee===" + name);

              // return Card(
              //     color: Colors.white,
              //     borderOnForeground: true,
              //     child: SingleChildScrollView(
              //       child: Column(mainAxisSize: MainAxisSize.min, children: <
              //           Widget>[
              //         CircleAvatar(
              //           radius: 64,
              //           backgroundImage: !image.isEmpty
              //               ? NetworkImage(image)
              //               : AssetImage('assets/head.png') as ImageProvider,
              //         ),
              //         Row(
              //           children: [
              //             SizedBox(height: 45),
              //             Padding(
              //               padding: const EdgeInsets.fromLTRB(49, 10, 10, 0),
              //             ),
              //             Text("Name  :"),
              //             Padding(padding: EdgeInsets.only(left: 20.0)),
              //             Text(
              //               snapshot.data!.name.toString(),
              //               style: TextStyle(
              //                   fontStyle: FontStyle.normal,
              //                   color: Colors.grey),
              //             ),
              //           ],
              //         ),
              //         Row(
              //           children: [
              //             SizedBox(height: 45),
              //             Padding(
              //               padding: const EdgeInsets.fromLTRB(21, 10, 10, 0),
              //             ),
              //             Text("Place  :"),
              //             Padding(padding: EdgeInsets.only(left: 20.0)),
              //             Text(
              //               snapshot.data!.place.toString(),
              //               style: TextStyle(
              //                   fontStyle: FontStyle.normal,
              //                   color: Colors.grey),
              //             ),
              //           ],
              //         ),
              //         Row(
              //           children: [
              //             SizedBox(height: 45),
              //             Padding(
              //               padding: const EdgeInsets.fromLTRB(28, 10, 10, 0),
              //             ),
              //             Text("Phone  :"),
              //             Padding(padding: EdgeInsets.only(left: 20.0)),
              //             Text(
              //               snapshot.data!.phone.toString(),
              //               style: TextStyle(
              //                   fontStyle: FontStyle.normal,
              //                   color: Colors.grey),
              //             ),
              //           ],
              //         ),
              //         Row(
              //           children: [
              //             SizedBox(height: 45),
              //             Padding(
              //               padding: const EdgeInsets.fromLTRB(49, 10, 10, 0),
              //             ),
              //             Text("Email  :"),
              //             Padding(padding: EdgeInsets.only(left: 20.0)),
              //             Text(
              //               snapshot.data!.email.toString(),
              //               style: TextStyle(
              //                   fontStyle: FontStyle.normal,
              //                   color: Colors.grey),
              //             ),
              //           ],
              //         ),
              //         Row(
              //           children: [
              //             SizedBox(height: 45),
              //             Padding(
              //               padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
              //             ),
              //             Text("Username  :"),
              //             Padding(padding: EdgeInsets.only(left: 20.0)),
              //             Text(
              //               snapshot.data!.username.toString(),
              //               style: TextStyle(
              //                   fontStyle: FontStyle.normal,
              //                   color: Colors.grey),
              //             ),
              //           ],
              //         ),
              //       ]),
              //     ));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
                child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple)));
          },
        ),
      ),
    );
  }
}
