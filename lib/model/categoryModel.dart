class categoryModel {
  String? id;
  String? name;
  String? image;

  categoryModel({this.id, this.image, this.name

      // required ProfileS datas
      });

  factory categoryModel.fromJson(Map<String, dynamic> json) {
    return categoryModel(
      //datas: datas
      id: json["id"],
      name: json["name"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
