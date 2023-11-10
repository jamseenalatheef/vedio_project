import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vedio_project/coreFile/api.dart';
import 'package:vedio_project/model/bannerModel.dart';
import 'package:vedio_project/model/bannerModel.dart';
import 'package:vedio_project/model/categoryModel.dart';
import 'package:vedio_project/model/loginModel.dart';
import 'package:vedio_project/model/media_model.dart';
import 'package:dio/dio.dart';
import 'package:vedio_project/model/profileModel.dart';
import 'package:vedio_project/model/subCategoryModel.dart';

class service {
  //banner
  dynamic res;
  List<bannerModel> profile = [];
  Future<List<bannerModel>> dataItem() async {
    try {
      String url = urll().mainurl + "banner.jsp";

      final response = await Dio().get((url));

      if (response.statusCode == 200) {
        print(response.statusCode.toString());
        final body = response.data;
        final Iterable json = body;
        log("response:_____________________" + body.toString());
        return json.map((item22) => bannerModel.fromJson(item22)).toList();
      } else {
        throw Exception("Unable to perform request!");
      }
    } catch (e) {
      print(e.toString());
    }
    return profile;
  }
  //category

  Future<List<categoryModel>> dataItem1() async {
    try {
      String url = urll().mainurl + "category.jsp";

      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        print(response.statusCode.toString());
        final body = response.data;
        final Iterable json = body;
        log("response  categoryyy:_____________________" + body.toString());
        return json.map((item22) => categoryModel.fromJson(item22)).toList();
      } else {
        throw Exception("Unable to perform request!");
      }
    } catch (e) {
      print(e.toString());
    }
    return res;
  }
  //subcategory

  Future<List<subcategoryModel>> dataItem2(String catid) async {
    try {
      String url = urll().mainurl + "subcategory.jsp";

      final response = await Dio().post((url), data: {"catid": catid});

      if (response.statusCode == 200) {
        print(response.statusCode.toString());
        final body = response.data;
        final Iterable json = body;
        log("response:sub_____________________" + body.toString());
        return json.map((item22) => subcategoryModel.fromJson(item22)).toList();
      } else {
        throw Exception("Unable to perform request!");
      }
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

//media
  dynamic res3;
  List<MediaModel> profile2 = [];
  Future<List<MediaModel>> dataItem3(String subid) async {
    try {
      log("inside  0");
      String url = urll().mainurl + "media.jsp";
      log("inside  1");
      final response = await Dio().post((url), data: {"subid": subid});
      // final response = await http.get(Uri.parse(url));
      log("inside  2");
      if (response.statusCode == 200) {
        print(response.statusCode.toString());
        final body = response.data;
        final Iterable json = body;
        log("response:_____________________" + body.toString());
        return json.map((item22) => MediaModel.fromJson(item22)).toList();
      } else {
        throw Exception("Unable to perform request!");
      }
    } catch (e) {
      print(e.toString());
    }
    return profile2;
  }
  //login

  Future<Map<String, dynamic>> login(String username, String password) async {
    print('webservice');
    print(username);
    print(password);
    var result;
    final Map<String, dynamic> loginData = {
      'username': username,
      'password': password
    };

    String url = "";
    url = urll().mainurl + "login.jsp";

    final response = await Dio().post((url), data: loginData);

    if (response.statusCode == 200) {
      print(response.statusCode);
      final Map<String, dynamic> responseData = response.data;
      print("Msg rsponse==" + response.data.toString());

      var userData = responseData;
      print("userData.toString=====$userData");

      LoginModel ws = LoginModel.fromJson(userData);
      print("print ws Service===$ws");
      log("ws Service===$ws");

      result = {'status': true, 'message': 'Successful', 'user': ws};
      print("printresult===$result");

      print("web res>>>>>>>>>" + result.toString());
    } else {
      result = {
        'status': false,
        'message': json.decode(response.data)['error']
      };
    }
    return result;
  }

  //profile

  Future<Map<String, dynamic>> profiles() async {
    SharedPreferences sh = await SharedPreferences.getInstance();

    String username = sh.getString("username")!;
    print('webservice');
    print(username);

    var result;
    final Map<String, dynamic> profileData = {
      'username': username,
    };

    String url = "";
    url = urll().mainurl + "profile.jsp";

    final response = await Dio().post((url), data: profileData);

    if (response.statusCode == 200) {
      print(response.statusCode);
      final Map<String, dynamic> responseData = response.data;
      print("Msg rsponse in profileee==" + response.data.toString());

      var userData = responseData;
      print("userData.toString=====$userData");

      ProfileModel ws = ProfileModel.fromJson(userData);
      print("print ws Service===$ws");
      log("ws Service===$ws");

      result = {'status': true, 'message': 'success', 'user': ws};
      print("printresult===$result");

      print("web res>>>>>>>>>" + result.toString());
    } else {
      result = {
        'status': false,
        'message': json.decode(response.data)['error']
      };
    }
    return result;
  }
}
