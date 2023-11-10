// To parse this JSON data, do
//
//     final vedioModel = vedioModelFromJson(jsonString);

import 'dart:convert';

List<MediaModel> vedioModelFromJson(String str) =>
    List<MediaModel>.from(json.decode(str).map((x) => MediaModel.fromJson(x)));

String vedioModelToJson(List<MediaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MediaModel {
  MediaModel({
    required this.id,
    required this.subcatId,
    required this.vedio,
    required this.audio,
    required this.text,
  });

  String id;
  String subcatId;
  String vedio;
  String audio;
  String text;

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
        id: json["id"].toString(),
        subcatId: json["subcat_id"].toString(),
        vedio: json["vedio"].toString(),
        audio: json["audio"].toString(),
        text: json["text"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subcat_id": subcatId,
        "vedio": vedio,
        "audio": audio,
        "text": text,
      };
}
