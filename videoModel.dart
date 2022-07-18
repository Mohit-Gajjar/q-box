import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String? imageUrl;
  int? likes;
  String? title;
  Timestamp? uploadDate;
  String? videoLink;

  VideoModel(
      {this.imageUrl, this.likes, this.title, this.uploadDate, this.videoLink});

  VideoModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    likes = json['likes'];
    title = json['title'];
    uploadDate = json['uploadDate'];
    videoLink = json['videoLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['likes'] = this.likes;
    data['title'] = this.title;
    data['uploadDate'] = this.uploadDate;
    data['videoLink'] = this.videoLink;
    return data;
  }
}
