// import 'package:flutter/cupertino.dart';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vedio_project/model/loginModel.dart';
import 'package:vedio_project/pages/homePage.dart';
import 'package:vedio_project/viewmodel/commonViewModel.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _MyAppState();
}

class _MyAppState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  late bool newuser;
  String? username;
  bool viewVisible = false;

  String? password;
  late SharedPreferences sh;
  viewmodel? vm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    sh = await SharedPreferences.getInstance();
    newuser = (sh.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<viewmodel>(context);

    // return
    //      MaterialApp(
    //       theme: ThemeData(
    //         primaryColor: Colors.purple,
    //       ),
    //       debugShowCheckedModeBanner: false,
    //       home:

    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      // appBar: AppBar(
      //   backgroundColor: Colors.purple,
      //   // title: Text(
      //   //   'Ultra App',
      //   // ),
      // ),
      body: Form(
        key: _formKey,
        child: Container(
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: Container(
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.purpleAccent,
                            height: MediaQuery.of(context).size.height * 0.30,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    radius: 40,
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                    ),
                                  ),
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  TextField(
                                    controller: usernameController,
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your username',
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 3,
                                        ),
                                      ),
                                      prefixIcon: IconTheme(
                                        data: IconThemeData(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        child: Icon(Icons.person),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextField(
                                    controller: passwordController,
                                    autocorrect: true,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your password',
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 3,
                                        ),
                                      ),
                                      prefixIcon: IconTheme(
                                        data: IconThemeData(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        child: Icon(Icons.lock),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    child: Center(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.purple
                                              .shade200, // if you want to change button colour
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            LoginModel mmodelnew;

                                            final Future<Map<String, dynamic>>
                                                SuccessfullMessage = vm!.login(
                                                    usernameController.text,
                                                    passwordController.text);

                                            SuccessfullMessage.then(
                                                (Response) async {
                                              if (Response['status']) {
                                                LoginModel ls =
                                                    Response['user'];
                                                log("message========" +
                                                    ls.message.toString());
                                                if (ls.message ==
                                                    "Successful") {
                                                  print(ls.message);
                                                  print("Succfully Logined");

                                                  SharedPreferences sh =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  sh.setBool('login', false);

                                                  sh.setString("username",
                                                      usernameController.text);

                                                  String image = ls.image;
                                                  String name = ls.name;
                                                  String email = ls.email;
                                                  Get.to(HomePage());
                                                  // Navigator.of(context).push(
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) {
                                                  //   return HomePage();
                                                  // }));
                                                } else {
                                                  SnackBar snackBar = SnackBar(
                                                      content: Text(
                                                          'Incorrect Username or Password'),
                                                      duration:
                                                          Duration(seconds: 5),
                                                      action: SnackBarAction(
                                                          label: "UNDO",
                                                          onPressed: () {}));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                  // print("filed");
                                                }
                                              } else {
                                                print('login failed');
                                              }
                                            });
                                          }
                                        },

                                        // padding: EdgeInsets.all(16),
                                        // color: Theme.of(context).primaryColor,
                                        // shape: RoundedRectangleBorder(
                                        //   borderRadius:
                                        //       BorderRadius.circular(20),
                                        // ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'LOGIN',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward,
                                              size: 25,
                                              color: Colors.purple,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
