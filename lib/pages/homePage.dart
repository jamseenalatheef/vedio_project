import 'dart:developer';
import 'dart:io';

import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:vedio_project/coreFile/api.dart';
import 'package:vedio_project/dummy/homeJson.dart';
import 'package:vedio_project/loginPage.dart';
import 'package:vedio_project/mediaHome.dart';
import 'package:vedio_project/model/profileModel.dart';
import 'package:vedio_project/pages/audio_feed_view.dart';

import 'package:vedio_project/pages/productDetailPage.dart';
import 'package:vedio_project/pages/profile.dart';
import 'package:vedio_project/pages/Profiles/profile.dart';
import 'package:vedio_project/pages/sideMenuPage.dart';
import 'package:vedio_project/themes/colors.dart';
import 'package:vedio_project/viewmodel/commonViewModel.dart';
import 'package:vedio_project/widgets/customSlider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final imagePicker = ImagePicker();
  XFile? selectedImage;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int pageIndex = 0;
  String profileurl = "";
  String name = "";
  late viewmodel vmodel;
  late SharedPreferences preferences;
  late ProfileModel users;
  @override
  void initState() {
    vmodel = Provider.of<viewmodel>(context, listen: false);
    vmodel.getDataItems();
    vmodel.getData();
    vmodel.sub("3");
    vmodel.fetchprofile();
  }

  @override
  Widget build(BuildContext context) {
    //log("img=======${widget.img}");
    // final user = UserPreferences.myUser;
    return FutureBuilder(
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

                String headpr, email, name;
                headpr = users.image;

                email = users.email;
                name = users.name;
                return Scaffold(
                  key: scaffoldKey,
                  backgroundColor: primary,
                  appBar: PreferredSize(
                      child: getAppBar(pr: headpr, name: name, email: email),
                      preferredSize: Size.fromHeight(60)),
                  body: getBody(pr: headpr, name: name, email: email),
                  drawer: SideMenuPage(name: name, email: email, image: headpr),
                );
              }
          }
          return Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.purple)),
          );
        });
  }

  Widget getAppBar(
      {required String pr, required String name, required String email}) {
    return AppBar(
      automaticallyImplyLeading: false,

//       leading: IconButton(
//         icon: Icon(
// AntDesign.menuunfold,



//           color: secondary,
//         ),
//         onPressed: () {
//           scaffoldKey.currentState?.openDrawer();

//         },
      leading: IconButton(
        icon: Icon(Icons.menu),
        color: Colors.black,
        onPressed: () => scaffoldKey.currentState?.openDrawer(),
      ),

      elevation: 0,
      backgroundColor: primary,
      actions: [
        Container(
          width: 70,
          height: 70,
          // decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     border: Border.all(color: secondary.withOpacity(0.5))),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: IconButton(
              iconSize: 50,
              onPressed: () {
                Get.to(profiled());
                //widget.img.toString();
              },
              icon: CircleAvatar(
                // backgroundImage:
                //     NetworkImage(urll().baseurl_image +pr),

                radius: 50,
                backgroundColor: Colors.grey.shade400,
                foregroundColor: Colors.black,

                backgroundImage: pr != "0"
                    ? NetworkImage(urll().baseurl_image + pr)
                    : AssetImage('assets/head.png') as ImageProvider,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  Widget getBody(
      {required String pr, required String name, required String email}) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          Text(
            email,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CustomSlider(
            items: vmodel.dataItems,
          ),
          SizedBox(
            height: 20,
          ),
          getCategorySection(),
          SizedBox(
            height: 20,
          ),
          getItemLists()
        ]));
  }

  Widget getCategorySection() {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Category",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: (size.width - 30) * 1.0,
              // width: MediaQuery.of(context).size.width / 1,

              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                    Consumer<viewmodel>(builder: (context, _category, child) {
                  return Row(
                    children: List.generate(_category.data.length, (index) {
                      log("length===" + _category.data.length.toString());
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              log("clickedddd_category===" +
                                  _category.data[index].datas.id.toString());

                              String clickedcatid =
                                  _category.data[index].datas.id.toString();
                              _category.sub(clickedcatid);

                              pageIndex = index;
                            });
                          },
                          child: Container(
                            height: 30,
                            decoration: pageIndex == index
                                ? BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: secondary, width: 1.5)))
                                : BoxDecoration(),
                            child: Text(
                                vmodel.data[index].datas.name.toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: pageIndex == index
                                        ? secondary
                                        : secondary.withOpacity(0.5))),
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ),
            // SizedBox(
            //   width: 10,
            // ),
            // Flexible(
            //   child: Container(
            //     height: 35,
            //     decoration: BoxDecoration(
            //         color: secondary.withOpacity(0.1),
            //         borderRadius: BorderRadius.only(
            //             topRight: Radius.circular(20),
            //             bottomRight: Radius.circular(20),
            //             bottomLeft: Radius.circular(12),
            //             topLeft: Radius.circular(4))),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         // Icon(
            //         //   AntDesign.search1,
            //         //   size: 18,
            //         // ),
            //         SizedBox(
            //           width: 5,
            //         ),
            //         // Text(
            //         //   "Search...",
            //         //   style: TextStyle(fontSize: 13),
            //         // )
            //       ],
            //     ),
            //   ),
            // )
          ],
        )
      ],
    );
  }

  Widget getItemLists() {
    var size = MediaQuery.of(context).size;
    return Consumer<viewmodel>(
      builder: (context, _subcat, child) => Wrap(
        spacing: 20,
        runSpacing: 20,
        children: List.generate(_subcat.data1.length, (index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(mediaHome(
                    name: _subcat.data1[index].datas.subname.toString(),
                    subid: _subcat.data1[index].datas.id.toString(),
                    img: urll().baseurl_image +
                        _subcat.data1[index].datas.image.toString(),
                  ));

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (_) => mediaHome(
                  //               // name: homeJson[index]['name'],
                  //               // img: homeJson[index]['image'],
                  //               // price: homeJson[index]['price'],
                  //               // rate: homeJson[index]['rate'],
                  //               // colors: homeJson[index]['colors'],
                  //               name: _subcat.data1[index].datas.subname
                  //                   .toString(),
                  //               subid: _subcat.data1[index].datas.id.toString(),

                  //               img:
                  //                   "http://192.168.29.109:8080/vedioproject/images/" +
                  //                       _subcat.data1[index].datas.image
                  //                           .toString(),
                  //             )));
                },
                child: FadeIn(
                  duration: Duration(milliseconds: 1000 * index),
                  child: Container(
                    width: (size.width - 50) / 2,
                    height: 220,
                    child: Stack(
                      children: [
                        // Positioned(
                        //   top: 20,
                        //   child: Container(
                        //     width: (size.width - 50) / 2,
                        //     height: 200,
                        //     decoration: BoxDecoration(
                        //         color: secondary.withOpacity(0.1),
                        //         borderRadius: BorderRadius.circular(30)),
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(
                        //           bottom: 10, right: 15, left: 15),
                        //       child: Row(
                        //         crossAxisAlignment: CrossAxisAlignment.end,
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Row(
                        //             children: [
                        //               Icon(
                        //                 LineIcons.star,
                        //                 size: 18,
                        //                 color: secondary,
                        //               ),
                        //               SizedBox(
                        //                 width: 5,
                        //               ),
                        //               // Text(
                        //               //   homeJson[index]['rate'],
                        //               //   style: TextStyle(
                        //               //       fontWeight: FontWeight.w500),
                        //               // )
                        //             ],
                        //           ),
                        //           // Container(
                        //           //   width: 35,
                        //           //   height: 35,
                        //           //   decoration: BoxDecoration(
                        //           //       color: white,
                        //           //       shape: BoxShape.circle,
                        //           //       boxShadow: [
                        //           //         BoxShadow(
                        //           //             color:
                        //           //                 secondary.withOpacity(0.15),
                        //           //             blurRadius: 5,
                        //           //             offset: Offset(0, 5))
                        //           //       ]),
                        //           //   child: Center(
                        //           //     child: Icon(
                        //           //       LineIcons.shoppingBag,
                        //           //       size: 18,
                        //           //     ),
                        //           //   ),
                        //           // )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          top: -5,
                          child: Container(
                              width: (size.width - 50) / 2,
                              height: 180,
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade400),
                              child: Image.network(urll().baseurl_image +
                                  _subcat.data1[index].datas.image.toString())),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Container(
                width: (size.width - 60) / 2,
                child: Text(
                  _subcat.data1[index].datas.subname.toString(),
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ),
              // Container(
              //   width: (size.width - 60) / 2,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       // Padding(
              //       //   padding: const EdgeInsets.only(top: 3),
              //       //   child: Text(
              //       //     "\$",
              //       //     style: TextStyle(
              //       //         fontSize: 13,
              //       //         color: red,
              //       //         fontWeight: FontWeight.w500),
              //       //   ),
              //       // ),
              //       // SizedBox(
              //       //   width: 1,
              //       // ),
              //       // Text(
              //       //   homeJson[index]['price'],
              //       //   style: TextStyle(
              //       //       fontSize: 20,
              //       //       color: secondary.withOpacity(0.5),
              //       //       fontWeight: FontWeight.w500),
              //       // ),
              //     ],
              //   ),
              // )
            ],
          );
        }),
      ),
    );
  }
}
