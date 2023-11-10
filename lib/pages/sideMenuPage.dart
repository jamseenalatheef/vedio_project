import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vedio_project/coreFile/api.dart';
import 'package:vedio_project/dummy/sideMenuJson.dart';
import 'package:vedio_project/loginPage.dart';
import 'package:vedio_project/pages/homePage.dart';
import 'package:vedio_project/themes/colors.dart';

class SideMenuPage extends StatefulWidget {
  String name, image, email;
  SideMenuPage(
      {Key? key, required this.name, required this.image, required this.email})
      : super(key: key);

  @override
  State<SideMenuPage> createState() => _SideMenuPageState();
}

class _SideMenuPageState extends State<SideMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [getHeader(), getBodyItems(), getFooter()],
      ),
    );
  }

  Widget getHeader() {
    return SizedBox(
      height: 160,
      child: DrawerHeader(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: widget.image == "0"
                        ? AssetImage('assets/head.png') as ImageProvider
                        : NetworkImage(urll().baseurl_image + widget.image),
                    fit: BoxFit.cover),
                shape: BoxShape.circle,
                color: secondary),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            widget.name,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 5,
          ),
          Text(widget.email, style: TextStyle(fontSize: 16)),
        ],
      )),
    );
  }

  Widget getBodyItems() {
    return Column(
      children: List.generate(sideMenuItems.length, (index) {
        if (sideMenuItems[index]['selected']) {
          return FadeInLeft(
            duration: Duration(milliseconds: 200),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 15, top: 15),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: white,
                    border: Border.all(color: secondary.withOpacity(0.05)),
                    boxShadow: [
                      BoxShadow(
                          color: secondary.withOpacity(0.03),
                          blurRadius: 2.5,
                          offset: Offset(0, 5))
                    ]),
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);

                    Get.to((HomePage()));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) => sideMenuItems[index]['page']));
                  },
                  minLeadingWidth: 10,
                  leading: Icon(
                    sideMenuItems[index]['icon'],
                    color: secondary,
                  ),
                  title: Text(
                    sideMenuItems[index]['label'],
                    style: TextStyle(fontSize: 16, color: secondary),
                  ),
                ),
              ),
            ),
          );
        }
        return FadeInLeft(
          duration: Duration(milliseconds: index * 200),
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: ListTile(
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => sideMenuItems[index]['page']));
              },
              minLeadingWidth: 20,
              leading: Icon(
                sideMenuItems[index]['icon'],
                color: secondary.withOpacity(0.8),
                size: 26,
              ),
              title: Text(
                sideMenuItems[index]['label'],
                style:
                    TextStyle(fontSize: 16, color: secondary.withOpacity(0.8)),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget getFooter() {
    return Column(
      children: [
        Divider(),
        FadeInLeft(
          duration: Duration(milliseconds: 800),
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: ListTile(
              onTap: () async {
                SharedPreferences sh = await SharedPreferences.getInstance();
                sh.setBool('login', true);
                Get.to(LoginPage());
              },
              minLeadingWidth: 20,
              leading: Icon(
                LineIcons.alternateSignOut,
                color: secondary.withOpacity(0.8),
                size: 28,
              ),
              title: Text(
                "Logout",
                style:
                    TextStyle(fontSize: 16, color: secondary.withOpacity(0.8)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
