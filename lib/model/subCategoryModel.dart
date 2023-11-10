class subcategoryModel {
  String? id;
  String? cat_id;
  String? subname;
  String? image;

  subcategoryModel({this.id, this.cat_id, this.image, this.subname

      // required ProfileS datas
      });

  factory subcategoryModel.fromJson(Map<String, dynamic> json) {
    return subcategoryModel(
      //datas: datas
      id: json["id"],
      cat_id: json["cat_id"],
      subname: json["subname"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": cat_id,
        "subname": subname,
        "image": image,
      };
}
