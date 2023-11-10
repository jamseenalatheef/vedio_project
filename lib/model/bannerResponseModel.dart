import 'package:vedio_project/model/bannerModel.dart';

class banners {
  final bannerModel datas;

  banners({required this.datas});

  String? get id {
    return this.datas.id;
  }

  String? get image {
    return this.datas.image;
  }
}
