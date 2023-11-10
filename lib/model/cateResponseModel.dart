import 'package:vedio_project/model/bannerModel.dart';
import 'package:vedio_project/model/categoryModel.dart';

class category {
  final categoryModel datas;

  category({required this.datas});

  String? get id {
    return this.datas.id;
  }

  String? get name {
    return this.datas.name;
  }

  String? get image {
    return this.datas.image;
  }
}
