class bannerModel {
  String? id;
  String? image;

  bannerModel({this.id, this.image

      // required ProfileS datas
      });

  factory bannerModel.fromJson(Map<String, dynamic> json) {
    return bannerModel(
      //datas: datas
      id: json["id"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
