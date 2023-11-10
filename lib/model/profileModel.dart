// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

List<ProfileModel> profileModelFromJson(String str) => List<ProfileModel>.from(
    json.decode(str).map((x) => ProfileModel.fromJson(x)));

String profileModelToJson(List<ProfileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileModel {
  String username;
  String name;
  String place;
  String phone;
  String email;
  String image;

  ProfileModel({
    required this.username,
    required this.name,
    required this.place,
    required this.phone,
    required this.email,
    required this.image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        username: json["username"],
        name: json["name"],
        place: json["place"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "place": place,
        "phone": phone,
        "email": email,
        "image": image,
      };

  fromJson(item5) {}

  // ProfileModel copy(
  //         {required String imagePath,
  //         required String name,
  //         required String place,
  //         required String phone,
  //         required String email,
  //         required String username}) =>
  //     ProfileModel(
  //       image: imagePath ?? this.image,
  //       name: name ?? this.name,
  //       email: email ?? this.email,
  //       phone: phone ?? this.phone,
  //       place: place ?? this.place,
  //       username: username ?? this.username,
  //     );
}
