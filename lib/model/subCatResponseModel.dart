import 'package:vedio_project/model/bannerModel.dart';
import 'package:vedio_project/model/categoryModel.dart';
import 'package:vedio_project/model/subCategoryModel.dart';

class subcategory {
  final subcategoryModel datas;

  subcategory({required this.datas});

  String? get id {
    return this.datas.id;
  }

  String? get cat_id {
    return this.datas.cat_id;
  }

  String? get subname {
    return this.datas.subname;
  }

  String? get image {
    return this.datas.image;
  }
}
