// To parse this JSON data, do
//
//     final instagramPostModel = instagramPostModelFromJson(jsonString);

import 'dart:convert';

List<InstagramPostModel> instagramPostModelFromJson(String str) =>
    List<InstagramPostModel>.from(
        json.decode(str).map((x) => InstagramPostModel.fromJson(x)));

String instagramPostModelToJson(List<InstagramPostModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InstagramPostModel {
  InstagramPostModel({
    this.id,
    this.mediaType,
    this.mediaUrl,
  });

  String? id;
  String? mediaType;
  String ?mediaUrl;

  factory InstagramPostModel.fromJson(Map<String, dynamic> json) =>
      InstagramPostModel(
        id: json["id"],
        mediaType: json["media_type"],
        mediaUrl: json["media_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "media_type": mediaType,
        "media_url": mediaUrl,
      };
}
