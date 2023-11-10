import 'package:vedio_project/model/bannerModel.dart';
import 'package:vedio_project/model/categoryModel.dart';
import 'package:vedio_project/model/profileModel.dart';

class profileRM {
  final ProfileModel datas;

  profileRM({required this.datas});

  String? get username {
    return this.datas.username;
  }

  String? get name {
    return this.datas.name;
  }

  String? get place {
    return this.datas.place;
  }

  String? get phone {
    return this.datas.phone;
  }

  String? get email {
    return this.datas.email;
  }

  String? get image {
    return this.datas.image;
  }
}
