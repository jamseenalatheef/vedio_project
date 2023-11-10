import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:vedio_project/model/bannerModel.dart';
import 'package:vedio_project/model/bannerResponseModel.dart';
import 'package:vedio_project/model/cateResponseModel.dart';
import 'package:vedio_project/model/mediaResponseModel.dart';
import 'package:vedio_project/model/profileResponseModel.dart';
import 'package:vedio_project/model/subCatResponseModel.dart';
//import 'package:vedio_project/model/responseModel.dart';

import 'package:vedio_project/repository/service.dart';

class viewmodel extends ChangeNotifier {
  //banner
  List<banners> dataItems = [];

  Future<List<banners>> getDataItems() async {
    //print("hiiiiiiiii.................");

    final results = await service().dataItem();
    // print('......................');

    this.dataItems =
        results.map((item) => banners(datas: item)).cast<banners>().toList();

    print(dataItems);
    notifyListeners();
    return this.dataItems;
  }

  //category viewmodel

  List<category> data = [];

  Future<List<category>> getData() async {
    //print("hiiiiiiiii.................");

    final results = await service().dataItem1();
    // print('......................');

    this.data = results
        .map((item3) => category(datas: item3))
        .cast<category>()
        .toList();

    print(data);
    notifyListeners();
    return this.data;
  }
  //subcategory viewmodel

  List<subcategory> data1 = [];

  Future<List<subcategory>> sub(String catid) async {
    //print("hiiiiiiiii.................");

    final results = await service().dataItem2(catid);
    // print('......................');

    this.data1 = results
        .map((item3) => subcategory(datas: item3))
        .cast<subcategory>()
        .toList();

    print(data1);
    notifyListeners();
    return this.data1;
  }

  List mediaList = [];
  Future<List> getdata3(String subid) async {
    log("data inside vm........");
    final results = await service().dataItem3(subid);
    this.mediaList = results.map((item) => medias(datas: item)).toList();
    log("mediaList cv============" + mediaList.toString());
    log("medialist length ===" + mediaList.length.toString());
    notifyListeners();
    return mediaList;
  }

  notifyListeners();

  //login

  Future<Map<String, dynamic>> login(String username, String password) async {
    final result = await service().login(username, password);
    log("messagecommonlogin===== $result");
    return result;
  }

  //profile

  Future<Map<String, dynamic>> fetchprofile() async {
    final result = await service().profiles();
    log("messagecommonprofile===== $result");
    return result;
  }
}
